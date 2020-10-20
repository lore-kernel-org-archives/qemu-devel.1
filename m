Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7015EC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59D62224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bowTzD6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59D62224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtPl-00044L-Lc
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kUtJK-0004wq-9B
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kUtJG-0006aH-EQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603206740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dj+TOnvvZZ5vmfM8lwC0G0qMF8jX4le6TVB5sIfrB5s=;
 b=bowTzD6zU+UjDsvnTGmcjsctBjnlULc8ZA4/270isPmhmbMfJCcHbPGFgumrpaSlv4ZXow
 xlF3O1ZuEb7Sg3J2xuSlVkEwUoKsAApND+0VUu439u/SY/e71yUtBx3s2qzIj+vJk2D68E
 /4GzauQVPOFduBg+rZx9wliLtzuSxh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-CNpotVffPPW4WIMx97vDbQ-1; Tue, 20 Oct 2020 11:12:17 -0400
X-MC-Unique: CNpotVffPPW4WIMx97vDbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 455161084C85;
 Tue, 20 Oct 2020 15:12:16 +0000 (UTC)
Received: from [10.36.114.141] (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5471002C0E;
 Tue, 20 Oct 2020 15:12:15 +0000 (UTC)
Subject: Re: [PATCH 4/4] target/s390x: Improve SUB LOGICAL WITH BORROW
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201017022901.78425-1-richard.henderson@linaro.org>
 <20201017022901.78425-5-richard.henderson@linaro.org>
 <e2bd9942-6fe3-1570-cdc1-2cfd1519e4be@redhat.com>
 <3d014021-bf0c-c2d8-fcc1-a6a66a843353@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2a48d29a-6fa5-6557-e929-9434f0f1723e@redhat.com>
Date: Tue, 20 Oct 2020 17:12:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3d014021-bf0c-c2d8-fcc1-a6a66a843353@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.10.20 17:11, Richard Henderson wrote:
> On 10/20/20 7:17 AM, David Hildenbrand wrote:
>>> +    case CC_OP_ADDU:
>>
>> Can you give me a hint how we're converting the carry into a borrow?
>>
>> Can we apply something similar to compute_carry()?
>>
>>> +        tcg_gen_subi_i64(cc_src, cc_src, 1);
> 
> Right here: subtract one.
> 
>   carry = {1,0} -> borrow = {0,-1}

Ok, so it's really that simple :)

Thanks!

-- 
Thanks,

David / dhildenb


