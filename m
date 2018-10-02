Received: from eggs.gnu.org ([2001:4830:134:3::10]:33744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7Fcf-0004yz-Li
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7Fce-0002Ul-ID
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:01:37 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:39077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7Fcb-0002Q2-R6
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:01:34 -0400
Received: by mail-ot1-x32b.google.com with SMTP id c20-v6so1003843otl.6
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 01:01:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lg7hlend.fsf@linaro.org>
References: <CAFEAcA-T7-PcKLwPr0VO0wrwW3x+w2WbdEjTjN2YfWOmZXyfUg@mail.gmail.com>
	<87lg7hlend.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 09:01:11 +0100
Message-ID: <CAFEAcA8ZW_rDyUg0G+agmBfNc8dNVc7r1pdu-Tyb6cvLXdvzHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] racing between pause_all_vcpus() and
 qemu_cpu_stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>

On 1 October 2018 at 19:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> I would have thought the reset code should be scheduled via safe async
> work to run in the vCPU context. Why should the main loop get involved
> at all here?

The reset code is much older than the safe-async support for
running things in the vCPU context... Also, does the safe
async support work with KVM/HAX/Hypervisor.Framework? The
reset code has to handle all those, not just TCG.

Plus, which vCPU thread would you use? We're resetting
the entire system, so privileging an arbitrary vCPU
thread to do that doesn't seem any less odd than using
the main loop thread.

thanks
-- PMM
