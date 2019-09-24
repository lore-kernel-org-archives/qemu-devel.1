Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E3FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC742064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/CV14gy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC742064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCYHo-0003wU-VK
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 20:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCYGG-00038y-Gb
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCYGE-00020a-HP
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:00:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCYGD-0001zt-N7
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:00:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id y135so348632wmc.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=M1aYKNYh7FMUJhNQN/2j+kYoNsNKv4V/eKwvU/jPfiQ=;
 b=P/CV14gyqSOlos+oBd+vBpjcehPa1MUa3CpIF4lRDDHc9y3TdzDrjqWM43qVAlz4MJ
 pjAO5z20EdBROOXAU7dhw0EvN/JPZd+yUJKeT/RoqivojROswLFcYsPy2v1+EMNicGtK
 OOcAQe6l/xqS0wvjXZ3ICmaif4cxJolQ6mHXx1JqZE56nKVj5koyBwwS6VldU/hHga0z
 fhqAOlNaE9grMwcmY7nRAtQLEMIpp0P8x6JqpAPapOrhkYXruthPEgXf/SXQMooiVNpA
 PqhWWSPPQE1dvLBI3XAJQ37VLsWYpP8zGE0dwDf0cR4558Ymxk9uq7CWkHS1IXOs6Wsu
 SB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=M1aYKNYh7FMUJhNQN/2j+kYoNsNKv4V/eKwvU/jPfiQ=;
 b=sA+rn7l1FCJAB72S+Tw+zdIc1mJSej1vlukpheNdbnIX2Q+BI9BWep1ghcjSmieOzb
 8A/qZHjM0u5VgIQo55mSNXnskQXkfUXMSWzdyg6nMjco0awgrInBWubiOums2evSKJ5Q
 Wm9WZUsRSnWljDcFhK993dLrZAZ2YYjWwaB0OTcoCyf0GQ+SaZsj4XRmZ3vUVlGOsnNk
 B278W9aFT1fmfBgQ96eGmW6ri6BqVdSUIO6h8z/Tv4csgVBn3tPpB22CLAbdkNE26etd
 kQt46mhqq6eAWEs8XjzvHWQiFomd3nGobQN6BGZZwyFK7hheCqmpcidUqtGuWZtRRNwC
 Uj7Q==
X-Gm-Message-State: APjAAAWK/gHTustW7TODUZK8e/USBTBrNgazDSostUHJT3lFZYSteRMp
 W7TpgS8zja2jLNZDSp94J/ePSQ==
X-Google-Smtp-Source: APXvYqzRl5VvG9dy7k+oEIyGcpCx25LZ6Za0FTPN7bd1vSOgNo31IcFiIgUfu74YNewtlQNJ0/qmsQ==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr114482wmc.113.1569283252493;
 Mon, 23 Sep 2019 17:00:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d9sm25078wrc.44.2019.09.23.17.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 17:00:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E283C1FF87;
 Tue, 24 Sep 2019 01:00:50 +0100 (BST)
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-3-beata.michalska@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH 2/4] Memory: Enable writeback for given
 memory region
In-reply-to: <20190910095610.4546-3-beata.michalska@linaro.org>
Date: Tue, 24 Sep 2019 01:00:50 +0100
Message-ID: <87d0fqbm19.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, Beata Michalska <beata.michalska@linaro.org>,
 quintela@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Beata Michalska <beata.michalska@linaro.org> writes:

> Add an option to trigger memory writeback to sync given memory region
> with the corresponding backing store, case one is available.
> This extends the support for persistent memory, allowing syncing on-deman=
d.
>
> Also, adding verification for msync support on host.
>
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  configure               | 24 ++++++++++++++++++++++++
>  exec.c                  | 38 ++++++++++++++++++++++++++++++++++++++
>  include/exec/memory.h   |  6 ++++++
>  include/exec/ram_addr.h |  6 ++++++
>  memory.c                | 12 ++++++++++++
>  5 files changed, 86 insertions(+)
>
> diff --git a/configure b/configure
> index 95134c0180..bdb7dc47e9 100755
> --- a/configure
> +++ b/configure
> @@ -5081,6 +5081,26 @@ if compile_prog "" "" ; then
>      fdatasync=3Dyes
>  fi
>
> +##########################################
> +# verify support for msyc
> +
> +msync=3Dno
> +cat > $TMPC << EOF
> +#include <unistd.h>
> +#include <sys/mman.h>
> +int main(void) {
> +#if defined(_POSIX_MAPPED_FILES) && _POSIX_MAPPED_FILES > 0 \
> +&& defined(_POSIX_SYNCHRONIZED_IO) && _POSIX_SYNCHRONIZED_IO > 0
> +return msync(NULL,0, MS_SYNC);
> +#else
> +#error Not supported
> +#endif
> +}
> +EOF
> +if compile_prog "" "" ; then
> +    msync=3Dyes
> +fi
> +
>  ##########################################
>  # check if we have madvise
>
> @@ -6413,6 +6433,7 @@ echo "fdt support       $fdt"
>  echo "membarrier        $membarrier"
>  echo "preadv support    $preadv"
>  echo "fdatasync         $fdatasync"
> +echo "msync             $msync"
>  echo "madvise           $madvise"
>  echo "posix_madvise     $posix_madvise"
>  echo "posix_memalign    $posix_memalign"
> @@ -6952,6 +6973,9 @@ fi
>  if test "$fdatasync" =3D "yes" ; then
>    echo "CONFIG_FDATASYNC=3Dy" >> $config_host_mak
>  fi
> +if test "$msync" =3D "yes" ; then
> +    echo "CONFIG_MSYNC=3Dy" >> $config_host_mak
> +fi

I think it's best to split this configure check into a new prequel patch an=
d...

>  if test "$madvise" =3D "yes" ; then
>    echo "CONFIG_MADVISE=3Dy" >> $config_host_mak
>  fi
> diff --git a/exec.c b/exec.c
> index 235d6bc883..5ed6908368 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -65,6 +65,8 @@
>  #include "exec/ram_addr.h"
>  #include "exec/log.h"
>
> +#include "qemu/pmem.h"
> +
>  #include "migration/vmstate.h"
>
>  #include "qemu/range.h"
> @@ -2182,6 +2184,42 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t ne=
wsize, Error **errp)
>      return 0;
>  }
>
> +/*
> + * Trigger sync on the given ram block for range [start, start + length]
> + * with the backing store if available.
> + * @Note: this is supposed to be a SYNC op.
> + */
> +void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t le=
ngth)
> +{
> +    void *addr =3D ramblock_ptr(block, start);
> +
> +    /*
> +     * The requested range might spread up to the very end of the block
> +     */
> +    if ((start + length) > block->used_length) {
> +        error_report("%s: sync range outside the block boundires: "
> +                     "start: " RAM_ADDR_FMT " length: " RAM_ADDR_FMT
> +                     " block length: " RAM_ADDR_FMT " Narrowing down ...=
" ,
> +                     __func__, start, length, block->used_length);

Is this an error or just logging? error_report should be used for stuff
that the user needs to know about so it will appear on the HMP console
(or via stderr). If so what is the user expected to do? Have they
misconfigured their system?

> +        length =3D block->used_length - start;
> +    }
> +
> +#ifdef CONFIG_LIBPMEM
> +    /* The lack of support for pmem should not block the sync */
> +    if (ramblock_is_pmem(block)) {
> +        pmem_persist(addr, length);
> +    } else
> +#endif
> +    if (block->fd >=3D 0) {
> +#ifdef CONFIG_MSYNC
> +        msync((void *)((uintptr_t)addr & qemu_host_page_mask),
> +               HOST_PAGE_ALIGN(length), MS_SYNC);
> +#else
> +        qemu_fdatasync(block->fd);
> +#endif

... hide the implementation details in util/cutils.c, maybe as
qemu_msync()?

> +    }
> +}
> +
>  /* Called with ram_list.mutex held */
>  static void dirty_memory_extend(ram_addr_t old_ram_size,
>                                  ram_addr_t new_ram_size)
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 2dd810259d..ff0d7937cf 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1242,6 +1242,12 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
>   */
>  void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
>                                Error **errp);
> +/**
> + * memory_region_do_writeback: Trigger writeback for selected address ra=
nge
> + * [addr, addr + size]
> + *
> + */
> +void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr si=
ze);
>
>  /**
>   * memory_region_set_log: Turn dirty logging on or off for a region.
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index a327a80cfe..d4bce81a03 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -180,6 +180,12 @@ void qemu_ram_free(RAMBlock *block);
>
>  int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
>
> +void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t le=
ngth);
> +
> +/* Clear whole block of mem */
> +#define qemu_ram_block_writeback(rb)    \
> +    qemu_ram_writeback(rb, 0, rb->used_length)
> +
>  #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
>  #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_C=
ODE))
>
> diff --git a/memory.c b/memory.c
> index 61a254c3f9..436eb64737 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2228,6 +2228,18 @@ void memory_region_ram_resize(MemoryRegion *mr, ra=
m_addr_t newsize, Error **errp
>      qemu_ram_resize(mr->ram_block, newsize, errp);
>  }
>
> +
> +void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr si=
ze)
> +{
> +    /*
> +     * Might be extended case needed to cover
> +     * different types of memory regions
> +     */
> +    if (mr->ram_block && mr->dirty_log_mask) {
> +        qemu_ram_writeback(mr->ram_block, addr, size);
> +    }
> +}
> +
>  /*
>   * Call proper memory listeners about the change on the newly
>   * added/removed CoalescedMemoryRange.


--
Alex Benn=C3=A9e

