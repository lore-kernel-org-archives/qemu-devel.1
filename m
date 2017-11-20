Received: from eggs.gnu.org ([2001:4830:134:3::10]:34041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eGlX1-0006eZ-2O
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eGlWy-0007A8-1F
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:50:35 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eGlWx-00079t-Op
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:50:31 -0500
Received: by mail-wm0-x243.google.com with SMTP id y80so18438282wmd.0
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 04:50:31 -0800 (PST)
References: <8726068c-1112-eaea-5315-ec17ae37ae33@huawei.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8726068c-1112-eaea-5315-ec17ae37ae33@huawei.com>
Date: Mon, 20 Nov 2017 12:50:28 +0000
Message-ID: <878tf1xgff.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [question] mask SIGBUS in qemu main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, mst@redhat.com, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Ingo Molnar <mingo@redhat.com>, Wuquanming <wuquanming@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>


gengdongjiu <gengdongjiu@huawei.com> writes:

> Hi all,
>   sorry to disturb you, I have a question to consult with you why the SIG=
BUS mask bit is set in the Qemu main thread?
> do we not want to Qemu main thread to handle the SIGBUS signal?
>   thanks.

What exactly do you expect the main thread to do with a SIGBUS signal?

If QEMU doesn't catch the SIGBUS it will be up to the kernel to deal
with it, probably by terminating QEMU. This is fine because this is a
bug in QEMU that shouldn't have occurred.

This is different from dealing with SIGBUS due to the guests action
which might occur in the various vCPU threads.

> As shown in [1], the Qemu main thread PID is 30976.
> "cat /proc/30976/status" in [2], we can see the "SigBlk: 0000000010002240=
", SIGBUS block bit is 7, so the SIGBUS block bit is set.
> then the Qemu main thread will not be woken up if there is SIGBUS set to =
it.
> thanks!
>
>
> [1]:
> # ps -eL | grep "qemu"
> 30976 30976 pts/7    00:00:00 qemu-system-x86
> 30976 30977 pts/7    00:00:00 qemu-system-x86
>
> [2]
> # cat /proc/30976/status
> Name:   qemu-system-x86
> State:  S (sleeping)
> Tgid:   30976
> Ngid:   0
> Pid:    30976
> PPid:   34807
> TracerPid:      0
> Uid:    1000    1000    1000    1000
> Gid:    1000    1000    1000    1000
> FDSize: 256
> Groups: 4 24 27 30 46 108 114 115 1000
> NStgid: 30976
> NSpid:  30976
> NSpgid: 30976
> NSsid:  34772
> VmPeak:   604260 kB
> VmSize:   538724 kB
> VmLck:         0 kB
> VmPin:         0 kB
> VmHWM:     34176 kB
> VmRSS:     34176 kB
> VmData:   294308 kB
> VmStk:       136 kB
> VmExe:      4808 kB
> VmLib:     36144 kB
> VmPTE:       528 kB
> VmPMD:        16 kB
> VmSwap:        0 kB
> HugetlbPages:          0 kB
> Threads:        2
> SigQ:   6/514067
> SigPnd: 0000000000000000
> ShdPnd: 0000000000000000
> SigBlk: 0000000010002240
> SigIgn: 0000000000001000
> SigCgt: 0000000180004243
> CapInh: 0000000000000000
> CapPrm: 0000000000000000
> CapEff: 0000000000000000
> CapBnd: 0000003fffffffff
> CapAmb: 0000000000000000
> Seccomp:        0
> Cpus_allowed:   ffff,ffffffff
> Cpus_allowed_list:      0-47
> Mems_allowed:   00000000,00000003
> Mems_allowed_list:      0-1
> voluntary_ctxt_switches:        7638
> nonvoluntary_ctxt_switches:     3


--
Alex Benn=C3=A9e
