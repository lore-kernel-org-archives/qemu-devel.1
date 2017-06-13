Received: from eggs.gnu.org ([2001:4830:134:3::10]:40721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dKsS5-00066Z-AH
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dKsS3-0004nz-NP
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:30:13 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dKsS3-0004ke-Dj
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:30:11 -0400
Received: by mail-wr0-x241.google.com with SMTP id 77so3211525wrb.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 13:30:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2dba69fb-2894-5f8b-bc61-abfa97873dcf@tuxfamily.org>
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<20170608184944.19406-10-mrolnik@gmail.com>
	<2dba69fb-2894-5f8b-bc61-abfa97873dcf@tuxfamily.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 13 Jun 2017 23:29:27 +0300
Message-ID: <CAK4993hf9TSqzNAs6-c-TvD2zX7rQDh4X39AyRofehfN_nsRYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v19 09/13] target-avr: adding
 instruction decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Anichang <anichang@protonmail.ch>

this is generated code.

On Tue, Jun 13, 2017 at 11:01 PM, Thomas Huth <huth@tuxfamily.org> wrote:

> On 08.06.2017 20:49, Michael Rolnik wrote:
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Message-Id: <1471522070-77598-10-git-send-email-mrolnik@gmail.com>
> > Signed-off-by: Richard Henderson <rth@twiddle.net>
> > ---
> >  target/avr/Makefile.objs |   1 +
> >  target/avr/decode.c      | 691 ++++++++++++++++++++++++++++++
> +++++++++++++++++
> >  target/avr/translate.c   |   2 +
> >  3 files changed, 694 insertions(+)
> >  create mode 100644 target/avr/decode.c
> >
> > diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
> > index a448792ff3..9848b1cb4c 100644
> > --- a/target/avr/Makefile.objs
> > +++ b/target/avr/Makefile.objs
> > @@ -21,4 +21,5 @@
> >  obj-y += translate.o cpu.o helper.o
> >  obj-y += gdbstub.o
> >  obj-y += translate-inst.o
> > +obj-y += decode.o
> >  obj-$(CONFIG_SOFTMMU) += machine.o
> > diff --git a/target/avr/decode.c b/target/avr/decode.c
> > new file mode 100644
> > index 0000000000..2d2e54e448
> > --- /dev/null
> > +++ b/target/avr/decode.c
> > @@ -0,0 +1,691 @@
> > +/*
> > + * QEMU AVR CPU
> > + *
> > + * Copyright (c) 2016 Michael Rolnik
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> > + */
> > +
> > +#include <stdint.h>
> > +#include "translate.h"
> > +
> > +void avr_decode(uint32_t pc, uint32_t *l, uint32_t c,
> translate_function_t *t)
> > +{
> > +    uint32_t opc = extract32(c, 0, 16);
> > +    switch (opc & 0x0000d000) {
> > +        case 0x00000000: {
> > +            switch (opc & 0x00002c00) {
> > +                case 0x00000000: {
> > +                    switch (opc & 0x00000300) {
> > +                        case 0x00000000: {
> > +                            *l = 16;
> > +                            *t = &avr_translate_NOP;
> > +                            break;
> > +                        }
> > +                        case 0x00000100: {
> > +                            *l = 16;
> > +                            *t = &avr_translate_MOVW;
> > +                            break;
> > +                        }
> > +                        case 0x00000200: {
> > +                            *l = 16;
> > +                            *t = &avr_translate_MULS;
> > +                            break;
> > +                        }
> > +                        case 0x00000300: {
> > +                            switch (opc & 0x00000088) {
> > +                                case 0x00000000: {
> > +                                    *l = 16;
> > +                                    *t = &avr_translate_MULSU;
> > +                                    break;
> > +                                }
> > +                                case 0x00000008: {
> > +                                    *l = 16;
> > +                                    *t = &avr_translate_FMUL;
> > +                                    break;
> > +                                }
> > +                                case 0x00000080: {
> > +                                    *l = 16;
> > +                                    *t = &avr_translate_FMULS;
> > +                                    break;
> > +                                }
> > +                                case 0x00000088: {
> > +                                    *l = 16;
> > +                                    *t = &avr_translate_FMULSU;
> > +                                    break;
> > +                                }
> > +                            }
> > +                            break;
> > +                        }
> > +                    }
> > +                    break;
> > +                }
> [...]
>
> This functions with all those nested switch-statements is really huge
> and hard to read. Could you split it up in multiple functions or use
> tables instead?
>
> Also coding style is not very space-saving here ... you don't need most
> of the curly braces, and it is more common nowadays to put the "case" on
> the same indentation level as the "switch" keyword.
>
>  Thomas
>



-- 
Best Regards,
Michael Rolnik
