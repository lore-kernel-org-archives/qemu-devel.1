Received: from eggs.gnu.org ([2001:4830:134:3::10]:53805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTXBf-0004cm-IP
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTXBe-0006he-MK
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:37:03 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dTXBe-0006gM-FH
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:37:02 -0400
Received: by mail-wr0-x231.google.com with SMTP id k67so55988086wrc.2
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 10:37:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87inj49mr1.fsf@linaro.org>
References: <20170707161822.29659-1-alex.bennee@linaro.org>
	<87inj49mr1.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jul 2017 18:36:40 +0100
Message-ID: <CAFEAcA_YvS8OQVTPnvRtWyVuAKO2bccyNALOs1Oq7snTO1WwkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: ensure eret exits the
 run-loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Etienne Carriere <etienne.carriere@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>

On 7 July 2017 at 18:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Given the wording of:
>
> /* is_jmp field values */
> #define DISAS_NEXT    0 /* next instruction can be analyzed */
> #define DISAS_JUMP    1 /* only pc was modified dynamically */
> #define DISAS_UPDATE  2 /* cpu state was modified dynamically */
> #define DISAS_TB_JUMP 3 /* only pc was modified statically */
>
> I'm thinking that really these DISAS_JUMP's should be DISAS_UPDATEs and
> we need to disable the TB chaining optimisations for this. I'll prepare
> a more comprehensive series next week. However testing this patch for
> known failure modes will be useful.

The problem I think is that a lot of our current code assumes
that DISAS_UPDATE means "go back to the top loop".

In any case I think you are right that DISAS_UPDATE should not
allow chaining to the next TB, because it implies that perhaps
a TB flags bit got changed, so you need to look in the hash
table again.

thanks
-- PMM
