Received: from eggs.gnu.org ([2001:4830:134:3::10]:45647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhTB-0000XP-Lb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhTA-00033q-RA
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:20:53 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZhTA-00033S-La
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:20:52 -0500
Received: by mail-oi0-x242.google.com with SMTP id g128so2232780oib.11
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:20:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218174552.18871-3-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<20171218174552.18871-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 18:20:31 +0000
Message-ID: <CAFEAcA9igMy9u0WdTBvJWms1G4Cd2m0QXUucJeXCJ1Uo=7OAMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/23] target/arm: Add SVE decode skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 18 December 2017 at 17:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Including only 4, as-yet unimplemented, instruction patterns
> so that the whole thing compiles.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.h | 111 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c |  91 +++++++------------------------------
>  target/arm/translate-sve.c |  48 ++++++++++++++++++++
>  .gitignore                 |   1 +
>  target/arm/Makefile.objs   |  11 +++++
>  target/arm/sve.def         |  45 ++++++++++++++++++
>  6 files changed, 233 insertions(+), 74 deletions(-)
>  create mode 100644 target/arm/translate-a64.h
>  create mode 100644 target/arm/translate-sve.c
>  create mode 100644 target/arm/sve.def

This will be easier to review if you split the stuff that's
purely code motion from the .c file to the .h into its own
patch.


> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index c2d32988f9..d1ca1f799b 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -10,3 +10,14 @@ obj-y += gdbstub.o
>  obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
>  obj-y += crypto_helper.o
>  obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
> +
> +DECODETREE = $(SRC_PATH)/scripts/decodetree.py
> +
> +target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.def $(DECODETREE)
> +       $(call quiet-command,\
> +         $(PYTHON) $(DECODETREE) -o $@ --decode disas_sve \
> +               $(SRC_PATH)/target/arm/sve.def || rm -f $@, \
> +               "GEN", $@)
> +
> +target/arm/translate-sve.o: target/arm/decode-sve.inc.c
> +obj-$(TARGET_AARCH64) += translate-sve.o

If we're serious about the idea that this decoder script is
general purpose, we should have a rules.mak rune for
generally invoking it to create a decode-foo.inc.c from a foo.def.

thanks
-- PMM
