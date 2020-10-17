Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C972C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C059620704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5DduZtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C059620704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTizI-0003rE-VD
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kTiyG-0003OD-D5
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 05:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kTiyD-0001hk-Hn
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 05:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602928667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=An9bXN71cr32Fo0zF9nZw8jJ11tNpN+N0lxmzeK9iec=;
 b=I5DduZtG50jy/VnxVcNritcP5LQSgP4flt5ytpRqJY9fMpKdhC7oy9sk+oqxWnpS82iyWI
 Ccv+H5sFOG8L2UuWLIxj2R0++GUNTLmtceJtt/qu2bGaXrZkhm29+cASOWDq+Mrc57a0CK
 YEMlqDTkPJT/rwDvSm0NjwWocoUwv2U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-PaBt8Sn_Pt6gXSVNYDcMmA-1; Sat, 17 Oct 2020 05:57:45 -0400
X-MC-Unique: PaBt8Sn_Pt6gXSVNYDcMmA-1
Received: by mail-wr1-f72.google.com with SMTP id b6so4865229wrn.17
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 02:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=An9bXN71cr32Fo0zF9nZw8jJ11tNpN+N0lxmzeK9iec=;
 b=F75wDU7730t1cB7CeK66fAyqF5L+j4psL7oM8N7l7OCz6hCvT0R3kqKuuZTruTQaMt
 kapmIo4H6mJvzFHkZ6EeyhhyC7pGl0MOpWj0pOON5KREyUKIVx1+u88AJ4Tzel4fOXBc
 iMVf2a5RMN5RscWJeRsvhWc9couJtGCyq8pjMGVQTHvjjehQCea0NhdS5YJZfKfqO0lm
 NWyBOqLtJBsrM+hkDFFzlNpxyo/V97cnR+aX0VGmrj6Cf8kmsmqR8lvMMEZKcjjuQFBr
 6fhtcFGCPFaj4KvoCMztC9SYDD86xAnzC60WoxghmhujXo1UzRCcUF7nDNyMNrs32whe
 NlUg==
X-Gm-Message-State: AOAM532TJPNvb8TnpFIjj/EXQ5N06IOGdZslikIprlpx0gGNaKGcM2C0
 JN42+EV35B49D5D7W52haniSCpke5W7iM+XUmTDk3kntNTug4qR1sIy71lOFnY6owGnE1FAmno/
 t1UJxzQ5nH0Alfc0=
X-Received: by 2002:a1c:dcc3:: with SMTP id t186mr7892041wmg.70.1602928664228; 
 Sat, 17 Oct 2020 02:57:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9SVJfN+X3Rk8MikCgI6zzTYi5I8nhzkmH0bABGmuHdU8IZXw3ku7kTbcBBuLEJq5EXb52Qg==
X-Received: by 2002:a1c:dcc3:: with SMTP id t186mr7892024wmg.70.1602928664049; 
 Sat, 17 Oct 2020 02:57:44 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id c18sm6812588wmk.36.2020.10.17.02.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:57:43 -0700 (PDT)
Subject: Re: [PATCH v1] migration: using trace_ to replace DPRINTF
To: Bihong Yu <yubihong@huawei.com>, quintela@redhat.com, eblake@redhat.com,
 dgilbert@redhat.com, berrange@redhat.com
References: <1602927347-15669-1-git-send-email-yubihong@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1bd1c3f7-4c88-c93f-127c-9576fed176c7@redhat.com>
Date: Sat, 17 Oct 2020 11:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602927347-15669-1-git-send-email-yubihong@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 05:57:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: david.edmondson@oracle.com, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 wanghao232@huawei.com, zhengchuan@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 11:35 AM, Bihong Yu wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> ---
>   migration/block.c      | 36 ++++++++++++++++++------------------
>   migration/page_cache.c | 13 +++----------
>   migration/trace-events | 13 +++++++++++++
>   3 files changed, 34 insertions(+), 28 deletions(-)
...
> diff --git a/migration/trace-events b/migration/trace-events
> index 338f38b..772bb81 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -325,3 +325,16 @@ get_ramblock_vfn_hash(const char *idstr, uint64_t vfn, uint32_t crc) "ramblock n
>   calc_page_dirty_rate(const char *idstr, uint32_t new_crc, uint32_t old_crc) "ramblock name: %s, new crc: %" PRIu32 ", old crc: %" PRIu32
>   skip_sample_ramblock(const char *idstr, uint64_t ramblock_size) "ramblock name: %s, ramblock size: %" PRIu64
>   find_page_matched(const char *idstr) "ramblock %s addr or size changed"
> +
> +# block.c
> +init_blk_migration_shared(const char *blk_device_name) "Start migration for %s with shared base image"
> +init_blk_migration_full(const char *blk_device_name) "Start full migration for %s"
> +mig_save_device_dirty(int64_t sector) "Error reading sector %" PRId64
> +flush_blks(const char *action, int submitted, int read_done, int transferred) "%s submitted %d read_done %d transferred %d"
> +block_save(const char *mig_stage, int submitted, int transferred) "Enter save live %s submitted %d transferred %d"
> +block_save_complete(void) "Block migration completed"
> +block_save_pending(uint64_t pending) "Enter save live pending  %" PRIu64
> +
> +# page_cache.c
> +cache_init(int64_t max_num_items) "Setting cache buckets to %" PRId64
> +cache_insert(void) "Error allocating page"

The patch is good, but I strongly recommend to have trace events
starting with the subsystem prefix (here migration). So we can
keep using the 'block*' rule to match all events from the block
subsystem, without including the migration events.

Thanks,

Phil.


