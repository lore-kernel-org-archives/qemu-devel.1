Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DE9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87FE2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHqpdGhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87FE2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxQG-0006Zv-6W
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdxPe-00065I-2v
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:52:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdxPd-0005Z9-3A
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590591127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=QUDxZ5x9kcPU4rw4ADTLdD+Ra2ODWQ0xaNemVvImXOI=;
 b=iHqpdGhyRgwmOH+ZudAztaW6SUUQXsGhahd7ae6qQ15iKdtkLpKAog6xHYYdftbMQFbPhn
 IKt1+p/RJ159K8rTFcgmrVWcrKBkZSpT2EERBgefpxffGov44RYFF+hJZAQeIGosjWX52/
 imL8olCYIxO4g0/+cUajble4MmuT/t8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-hSnmNM-qOGuC6tu77p5SVQ-1; Wed, 27 May 2020 10:52:00 -0400
X-MC-Unique: hSnmNM-qOGuC6tu77p5SVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73B8D1B18BC0;
 Wed, 27 May 2020 14:51:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-170.ams2.redhat.com [10.36.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68E6479C5B;
 Wed, 27 May 2020 14:51:54 +0000 (UTC)
Subject: Re: [PATCH 7/7] linux-user: limit check to HOST_LONG_BITS <
 TARGET_ABI_BITS
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-8-thuth@redhat.com>
 <1b050c61-0cd3-bc91-7610-856a28a27175@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ab17e3cd-5117-b54b-6460-60c595d97033@redhat.com>
Date: Wed, 27 May 2020 16:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1b050c61-0cd3-bc91-7610-856a28a27175@vivier.eu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/2020 16.44, Laurent Vivier wrote:
> Le 25/05/2020 à 15:18, Thomas Huth a écrit :
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> Newer clangs rightly spot that you can never exceed the full address
>> space of 64 bit hosts with:
>>
>>   linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
>>   long' > 18446744073709551615 is always false
>>   [-Werror,-Wtautological-type-limit-compare]
>>   4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>   4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>>   4687 1 error generated.
>>
>> So lets limit the check to 32 bit hosts only.
>>
>> Fixes: ee94743034bf
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> [thuth: Use HOST_LONG_BITS < TARGET_ABI_BITS instead of HOST_LONG_BITS == 32]
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  linux-user/elfload.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 01a9323a63..ebc663ea0b 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -2073,12 +2073,14 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
>>              exit(EXIT_FAILURE);
>>          }
>>      } else {
>> +#if HOST_LONG_BITS < TARGET_ABI_BITS
>>          if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>              error_report("%s: requires more virtual address space "
>>                           "than the host can provide (0x%" PRIx64 ")",
>>                           image_name, (uint64_t)guest_hiaddr - guest_base);
>>              exit(EXIT_FAILURE);
>>          }
>> +#endif
>>      }
>>  
>>      /*
>>
> 
> Philippe sent the same patch:
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg699796.html

Indeed, but looking more closely, he's using slightly different
locations for the #if and #endif ... not sure what's better though...?

 Thomas


