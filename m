Received: from eggs.gnu.org ([2001:4830:134:3::10]:45927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eHUgy-0000Eu-HY
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eHUgt-0000SJ-Po
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:03:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eHUgt-0000S8-Jm
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:03:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3875137E6E
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 13:03:46 +0000 (UTC)
Date: Wed, 22 Nov 2017 13:02:37 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171122130237.GG29565@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171122124219.12954-1-quintela@redhat.com>
	<20171122124219.12954-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122124219.12954-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] migration: Create uri parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, armbru@redhat.com, eblake@redhat.com

On Wed, Nov 22, 2017 at 01:42:16PM +0100, Juan Quintela wrote:
> It will be used to store the uri migration parameter.  Right now it is
> just the parameter code.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hmp.c                 |  7 +++++++
>  migration/migration.c | 13 +++++++++++++
>  qapi/migration.json   | 18 +++++++++++++++---
>  3 files changed, 35 insertions(+), 3 deletions(-)

> diff --git a/qapi/migration.json b/qapi/migration.json
> index bbc4671ded..ebde890604 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -488,6 +488,9 @@
>  #                     and a power of 2
>  #                     (Since 2.11)
>  #
> +# @uri: defines the method we are susing to migrate
> +#                     (Since 2.11)

On the migrate command, we've inherited the use of a URI string from the
very earliest days of QMP design, but I can't help thinking that for any
new stuff we define, we should do a full QMP model for the paraneters,
instead of continuing to use the URI. eg we should define a union of
structs, giving the individual parameters for each component, and the
tcp/unix parts probably ought to reuse the SocketAddress struct. This
is how we've approached the blockdev code in QMP, avoiding exposing the
legacy URI/filename formats in favour of full QMP modelling.

The HMP side could still continue to use a URI though.

Copying Markus/Eric for views on QMP modelling.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
