Received: from eggs.gnu.org ([2001:4830:134:3::10]:41533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <igor.rubinov@gmail.com>) id 1d5X9K-0003hi-Np
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <igor.rubinov@gmail.com>) id 1d5X9J-0008NR-T6
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:43:26 -0400
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:35943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <igor.rubinov@gmail.com>)
	id 1d5X9J-0008Mw-Nj
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:43:25 -0400
Received: by mail-vk0-x233.google.com with SMTP id q78so72021204vke.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 05:43:25 -0700 (PDT)
MIME-Version: 1.0
Sender: igor.rubinov@gmail.com
In-Reply-To: <87bmrj8eks.fsf@linaro.org>
References: <CAPnv1PJeMRPKv9UUSmSWxyn=GFOPaWY8eUgH8ZeL=ZBMDJpbdg@mail.gmail.com>
	<CAJhHMCCZh7hvQT8x9Bks9k6=ka4G1Oybv1MrkKJ9_VZ_eRZBfQ@mail.gmail.com>
	<CAPnv1PL7-BAt36BvTxP7G8J8990Ur9MJJbr-QPccWziD4sy28g@mail.gmail.com>
	<87bmrj8eks.fsf@linaro.org>
From: Igor R <boost.lists@gmail.com>
Date: Tue, 2 May 2017 15:42:54 +0300
Message-ID: <CAPnv1PKyak1G-uL=H=-Vh_9TH2dZKffYjDf_2Z+LWuqovMKCBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] What is the best commit for record-replay?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Pranith Kumar <bobby.prani+qemu@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

>>>> I'm trying to use the deterministic record/replay feature, and I would
>>>> like to know which commit I should take to get it work.
>>>> In RC0 it seems to be broken. I tried pre-MTTCG commit 2421f381dc, as
>>
>>> Can you retry with the latest rc? There were some fixes regarding rr since rc0.
>>
>>
>> I've taken 2.9 release, and RR does not seem to work there.
>> I recorded the boot process of x86 Fedora-21 linux and the replay got
>> stuck almost immediately.
>
> What's your command line?
>
> Does it get stuck at the same place each time?
>
> Can you boot fine with icount but without record/replay?

Here is the exact scenario:
- Get 2.9 from git, configure it as follows: "./configure
--target-list=i386-softmmu --enable-sdl" and  make.
- Download https://people.debian.org/~aurel32/qemu/i386/debian_squeeze_i386_standard.qcow2
- Run qemu with the following command line, until login prompt:
-icount shift=7,rr=record,rrfile=replay.bin -drive
file=debian_squeeze_i386_standard.qcow2,if=none,id=img-direct -drive
driver=blkreplay,if=none,image=img-direct,id=img-blkreplay -device
ide-hd,drive=img-blkreplay -monitor stdio
- Replay: -icount shift=7,rr=replay,rrfile=replay.bin -drive
file=debian_squeeze_i386_standard.qcow2,if=none,id=img-direct -drive
driver=blkreplay,if=none,image=img-direct,id=img-blkreplay -device
ide-hd,drive=img-blkreplay -monitor stdio

Every time I attempt to replay, QEMU gets stuck at the same EIP, at a
very early stage.


> Can you boot fine with icount but without record/replay?

Yes. I can also enable icount and recording - it also boots fine. The
problem with the replay.
