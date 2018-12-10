Received: from eggs.gnu.org ([2001:4830:134:3::10]:58650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWLHU-0002wf-LR
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWLHT-0006Qm-O7
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:07:28 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWLHT-0006QR-Hp
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:07:27 -0500
Received: by mail-ot1-x343.google.com with SMTP id v23so10278357otk.9
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 05:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20181207155911.12710-1-peter.maydell@linaro.org>
	<87wooh1w21.fsf@linaro.org>
	<CAFEAcA8x6Xv0dL_zZRzMENhixBFw2xd5=0hYwpDF86FiH_WkSQ@mail.gmail.com>
	<87va411ssi.fsf@linaro.org>
In-Reply-To: <87va411ssi.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 13:07:14 +0000
Message-ID: <CAFEAcA_nGuZhu2q_LWxC1kyk5tgYvfLw41p+VxmDmSN8juHn8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cpus.c: Fix race condition in
 cpu_stop_current()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Jaap Crezee <jaap@jcz.nl>, "patches@linaro.org" <patches@linaro.org>

On Mon, 10 Dec 2018 at 12:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > though I might actually have meant pause_all_vcpus().
> > (For pause_all_vcpus() I think the correct thing is to
> > fix the hw/i386/kvmvapic.c code to work in some other way,
> > and then assert that pause_all_vcpus() is never called from
> > the VCPU thread.)
>
> I thought we had already fixed this, but it is yet another case. See the
> patch_instruction code in the same file. The only niggle is ensuring
> that either the helper is called from last instruction in the block or
> forcing a cpu_exit after queuing the work.

Note that the call to pause_all_vcpus() is inside an
"if (kvm_enabled())" so it doesn't matter what the TCG
code does in the way of dividing code up into blocks.
(Though the comment suggests that making it work in TCG
might be nice in theory.)

thanks
-- PMM
