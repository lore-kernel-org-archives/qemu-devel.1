Received: from eggs.gnu.org ([2001:4830:134:3::10]:60740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGSDQ-0006Om-1b
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 10:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGSDM-0005Vi-0V
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 10:08:32 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cGSDL-0005VM-MZ
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 10:08:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so11834514wmu.0
	for <Qemu-devel@nongnu.org>; Mon, 12 Dec 2016 07:08:27 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20161212145117.GB21817@lemon>
Date: Mon, 12 Dec 2016 17:07:24 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <F71562E4-2D12-4F28-AC3F-70463E91E6A5@livius.net>
References: <20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
	<20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
	<20161212093907.GA7918@lemon>
	<151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
	<20161212103616.GB7918@lemon>
	<220EB996-A454-4FB1-9BAD-B0F4A300345E@livius.net>
	<20161212122803.GC7918@lemon>
	<EA7E7748-CB11-49AB-ADBA-555A0A510611@livius.net>
	<20161212145117.GB21817@lemon>
Subject: Re: [Qemu-devel] experience with SDL2, event loop & main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developer <Qemu-devel@nongnu.org>


> On 12 Dec 2016, at 16:51, Fam Zheng <famz@redhat.com> wrote:
>=20
> On Mon, 12/12 15:22, Liviu Ionescu wrote:
>> so, back to square one; any suggestion on how to avoid the periodic =
timer
>> required to poll SDL system events?
>=20
> Good question, I've missed that!
>=20
> Sadly I don't find it possible. The main thread of QEMU has to run the =
glib
> event loop so it cannot block on SDL_WaitEvent().

why should the glib event loop run as the main thread? according to my =
tests, on linux and macos the glib event loop can run very well on a =
regular thread.

the problem that I encountered with this approach was on windows, where =
there is no `poll()`, and the existing implementation of it in qemu does =
not work if moved on a different thread. I do not know if the qemu =
implementation is not correct, or the win32 api does not allow this.

> ... it cannot block on SDL_WaitEvent().

initially I considered that rearranging threads to free the main thread =
for a dedicated SDL loop that blocks on SDL_WaitEvent() is a good =
solution, but then I took a look at how SDL_WaitEvent() is implemented: =
a loop that sleeps 10 ms and checks if there are events in the queue. =
:-(

so the best solution would be to make SDL asynchronous and run it on the =
glib event loop.

> Ideally SDL should provide an API to get a pollable fd (or a set of) =
to allow
> such types of integration, not much can be done from QEMU side in its =
current
> form.

I'm glad you reached more or less the same conclusion as I mentioned in =
one of the previous messages:

> I guess making SDL run asynchronously will need some major changes to =
the SDL
> source code, not simple patches that can be added to the QEMU build.


regards,

Liviu
