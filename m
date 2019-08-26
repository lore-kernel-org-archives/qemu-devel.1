Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA0AC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FF62080C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IshpynXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FF62080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2HqL-0002ZD-OC
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 12:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2Hn4-0000WF-Iv
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2Hn0-00071L-2o
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:24:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2Hmu-0006yE-S7
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:24:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id s18so15960090wrn.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=V7nehTfNBRDtYYVfb4T3FnHfeZzbZftCZ2XfbyBu86k=;
 b=IshpynXsLVBv4xI+xNKrg3oRHgFXGNaTcAnzcldPmtSsfCJ5kCCPt8uVE4WN4C534j
 19Cj+bQdajBKnyZXCyfCgD8RYDZU/oTnEw0l1vFvghDHwepaQxwUJCFFmYWX5uSb8RFy
 Jxg121uZggDaAN/kwX7gs5oAOKw/ULvUcqHpFH9awxrEL9aoWEIuspoQic0Iq1yed5k4
 HLuIAkL8WePtGpVvFrBDy220pQf4x00pWiYc5MrKGxDvfJClfQqeneoaz7IZWe9YpcAL
 YoPbQdo2o82lB61HDHrk0irA2yMqpbXIrCK88EvCvmO/QGfGkU4EUhVrDxnzGHUTEQoP
 iY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=V7nehTfNBRDtYYVfb4T3FnHfeZzbZftCZ2XfbyBu86k=;
 b=DSJ1yt8mz1ijf3vupYo1xdcX16iPNP60yjXmFv9L6OejmM2fY8Pd9NE7aOz/f94iZM
 14+ouE1qXMkoQlu2f8cR7XETY5ZY2N1Rwyd40Y45xXb2Nur+0W9CN5WOMBDu6V+BLRwt
 cQSCRX2rm1PY1WbUg06u/CkOrd757XEFI/1wz7ZmdMjXk/hOZoJ+CBIAmYApXXSCqqOV
 0qRI4/SYLXX8F2ESeZwm2p7iRGJCoEwDbYny7lwKqqxfvGavDg8dR3UTS5cmYdCGb/C+
 Ued2rjJNw/WVegi5jeDGJGNSfKACsaNZF2OBTRPSv8za1aC+LwFSmmgLAMrTjPBiumcu
 ciNw==
X-Gm-Message-State: APjAAAUjsxqhPXp+nfQnYu6vjynSDcMjvH/WrWmBwMxP/7C8lZUYBbS6
 MQxuGT40oVRgomrZvD+AiUirug==
X-Google-Smtp-Source: APXvYqwebTZD5PgkC1518awJAkD+O+sbizOyyDoBQDEzFSHveiwbzKXxM9wlWfqAuRK/oXIEMup9qQ==
X-Received: by 2002:adf:f7cd:: with SMTP id a13mr23516770wrq.165.1566836649724; 
 Mon, 26 Aug 2019 09:24:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 6sm12799211wmf.23.2019.08.26.09.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 09:24:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 55EAC1FF87;
 Mon, 26 Aug 2019 17:24:08 +0100 (BST)
References: <20190821172329.2062-1-vandersonmr2@gmail.com>
 <20190821172329.2062-2-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: vandersonmr <vandersonmr2@gmail.com>
In-reply-to: <20190821172329.2062-2-vandersonmr2@gmail.com>
Date: Mon, 26 Aug 2019 17:24:08 +0100
Message-ID: <87h863zyhj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v6 01/10] accel: introducing TBStatistics
 structure
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> To store statistics for each TB, we created a TBStatistics structure
> which is linked with the TBs. TBStatistics can stay alive after
> tb_flush and be relinked to a regenerated TB. So the statistics can
> be accumulated even through flushes.
>
> The goal is to have all present and future qemu/tcg statistics and
> meta-data stored in this new structure.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/Makefile.objs      |  2 +-
>  accel/tcg/perf/Makefile.objs |  1 +
>  accel/tcg/tb-stats.c         | 39 ++++++++++++++++++++++++
>  accel/tcg/translate-all.c    | 57 ++++++++++++++++++++++++++++++++++++
>  include/exec/exec-all.h      | 15 +++-------
>  include/exec/tb-context.h    | 12 ++++++++
>  include/exec/tb-hash.h       |  7 +++++
>  include/exec/tb-stats.h      | 43 +++++++++++++++++++++++++++
>  util/log.c                   |  2 ++
>  9 files changed, 166 insertions(+), 12 deletions(-)
>  create mode 100644 accel/tcg/perf/Makefile.objs
>  create mode 100644 accel/tcg/tb-stats.c
>  create mode 100644 include/exec/tb-stats.h
>
> diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
> index d381a02f34..49ffe81b5d 100644
> --- a/accel/tcg/Makefile.objs
> +++ b/accel/tcg/Makefile.objs
> @@ -2,7 +2,7 @@ obj-$(CONFIG_SOFTMMU) +=3D tcg-all.o
>  obj-$(CONFIG_SOFTMMU) +=3D cputlb.o
>  obj-y +=3D tcg-runtime.o tcg-runtime-gvec.o
>  obj-y +=3D cpu-exec.o cpu-exec-common.o translate-all.o
> -obj-y +=3D translator.o
> +obj-y +=3D translator.o tb-stats.o
>
>  obj-$(CONFIG_USER_ONLY) +=3D user-exec.o
>  obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D user-exec-stub.o
> diff --git a/accel/tcg/perf/Makefile.objs b/accel/tcg/perf/Makefile.objs
> new file mode 100644
> index 0000000000..f82fba35e5
> --- /dev/null
> +++ b/accel/tcg/perf/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y +=3D jitdump.o
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> new file mode 100644
> index 0000000000..02844717cb
> --- /dev/null
> +++ b/accel/tcg/tb-stats.c
> @@ -0,0 +1,39 @@

I should have picked up on this last time but you need a copyright
header for you new files.

> +#include "qemu/osdep.h"
> +
> +#include "disas/disas.h"
> +
> +#include "exec/tb-stats.h"
> +
<snip>
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> new file mode 100644
> index 0000000000..cc8f8a6ce6
> --- /dev/null
> +++ b/include/exec/tb-stats.h
> @@ -0,0 +1,43 @@

And a copyright header here as well.

> +#ifndef TB_STATS_H
> +
> +#define TB_STATS_H
> +
> +#include "exec/cpu-common.h"
> +#include "exec/tb-context.h"
> +#include "tcg.h"
> +
> +typedef struct TBStatistics TBStatistics;
> +
> +/*
> + * This struct stores statistics such as execution count of the
> + * TranslationBlocks. Each sets of TBs for a given phys_pc/pc/flags
> + * has its own TBStatistics which will persist over tb_flush.
> + *
> + * We include additional counters to track number of translations as
> + * well as variants for compile flags.
> + */
> +struct TBStatistics {
> +    tb_page_addr_t phys_pc;
> +    target_ulong pc;
> +    uint32_t     flags;
> +    /* cs_base isn't included in the hash but we do check for matches */
> +    target_ulong cs_base;
> +    /* current TB linked to this TBStatistics */
> +    TranslationBlock *tb;
> +};
> +
> +bool tb_stats_cmp(const void *ap, const void *bp);
> +
> +void init_tb_stats_htable_if_not(void);
> +
> +/* TBStatistic collection controls */
> +enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED=
 };
> +extern int tcg_collect_tb_stats;
> +
> +void enable_collect_tb_stats(void);
> +void disable_collect_tb_stats(void);
> +void pause_collect_tb_stats(void);
> +bool tb_stats_collection_enabled(void);
> +bool tb_stats_collection_paused(void);
> +
> +#endif
> diff --git a/util/log.c b/util/log.c
> index 1d1b33f7d9..393a17115b 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -31,6 +31,8 @@ int qemu_loglevel;
>  static int log_append =3D 0;
>  static GArray *debug_regions;
>
> +int tcg_collect_tb_stats;
> +
>  /* Return the number of characters emitted.  */
>  int qemu_log(const char *fmt, ...)
>  {


--
Alex Benn=C3=A9e

