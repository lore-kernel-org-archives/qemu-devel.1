Received: from eggs.gnu.org ([2001:4830:134:3::10]:36164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGh92-0008QW-2v
	for Qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGh8y-0006pE-Sk
	for Qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:05:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cGh8y-0006nq-NQ
	for Qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:04:56 -0500
Date: Tue, 13 Dec 2016 15:04:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161213070453.GB2165@lemon>
References: <20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
	<20161212093907.GA7918@lemon>
	<151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
	<20161212103616.GB7918@lemon>
	<220EB996-A454-4FB1-9BAD-B0F4A300345E@livius.net>
	<20161212122803.GC7918@lemon>
	<EA7E7748-CB11-49AB-ADBA-555A0A510611@livius.net>
	<20161212145117.GB21817@lemon>
	<F71562E4-2D12-4F28-AC3F-70463E91E6A5@livius.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F71562E4-2D12-4F28-AC3F-70463E91E6A5@livius.net>
Subject: Re: [Qemu-devel] experience with SDL2, event loop & main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: QEMU Developer <Qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On Mon, 12/12 17:07, Liviu Ionescu wrote:
> 
> > On 12 Dec 2016, at 16:51, Fam Zheng <famz@redhat.com> wrote:
> > 
> > On Mon, 12/12 15:22, Liviu Ionescu wrote:
> >> so, back to square one; any suggestion on how to avoid the periodic timer
> >> required to poll SDL system events?
> > 
> > Good question, I've missed that!
> > 
> > Sadly I don't find it possible. The main thread of QEMU has to run the glib
> > event loop so it cannot block on SDL_WaitEvent().
> 
> why should the glib event loop run as the main thread? according to my tests,
> on linux and macos the glib event loop can run very well on a regular thread.

According to the API documentation I think it is supposed to work, but it will
be an unusual use case anyway so it's presumably less tested and I remember
hearing about things break here and there (cannot recall any detail :().

> 
> the problem that I encountered with this approach was on windows, where there
> is no `poll()`, and the existing implementation of it in qemu does not work if
> moved on a different thread. I do not know if the qemu implementation is not
> correct, or the win32 api does not allow this.
> 
> > ... it cannot block on SDL_WaitEvent().
> 
> initially I considered that rearranging threads to free the main thread for a
> dedicated SDL loop that blocks on SDL_WaitEvent() is a good solution, but then
> I took a look at how SDL_WaitEvent() is implemented: a loop that sleeps 10 ms
> and checks if there are events in the queue. :-(
> 
> so the best solution would be to make SDL asynchronous and run it on the glib
> event loop.

Maybe, but that would be a big project.

Given how SDL_WaitEvent() works as you said above, the easies solution would be
using qemu_bh_schedule_idle in the QEMU main loop and poll event there
periodically.

Fam
