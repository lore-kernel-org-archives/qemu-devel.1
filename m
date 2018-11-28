Received: from eggs.gnu.org ([2001:4830:134:3::10]:57090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gS5gb-00032L-NS
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gS5ga-0001Ex-R0
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:39:49 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:41213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gS5ga-000163-Ki
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:39:48 -0500
Received: by mail-oi1-x231.google.com with SMTP id j21so23633776oii.8
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 11:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20181128010817.6191-1-programmingkidx@gmail.com>
In-Reply-To: <20181128010817.6191-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Nov 2018 19:39:25 +0000
Message-ID: <CAFEAcA_C3BtOvEFrSOntma4GtreJNEmtg3pxkB+2iCYKVFQinA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] (no subject)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: Berkus Decker <berkus@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 28 Nov 2018 at 01:12, John Arbuckle <programmingkidx@gmail.com> wrote:
>
> From af4497f2b161bb4165acb8eee5cae3f2a7ea2227 Mon Sep 17 00:00:00 2001
> From: John Arbuckle <programmingkidx@gmail.com>
> Date: Tue, 27 Nov 2018 20:01:20 -0500
> Subject: [PATCH] ui/cocoa.m: fix crash due to cocoa_refresh() on Mac OS 10.14

Something seems to have got the formatting of this patch email
wrong -- it's got all this in the body and the actual Subject
line of the email is blank.

> Mac OS 10.14 only wants UI code to be called from the main thread. The
> cocoa_refresh() function is called on another thread and this causes a
> crash to take place. To fix this problem the cocoa_refresh() code is
> called from the main thread only.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 59 ++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 34 insertions(+), 25 deletions(-)

I get a compile warning with this patch:
/Users/pm215/src/qemu/ui/cocoa.m:1615:23: warning: instance method
'-cocoa_refresh' not found (return type defaults to 'id')
[-Wobjc-method-access]
    [[NSApp delegate] cocoa_refresh];
                      ^~~~~~~~~~~~~

To be honest, I'm still confused about what is causing the
problems on Mojave. The refresh method should be being called
on the main thread even with the code on master -- it's just
that that is the iothread and it's running the event pumping
code in the refresh callback rather than a standard OSX
event loop. I'm hoping that the backtrace with symbols of
the Mojave assertion failure will help there, since I
can't currently see where refresh gets called from some
non-main thread.

I also think that this patch doesn't address the problems
of locking that I mention on the discussion thread for
Berkus' patch. It also doesn't handle any of the other
callbacks from QEMU to the cocoa UI -- surely we need to
handle all of them if there is a problem here?

(I have some prototype patches which I've been working
on which address the locking problem and also make all
the QEMU callbacks run their work on the main thread.
I may be able get those into shape to post those next week.)

thanks
-- PMM
