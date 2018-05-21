Received: from eggs.gnu.org ([2001:4830:134:3::10]:55453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKmLA-0002Wd-6X
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fKmL9-0005ah-Bo
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:03:12 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fKmL9-0005aI-7E
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:03:11 -0400
Received: by mail-oi0-x244.google.com with SMTP id k17-v6so13263679oih.5
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 08:03:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c049f864-304d-f8ee-4b2f-1476a602be30@redhat.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-24-peter.maydell@linaro.org>
	<c049f864-304d-f8ee-4b2f-1476a602be30@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 16:02:49 +0100
Message-ID: <CAFEAcA_ErfYKnVrp=Dv9mNg55Y+=fFmg4eEMddGdMxUGVb9ztA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 21 May 2018 at 15:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Why do the levels have to be migrated at all?  It should be enough if
> the IRQ level is either migrated manually, or restored (e.g. in
> post_save callbacks) through other data that is migrated.

This is standard behaviour for devices: they track their
inbound irq/gpio lines, and then that becomes internal state for
them that must be migrated.

If we didn't migrate the input line state, then after a migration
the levels[] array would be all zeroes, and the next time a
connected device signalled a high-to-low transition we'd take
the output line low even if it should not be (because we'd have
forgotten that some other input lines were high).

In a different world, the state would be in the qemu_irq line itself
(in the same way that in hardware signal lines are their own state),
but we can't get there from here.

thanks
-- PMM
