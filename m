Received: from eggs.gnu.org ([2001:4830:134:3::10]:58917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebSSW-0007Nn-9E
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebSST-00010w-L5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:43:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebSST-00010Z-Er
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:43:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DC8950F7B
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 14:43:24 +0000 (UTC)
Date: Tue, 16 Jan 2018 14:43:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180116144311.GG1521@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-9-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516112253-14480-9-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL 08/51] chardev: introduce
 qemu_chr_timeout_add_ms()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

On Tue, Jan 16, 2018 at 03:16:50PM +0100, Paolo Bonzini wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> It's a replacement of g_timeout_add[_seconds]() for chardevs.  Chardevs
> now can have dedicated gcontext, we should always bind chardev tasks
> onto those gcontext rather than the default main context.  Since there
> are quite a few of g_timeout_add[_seconds]() callers, a new function
> qemu_chr_timeout_add_ms() is introduced.

FYI the point of using g_timeout_add_seconds() is that it allow the
glib event loop to be more efficient. It ensures that all timers
which second granularity are dispatched on the same iteration of
the main loop. IOW, if you have 10 timers registered with
g_timeout_add_seconds() the main loop wakes up once a second and
runs all 10 of them. If you have 10 timers registered with g_timeout_add
the main loop wakes up 10 times a second, at a different time for each
timer.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
