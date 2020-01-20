Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514CEC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203AF207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvDnU5lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203AF207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itVD1-00073V-At
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itVBm-0005yy-Ti
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itVBl-0005z7-4M
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:25:50 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itVBk-0005yj-Sq
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:25:49 -0500
Received: by mail-wm1-x343.google.com with SMTP id f129so14333327wmf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 03:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RdgNFyDqnBtzrNj/JHMkDwuD7DjGpRvyTKmhZMX7m/c=;
 b=pvDnU5lISivdAN99egbHGzmcUd859EVnL+u29P153Xxs9j9cFt8Iz3myMuQAUNk/YK
 l1PcpQuWSrc6BNcRROBBwPToEQTd+VkH+QnRfVTolIPaBsdmqp4CJJRN55dQVjDuhE6R
 0BLXqeWcDxdcWaesI/7ScYPeX3MuR/vs4VTVTu+sCnB0ugYfFkNA3WX/3M5ogSWxiUPF
 6J2XiEKBZ8qpWB0iUj7OJCaapfi632aahj73ImJkxoPmQLp1QVRQcWluDudGZjs0kQo+
 HNv08b8OvBaNoUjUhzl5VVPhNQ6d48OaS5O8OCpjGB+Ds90AlnFh5hyxqAdtYSlfKnBn
 gMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RdgNFyDqnBtzrNj/JHMkDwuD7DjGpRvyTKmhZMX7m/c=;
 b=CUoFT65Cbqloci/KWR+IlTLmjxSOUGHTBy6jMA5OJ1WoB93jeqQh/F7lFTVXjB2BLx
 lA9NtO9wGa9xQODnGSBEIpX4LSX6zQWkO8DJaL7kjs9vIIa2TZNquVQ4GhJueYx11Nh+
 +OCABx95+3AvsYjjURW3F0V/wCdtMGgfKS7hsNfIA1wQKRchz3BMWKoSTnT2yWDXm+iu
 6xkjodE+0fw5hg+Q5Z7mSQLtfjoKfm25NjmwthBqS7Dgt4pp+PpeS8CtY2yx1GkeUjaw
 Bpz1WZ9omAsPDJd9ZwydySbfYWZ44xrJ40azXxq2CtH+wkCV6duCmywxAI1t4Q8qX5q3
 41Jg==
X-Gm-Message-State: APjAAAVMlZuo5IWT+1+8WP2VX6R6fcWiSxhtvGSXj6T4+FH5nmJlbfAd
 7pxuhIdfEj8A4PQ8KTWqf8KL4w==
X-Google-Smtp-Source: APXvYqwrydQq/LOjWM8Jk4UWjeFtwzF6hu/x/BCeG54TZ2pEVjxhMzZN/e5uRgVvC8hHeEb4EYMV1w==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr18460766wmd.9.1579519547582; 
 Mon, 20 Jan 2020 03:25:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm48666100wrn.33.2020.01.20.03.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 03:25:46 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D46B71FF87;
 Mon, 20 Jan 2020 11:25:45 +0000 (GMT)
References: <20200117230245.5040-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] linux-user: Reserve space for brk
In-reply-to: <20200117230245.5040-1-richard.henderson@linaro.org>
Date: Mon, 20 Jan 2020 11:25:45 +0000
Message-ID: <871rru4beu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> With bad luck, we can wind up with no space at all for brk,
> which will generally cause the guest malloc to fail.
>
> This bad luck is easier to come by with ET_DYN (PIE) binaries,
> where either the stack or the interpreter (ld.so) gets placed
> immediately after the main executable.
>
> But there's nothing preventing this same thing from happening
> with ET_EXEC (normal) binaries, during probe_guest_base().
>
> In both cases, reserve some extra space via mmap and release
> it back to the system after loading the interpreter and
> allocating the stack.
>
> The choice of 16MB is somewhat arbitrary.  It's enough for libc
> to get going, but without being so large that 32-bit guests or
> 32-bit hosts are in danger of running out of virtual address space.
> It is expected that libc will be able to fall back to mmap arenas
> after the limited brk space is exhausted.
>
> Launchpad: https://bugs.launchpad.net/qemu/+bug/1749393
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

and I can debootstrap buster again ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>
> Note that the LP comments mention the fix for this in the kernel,
> and about there being a "guaranteed 128MB gap" for x86_64.  As far
> as I can see, this "gap" is part of the unmapped_area() algorithm.
> For qemu, this would correspond to mmap_find_vma(), except that,
> except when we fall back to mmap_find_vma_reserved(), we are not
> 100% in control over the allocation.
>
>
> r~
>
> ---
>  linux-user/qemu.h    |  1 +
>  linux-user/elfload.c | 73 +++++++++++++++++++++++++++++++++-----------
>  2 files changed, 57 insertions(+), 17 deletions(-)
>
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index f6f5fe5fbb..560a68090e 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -35,6 +35,7 @@ struct image_info {
>          abi_ulong       end_data;
>          abi_ulong       start_brk;
>          abi_ulong       brk;
> +        abi_ulong       reserve_brk;
>          abi_ulong       start_mmap;
>          abi_ulong       start_stack;
>          abi_ulong       stack_limit;
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 07b16cc0f4..2edb5d5b31 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -10,6 +10,7 @@
>  #include "qemu/path.h"
>  #include "qemu/queue.h"
>  #include "qemu/guest-random.h"
> +#include "qemu/units.h"
>=20=20
>  #ifdef _ARCH_PPC64
>  #undef ARCH_DLINFO
> @@ -2364,24 +2365,51 @@ static void load_elf_image(const char *image_name=
, int image_fd,
>          }
>      }
>=20=20
> -    load_addr =3D loaddr;
> -    if (ehdr->e_type =3D=3D ET_DYN) {
> -        /* The image indicates that it can be loaded anywhere.  Find a
> -           location that can hold the memory space required.  If the
> -           image is pre-linked, LOADDR will be non-zero.  Since we do
> -           not supply MAP_FIXED here we'll use that address if and
> -           only if it remains available.  */
> -        load_addr =3D target_mmap(loaddr, hiaddr - loaddr, PROT_NONE,
> -                                MAP_PRIVATE | MAP_ANON | MAP_NORESERVE,
> -                                -1, 0);
> -        if (load_addr =3D=3D -1) {
> -            goto exit_perror;
> +    if (pinterp_name !=3D NULL) {
> +        /*
> +         * This is the main executable.
> +         *
> +         * Reserve extra space for brk.
> +         * We hold on to this space while placing the interpreter
> +         * and the stack, lest they be placed immediately after
> +         * the data segment and block allocation from the brk.
> +         *
> +         * 16MB is chosen as "large enough" without being so large
> +         * as to allow the result to not fit with a 32-bit guest on
> +         * a 32-bit host.
> +         */
> +        info->reserve_brk =3D 16 * MiB;
> +        hiaddr +=3D info->reserve_brk;
> +
> +        if (ehdr->e_type =3D=3D ET_EXEC) {
> +            /*
> +             * Make sure that the low address does not conflict with
> +             * MMAP_MIN_ADDR or the QEMU application itself.
> +             */
> +            probe_guest_base(image_name, loaddr, hiaddr);
>          }
> -    } else if (pinterp_name !=3D NULL) {
> -        /* This is the main executable.  Make sure that the low
> -           address does not conflict with MMAP_MIN_ADDR or the
> -           QEMU application itself.  */
> -        probe_guest_base(image_name, loaddr, hiaddr);
> +    }
> +
> +    /*
> +     * Reserve address space for all of this.
> +     *
> +     * In the case of ET_EXEC, we supply MAP_FIXED so that we get
> +     * exactly the address range that is required.
> +     *
> +     * Otherwise this is ET_DYN, and we are searching for a location
> +     * that can hold the memory space required.  If the image is
> +     * pre-linked, LOADDR will be non-zero, and the kernel should
> +     * honor that address if it happens to be free.
> +     *
> +     * In both cases, we will overwrite pages in this range with mappings
> +     * from the executable.
> +     */
> +    load_addr =3D target_mmap(loaddr, hiaddr - loaddr, PROT_NONE,
> +                            MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
> +                            (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED : 0=
),
> +                            -1, 0);
> +    if (load_addr =3D=3D -1) {
> +        goto exit_perror;
>      }
>      load_bias =3D load_addr - loaddr;
>=20=20
> @@ -2860,6 +2888,17 @@ int load_elf_binary(struct linux_binprm *bprm, str=
uct image_info *info)
>      bprm->core_dump =3D &elf_core_dump;
>  #endif
>=20=20
> +    /*
> +     * If we reserved extra space for brk, release it now.
> +     * The implementation of do_brk in syscalls.c expects to be able
> +     * to mmap pages in this space.
> +     */
> +    if (info->reserve_brk) {
> +        abi_ulong start_brk =3D HOST_PAGE_ALIGN(info->brk);
> +        abi_ulong end_brk =3D HOST_PAGE_ALIGN(info->brk + info->reserve_=
brk);
> +        target_munmap(start_brk, end_brk - start_brk);
> +    }
> +
>      return 0;
>  }


--=20
Alex Benn=C3=A9e

