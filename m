Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B53C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D551C2073B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JISjYSI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D551C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHnIp-0003K7-2L
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHnIF-0002ju-Qz
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHnIE-0006HC-Eq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:36:55 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHnIE-00068r-01
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:36:54 -0400
Received: by mail-ot1-x343.google.com with SMTP id z5so9077401oth.9
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bQoEZyoukzBu4eRznOzarBt0Mlw0U0dE74siuW5IkX8=;
 b=JISjYSI0q/dkZJ2QcGJ1FWoxI/9ZEk29dseRJ90iMCNYvO/kT5X0cU0X+9+bHOm1Z3
 Vvs+oAFkoD4r290LxSHgQ8+KQnm2RRSeVVJdHNVzFRfDkwwW0xmxxccmbzzGbSWGnijv
 2H9/o+pxVq2QHK9QLvv+1h9+PerXXwEklm4JeN9bDKPHabgIKiKPmRttCisj49e8raIC
 QV9uuFTZa0BmWpry/H+632zH1hqk7xIeHV9gxcl3rYTucpUBPmmHmUZjRR0kZVGCwcbh
 XB+wDovlKeABoXmcxYa7xpmnMtqc4/s+KFxbcL1sw1jHap+i5C/1tAKe79XBp+D44dWQ
 LK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bQoEZyoukzBu4eRznOzarBt0Mlw0U0dE74siuW5IkX8=;
 b=QFl9G/JS++zW7LKURaxavSKKcpY/LUuUJlCCRvE6XJPyS5ZpK0vljjjpo/6upv6oc9
 ulSWSyBzhc4OJLE/7SWEiYce8psc4qNgV0Ea1wGEfE+B+ab/vHOUty/eGca4AlsdE7Wu
 n0Lx+FRu55ZyeOYn7DV2KagiTogJaowKUuLL4+IE3q1JlEwpYpIfqcPhwxtFW5AbjUYW
 6TUVAsBzI1vgGNaMw7KqaW50Tlreg8SoIayxcxIVBw8Kp1MByyFvnFPUc2jtAO8VwPAu
 jN4CQ0YLJxYY4fqL2HtZeGgKsIJngFIbj3aZrJf2OiZ53QkWYQZHzhsmrpfzyLneF0aD
 hRzw==
X-Gm-Message-State: ANhLgQ3iZJhnqg7+K99BN1xm5OVEMh/uG+2YGCKkMo1+u+pViLT7Pv3f
 Qhof+k0yiA3ZGJ1aBAaEK/RafflZYWqurXPNyU9OUA==
X-Google-Smtp-Source: ADFU+vu7xz2ECsp1S38/PmL/7nKdJUMhVrTM9UNcrNch3IdWPNk/R1XPi0dc4IgWg88u15lsq+J743p2UIiGPw3IfPw=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr9479366ota.221.1585309012591; 
 Fri, 27 Mar 2020 04:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2020 11:36:41 +0000
Message-ID: <CAFEAcA-u-vp6ETypJLTakc0bCTYfg7_9ONF6Za7GsmOtz6qXVQ@mail.gmail.com>
Subject: Re: [PULL 00/13] Net patches
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 at 11:14, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit cfe68ae025f704f336d7dd3d1903ce37b445831d:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging (2020-03-26 20:55:54 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to f3b364f4f77fcb24cec468f518bf5e093dc27cb7:
>
>   hw/net/allwinner-sun8i-emac.c: Fix REG_ADDR_HIGH/LOW reads (2020-03-27 18:59:47 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Hi; this fails to compile (all platforms):

/home/petmay01/qemu-for-merges/hw/net/allwinner-sun8i-emac.c:773:20:
error: initialization from incompatible pointer type
[-Werror=incompatible-pointer-types]
     .can_receive = allwinner_sun8i_emac_can_receive,
                    ^
/home/petmay01/qemu-for-merges/hw/net/allwinner-sun8i-emac.c:773:20:
note: (near initialization for
'net_allwinner_sun8i_emac_info.can_receive')


There's also this one, though not every compiler picked it up:

/home/peter.maydell/qemu/hw/net/i82596.c: In function 'i82596_receive':
/home/peter.maydell/qemu/hw/net/i82596.c:657:30: error: comparison of
unsigned expression >= 0 is always true [-Werror=type-limits]
                 assert(bufsz >= 0);
                              ^
/home/peter.maydell/qemu/hw/net/i82596.c:657:30: error: comparison of
unsigned expression >= 0 is always true [-Werror=type-limits]
                 assert(bufsz >= 0);
                              ^


For the first error, I think this needs squashing into
"hw/net: Make NetCanReceive() return a boolean":

diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index fc67a1be70..28637ff4c1 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -395,7 +395,7 @@ static void
allwinner_sun8i_emac_flush_desc(FrameDescriptor *desc,
     cpu_physical_memory_write(phys_addr, desc, sizeof(*desc));
 }

-static int allwinner_sun8i_emac_can_receive(NetClientState *nc)
+static bool allwinner_sun8i_emac_can_receive(NetClientState *nc)
 {
     AwSun8iEmacState *s = qemu_get_nic_opaque(nc);
     FrameDescriptor desc;


Squashing this into my
"hw/net/i82596.c: Avoid reading off end of buffer in i82596_receive()"
commit fixes the second error.

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index a9bdbac339..055c3a1470 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -653,8 +653,8 @@ ssize_t i82596_receive(NetClientState *nc, const
uint8_t *buf, size_t sz)

             if (bufcount > 0) {
                 /* Still some of the actual data buffer to transfer */
+                assert(bufsz >= bufcount);
                 bufsz -= bufcount;
-                assert(bufsz >= 0);
                 address_space_write(&address_space_memory, rba,
                                     MEMTXATTRS_UNSPECIFIED, buf, bufcount);
                 rba += bufcount;

thanks
-- PMM

