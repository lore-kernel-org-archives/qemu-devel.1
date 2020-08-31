Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5DBC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C5D208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="K0OyUCgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C5D208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCftp-0006KR-H1
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kCft4-0005nQ-Uj
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:14:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kCft3-0003ME-DS
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:14:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id z4so2363552wrr.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=/aK1n5icyuicUNOgLIOyp+xcXuKWE5h0OFGJlg/XvWY=;
 b=K0OyUCgFmrU+zK57oXaW/DEBWS//jpCMvFWLy6VZBKMNWh+Y09fu5lK1KTQIneI1M5
 VaRl8QcuwCNriB2FMwd3XRTnEAhOStpRk+GgJ6aXOFibwkVCAuRxn8DiglyfVovMPmHL
 VWsPL6na4rPH3EqPXskJrWl2qESQwVbM1fS8y1pFUC/JRRA0Vt0UVEZ1y8DX4UZDh+yq
 Zdi/hHhCIZRCniBD8OUJTUHo1AQ3Uh9bM78SDV+T/MXc+ybbHdVAaTGnIYvR/mDxUyX+
 KrBlCGCUpu7B1EZE4z9IHC5bkEpE3e+s2sAg6yMdSE1DceLbzylXvFZZwq7Jvpx9aSPU
 R6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=/aK1n5icyuicUNOgLIOyp+xcXuKWE5h0OFGJlg/XvWY=;
 b=SWw925zxxKXLeHu7AXSNDHRurEjr/baszZDA/HZtvwV54UzJ91SETX0PmyjDhRJxxr
 S/wR4QGkI8/nm5SMnLhh+UfRyLsj5xD92oPBbl2XvSLI6yzmzOQ4iiMnPmRSwsZkS1j5
 2MFvTXhVqU0jCFtp5MkJTUcjtWBWXxoCnTt6gDil+mxfBmNXbrPCHW8srhKJO/acvuVB
 GCmUvp0o5lL+Zm2XrivvAqHSWG3Lbvyl16ZIkudNQ+7ys1yYl1GSzdXpVA+LoZMX6Zz5
 6YAqfT5uxOZm5GNxMqjRZCSasq676vZ7/+HJGiU7FHH54DPiyCK+SnMpV0nETJbu2pAK
 ylQQ==
X-Gm-Message-State: AOAM530kB3FtqvF55tkVQ9Xvj9bxYQsF5iKRW5pUUaAeNFAhYUv37bUO
 5cMSLt3VkKkaJ0S2u7fMZwZVaQ==
X-Google-Smtp-Source: ABdhPJzYgy2LFAxzFWxrTzXDeN2C+s9X1EjUrnypIAlvm4ejwtmywPJQSrmXD/1NPIXkMAB3L+3Sjg==
X-Received: by 2002:adf:9125:: with SMTP id j34mr794073wrj.157.1598865239938; 
 Mon, 31 Aug 2020 02:13:59 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id n124sm10922949wmn.29.2020.08.31.02.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 02:13:59 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 3f3af1f4;
 Mon, 31 Aug 2020 09:13:58 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v6 10/12] migration/dirtyrate: Implement
 calculate_dirtyrate() function
In-Reply-To: <1598669577-76914-11-git-send-email-zhengchuan@huawei.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-11-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Mon, 31 Aug 2020 10:13:58 +0100
Message-ID: <m2tuwjb2jt.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::443;
 envelope-from=dme@dme.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Cc: alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 zhang.zhanghailiang@huawei.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Saturday, 2020-08-29 at 10:52:55 +08, Chuan Zheng wrote:

> Implement calculate_dirtyrate() function.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 850126d..95ee23e 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -162,6 +162,21 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>      strcpy(info->idstr, qemu_ram_get_idstr(block));
>  }
>  
> +static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, int count)
> +{
> +    int i;
> +
> +    if (!infos) {
> +        return;
> +    }
> +
> +    for (i = 0; i < count; i++) {
> +        g_free(infos[i].sample_page_vfn);
> +        g_free(infos[i].hash_result);
> +    }
> +    g_free(infos);
> +}
> +
>  static struct RamblockDirtyInfo *
>  alloc_ramblock_dirty_info(int *block_index,
>                            struct RamblockDirtyInfo *block_dinfo)
> @@ -301,8 +316,34 @@ static int compare_page_hash_info(struct RamblockDirtyInfo *info,
>  
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
> -    /* todo */
> -    return;
> +    struct RamblockDirtyInfo *block_dinfo = NULL;
> +    int block_index = 0;
> +    int64_t msec = 0;
> +    int64_t initial_time;
> +
> +    rcu_register_thread();
> +    reset_dirtyrate_stat();
> +    rcu_read_lock();
> +    initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if (record_ramblock_hash_info(&block_dinfo, config, &block_index) < 0) {
> +        goto out;
> +    }
> +    rcu_read_unlock();
> +
> +    msec = config.sample_period_seconds * 1000;
> +    msec = set_sample_page_period(msec, initial_time);
> +
> +    rcu_read_lock();
> +    if (compare_page_hash_info(block_dinfo, block_index) < 0) {
> +        goto out;
> +    }
> +
> +    update_dirtyrate(msec);
> +
> +out:
> +    rcu_read_unlock();

This still holds the RCU lock across update_dirtyrate(), which I
understood to be unnecessary.

> +    free_ramblock_dirty_info(block_dinfo, block_index + 1);
> +    rcu_unregister_thread();
>  }
>  
>  void *get_dirtyrate_thread(void *arg)
> -- 
> 1.8.3.1

dme.
-- 
I'd come on over but I haven't got a raincoat.

