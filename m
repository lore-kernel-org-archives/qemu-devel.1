Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935E1C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5922421D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtL/ROEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5922421D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfJy-0003KB-LD
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBfDe-0001t9-B1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBfDd-0001ue-1o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:46:50 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBfDc-0001sc-RM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:46:48 -0400
Received: by mail-oi1-x243.google.com with SMTP id c1so13882378oiy.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UriesWLsts8g3AWLL3Fr/KU3sYx2gYgtiZ9+aQWTYxI=;
 b=EtL/ROEEMfsDdQCxW7ixrxfjnD+GmQCe/yjYNSS7W7og6xFtrnuT2frcZ5K/JSoCK6
 PW1BeGoC3aLn821yTK/h+xIKJXy0FHlESIAeGV2JWBekoZ24MrusnZ+qFzanCqoni5oS
 mi+c0WpEnZcnZwcnsjIGy9Yz2OI8d0bnZcLBwKd2H6DG1Sgw4W1YpCYn2w1oThW0azu9
 VQH/zyucAu2D/rQZL5iDpIgQjGAkxil5XWponyH2FDbkX5rZTlLoe6lvcnq3x4Y/RzPl
 i3mTJweXc2oxTxkrfzNLaABn4ogkmw75+UMC2Uda4a5iNoSY0kNElsNfonX3ptUXSARI
 B5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UriesWLsts8g3AWLL3Fr/KU3sYx2gYgtiZ9+aQWTYxI=;
 b=S9irpa+vkptOZI2q2UExi5ctvRikCjV6eC1M+f5o1zO6HgW0vhNoIdo6p9S4rDbtwg
 DbB10E1ID/6ZvvbxhNfLay6d3GNGwaGZTRWUo1dXxOzYGwSbUe5SvnCMouOgxTT5anHx
 afxdWEtoByFUMY0RVxC552rNzlAkGxqo2JQv0ASH+p9nL0X1+LaQv/2+ms0SDTvDXmNP
 iiV/XuA7xAeyd8gSMfobAHnz2Q+ra2yEvb3FjO30VncfubeGJ5ijOvNOXlKho9sbgA6N
 nqVc94qVOA/oR1yr6xpocT6IWNduusjgkF29ldAgW0mwNWxy2uUyRlTyYNw/RldqHE/d
 GJAg==
X-Gm-Message-State: ANhLgQ0bhgo0PoNOly5z9+MHJ5t7OV485XOhmMqGr0FwHbeF5Y417D+m
 qMHxrcPVBPfw4aQw6xDeDWXasiAhXZH+JlYaxzbeug==
X-Google-Smtp-Source: ADFU+vvBq1lO9r1au90d1RE3F8//jA0ax/bbF4YpGGq2Lk9d7ZSa0TvP1aoYvVuHqIScMSo9NB86sAVZrnCMVk+aHeA=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr1170441oic.48.1583848007667; 
 Tue, 10 Mar 2020 06:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200310130844.30076-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20200310130844.30076-1-kuhn.chenqun@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 13:46:35 +0000
Message-ID: <CAFEAcA_W2pRztEAmd1v+6O-1J9-CckVV8+G6kZ3igmR-ie6k+Q@mail.gmail.com>
Subject: Re: [PATCH] hw/scsi/megasas:Clean up some redundant code fix Clang
 warnings
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Fam Zheng <fam@euphon.net>, Hannes Reinecke <hare@suse.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 13:10, Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> Here are some redundant statements, we can clean them up.
> Clang static code analyzer show warning:
> hw/scsi/megasas.c:1175:32: warning: Value stored to 'max_ld_disks' during its initialization is never read
>     uint32_t num_ld_disks = 0, max_ld_disks = s->fw_luns;
>                                ^~~~~~~~~~~~   ~~~~~~~~~~
> hw/scsi/megasas.c:1183:9: warning: Value stored to 'max_ld_disks' is never read
>         max_ld_disks = 0;
>         ^              ~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: qemu-block@nongnu.org
> ---
>  hw/scsi/megasas.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index af18c88b65..3f982e1d3b 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -1172,7 +1172,7 @@ static int megasas_dcmd_ld_list_query(MegasasState *s, MegasasCmd *cmd)
>      uint16_t flags;
>      struct mfi_ld_targetid_list info;
>      size_t dcmd_size = sizeof(info), resid;
> -    uint32_t num_ld_disks = 0, max_ld_disks = s->fw_luns;
> +    uint32_t num_ld_disks = 0, max_ld_disks;
>      BusChild *kid;
>
>      /* mbox0 contains flags */
> @@ -1180,7 +1180,6 @@ static int megasas_dcmd_ld_list_query(MegasasState *s, MegasasCmd *cmd)
>      trace_megasas_dcmd_ld_list_query(cmd->index, flags);
>      if (flags != MR_LD_QUERY_TYPE_ALL &&
>          flags != MR_LD_QUERY_TYPE_EXPOSED_TO_HOST) {
> -        max_ld_disks = 0;
>      }

This doesn't look right -- your change removes the only statement
in the body of this "if". I think you need to examine what the
function is trying to do with the test it is doing on these flags
in order to identify what the right change is... Probably this
means going back to the h/w spec to identify the correct behaviour
overall.

thanks
-- PMM

