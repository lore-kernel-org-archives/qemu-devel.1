Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E66ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFF920872
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3+bchj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFF920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yoM-0005HG-Dw
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7ymj-0003RJ-Rf
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7ymh-0006vZ-TI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:19:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7ymh-0006sy-M8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:19:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id d17so10870281wrq.13
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pF62HMpZmO2GC18uvn7ta+ZUSLM8vfweqMpRGxrF/lI=;
 b=B3+bchj2G4FTEtlxFYX8D3lsFnr2MnxixJU5t2DctMQ3NcxRzCE5Cg6Q/+sgP+gYm7
 LmRlnXwS+8wbh1PHBqe53kpkZ2ODSzlbU8EtiZ1JQi2djiu6xGsG6gMGmRR7GqQwapi8
 Ruif994nU6/AIfJgvU4MRSJctDkjSu1VUbfiEWmaoYln88pa01AMIv3oJZ9WrHIgNWLY
 30FoK09BufnTV3JoWL6Gzoq92dP4legoDJc6OOsJQoUaG/0FNvyCF1YcpmuWUot1ee6v
 TbILj8it5Gan77srfc7091zvdaQHPDHwmdo+BPCqK1/YzNzjCvnazpAae6JZ1+M3NOR8
 ZWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pF62HMpZmO2GC18uvn7ta+ZUSLM8vfweqMpRGxrF/lI=;
 b=OulzWGXDz4Z5VwUxvvLsIme54w+neEHUNk1BzBuEJs/oE8mNgPM6rCJy5VPb71SkW7
 XSj09wovmOW+bnARxfDJiPsDcBLpQYDeOVyThKLcCHcyFoM2OvZhJFkVDLHtgiBW/JOx
 C91sL7bYID5PQhn9ctLKeCoA31n7UDnqT7VfmEKnmOf1xocsyPJo+8lpIgY876YV0QgC
 kPt8EijWmqtnWXy7T/tXMPzJopoRT51RqeFTU0Cg6zkOWsu+se//yuskjyI/lFeqSqzY
 fqV2E6MXVvrGlPEryxcorld3/qYLPYDK3Ms9NKCm8eWanl+xhJcsGLtDcQB7OLHJb2GT
 0/vw==
X-Gm-Message-State: APjAAAW25L83/P+VOoE6XZ30ts2q18GCaHpG6Bt/txCCOttrylS8vE2H
 J/VJN0yWyTXFJHtblfCzR2Ov6Q==
X-Google-Smtp-Source: APXvYqzTbsdsWmuo/+wIno+QXDyuGOaxoFjgRpv0I1GlP2v2tMUS4xIv10I7WUT4E4x5jL3ucKKwYA==
X-Received: by 2002:a5d:5045:: with SMTP id h5mr829682wrt.312.1568193569995;
 Wed, 11 Sep 2019 02:19:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z25sm2405620wmk.0.2019.09.11.02.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 02:19:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 834631FF87;
 Wed, 11 Sep 2019 10:19:28 +0100 (BST)
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-3-alex.bennee@linaro.org>
 <alpine.BSF.2.21.9999.1909111015260.4726@zero.eik.bme.hu>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
In-reply-to: <alpine.BSF.2.21.9999.1909111015260.4726@zero.eik.bme.hu>
Date: Wed, 11 Sep 2019 10:19:28 +0100
Message-ID: <875zlz197j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v1 2/4] elf: move elf.h to elf/elf.h and
 split out types
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, qemu-devel@nongnu.org,
 "open list:S390-ccw boot" <qemu-s390x@nongnu.org>, qemu-arm@nongnu.org,
 "open list:PReP" <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Tue, 10 Sep 2019, Alex Benn=C3=A9e wrote:
>> diff --git a/include/elf/elf-types.inc.h b/include/elf/elf-types.inc.h
>> new file mode 100644
>> index 00000000000..35163adb2b5
>> --- /dev/null
>> +++ b/include/elf/elf-types.inc.h
>> @@ -0,0 +1,63 @@
>> +/*
>> + * Elf Type Specialisation
>> + *
>> + * Copyright (c) 2019
>> + * Written by Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> + *
>> + * This code is licensed under the GNU .
>
> You're missing end of licence sentence here. Also original file did
> not have copyright and licence header so you may want to fix that too
> or leave it out here as well for consistency,

The fault of my header macro - I'll try and fix it up when it's
expanding on the QEMU tree.

I'm going to assume that is should be the whole project license (GPL
v2). Most of the original file dates from 2003 and is Frabrice's commit
with the occasional commit mentioning be copied from Linux.

>
>> + */
>> +
>> +#ifndef _ELF_TYPES_INC_H_
>> +#define _ELF_TYPES_INC_H_
>> +
>> +#ifndef ELF_CLASS
>> +#error you must define ELF_CLASS before including elf-types.inc.h
>> +#else
>> +
>> +#if ELF_CLASS =3D=3D ELFCLASS32
>> +
>> +#define elfhdr      elf32_hdr
>> +#define elf_phdr    elf32_phdr
>> +#define elf_note    elf32_note
>> +#define elf_shdr    elf32_shdr
>> +#define elf_sym     elf32_sym
>> +#define elf_addr_t  Elf32_Off
>> +#define elf_rela    elf32_rela
>> +
>> +#ifdef ELF_USES_RELOCA
>> +# define ELF_RELOC  Elf32_Rela
>> +#else
>> +# define ELF_RELOC  Elf32_Rel
>> +#endif
>> +
>> +#ifndef ElfW
>> +#  define ElfW(x)   Elf32_ ## x
>> +#  define ELFW(x)   ELF32_ ## x
>> +#endif
>> +
>> +#else /* ELF_CLASS =3D=3D ELFCLASS64 */
>> +
>> +#define elfhdr      elf64_hdr
>> +#define elf_phdr    elf64_phdr
>> +#define elf_note    elf64_note
>> +#define elf_shdr    elf64_shdr
>> +#define elf_sym     elf64_sym
>> +#define elf_addr_t  Elf64_Off
>> +#define elf_rela    elf64_rela
>> +
>> +#ifdef ELF_USES_RELOCA
>> +# define ELF_RELOC  Elf64_Rela
>> +#else
>> +# define ELF_RELOC  Elf64_Rel
>> +#endif
>> +
>> +#ifndef ElfW
>> +#  define ElfW(x)   Elf64_ ## x
>> +#  define ELFW(x)   ELF64_ ## x
>> +#endif
>> +
>> +#endif /* ELF_CLASS =3D=3D ELFCLASS64 */
>> +#endif /* ELF_CLASS */
>> +#else
>> +#error elf-types.inc.h should not be included twice in one compilation =
unit
>> +#endif /* _ELF_TYPES_INC_H_ */
>> diff --git a/include/elf.h b/include/elf/elf.h
>> similarity index 98%
>> rename from include/elf.h
>> rename to include/elf/elf.h
>> index 3501e0c8d03..2e264c1a7a0 100644
>> --- a/include/elf.h
>> +++ b/include/elf/elf.h
>> @@ -1696,49 +1696,7 @@ struct elf32_fdpic_loadmap {
>> };
>>
>> #ifdef ELF_CLASS
>> -#if ELF_CLASS =3D=3D ELFCLASS32
>> -
>> -#define elfhdr		elf32_hdr
>> -#define elf_phdr	elf32_phdr
>> -#define elf_note	elf32_note
>> -#define elf_shdr	elf32_shdr
>> -#define elf_sym		elf32_sym
>> -#define elf_addr_t	Elf32_Off
>> -#define elf_rela  elf32_rela
>> -
>> -#ifdef ELF_USES_RELOCA
>> -# define ELF_RELOC      Elf32_Rela
>> -#else
>> -# define ELF_RELOC      Elf32_Rel
>> -#endif
>> -
>> -#else
>> -
>> -#define elfhdr		elf64_hdr
>> -#define elf_phdr	elf64_phdr
>> -#define elf_note	elf64_note
>> -#define elf_shdr	elf64_shdr
>> -#define elf_sym		elf64_sym
>> -#define elf_addr_t	Elf64_Off
>> -#define elf_rela  elf64_rela
>> -
>> -#ifdef ELF_USES_RELOCA
>> -# define ELF_RELOC      Elf64_Rela
>> -#else
>> -# define ELF_RELOC      Elf64_Rel
>> -#endif
>> -
>> -#endif /* ELF_CLASS */
>>
>> -#ifndef ElfW
>> -# if ELF_CLASS =3D=3D ELFCLASS32
>> -#  define ElfW(x)  Elf32_ ## x
>> -#  define ELFW(x)  ELF32_ ## x
>> -# else
>> -#  define ElfW(x)  Elf64_ ## x
>> -#  define ELFW(x)  ELF64_ ## x
>> -# endif
>> -#endif
>>
>> #endif /* ELF_CLASS */
>
> Is there anything remaining in this #ifdef ELF_CLASS after this patch?
> If not why do you keep it?
>
> Regards,
> BALATON Zoltan


--
Alex Benn=C3=A9e

