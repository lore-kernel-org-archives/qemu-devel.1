Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728C9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 12:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E32820866
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 12:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="nMS1n7iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E32820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCidg-00051F-73
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 08:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kCid8-0004cS-3O
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 08:09:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kCid5-0000JM-HI
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 08:09:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so5689268wrp.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=cfRZE9TQ5iUK5E0fnaYWMFGX9ifN31N2/wgRkCsCVBM=;
 b=nMS1n7iwMn4uH+Bf6BZJFvoKIbEu/ygq3lnxBhdlwO2RViCBtngq87TEO6YcEeuf9Q
 qKVMMpO76PpMjkLR175/foj+5YcGst0u/NOU3ffIWs731DmH9Xh6OufMz8pxyaebtFvi
 jxjI1Qc2uo9BCuOSx/6nH99yYCPxvhmzWqKoT75T4YLN4wXqCyvLaFlsEwJbr3ASvdgJ
 tdZf+bouJVHYBmd/Ui/g/QZhS+TBa7MAnNT2ryazkH9BSvJOEqFqFcB4o/Y7eVOI2OcD
 ycPBMiCSSLQKMGSr3Kyo3Cecy/FJZeB5/aqq1x6Yz+FBWZ7QRL1cvnno7RKr7EhcExfL
 D1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=cfRZE9TQ5iUK5E0fnaYWMFGX9ifN31N2/wgRkCsCVBM=;
 b=gv3R9qfVCBINE+ylStKb9j9lGWVxomuc8nXpW3A5vudqedAw8HrWP5QXQXulSA/y2l
 k1i3h1Y8fhxapa55g43EajPMJkhGbES7Dts/nuKILw5FDFcNo8GJz5Zk4Mk9q5YHH8q0
 x5vS5XoQifsRVjOQyXQ7ewygp0s27RR2+m239ybBIoCCSR2Qt18ublxaqb4i530rPAof
 9glbPmml0uMW2CLfDh1ersrOV99oyiUV+CxZWkEXWeVQNAxA0PLZkGwS8k1SKpS2hQSa
 bKpYN5++hyoag7QSc/SoQrsVxYrjgOMRE0a4+hb0KJqB2M8ttNiCbazjgI8slwAo4Fne
 Fo/Q==
X-Gm-Message-State: AOAM530An5gf3+ouPhBokqlD5XGSv2/PU7BaSM15sSSPf5ZJSHtAYAAI
 U3+CO7SeAIv3//M2oGOywCtTiF2jjwd8JmbvoKI=
X-Google-Smtp-Source: ABdhPJxeEAFJKa8vLBo03rudmdTiZvQBD8FYM5BcJNKMLO2dwro/JPCgeOG4eM/mg60MQf/T8b0DfA==
X-Received: by 2002:a5d:5390:: with SMTP id d16mr1305052wrv.401.1598875269736; 
 Mon, 31 Aug 2020 05:01:09 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id 11sm11300115wmo.23.2020.08.31.05.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 05:01:09 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 35951c26;
 Mon, 31 Aug 2020 12:01:08 +0000 (UTC)
To: Zheng Chuan <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v6 10/12] migration/dirtyrate: Implement
 calculate_dirtyrate() function
In-Reply-To: <7cf49925-1ff6-d57e-3cac-fb573be182f9@huawei.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-11-git-send-email-zhengchuan@huawei.com>
 <m2tuwjb2jt.fsf@dme.org> <7cf49925-1ff6-d57e-3cac-fb573be182f9@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Mon, 31 Aug 2020 13:01:08 +0100
Message-ID: <m2h7sjaut7.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::444;
 envelope-from=dme@dme.org; helo=mail-wr1-x444.google.com
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

On Monday, 2020-08-31 at 19:24:04 +08, Zheng Chuan wrote:

> On 2020/8/31 17:13, David Edmondson wrote:
>> On Saturday, 2020-08-29 at 10:52:55 +08, Chuan Zheng wrote:
>> 
>>> Implement calculate_dirtyrate() function.
>>>
>>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>>> ---
>>>  migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 43 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>>> index 850126d..95ee23e 100644
>>> --- a/migration/dirtyrate.c
>>> +++ b/migration/dirtyrate.c
>>> @@ -162,6 +162,21 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>>>      strcpy(info->idstr, qemu_ram_get_idstr(block));
>>>  }
>>>  
>>> +static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, int count)
>>> +{
>>> +    int i;
>>> +
>>> +    if (!infos) {
>>> +        return;
>>> +    }
>>> +
>>> +    for (i = 0; i < count; i++) {
>>> +        g_free(infos[i].sample_page_vfn);
>>> +        g_free(infos[i].hash_result);
>>> +    }
>>> +    g_free(infos);
>>> +}
>>> +
>>>  static struct RamblockDirtyInfo *
>>>  alloc_ramblock_dirty_info(int *block_index,
>>>                            struct RamblockDirtyInfo *block_dinfo)
>>> @@ -301,8 +316,34 @@ static int compare_page_hash_info(struct RamblockDirtyInfo *info,
>>>  
>>>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>>>  {
>>> -    /* todo */
>>> -    return;
>>> +    struct RamblockDirtyInfo *block_dinfo = NULL;
>>> +    int block_index = 0;
>>> +    int64_t msec = 0;
>>> +    int64_t initial_time;
>>> +
>>> +    rcu_register_thread();
>>> +    reset_dirtyrate_stat();
>>> +    rcu_read_lock();
>>> +    initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>> +    if (record_ramblock_hash_info(&block_dinfo, config, &block_index) < 0) {
>>> +        goto out;
>>> +    }
>>> +    rcu_read_unlock();
>>> +
>>> +    msec = config.sample_period_seconds * 1000;
>>> +    msec = set_sample_page_period(msec, initial_time);
>>> +
>>> +    rcu_read_lock();
>>> +    if (compare_page_hash_info(block_dinfo, block_index) < 0) {
>>> +        goto out;
>>> +    }
>>> +
>>> +    update_dirtyrate(msec);
>>> +
>>> +out:
>>> +    rcu_read_unlock();
>> 
>> This still holds the RCU lock across update_dirtyrate(), which I
>> understood to be unnecessary.
>>It does need to update_dirtyrate if we goto out when erro happens.
> In order to remove update_dirtyrate out of RCU, it need to add flag
> like is_need_update, like:
> if (record_ramblock_hash_info(&block_dinfo, config, &block_index) < 0) {
>          is_need_update = false;
>          goto out;
> }
>
> if (is_need_update)
>     update_dirtyrate(msec);
>
> I doubt it is worth doing that or it will does any hurt if i holds
> the RCU lock across update_dirtyrate()?

Honestly I'm not sure if holding the RCU lock a little longer will be
measurable or not, perhaps someone with more experience will have a
better idea.

>
>>> +    free_ramblock_dirty_info(block_dinfo, block_index + 1);
>>> +    rcu_unregister_thread();
>>>  }
>>>  
>>>  void *get_dirtyrate_thread(void *arg)
>>> -- 
>>> 1.8.3.1
>> 
>> dme.
>> 

dme.
-- 
We wanna wait, but here we go again.

