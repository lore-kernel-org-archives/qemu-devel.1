Received: from eggs.gnu.org ([2001:4830:134:3::10]:53368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duEra-0001Tp-5f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duErV-0000Ps-JE
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:30:42 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:49423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1duErV-0000PK-Cc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:30:37 -0400
Received: by mail-wm0-x22c.google.com with SMTP id e71so3396557wmg.4
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 02:30:37 -0700 (PDT)
References: <CAPnv1PJeMRPKv9UUSmSWxyn=GFOPaWY8eUgH8ZeL=ZBMDJpbdg@mail.gmail.com>
	<CAJhHMCCZh7hvQT8x9Bks9k6=ka4G1Oybv1MrkKJ9_VZ_eRZBfQ@mail.gmail.com>
	<CAPnv1PL7-BAt36BvTxP7G8J8990Ur9MJJbr-QPccWziD4sy28g@mail.gmail.com>
	<87bmrj8eks.fsf@linaro.org>
	<CAPnv1PKyak1G-uL=H=-Vh_9TH2dZKffYjDf_2Z+LWuqovMKCBQ@mail.gmail.com>
	<CAKSfGUC_k6K=2Xy8pGcwuQ66DMPYCDvA47Ojgm7ntQfALGwDsQ@mail.gmail.com>
	<CAKSfGUD-FEb+DGwtrVHm2_NR_WOes9_+WkPm3Z76OPNhc3vbGA@mail.gmail.com>
	<000601d33128$2dd9d5e0$898d81a0$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <000601d33128$2dd9d5e0$898d81a0$@ru>
Date: Tue, 19 Sep 2017 10:30:35 +0100
Message-ID: <87bmm7dohw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] What is the best commit for record-replay?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Aleksandr Bezzubikov' <zuban32s@gmail.com>, 'QEMU Developers' <qemu-devel@nongnu.org>, 'Pranith Kumar' <bobby.prani+qemu@gmail.com>, pavel.dovgaluk@ispras.ru, 'Aleksandr Bezzubikov' <abezzubikov@ispras.ru>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Igor R' <boost.lists@gmail.com>


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Aleksandr Bezzubikov [mailto:zuban32s@gmail.com]
>> 2017-09-18 15:02 GMT+03:00 Aleksandr Bezzubikov <zuban32s@gmail.com>:
>> > 2017-05-02 15:42 GMT+03:00 Igor R <boost.lists@gmail.com>:
>> >>>>>> I'm trying to use the deterministic record/replay feature, and I would
>> >>>>>> like to know which commit I should take to get it work.
>> >>>>>> In RC0 it seems to be broken. I tried pre-MTTCG commit 2421f381dc, as
>> >>>>
>> >>>>> Can you retry with the latest rc? There were some fixes regarding rr since rc0.
>> >>>>
>> >>>>
>> >>>> I've taken 2.9 release, and RR does not seem to work there.
>> >>>> I recorded the boot process of x86 Fedora-21 linux and the replay got
>> >>>> stuck almost immediately.
>> >>>
>> >>> What's your command line?
>> >>>
>> >>> Does it get stuck at the same place each time?
>> >>>
>> >>> Can you boot fine with icount but without record/replay?
>> >>
>> >> Here is the exact scenario:
>> >> - Get 2.9 from git, configure it as follows: "./configure
>> >> --target-list=i386-softmmu --enable-sdl" and  make.
>> >> - Download https://people.debian.org/~aurel32/qemu/i386/debian_squeeze_i386_standard.qcow2
>> >> - Run qemu with the following command line, until login prompt:
>> >> -icount shift=7,rr=record,rrfile=replay.bin -drive
>> >> file=debian_squeeze_i386_standard.qcow2,if=none,id=img-direct -drive
>> >> driver=blkreplay,if=none,image=img-direct,id=img-blkreplay -device
>> >> ide-hd,drive=img-blkreplay -monitor stdio
>> >> - Replay: -icount shift=7,rr=replay,rrfile=replay.bin -drive
>> >> file=debian_squeeze_i386_standard.qcow2,if=none,id=img-direct -drive
>> >> driver=blkreplay,if=none,image=img-direct,id=img-blkreplay -device
>> >> ide-hd,drive=img-blkreplay -monitor stdio
>> >>
>> >> Every time I attempt to replay, QEMU gets stuck at the same EIP, at a
>> >> very early stage.
>> >>
>> >>
>> >>> Can you boot fine with icount but without record/replay?
>> >>
>> >> Yes. I can also enable icount and recording - it also boots fine. The
>> >> problem with the replay.
>> >
>> > Hi guys,
>> > Maybe the thread is a bit outdated, but the problem is still relevant.
>> > I've just tried to record and replay WinXP boot process, and I've encountered
>> > exactly the same problem as described above - record is fine, replay
>> > gets stuck early. I use current master.
>
> Maybe this commit will work: cfb2d02be9413d45b30ed6d8e38800250b6b4b48
>
>> > And I've discovered the second problem - recording makes initial snapshot,
>> > but it doesn't seem to be saved to the disk - replay can't see it.
>
> It is ok, because there is a mode where snapshot is created and loaded.
>
>> >
>> > Hope you've already found the solution (as the last post was on 2 May)
>> > and it's just got missed the mailing list.
>
> As I know, RR is still broken in the current version.
> It was caused by the MTTCG implementation.
> Alex Bennee tried to fix RR back. Alex, have you found any solution?
>
> We also trying to find a way to fix RR. It seems, that we will reinvent BQL for RR.

I think the method outlined in my RFC is the way to go, essentially the
RR mutex taking over for the what the BQL did. The RFC patch hadn't
hoisted the mutex for the additional devices so I'm just re-basing now
and I'll see if I can make the changes for Igor's test case.

--
Alex Bennée
