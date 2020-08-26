Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD31C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786642080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="axjCNdfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786642080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAt62-0003Kz-Mc
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAt3N-0005uJ-8g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:53:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAt3H-0001W0-4Z
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:53:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id a5so1330233wrm.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=ALlIKMUEnT3uU6b07euw91wpzQdUfu2Dw7stGzRpdrg=;
 b=axjCNdfKWcxV74aSNNQUn2x9vpVIBUFHNv8BEvYA2/M9sS6sSi8Z6E04nrmm9UKVOw
 e1U9sPXnT/Fxti1bKyqgmGefXT2J4uoJY/DPLXHXIoIctHsrnEGAn7wBJR3kvlKZKI29
 B4whje4UY5K5+K1Kv7Tn+1hM56GX/wDSs5XRNfGG+fFX5F437rkCE2yu4a1OpEmOsiFp
 Zx65NGZlcff3T5ul+y4M30y/BGguYuaoT7l+D9Ozl3vATxRu3ISNoYcve49VjGqU0s8A
 mxEbJNaCxjF90Hh7mv8rRYUej0ButhxktClNWz+tFzG7jrBTsPTvVKapNNs6zqD6v77s
 wxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=ALlIKMUEnT3uU6b07euw91wpzQdUfu2Dw7stGzRpdrg=;
 b=CVBfJ9VCJx+QSPgq/LGd3MLS0X+K1ouA7qJyL+gfJ6/UZEtHxGrpSi8dhY6oUsI2H/
 wPJhlCh2mV9cggz4C2gP92ooKGj3WulamHmTlL04Yz2cX3Vff5Z87gHJruUXGYCKNPIt
 05z6ryJhU+n5O0cB4AwSR51Yvkh+NaOG40E1u6xD2Aei8NcQAZuTOt8IjSrlSsqwILgQ
 Xh5s7hkslwWgtmXflNZI8X8TLVUdB0YtNqET2ui39tuy/pttjeTrkA8JS/9l7wZLey5P
 iqhVDOqgIDCDO4h5qf0UuQAnPK1igkVz9dMwccUtgrAZfRtLKdnsaIu/yoSM8fdvW0dZ
 a8eQ==
X-Gm-Message-State: AOAM531xC08OQ4Z0etw2SngHqV0VrC4vmbi8LccN0C99zGJyyeIkZS5b
 bwjFNaGHBls8bAUccObSnwEs3g==
X-Google-Smtp-Source: ABdhPJymphwzmWKb+2jhQGjfFNDmZrQLKKhM34VjvyAxWBEqA6b97SW6AwKMnyT03klRaLJYH+ZOEA==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr15042522wrs.368.1598439188945; 
 Wed, 26 Aug 2020 03:53:08 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id n18sm4752401wrp.58.2020.08.26.03.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 03:53:08 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 1d2838e8;
 Wed, 26 Aug 2020 10:53:07 +0000 (UTC)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 03/12] migration/dirtyrate: Add RamlockDirtyInfo to
 store sampled page info
In-Reply-To: <20200826103330.GB2726@work-vm>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-4-git-send-email-zhengchuan@huawei.com>
 <m2lfi1lpqj.fsf@dme.org> <20200826103330.GB2726@work-vm>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 11:53:07 +0100
Message-ID: <m2tuwpk7ak.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::441;
 envelope-from=dme@dme.org; helo=mail-wr1-x441.google.com
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
Cc: alex.chen@huawei.com, berrange@redhat.com, zhang.zhanghailiang@huawei.com,
 quintela@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 Chuan Zheng <zhengchuan@huawei.com>, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-08-26 at 11:33:30 +01, Dr. David Alan Gilbert wrote:

> * David Edmondson (dme@dme.org) wrote:
>> On Monday, 2020-08-24 at 17:14:31 +08, Chuan Zheng wrote:
>> 
>> > Add RamlockDirtyInfo to store sampled page info of each ramblock.
>> >
>> > Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> > ---
>> >  migration/dirtyrate.h | 18 ++++++++++++++++++
>> >  1 file changed, 18 insertions(+)
>> >
>> > diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>> > index 33669b7..70000da 100644
>> > --- a/migration/dirtyrate.h
>> > +++ b/migration/dirtyrate.h
>> > @@ -19,6 +19,11 @@
>> >   */
>> >  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
>> >  
>> > +/*
>> > + * Record ramblock idstr
>> > + */
>> > +#define RAMBLOCK_INFO_MAX_LEN                     256
>> > +
>> >  /* Take 1s as default for calculation duration */
>> >  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>> >  
>> > @@ -27,6 +32,19 @@ struct DirtyRateConfig {
>> >      int64_t sample_period_seconds; /* time duration between two sampling */
>> >  };
>> >  
>> > +/*
>> > + * Store dirtypage info for each ramblock.
>> > + */
>> > +struct RamblockDirtyInfo {
>> > +    char idstr[RAMBLOCK_INFO_MAX_LEN]; /* idstr for each ramblock */
>> > +    uint8_t *ramblock_addr; /* base address of ramblock we measure */
>> > +    uint64_t ramblock_pages; /* ramblock size in 4K-page */
>> 
>> It's probably a stupid question, but why not store a pointer to the
>> RAMBlock rather than copying some of the details?
>
> I think I figured that out in the last round;  this code runs as:
>
>     rcu lock {
>        calculate initial CRCs
>     }
>
>     <sleep 1 second ish>
>     rcu lock {
>        calculate new CRCs
>     }
>
> A RAMBlock might get deleted between the two.

Makes sense, thanks.

dme.
-- 
Why does it have to be like this? I can never tell.

