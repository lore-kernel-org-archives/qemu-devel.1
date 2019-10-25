Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D12CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D727F20663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fgw49us/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D727F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0Kr-0006Mz-Sq
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO0Ao-000340-K2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO0Am-0007Pc-O9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:02:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO0Am-0007PA-Fw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:02:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id r141so2125946wme.4
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=guq5J78UShi1OteZ2oPTiw1h2oDmPFvjT9o2d5zZ77Q=;
 b=Fgw49us/j/uj+h595ZK4CYk++nqjiZnCU5JTU7k+7AB1vANRWBJbQHSDcWc8Aj3KSo
 +GPUky6cCjtYfkkG4Zl/hpfnsqczBZnTJR1h1JpCuk8sBApXBkISvWARUuQ1c7c624AB
 8xTp7oe7M01KjDkO/GPj0t+ZuSBQfeHS3mjDEKAZQ9xYpEe9Ys2W9mtv3Vh36AG9U+NU
 ZtJzFzJG5iDcseqIIr+3sdx6UkhCqXsdPee89+uEyx8cUpD9BScx85yMFWyCKDT7touw
 Bu2uV4n18nAMmRF+Amde0bAOpJzSc/Z9FcC7bxghK85cuj21u91QWHf/5AhtQmA+owOq
 nalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=guq5J78UShi1OteZ2oPTiw1h2oDmPFvjT9o2d5zZ77Q=;
 b=lPhls1c7bVEAmAsqof5QxG+LnIdWvGfc2crlfYJj4Moe7E/qqApEeIYLfrX5zpksiW
 emTPZq8471uXJUTLH1ByjKYAo34isQ9I5AA3DC3MDXn21WCuXn1lOILj2u6IBClA1rrI
 9Ei4wexAfh4hYcu6kpcu5If+aLqB2J2cdBMPiApYA77sy68UjP+H/sKgs8SOzZczOprp
 BbCuuUdVIJPT9LdywD/zxHDmJX5P/+QDINPGWE+S7IQJQqfvsyopRaeAV2xbiRAjiXpc
 rNfgatKh2jKgPZ3trbJF1IT63Rhy5+s1CoEIE1sVmmGtpvVJUvLVSOb0fgS5VuBXcaGq
 Qt/w==
X-Gm-Message-State: APjAAAW63nSLqXC9t8FqRzjCYu2Xs7+vLspRCubo74aUMEwqM+isCBEi
 TcKByxRGG93SGl+O34DkKKAJ/A==
X-Google-Smtp-Source: APXvYqwoM08KyrJMKTHp439V5I1d7waH80D8zThz70+vMEtnhHF5sDbBJk/grw9ThcO0SOF4c5BRFQ==
X-Received: by 2002:a05:600c:2948:: with SMTP id
 n8mr3576531wmd.128.1572012154843; 
 Fri, 25 Oct 2019 07:02:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t4sm1589860wmi.39.2019.10.25.07.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:02:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3672F1FF87;
 Fri, 25 Oct 2019 15:02:33 +0100 (BST)
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 2/7] exec: Split out variable page size support to
 exec-vary.c
In-reply-to: <20191023154505.30521-3-richard.henderson@linaro.org>
Date: Fri, 25 Oct 2019 15:02:33 +0100
Message-ID: <87wocsly86.fsf@linaro.org>
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The next patch will play a trick with "const" that will
> confuse the compiler about the uses of target_page_bits
> within exec.c.  Moving everything to a new file prevents
> this confusion.
>
> No functional change so far.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile.target       |  2 +-
>  include/qemu-common.h |  6 +++++
>  exec-vary.c           | 57 +++++++++++++++++++++++++++++++++++++++++++
>  exec.c                | 34 --------------------------
>  4 files changed, 64 insertions(+), 35 deletions(-)
>  create mode 100644 exec-vary.c
>
> diff --git a/Makefile.target b/Makefile.target
> index 5e916230c4..ca3d14efe1 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -107,7 +107,7 @@ obj-y +=3D trace/
>
>  #########################################################
>  # cpu emulator library
> -obj-y +=3D exec.o
> +obj-y +=3D exec.o exec-vary.o
>  obj-y +=3D accel/
>  obj-$(CONFIG_TCG) +=3D tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-o=
p-gvec.o
>  obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o tcg/optimize.o
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 8d84db90b0..082da59e85 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -74,6 +74,12 @@ void cpu_exec_step_atomic(CPUState *cpu);
>   */
>  bool set_preferred_target_page_bits(int bits);
>
> +/**
> + * finalize_target_page_bits:
> + * Commit the final value set by set_preferred_target_page_bits.
> + */
> +void finalize_target_page_bits(void);
> +
>  /**
>   * Sends a (part of) iovec down a socket, yielding when the socket is fu=
ll, or
>   * Receives data into a (part of) iovec from a socket,
> diff --git a/exec-vary.c b/exec-vary.c
> new file mode 100644
> index 0000000000..48c0ab306c
> --- /dev/null
> +++ b/exec-vary.c
> @@ -0,0 +1,57 @@
> +/*
> + * Variable page size handling
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "exec/exec-all.h"
> +
> +#ifdef TARGET_PAGE_BITS_VARY
> +int target_page_bits;
> +bool target_page_bits_decided;
> +#endif
> +
> +bool set_preferred_target_page_bits(int bits)
> +{
> +    /*
> +     * The target page size is the lowest common denominator for all
> +     * the CPUs in the system, so we can only make it smaller, never
> +     * larger. And we can't make it smaller once we've committed to
> +     * a particular size.
> +     */
> +#ifdef TARGET_PAGE_BITS_VARY
> +    assert(bits >=3D TARGET_PAGE_BITS_MIN);
> +    if (target_page_bits =3D=3D 0 || target_page_bits > bits) {
> +        if (target_page_bits_decided) {
> +            return false;
> +        }
> +        target_page_bits =3D bits;
> +    }
> +#endif
> +    return true;
> +}
> +
> +void finalize_target_page_bits(void)
> +{
> +#ifdef TARGET_PAGE_BITS_VARY
> +    if (target_page_bits =3D=3D 0) {
> +        target_page_bits =3D TARGET_PAGE_BITS_MIN;
> +    }
> +    target_page_bits_decided =3D true;
> +#endif
> +}
> diff --git a/exec.c b/exec.c
> index fb0943cfed..5bf181d23e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -91,11 +91,6 @@ AddressSpace address_space_memory;
>  static MemoryRegion io_mem_unassigned;
>  #endif
>
> -#ifdef TARGET_PAGE_BITS_VARY
> -int target_page_bits;
> -bool target_page_bits_decided;
> -#endif
> -
>  CPUTailQ cpus =3D QTAILQ_HEAD_INITIALIZER(cpus);
>
>  /* current CPU in the current thread. It is only valid inside
> @@ -109,37 +104,8 @@ int use_icount;
>  uintptr_t qemu_host_page_size;
>  intptr_t qemu_host_page_mask;
>
> -bool set_preferred_target_page_bits(int bits)
> -{
> -    /* The target page size is the lowest common denominator for all
> -     * the CPUs in the system, so we can only make it smaller, never
> -     * larger. And we can't make it smaller once we've committed to
> -     * a particular size.
> -     */
> -#ifdef TARGET_PAGE_BITS_VARY
> -    assert(bits >=3D TARGET_PAGE_BITS_MIN);
> -    if (target_page_bits =3D=3D 0 || target_page_bits > bits) {
> -        if (target_page_bits_decided) {
> -            return false;
> -        }
> -        target_page_bits =3D bits;
> -    }
> -#endif
> -    return true;
> -}
> -
>  #if !defined(CONFIG_USER_ONLY)
>
> -static void finalize_target_page_bits(void)
> -{
> -#ifdef TARGET_PAGE_BITS_VARY
> -    if (target_page_bits =3D=3D 0) {
> -        target_page_bits =3D TARGET_PAGE_BITS_MIN;
> -    }
> -    target_page_bits_decided =3D true;
> -#endif
> -}
> -
>  typedef struct PhysPageEntry PhysPageEntry;
>
>  struct PhysPageEntry {


--
Alex Benn=C3=A9e

