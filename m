Received: from eggs.gnu.org ([2001:4830:134:3::10]:42203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddN1K-00083a-Qq
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddN1I-0004Wx-0f
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 16:47:02 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-3-git-send-email-peter.maydell@linaro.org>
	<3f6ee028-b7f9-fbe0-1aea-eb1e6faab5a3@twiddle.net>
	<20170803204001.GX4859@toto>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4e0cab0f-83ab-0742-988d-9b2615f6ef4b@twiddle.net>
Date: Thu, 3 Aug 2017 13:46:56 -0700
MIME-Version: 1.0
In-Reply-To: <20170803204001.GX4859@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 02/15] target/arm: Don't trap
 WFI/WFE for M profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On 08/03/2017 01:40 PM, Edgar E. Iglesias wrote:
> I don't have the spec at hand but IIRC the trap should only happen
> if the processor would have entered the low-power state (i.e if
> there's no work).

  when SystemHintOp_WFE
    if IsEventRegisterSet() then
      ClearEventRegister();
    else
      if PSTATE.EL == EL0 then
        AArch64.CheckForWFxTrap(EL1, TRUE);
      if HaveEL(EL2) && !IsSecure()
         && PSTATE.EL IN {EL0, EL1} && !IsInHost() then
        AArch64.CheckForWFxTrap(EL2, TRUE);
      if HaveEL(EL3) && PSTATE.EL != EL3 then
        AArch64.CheckForWFxTrap(EL3, TRUE);
      WaitForEvent();

Ah, I see what you mean, since WaitForEvent is also
described as checking EventRegister.

Thanks.


r~
