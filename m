Received: from eggs.gnu.org ([2001:4830:134:3::10]:43452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXV37-0002lv-A3
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXV33-0004lo-9s
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:13:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fXV33-0004le-4r
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:13:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAC14401C7E8
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 17:13:04 +0000 (UTC)
Date: Mon, 25 Jun 2018 18:13:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180625171301.GM18580@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625170715.23149-1-rjones@redhat.com>
	<20180625170715.23149-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625170715.23149-2-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] crypto: Implement TLS Pre-Shared Keys
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

On Mon, Jun 25, 2018 at 06:07:15PM +0100, Richard W.M. Jones wrote:
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
>  5 files changed, 448 insertions(+)

Not done a proper code review yet but just a docs point...

Can you describe the new object type in qemu-options.hx - look for the
existing entry related to tls-creds-x509

Also in qemu-doc.texi at approx

  "@section TLS setup for network services"

we'll need something added related to PSK to describe how to set it
up. I guess we'll want to put what's there already under an "x509"
section, and add a PSK section


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
