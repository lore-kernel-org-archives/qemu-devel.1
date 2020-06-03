Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AEAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 18:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C98F20734
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 18:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alUxlVp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C98F20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgXqp-0006ul-D0
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 14:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgXpo-0006Oa-L1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 14:09:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgXpn-00011B-UB
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 14:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591207790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=QN0qYaWR9+ivisDQyr8v7AoVy4mfWH0fw3Qaelnh8Wg=;
 b=alUxlVp8wB45bN+DUKAatX9D2GreCNASxRO3i8Y+wrie5/BymfuVAqFlzSmRgI4MwUHq2S
 NVgIqL1da6hiRYLh3rw/DhvvPCGBMe8NLvhdUoBecGL4wXgEKKydHleA1171X/zfWglSxm
 2xymBp5NpU8u5nnCUFTVceQoqT6AI9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-cqqY9AhmNPei2BA3qdwpUw-1; Wed, 03 Jun 2020 14:09:46 -0400
X-MC-Unique: cqqY9AhmNPei2BA3qdwpUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A16D080058E;
 Wed,  3 Jun 2020 18:09:45 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 324DB60BF4;
 Wed,  3 Jun 2020 18:09:40 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] linux-user/mmap: Fix Clang 'type-limit-compare'
 warning
To: Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
References: <20200503113220.30808-1-f4bug@amsat.org>
 <20200503113220.30808-3-f4bug@amsat.org>
 <7529763d-1f4a-5077-14ed-98753c8db288@redhat.com>
 <555fa273-336a-1e46-77f6-e3057dea36ca@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d8ecf1e7-6f19-e16a-3801-aaaf64c90030@redhat.com>
Date: Wed, 3 Jun 2020 20:09:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <555fa273-336a-1e46-77f6-e3057dea36ca@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/06/2020 20.01, Richard Henderson wrote:
> On 6/3/20 9:06 AM, Eric Blake wrote:
>> Instead of using #if, the following suffices to shut up clang:
>>
>> diff --git c/linux-user/mmap.c w/linux-user/mmap.c
>> index e37803379747..8d9ba201625d 100644
>> --- c/linux-user/mmap.c
>> +++ w/linux-user/mmap.c
>> @@ -715,7 +715,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>>              host_addr = MAP_FAILED;
>>          }
>>          /* Check if address fits target address space */
>> -        if ((unsigned long)host_addr + new_size > (abi_ulong)-1) {
>> +        if ((unsigned long)host_addr > (abi_ulong)-1 - new_size) {
>>              /* Revert mremap() changes */
>>              host_addr = mremap(g2h(old_addr), new_size, old_size, flags);
>>              errno = ENOMEM;
>>
>>
>> That is, it is no longer a tautological type compare if you commute the
>> operations so that neither side is a compile-time constant.
> 
> To some extent the tautological compare is a hint to the compiler that the
> comparison may be optimized away.  If sizeof(abi_ulong) >= sizeof(unsigned
> long), then the host *cannot* produce an out-of-range target address.
> 
> We could add the sizeof test to the if, to preserve the optimization, but that
> by itself doesn't prevent the clang warning.
> 
> Which is why I have repeatedly suggested that we disable this warning globally.

I guess most people (like me) don't have a strong opinion about this. So
maybe simply suggest a patch to disable the warning? I don't think that
anybody will object.

 Thomas


