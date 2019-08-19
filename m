Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53714C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7092085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKkTPaM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7092085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgI4-0008WD-An
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 07:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hzgGt-0007Hc-DA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hzgGr-0003vB-Ol
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:56:23 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hzgGr-0003uV-IS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:56:21 -0400
Received: by mail-ot1-x342.google.com with SMTP id f17so1384886otq.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=feOMUL1yCDX0oKsVjp6Le2AerIZX7uLeJuPMhym8J3I=;
 b=nKkTPaM00dIYrQxL8sAz65XQUObkbvamYq0w8rje40KVUMUIHHkH8eUdxCNjZ/nckN
 WnmzrciMiC+wXnfd2nDPe2PALerCzx3xBRw7uaM5OKoFIgLx5s2ao1wDysqRezM2hAag
 1YjFVzyT4SL2GUm3NVPNDPZ3ag/UCQKlHAKxeB9nX+OYvCjsPn+7k+Ak6b3OMy6ucT8h
 9ZqbQiX7ECb64ymTDNTl2p+aD3HcSag/XSMA+SKgRQf53Wh11rvfeFYEkiTK60j5veuP
 woQL0QtF83J3KrVcEAgXFShTsXfSwrJRjTnzeJNtgNiDkOVI7eMVO8P35r3y6dEHjTYp
 gXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=feOMUL1yCDX0oKsVjp6Le2AerIZX7uLeJuPMhym8J3I=;
 b=ewLWClHu8MQ6xKok6X1dJqq7BcH96aG6SOQYQlQsdqEoBZBcfrIWbPt94wtXWpSDEU
 gTrMs0NbReOGmbdFnBgKITAikwv3UmNeoIpo7moE9wdVpDL01gAK+ryjWyA+WwvOC16Z
 BFu4URMQkw50mdyUCF2/pKy4fYjDIPn3FLeylq8uLY1wdANGCp6lYgLQRXv7hjHcJIQd
 Sf5O4ficwpOV+S6CGYIn6F3Fd6ogPF/2pxLM3VcEt/wm3Uq+oRZkMqOaPMqHnLwKUjFM
 Ex57KGDXKkBzIc52S8qld/sXFU2vNZ8ZXaC1EQfVDq6IZMqtut52Qoc5sng3KTlfNwyN
 gwMQ==
X-Gm-Message-State: APjAAAXkwU+qcoMh7rhv1xyji3O8SEyCFkSRvnWnmIOpSnxVFNb0WZ6A
 Qs35Ja9ec3txpb9l4kEDrx5alnqYys2/zs6+y+kovg==
X-Google-Smtp-Source: APXvYqx7nUcin9XusJMz/Ab5ffqToSNWelQASDS5UEsqQwtD85SA/1/bVAI5m5Z3FPGHYgrTHfX6DZ69Xb79tNaUmas=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr16749176otq.221.1566215779388; 
 Mon, 19 Aug 2019 04:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190816211049.57317-1-scw@google.com>
In-Reply-To: <20190816211049.57317-1-scw@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2019 12:56:08 +0100
Message-ID: <CAFEAcA-GWR6_wGCMWkMHttU3ARJPqfADvNTnqQUU_OzcWgHHuQ@mail.gmail.com>
To: Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] linux-user: add memfd_create
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
Cc: arunkaly@google.com, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Aug 2019 at 22:28, Shu-Chun Weng via Qemu-devel
<qemu-devel@nongnu.org> wrote:
>
> Add support for the memfd_create syscall. If the host does not have the
> libc wrapper, translate to a direct syscall with NC-macro.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1734792
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  include/qemu/memfd.h |  4 ++++
>  linux-user/syscall.c | 11 +++++++++++
>  util/memfd.c         |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
> index d551c28b68..975b6bdb77 100644
> --- a/include/qemu/memfd.h
> +++ b/include/qemu/memfd.h
> @@ -32,6 +32,10 @@
>  #define MFD_HUGE_SHIFT 26
>  #endif
>
> +#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
> +int memfd_create(const char *name, unsigned int flags);
> +#endif
> +
>  int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>                        uint64_t hugetlbsize, unsigned int seals, Error **errp);
>  bool qemu_memfd_alloc_check(void);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8367cb138d..b506c1f40e 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/path.h"
> +#include "qemu/memfd.h"
>  #include <elf.h>
>  #include <endian.h>
>  #include <grp.h>
> @@ -11938,6 +11939,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          /* PowerPC specific.  */
>          return do_swapcontext(cpu_env, arg1, arg2, arg3);
>  #endif
> +#ifdef TARGET_NR_memfd_create
> +    case TARGET_NR_memfd_create:
> +        p = lock_user_string(arg1);
> +        if (!p) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(memfd_create(p, arg2));

I think here you may need to call
           fd_trans_unregister(ret);

since memfd_create() returns a file descriptor.
(This call unregisters any pre-existing hooks for "we need
to mangle the data for reads/writes of this file descriptor",
in case the fd was previously being used for a file descriptor
type that needed that.) This is what eg NR_open does.

Laurent -- do I have this right? It's not entirely clear
to me that we could ever be in a situation where a syscall
like open or memfd_create returns an fd that's got an fd_trans
hook active, because that would imply we'd failed to delete
the hook on fd-close somehow. Is this just a belt-and-braces
bit of coding ?

thanks
-- PMM

