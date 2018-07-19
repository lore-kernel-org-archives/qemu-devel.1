Received: from eggs.gnu.org ([2001:4830:134:3::10]:55866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fg14h-0002qr-UH
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 01:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fg14e-0007sf-Ry
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 01:01:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fg14e-0007sQ-Mf
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 01:01:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0142340711BF
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 05:01:56 +0000 (UTC)
Date: Thu, 19 Jul 2018 13:01:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180719050145.GD4071@xz-mi>
References: <20180620071040.28729-1-peterx@redhat.com>
	<87y3e8lfks.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y3e8lfks.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v4] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Jul 18, 2018 at 05:38:11PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > After the Out-Of-Band work, the monitor iothread may be accessing the
> > cur_mon as well (via monitor_qmp_dispatch_one()).  Let's convert the
> > cur_mon variable to be a per-thread variable to make sure there won't be
> > a race between threads when accessing the variable.
> 
> Hmm... why hasn't the OOB work created such a race already?
> 
> A monitor reads, parses, dispatches and executes commands, formats and
> sends replies.
> 
> Before OOB, all of that ran in the main thread.  Any access of cur_mon
> should therefore be from the main thread.  No races.
> 
> OOB moves read, parse, format and send to an I/O thread.  Dispatch and
> execute remain in the main thread.  *Except* for commands executed OOB,
> dispatch and execute move to the I/O thread, too.
> 
> Why is this not racy?  I guess it relies on careful non-use of cur_mon
> in any part that may now execute in the I/O thread.  Scary...

I think it's because cur_mon is not really used in out-of-band command
executions - now we only have a few out-of-band enabled commands, and
IIUC none of them is using cur_mon (for example, in
qmp_migrate_recover() we don't even call error_report, and the code
path is quite straight forward to make sure of that).  So IIUC cur_mon
variable is still only touched by main thread for now hence we should
be safe.  However that condition might change in the future when we
add more out-of-band capable commands.

(not to mention that I don't even know whether there are real users of
 out-of-band if we haven't yet started to support that for libvirt...)

> 
> Should this go into 3.0 to reduce the risk of bugs?

Yes I think it would be good to have that even for 3.0, since it still
can be seen as a bug fix of existing code.

Regards,

-- 
Peter Xu
