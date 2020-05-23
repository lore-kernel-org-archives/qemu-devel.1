Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1283AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54AB2072C
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="2DCHmHn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54AB2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcb0w-00084o-Vw
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 16:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcb0J-0007YU-Di
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:44:23 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:44079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcb0H-0006Vg-TL
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:44:23 -0400
Received: by mail-qv1-xf44.google.com with SMTP id ee19so6376345qvb.11
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 13:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OznxruV7D33AfvCltPkVf97gqkc/kVtIThlYppXURtg=;
 b=2DCHmHn2G9DxI9YLkeezMZoshN8nT/4ywl5vU5ieXQet3ZR7s6jgmSEntQK4cjrj2a
 SOKwAv7Bj9CPouIuczxkbfHvQ933jQgMFXn6IMPAlZtwGW7Ycg+oTR1WNF2QoM6+smMm
 Rl3dN+dWiW8TMkXA7d4yuToRJFbfcJob8USrB8zQVs81jOcGB7tkfpuatP5oEOiq9P54
 ySFEh5kMK8y2LAvof2yRl8SWzuGM6BT5/eZ3wjaqEEy6oGJ/9aIspwj4Z1XilduGHoqm
 76/Z4OAx3lIjS3jvakZk/MDb2b6/wVNJLU5W9J0zevV8idZDshBqIzS4AmQsLcuXDP/F
 h86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OznxruV7D33AfvCltPkVf97gqkc/kVtIThlYppXURtg=;
 b=lC1EpuQ/n0pWigUp++3gbEeLkAAcChhl55t0aMJAW39KIhO8DyZLlCLEClXKJBfDJ4
 RLwJ52kKgkjFAZYBYZ7ePXgt/tmkwGaVOcwQAPkCBJmXjM5Dca3bWBInWrC1HAFfpbol
 oTRLbyr3EpLt6lTTTDyAJETDHw9j/Rp+286qtcFYLZ6UJVOFpyvNq+66BPDwK/LDIf7E
 xSgsLRQY/ThpY+647Pbw0Bo9iS46rXiNRbLQYw9MREVvlnzH+5AQeNL3Fzzu6UlKmHRp
 EUi/Ia8+8nwK2bvhd4U/OtCJUnfMcaS1GBqLHOYurmTw/Gl3IIwGcUMeqSi138QwfkwJ
 YzLA==
X-Gm-Message-State: AOAM531fEhqloXKTkEoVY5KQD0DvDs6MU0DTCcFBUx7ZJWF9VXvVbuhl
 pYKsX5xsF1esfwt8Go76ktg+9g==
X-Google-Smtp-Source: ABdhPJzH8CZoq72ekfVkDkydDvAnlYyaXErbDKVK1nAmeV89jIuY6mGjnQFyqZqbXhI49LBopNhcOg==
X-Received: by 2002:a05:6214:13aa:: with SMTP id
 h10mr9192577qvz.41.1590266660551; 
 Sat, 23 May 2020 13:44:20 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id d14sm1335457qkg.25.2020.05.23.13.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 13:44:20 -0700 (PDT)
Date: Sat, 23 May 2020 16:44:19 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 15/19] qht: Fix tsan warnings.
Message-ID: <20200523204419.GI382220@sff>
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-16-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522160755.886-16-robert.foley@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::f44;
 envelope-from=cota@braap.org; helo=mail-qv1-xf44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 12:07:51 -0400, Robert Foley wrote:
> For example:
> WARNING: ThreadSanitizer: data race (pid=23406)
>   Atomic read of size 4 at 0x7b100003e3c8 by thread T7:
>     #0 __tsan_atomic32_load <null> (qemu-system-aarch64+0x39a36c)
>     #1 qht_do_lookup util/qht.c:495:17 (qemu-system-aarch64+0xd82f7a)
>     #2 qht_lookup_custom util/qht.c:539:11 (qemu-system-aarch64+0xd82f7a)
>   Previous write of size 8 at 0x7b100003e3c8 by thread T6 (mutexes: write M166769147697783108, write M995435858420506688):
>     #0 posix_memalign <null> (qemu-system-aarch64+0x350dd1)
>     #1 qemu_try_memalign util/oslib-posix.c:189:11 (qemu-system-aarch64+0xd59317)
>     #2 qemu_memalign util/oslib-posix.c:205:27 (qemu-system-aarch64+0xd5943e)
>     #3 qht_insert__locked util/qht.c:583:9 (qemu-system-aarch64+0xd837c5)
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  util/qht.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/util/qht.c b/util/qht.c
> index 67e5d5b916..739a53ced0 100644
> --- a/util/qht.c
> +++ b/util/qht.c
> @@ -69,6 +69,7 @@
>  #include "qemu/qht.h"
>  #include "qemu/atomic.h"
>  #include "qemu/rcu.h"
> +#include "qemu/tsan.h"
>  
>  //#define QHT_DEBUG
>  
> @@ -580,10 +581,12 @@ static void *qht_insert__locked(const struct qht *ht, struct qht_map *map,
>          b = b->next;
>      } while (b);
>  
> +    TSAN_ANNOTATE_IGNORE_WRITES_BEGIN();
>      b = qemu_memalign(QHT_BUCKET_ALIGN, sizeof(*b));
>      memset(b, 0, sizeof(*b));
>      new = b;
>      i = 0;
> +    TSAN_ANNOTATE_IGNORE_WRITES_END();

I cannot reproduce this warning post-series with detect_deadlocks=0
but my hypothesis is that this is a side effect of tsan not understanding
the seqlock: tsan sees that below we "publish" this piece of memory with
an atomic write (in atomic_rcu_set), and does not see that with
seqlock_write_begin we have a write memory barrier. I wonder if
what we need instead is to annotate the seqlock functions, not the
callers.

Thanks,

		E.

