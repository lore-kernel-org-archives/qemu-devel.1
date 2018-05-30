Received: from eggs.gnu.org ([2001:4830:134:3::10]:47341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO4Rx-0002n0-4C
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO4Rt-0008OR-Tn
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:59:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fO4Rt-0008Mn-NP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:59:45 -0400
Received: by mail-wr0-f195.google.com with SMTP id v13-v6so18565235wrp.13
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 09:59:45 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-24-peter.maydell@linaro.org>
	<c049f864-304d-f8ee-4b2f-1476a602be30@redhat.com>
	<CAFEAcA_ErfYKnVrp=Dv9mNg55Y+=fFmg4eEMddGdMxUGVb9ztA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <530bef1b-a143-1566-3089-32629ab250b8@redhat.com>
Date: Wed, 30 May 2018 18:59:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ErfYKnVrp=Dv9mNg55Y+=fFmg4eEMddGdMxUGVb9ztA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/27] hw/core/or-irq: Support more than 16
 inputs to an OR gate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 21/05/2018 17:02, Peter Maydell wrote:
> On 21 May 2018 at 15:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Why do the levels have to be migrated at all?  It should be enough if
>> the IRQ level is either migrated manually, or restored (e.g. in
>> post_save callbacks) through other data that is migrated.
> This is standard behaviour for devices: they track their
> inbound irq/gpio lines, and then that becomes internal state for
> them that must be migrated.

But or_irq's input are another device's outbound lines, so tracking them
should not be necessary.  The other device would do it for or_irq.

Paolo

> If we didn't migrate the input line state, then after a migration
> the levels[] array would be all zeroes, and the next time a
> connected device signalled a high-to-low transition we'd take
> the output line low even if it should not be (because we'd have
> forgotten that some other input lines were high).
> 
> In a different world, the state would be in the qemu_irq line itself
> (in the same way that in hardware signal lines are their own state),
> but we can't get there from here.
