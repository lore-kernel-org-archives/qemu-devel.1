Received: from eggs.gnu.org ([2001:4830:134:3::10]:40988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fY9Rm-0002ZQ-Gg
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fY9Rj-0006F2-D2
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:21:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fY9Rj-0006EA-7c
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:21:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D393A401EF06
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 12:21:14 +0000 (UTC)
Date: Wed, 27 Jun 2018 13:21:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180627122110.GI30628@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180626102554.23290-1-rjones@redhat.com>
	<20180626102554.23290-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180626102554.23290-2-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com

On Tue, Jun 26, 2018 at 11:25:54AM +0100, Richard W.M. Jones wrote:
> Pre-Shared Keys (PSK) is a simpler mechanism for enabling TLS
> connections than using certificates.  It requires only a simple secret
> key:
> 
>   $ mkdir -m 0700 /tmp/keys
>   $ psktool -u rjones -p /tmp/keys/keys.psk
>   $ cat /tmp/keys/keys.psk
>   rjones:d543770c15ad93d76443fb56f501a31969235f47e999720ae8d2336f6a13fcbc
> 
> The key can be secretly shared between clients and servers.  Clients
> must specify the directory containing the "keys.psk" file and a
> username (defaults to "qemu").  Servers must specify only the
> directory.
> 
> Example NBD client:
> 
>   $ qemu-img info \
>     --object tls-creds-psk,id=tls0,dir=/tmp/keys,username=rjones,endpoint=client \
>     --image-opts \
>     file.driver=nbd,file.host=localhost,file.port=10809,file.tls-creds=tls0,file.export=/
> 
> Example NBD server using qemu-nbd:
> 
>   $ qemu-nbd -t -x / \
>     --object tls-creds-psk,id=tls0,endpoint=server,dir=/tmp/keys \
>     --tls-creds tls0 \
>     image.qcow2
> 
> Example NBD server using nbdkit:
> 
>   $ nbdkit -n -e / -fv \
>     --tls=on --tls-psk=/tmp/keys/keys.psk \
>     file file=disk.img
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  crypto/Makefile.objs         |   1 +
>  crypto/tlscredspsk.c         | 300 +++++++++++++++++++++++++++++++++++++++++++
>  crypto/tlssession.c          |  38 ++++++
>  crypto/trace-events          |   3 +
>  include/crypto/tlscredspsk.h | 106 +++++++++++++++
>  qemu-doc.texi                |  37 ++++++
>  qemu-options.hx              |  24 ++++
>  7 files changed, 509 insertions(+)


> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index 96a02deb69..aed754bb83 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "crypto/tlssession.h"
>  #include "crypto/tlscredsanon.h"
> +#include "crypto/tlscredspsk.h"
>  #include "crypto/tlscredsx509.h"
>  #include "qapi/error.h"
>  #include "qemu/acl.h"
> @@ -162,6 +163,39 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
>                         gnutls_strerror(ret));
>              goto error;
>          }
> +    } else if (object_dynamic_cast(OBJECT(creds),
> +                                   TYPE_QCRYPTO_TLS_CREDS_PSK)) {
> +        QCryptoTLSCredsPSK *pcreds = QCRYPTO_TLS_CREDS_PSK(creds);
> +        char *prio;
> +
> +        if (creds->priority != NULL) {
> +            prio = g_strdup_printf("%s:+PSK:+DHE-PSK", creds->priority);
> +        } else {
> +            prio = g_strdup(CONFIG_TLS_PRIORITY ":+PSK:+DHE-PSK");

GNUTLS maintainer recommended that we list  DHE-PSK  as that provides
forward secrecy, and in fact list ECDHE-PSK first. So I think we need

    :+ECDHE-PSK,+DHE-PSK,+PSK


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
