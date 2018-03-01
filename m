Received: from eggs.gnu.org ([2001:4830:134:3::10]:35404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQjp-0000oW-1K
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQjk-0000J1-T3
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:07:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1erQjk-0000IG-NV
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:07:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B361814F0CF
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 16:07:13 +0000 (UTC)
Date: Thu, 1 Mar 2018 16:07:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180301160706.GV14643@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301084438.13594-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/15] qio: general non-default
 GMainContext support
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

On Thu, Mar 01, 2018 at 04:44:23PM +0800, Peter Xu wrote:
> This is another preparation work for monitor OOB seires.
> 
> V1: http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg06972.html
> 
> V2 rewrote the bottom half of the code.  The first 8 patches are
> mostly the same, but I rewrote the last patches to solve both TLS and
> reconnect use cases by introducing a machine_done hook for chardevs in
> general.  So if I copy the problems:
> 
> - migration
>   - incoming side: still always running on main context, while we need
>     to be able to run some command in OOB thread [1]
> - tcp chardev (non-tcp chardevs should all support non-NULL context now)
>   - server listening mode: QIO net listener used [2]
>   - TELNET session: an isolated GSource used (tcp_chr_telnet_init) [3]
>   - when "reconnect=N" is used, QIO threaded task is used [4]
>   - TLS session: QIO tls handshake is used (tcp_chr_tls_init) [5]
> 
> Problem [1-3] are still fixed in the old way, but [4-5] now are fixed
> by using the new machine_done notifier.

The QIO code changes all look good to me know, aside from minor
comments. I really dislike all of the chardev stuff though. I
think it makes the chardev code even harder to follow & rationalize
behaviour of.

If you post a v3 series contaning just the qio/ directory changes,
I'd queue those patches, while we discuss chardev stuff more.

I struggle to suggest better approach, because its any missing
context of how the changes are going to be used, presumably by
patch series yet to be posted. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
