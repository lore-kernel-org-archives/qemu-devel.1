Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EDDC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CA020679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLVu7BnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CA020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLqn-0006Y1-U3
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kNLYi-0000QO-Fu
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kNLYg-0007Gv-4C
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:45:08 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601408704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApZGxpY8y8F7xmMMII2LWwpwh5Cnnxx2AjaMg3GtiCI=;
 b=bLVu7BnXEA+KxLJzNqWDuQnrtGiI5TndZ6wCBwAbODjA4e+QEwST7qd431DFExRIoq8z4V
 wcFYEoNXIu32wlJi4dxlqS5dIMXxvtBncJRU8WxA8rl6AjHEaV7dmgkrmCdvE88ie/pG8w
 xO7Hk7L9/r49JnEwQMAbHh16juj6d90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-wweYFVZrOKye_q78H9BtWg-1; Tue, 29 Sep 2020 15:45:00 -0400
X-MC-Unique: wweYFVZrOKye_q78H9BtWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93FCB186841B;
 Tue, 29 Sep 2020 19:44:59 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33D7655795;
 Tue, 29 Sep 2020 19:44:50 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] util/vfio-helpers: Rework the IOVA allocator to
 avoid IOVA reserved regions
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200929085550.30926-1-eric.auger@redhat.com>
 <20200929085550.30926-3-eric.auger@redhat.com>
 <20200929155951.GB191675@stefanha-x1.localdomain>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6ebdb1f7-792b-6fbe-d4b3-f06aafc8deef@redhat.com>
Date: Tue, 29 Sep 2020 21:44:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200929155951.GB191675@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: fam@euphon.net, lvivier@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, kwolf@redhat.com, philmd@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 9/29/20 5:59 PM, Stefan Hajnoczi wrote:
> On Tue, Sep 29, 2020 at 10:55:50AM +0200, Eric Auger wrote:
>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>> index ba0ee6e21c..71145970f3 100644
>> --- a/util/vfio-helpers.c
>> +++ b/util/vfio-helpers.c
>> @@ -667,6 +667,50 @@ static bool qemu_vfio_verify_mappings(QEMUVFIOState *s)
>>      return true;
>>  }
>>  
>> +static int
>> +qemu_vfio_find_fixed_iova(QEMUVFIOState *s, size_t size, uint64_t *iova)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < s->nb_iova_ranges; i++) {
>> +        if (s->usable_iova_ranges[i].end < s->low_water_mark) {
>> +            continue;
>> +        }
>> +        s->low_water_mark =
>> +            MAX(s->low_water_mark, s->usable_iova_ranges[i].start);
>> +
>> +        if (s->usable_iova_ranges[i].end - s->low_water_mark + 1 >= size ||
>> +            s->usable_iova_ranges[i].end - s->low_water_mark + 1 == 0) {
> 
> I don't understand the == 0 case. It seems like we are allocating an
> IOVA beyond usable_iova_ranges[i].end?>
It is meant to handle the case were low_water_mark = 0 and
s->usable_iova_ranges[0].end = ULLONG_MAX (I know it cannot exist at the
moment but may happen in the future) where we get an overflow. Given the
        if (s->usable_iova_ranges[i].end < s->low_water_mark) {
            continue;
        }
I think this prevents us from allocating beyond
usable_iova_ranges[i].end or do I miss something?

Thanks

Eric


