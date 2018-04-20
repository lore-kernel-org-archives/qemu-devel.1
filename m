Received: from eggs.gnu.org ([2001:4830:134:3::10]:56077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9TTr-0007u3-QK
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9TTr-00084X-43
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:41:27 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:45127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9TTq-00083t-WF
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:41:27 -0400
Received: by mail-ot0-x231.google.com with SMTP id w4-v6so9093517ote.12
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 03:41:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523997485-1905-4-git-send-email-alindsay@codeaurora.org>
References: <1523997485-1905-1-git-send-email-alindsay@codeaurora.org>
	<1523997485-1905-4-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 11:41:05 +0100
Message-ID: <CAFEAcA-zeQ8T7_ngYm_q+MBJKk6ueMtg5ekLTBJS94tzqTyGkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 03/21] target/arm: Reorganize PMCCNTR
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 17 April 2018 at 21:37, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> pmccntr_read and pmccntr_write contained duplicate code that was already
> being handled by pmccntr_sync. Consolidate the duplicated code into two
> functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
> c15_ccnt in CPUARMState so that we can simultaneously save both the
> architectural register value and the last underlying cycle count - this
> ensure time isn't lost and will also allow us to access the 'old'
> architectural register value in order to detect overflows in later
> patches.

Can we handle the overflow case by setting up a timer that will
expire when the counter would overflow? We'll want that anyway
to be able to signal an interrupt on overflows. That would avoid
the need to have an extra field in the CPU state structure, I think.
Since PMCCNTR_EL0 is 64 bits it's not going to overflow very often
so the slight overhead of a timer firing is not going to be a
problem...

thanks
-- PMM
