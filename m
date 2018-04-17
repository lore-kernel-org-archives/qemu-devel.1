Received: from eggs.gnu.org ([2001:4830:134:3::10]:50646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1f8Y87-0006p8-B4
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1f8Y84-0001Wd-Vp
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:27:11 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Hti-FYqEse7ubdNyVr3fPHO==e6MDv9Ym4KVYJcYTwA@mail.gmail.com>
References: <CAOuPqTE8GsN_+REWzSt4DOiqddSbZC-kOH=WnYG3U8ge3GsLoA@mail.gmail.com>
	<CAFEAcA_Hti-FYqEse7ubdNyVr3fPHO==e6MDv9Ym4KVYJcYTwA@mail.gmail.com>
From: Henry Wertz <hwertz10@gmail.com>
Date: Tue, 17 Apr 2018 16:27:02 -0500
Message-ID: <CAOuPqTG_C_dLF+RPxP_=A7575KWSg=dTbuN6-94HCDqsTEJPOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Patch for ARM memory barriers and getdent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <Laurent@vivier.eu>

Hi Henry; thanks for these patches. Please could you provide
> a Signed-off-by: line for them? This says you're happy for us
> to apply them to QEMU under our license, and we can't do anything
> with them without one. The top part of
> https://wiki.qemu.org/Contribute/SubmitAPatch
> has more detail.
>
     Yup, I'll resubmit both in proper format.

> You'll probably have better luck if you submit patches as separate
> emails rather than all in one -- the set of people who care about
>
     Can do.

In general, 64-bit binary on a 32-bit host is not supported by linux-user.
> Various things are likely to go wrong for anything but the simplest
> of guest binaries. You need a 64-bit host to reliably use linux-user
> for a 64-bit guest binary.
>
     I didn't test it very hard, I was only using it to run the couple
Android SDK binaries (aapt and friends) that Android Studio runs; these in
general open a file or two, process them, write out a result, so they
probably are pretty simple guest binaries.  Nevertheless,with this patch
these few x86-64 binaries run on 32-bit ARM and (last I checked) 32-bit
Intel.


>
> I think your change isn't sufficient to handle the "target 32 bits
> and host 64 bits" case, because the 64-on-32 code path that you're
> using for it uses the guest's buffer size as the size of the
> host buffer it allocates to pass to the host syscall.
>
....

> Maybe I'm missing a clever trick?
>
     As far as I can tell, it makes a "linux_dirent" and "target_dirent"
and is pretty careful to calculate rather than assume offsets, and so on as
it copies data from one struct to the other.  i didn't look before, but
there is in fact a line "assert(count1 + treclen <= count);" that would
trigger if the buffer is going to be overflowed.  I think the code may not
have even been needed, except that d_type (file type) was moved to the
"middle" of the dirent64 struct instead of at the end.

Thanks!
-- Henry
