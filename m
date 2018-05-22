Received: from eggs.gnu.org ([2001:4830:134:3::10]:60678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLCvW-0004iL-Ms
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLCvV-0006RD-Rh
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:26:30 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLCvV-0006Qo-MO
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:26:29 -0400
Received: by mail-ot0-x244.google.com with SMTP id h8-v6so22358720otb.2
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 12:26:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d8c13782-48b1-0975-ee2c-0d2ec2eecebe@kaod.org>
References: <20180522173713.26282-1-peter.maydell@linaro.org>
	<d8c13782-48b1-0975-ee2c-0d2ec2eecebe@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 20:26:08 +0100
Message-ID: <CAFEAcA_3P-JEsiz_3ZdVhG2kcQ+Y3yOAufLQtHknuzufRosANQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Correct CPACR reset value for v7 cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 22 May 2018 at 20:06, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 05/22/2018 07:37 PM, Peter Maydell wrote:
>> This is sufficient that a save-and-reload while the romulus-bmc
>> machine is in the bootloader will work. On the other hand if
>> I do a save-and-reload after the kernel has started booting
>> then we get the classic "guest hang after reload", so some
>> state is still not being transferred somewhere (probably in
>> a device in the machine model?)
>
> I see the problem. Bizarre.

Usually it means that something in the path from timer device
through to the CPU has failed to save-and-reload the state
that it needs to, so that when the timer fires post-reload
it doesn't actually cause a CPU interrupt. You can probably
debug by putting a breakpoint on whatever looks like a likely
timer device's 'set the irq line' function and stepping
through to figure out what's happening.

(You're not using trustzone, are you? I know of a bug with
migration of cpus with TZ enabled which I'm probably going to
look at later this week)

thanks
-- PMM
