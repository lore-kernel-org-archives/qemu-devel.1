Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC67C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3445D214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzrmd01T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3445D214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifD7K-0002jq-95
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 20:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifD6M-0001ni-NR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifD6L-0003Ul-IZ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:17:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifD6L-0003T2-EC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576113428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=poMrsCxkILLRjzw50L6xZ8xAfs/erQGHkLXQAsQ+d8I=;
 b=bzrmd01Tz4QNP6+DE2LfG8l7brHDVX5c+a/OHbh2+/27hXOcpb0RURVCk4XGk2t3i/L7GI
 qzWonM7VdzGg+Jc1gkhpvEmfyp28SHPFr+BLisp46fmr/WOlYGp9xLbir4XFixhrSocEYr
 DSiWqRclqp0fiWprJiN2Av/GZQvHGzo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-wRaDTrIMOd-BxfvFRuzyPw-1; Wed, 11 Dec 2019 20:17:07 -0500
Received: by mail-wr1-f71.google.com with SMTP id l20so351569wrc.13
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 17:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=poMrsCxkILLRjzw50L6xZ8xAfs/erQGHkLXQAsQ+d8I=;
 b=CdfBJ8LtfCjTlBwbH9NT4fLMfplmgvciHKnDtBnuWRnOgOSVPnKqp37F9Pn8tPLYM9
 XbEabhxXgmqiIsNAKgEIZFrFaVtxRMug3BX1wd/2jtNDq9ILqu8EgYuFntLbouqUjbeP
 WNEuraGKZqNVIMibf76/QbjMmgJoRsd8F09KJmA1wxVBtLo8qy0fKbCGE/H0Y0HFQSeL
 Dh8MxwvxwdQnc+5t2720LJwqrsDF6FLH42N0w0NAkc2E1M231BFq3E4Ukra4pP5uW9fv
 OetBWlzITZi3zN/aHQGxSfekYbSwXjuQ3qVCG9cwGaIqaJ0T1JJEBvgwXUkRpZGFsLTA
 LW1w==
X-Gm-Message-State: APjAAAWYpYoLywRwokJYUBAPdoAosaI5iTtC0t7pfptAGc0ISERYBGxx
 C+uKDiPtfxjv+8Z341OEV/pZyq5MnYLi1peTkRo4+4dSvY1nSGUfXsquA2E/vuNYrm0Xj4sveJL
 q5PGa+j31vvVx9LU=
X-Received: by 2002:a7b:c936:: with SMTP id h22mr2955826wml.115.1576113426056; 
 Wed, 11 Dec 2019 17:17:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3xj/t1F4y4JT42ZJLY/r6/Lcp8Y28rmceRF8yboPRgre9YGQd778Tece/AVloJw6ZkiRX4g==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr2955806wml.115.1576113425792; 
 Wed, 11 Dec 2019 17:17:05 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id k19sm4075856wmi.42.2019.12.11.17.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 17:17:05 -0800 (PST)
Subject: Re: [PATCH] tests: use g_test_rand_int
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1576074210-52834-6-git-send-email-pbonzini@redhat.com>
 <c61a0b0f-d4c0-6418-c7cd-568cd6d27c5b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fef051da-ba9a-4eb1-4fd0-5553e92b5843@redhat.com>
Date: Thu, 12 Dec 2019 02:17:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c61a0b0f-d4c0-6418-c7cd-568cd6d27c5b@redhat.com>
Content-Language: en-US
X-MC-Unique: wRaDTrIMOd-BxfvFRuzyPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 20:25, Thomas Huth wrote:
> On 11/12/2019 15.23, Paolo Bonzini wrote:
>> g_test_rand_int provides a reproducible random integer number, using a
>> different number seed every time but allowing reproduction using the
>> --seed command line option.  It is thus better suited to tests than
>> g_random_int or random.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  block/vhdx.c         | 2 +-
>>  block/vmdk.c         | 4 ++--
>>  tests/ivshmem-test.c | 2 +-
>>  tests/test-bitmap.c  | 8 ++++----
>>  tests/test-qga.c     | 4 ++--
>>  5 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/vhdx.c b/block/vhdx.c
>> index f02d261..36465d5 100644
>> --- a/block/vhdx.c
>> +++ b/block/vhdx.c
>> @@ -1504,7 +1504,7 @@ static int vhdx_create_new_headers(BlockBackend *blk, uint64_t image_size,
>>      hdr = g_new0(VHDXHeader, 1);
>>  
>>      hdr->signature       = VHDX_HEADER_SIGNATURE;
>> -    hdr->sequence_number = g_random_int();
>> +    hdr->sequence_number = g_test_rand_int();
>>      hdr->log_version     = 0;
>>      hdr->version         = 1;
>>      hdr->log_length      = log_size;
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index 20e909d..eba96bf 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -2037,7 +2037,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>          /* update CID on the first write every time the virtual disk is
>>           * opened */
>>          if (!s->cid_updated) {
>> -            ret = vmdk_write_cid(bs, g_random_int());
>> +            ret = vmdk_write_cid(bs, g_test_rand_int());
>>              if (ret < 0) {
>>                  return ret;
>>              }
>> @@ -2499,7 +2499,7 @@ static int coroutine_fn vmdk_co_do_create(int64_t size,
>>  
>>      /* generate descriptor file */
>>      desc = g_strdup_printf(desc_template,
>> -                           g_random_int(),
>> +                           g_test_rand_int(),
>>                             parent_cid,
>>                             BlockdevVmdkSubformat_str(subformat),
>>                             parent_desc_line,
> 
> Why do you also change this in block/ and not only in tests/ ?

Because today was not my day. :/

Paolo


