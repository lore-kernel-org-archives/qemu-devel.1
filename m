Received: from eggs.gnu.org ([2001:4830:134:3::10]:36475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1cf95m-0002h1-QE
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 12:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1cf95h-0008G7-F7
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 12:46:42 -0500
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-4-git-send-email-peter.maydell@linaro.org>
	<87mvdnvcxx.fsf@linaro.org>
	<CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
	<CAFEAcA8X1qvweDHBWQjZwH68xWdn4K+Wfqv0yRhjM5QCxd=VBA@mail.gmail.com>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <1e2962d7-1b50-9543-3e1d-9c388d4167c3@gmail.com>
Date: Sat, 18 Feb 2017 12:45:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8X1qvweDHBWQjZwH68xWdn4K+Wfqv0yRhjM5QCxd=VBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] armv7m: Rewrite NVIC to not use any
 GIC code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Liviu Ionescu <ilg@livius.net>

On 02/16/2017 09:11 AM, Peter Maydell wrote:
> I haven't actually checked real hardware behaviour, but I think
> we can fairly safely implement this as not checking the IPSR
> exception field. (We might as well go with the "reads 1 in
> handler mode" choice of UNKNOWN that the M3 documents, though.)

For what it's worth, I dug up my TI TM4C1294 eval board and re-ran
test10.c [1] which is designed to probe this behavior by nesting
exceptions PendSV within SVC.  RETTOBASE is 0x800 in ICSR.

> 1..12
> # BASEPRI mask 000000e0
> # DEBUG prio 000000e0
> ok 1 - 00000000 == 00000000 ICSR
> ok 2 - 00000000 == 00000000 SHCSR
> # Call SVC
> # In SVC
> ok 3 - 0000080b == 0000080b ICSR
> ok 4 - 00000080 == 00000080 SHCSR
> # In PendSV
> ok 5 - 0000000e == 0000000e ICSR
> ok 6 - 00000480 == 00000480 SHCSR
> # Back in SVC
> ok 7 - 00000003 == 00000003 Back in SVC
> ok 8 - 0000080b == 0000080b ICSR
> ok 9 - 00000080 == 00000080 SHCSR
> # Back in main
> ok 10 - 00000004 == 00000004 Back in main
> ok 11 - 00000000 == 00000000 ICSR
> ok 12 - 00000000 == 00000000 SHCSR
> # Done

[1] https://github.com/mdavidsaver/baremetal/blob/qemutest/test10.c
