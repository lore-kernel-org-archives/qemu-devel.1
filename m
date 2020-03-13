Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D3C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEB220409
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4bKrtM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEB220409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCeT0-0004qP-Nr
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 03:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jCeSK-0004LJ-UN
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jCeSI-0001U7-7O
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:10:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57244
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jCeSH-0001RV-UV
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584083401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nyol2i9OCPXQyZQ2DOtx8VgaSwLx9w9v7j4usAOnsbM=;
 b=i4bKrtM8qaGGZwZPabGtvaEsMJYgtDTiKAP2vOWYjyetVmgOimJlRmR3Fp38f0IN/57/nY
 1uBs0i3QbaPYYID6axe9Vb427mZztIvtmy1L4yVbqYEqmcmPyRfap3LHrAjaJgC7kPhH3A
 LRI5LbWvLqpaGWTleBzTWAl0wDz13VE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-F1qHMyurPUqiclindfhh-A-1; Fri, 13 Mar 2020 03:09:59 -0400
X-MC-Unique: F1qHMyurPUqiclindfhh-A-1
Received: by mail-wr1-f69.google.com with SMTP id w6so3822561wrm.16
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 00:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nyol2i9OCPXQyZQ2DOtx8VgaSwLx9w9v7j4usAOnsbM=;
 b=goXA3nXryHk7iiVnA+a8yx/gUeNprlrYCCR5++wC2GgZSMOJDsxL/nF2IBtGad9pNi
 r12s6jQxns78tQtpjJV1JYq0/gYYkreGsj4nk3j8paVp8zTm7246YUDD1+pl/LkLlG4O
 6Iruw6ydVr2mgFN8ohT1S+0X205tldmGlhwngUX/COAmLC4lve14uWNP4rXANpJdmhlz
 E6pqK5e0M/GcMe2BxYscbDMaUrE66h5ENqAANHBas2nCBHh6SmE1aPgHyJml6FHdpujm
 hRY6pAbWC+jkI84cLfLWXl8+aVluw3Oy1Zan3mSQeCISNsrY5SJK+iRodGe8kwTGwkrT
 S35w==
X-Gm-Message-State: ANhLgQ3HuxtsviT0Z0Y0kQy25HPAcoycwKtFetjv5Grhmwbf9KW+QQ4J
 SO0xhaMQqxBiZHcMRZpmlrY0xhbz67K5ETO84imvTkrZ2aDWB0sLSuMB2LAHinb4X7oget0392H
 HgFvn0qncZSlVdAs=
X-Received: by 2002:a05:600c:22c6:: with SMTP id
 6mr5702174wmg.161.1584083398251; 
 Fri, 13 Mar 2020 00:09:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vscyeCP6dzGc6aYo9YUQ2VHfzw4cj7worbFJah5WoF1p3589h95rcgPWYRBJVxqitDBtnuUlQ==
X-Received: by 2002:a05:600c:22c6:: with SMTP id
 6mr5702138wmg.161.1584083397953; 
 Fri, 13 Mar 2020 00:09:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac?
 ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
 by smtp.gmail.com with ESMTPSA id h13sm21116443wrv.39.2020.03.13.00.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 00:09:57 -0700 (PDT)
Subject: Re: [RFC] cpus: avoid get stuck in pause_all_vcpus
To: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>, rth@twiddle.net
References: <20200310091443.1326-1-longpeng2@huawei.com>
 <8ed76f64-1a24-a278-51f3-19515e65ff39@redhat.com>
 <a6c8eac3-a714-ff6f-2bd6-1fa1d1037a81@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4dc19fd-bee2-251f-1fef-b41cd6da6c23@redhat.com>
Date: Fri, 13 Mar 2020 08:09:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a6c8eac3-a714-ff6f-2bd6-1fa1d1037a81@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, arei.gonglei@huawei.com,
 huangzhichao@huawei.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel @ nongnu . org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/03/20 02:43, Longpeng (Mike, Cloud Infrastructure Service Product
Dept.) wrote:
>> diff --git a/cpus.c b/cpus.c
>> index b4f8b84b61..1eb7533a91 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1899,6 +1899,10 @@ void resume_all_vcpus(void)
>>  {
>>      CPUState *cpu;
>>
>> +    if (!runstate_is_running()) {
>> +        return;
>> +    }
>> +
> Hi Paolo,
> 
> The runstate of my above sketch is running, so maybe your patch can fix some
> other issues but not mine ?

You're right, do_vm_stop sets the runstate after pause_all_vcpus.  We
can move that before and it should fix your case too.

Paolo


