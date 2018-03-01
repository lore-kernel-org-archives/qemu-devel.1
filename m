Received: from eggs.gnu.org ([2001:4830:134:3::10]:33035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQeX-0005XL-7n
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQeT-0004sr-Cg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:01:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1erQeT-0004sC-8L
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:01:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 721C54023112
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 16:01:45 +0000 (UTC)
Date: Thu, 1 Mar 2018 16:01:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180301160138.GS14643@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-15-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301084438.13594-15-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/15] chardev: tcp: postpone async
 connection setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 04:44:37PM +0800, Peter Xu wrote:
> This patch allows the socket chardev async connection be setup with
> non-default gcontext.  We do it by postponing the setup to machine done,
> since until then we can know which context we should run the async
> operation on.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-socket.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

I don't like this as it is special casing behaviour wrt GMainContext
only the the case where the chardev is configured as a client with
non-blocking connect. So any code that uses chardevs and wants to
set a different GMainContext may or may not work, depending on
whether the user gave the ',wait' option to the chardev. I'm struggling
to see why this is really needed at all.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
