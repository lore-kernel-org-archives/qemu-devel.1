Received: from eggs.gnu.org ([2001:4830:134:3::10]:33012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ca0Dr-0006wr-EC
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 08:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ca0Dq-0006fD-Km
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 08:17:47 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ca0Dq-0006ev-CH
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 08:17:46 -0500
Received: by mail-wm0-x230.google.com with SMTP id c85so69570474wmi.1
	for <qemu-devel@nongnu.org>; Sat, 04 Feb 2017 05:17:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b9eaacfd-74ab-68ef-dc46-488ef8427aa9@greensocs.com>
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
	<CAFEAcA9J-F4bVONk_Yhafx3T6R2POW9=pAbLdY+5iW_R_fmBCw@mail.gmail.com>
	<b9eaacfd-74ab-68ef-dc46-488ef8427aa9@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Feb 2017 13:17:24 +0000
Message-ID: <CAFEAcA8XzkghP+p=QJj0Qba89m_-VtAN3CvGO6rqLZkTa-EHKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 0/5] execute code from mmio area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frederic Konrad <fred.konrad@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Mark Burton <mark.burton@greensocs.com>

On 4 February 2017 at 12:52, Frederic Konrad <fred.konrad@greensocs.com> wrote:
> Is that the case that we might get a Bad RAM address error or some such
> if we are not on a page boundary (or too small as you say)?
> I guess this is a limitation. Mapping on a page boundary shouldn't be
> too much restrictive.

Yeah. I really ought to look more closely at what the flow of
execution is here, because I think how it works right now
is a bit weird and works as much by luck as by judgement
(we can longjump out of the middle of translating code
right back to the cpu-exec.c loop, and in some cases
I think what happens is that we try to translate code,
and as part of the "load didn't work" code path we
nestedly try to translate the same thing again which
of course fails again, only the second time around we
realize and longjump out.

(At the moment for linux-user mode this is causing us to
assert about taking the tb lock twice, because we hold
the tb lock during translation and then try to grab it
again to do the cpu_restore_state() in the signal handler.)

thanks
-- PMM
