Received: from eggs.gnu.org ([2001:4830:134:3::10]:58313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkwwv-0006Ra-ON
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 15:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkwwu-0001Dz-MA
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 15:38:21 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkwwu-0001D2-Fu
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 15:38:20 -0400
Received: by mail-oi0-x244.google.com with SMTP id d189-v6so36761454oib.6
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 12:38:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868ECFD24601E06677D4C55C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-8-git-send-email-aleksandar.markovic@rt-rk.com>
	<4bc391e5-9aac-57c6-7173-0fdd7a25bccc@vivier.eu>
	<BN7PR08MB4868ECFD24601E06677D4C55C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Aug 2018 20:37:59 +0100
Message-ID: <CAFEAcA9xdOSKY6LRRYM4HZQx=xbFiD1-24zMGn-i7BiDWqTZSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 07/76] elf: Remove duplicate
 preprocessor constant definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

On 1 August 2018 at 19:51, Aleksandar Markovic <amarkovic@wavecomp.com> wro=
te:
> Hi, Laurent.
>
>> From: Laurent Vivier <laurent@vivier.eu>
>> Sent: Monday, July 30, 2018 6:49 PM
>>
>> Le 30/07/2018 =C3=A0 18:11, Aleksandar Markovic a =C3=A9crit :
>> > diff --git a/include/elf.h b/include/elf.h
>> > index 934dbbd..c8aaa2a 100644
>> > --- a/include/elf.h
>> > +++ b/include/elf.h
>> > @@ -33,7 +33,6 @@ typedef int64_t  Elf64_Sxword;
>> >
>> >  /* Flags in the e_flags field of the header */
>> >  /* MIPS architecture level. */
>> > -#define EF_MIPS_ARCH            0xf0000000
>> >
>> >  /* Legal values for MIPS architecture level.  */
>> >  #define EF_MIPS_ARCH_1               0x00000000      /* -mips1 code. =
 */
>> >
>>
>> You should move the comment "MIPS architecture level" where the other
>> EF_MIPS_ARCH is defined (see glibc or system elf.h).
>>
>> Thanks,
>> Laurent
>
> The comment "/* MIPS architecture level */" was present both
> before and after the commit 45506bdd. The scope of this patch
> is to rollback a duplicate preprocessor definition originating
> from the commit 45506bdd. This means that moving/modifying
> comments should not be in this patch. Can you please clarify
> for me what additional changes you suggest (but these should
> definitely be in a separate patch)? Do you want to sync this
> segment of QEMU's elf.h (copied below) with glibc corresponding
> section from its elf.h (also below)?

It seems to me that the logical place for defining EF_MIPS_ARCH
is next to the definitions EF_MIPS_ARCH_1 &c which give the
valid values for that field. It's likely because the
pre-45506bdd QEMU header didn't put the two together as
you'd expect that the duplicate got added.

We should fix the duplication not by just rolling back to
pre-45506bdd, but in a way that gets us to having the
EF_MIPS_ARCH and EF_MIPS_ARCH_1 &c in the same place in
the file. The simplest way to do that is just to delete
the second (original) EF_MIPS_ARCH #define, the one just
below the EF_MIPS_NAN2008 define.

We could line up with the order the glibc headers use, but
that seems like overkill compared to just deleting a line.

thanks
-- PMM
