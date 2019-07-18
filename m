Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFE8C76196
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 09:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A53217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 09:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A53217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho36N-00010V-Az
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 05:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49553)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1ho36D-0000bs-MO
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ho36C-0008CD-QZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:53:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ho36C-0008BK-Hz
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:53:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so24942122wma.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 02:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FFbNIlNP6SJe3WIJ+tlvjRKnnJMBSF7yiWaqiTsDftU=;
 b=aHOiCMM3rl18TKTFWTyhJMuz78ggse0cvZD1zONoD98stBlCSCVPIOdEbQH9g/QLxo
 RIcdLnhYc/145t561F95QhiGht1dM/gHiXraTFTr+d7xauunTYwLqjjgv5qZv/kvO4+/
 mL1XW2jlT4ZUg9XJuG1I3IX8MdO3Hx4kLv6ZTWsM74bd+dLjUV0AM4pp1aP8bslzRwDK
 TRLfGIsRPT2TxsP9EWxtWXPK47fG96+7EEjEYWIYyoNM7GBL/HCaYjDrwC5AaGPr7KOB
 Ki2aPeneo2mk7+EzG2QR4zSEhamxzyg5PYckgk1/8f3b8P7WBOli0vVUmFz+q9Mb5ipW
 oDzw==
X-Gm-Message-State: APjAAAVzHM9TJ0EK2ILsXcTT8wkUpF44kTFoqVkpVxMJCiy7VECQx8oI
 OzTJQikSWHOYmBqZlcqaOkP9bUBk//kjQA==
X-Google-Smtp-Source: APXvYqyGPk8knY53PuOjZoePg7aBJR+VooMV4WwCIPuDgWfrw1xyhH+B9Ds7Mfhrax0a7yusgtsEeQ==
X-Received: by 2002:a7b:c928:: with SMTP id h8mr4143495wml.93.1563443594828;
 Thu, 18 Jul 2019 02:53:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id x16sm20347330wmj.4.2019.07.18.02.53.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 02:53:14 -0700 (PDT)
To: Peter Xu <zhexu@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>
References: <20190718010456.4234-1-richardw.yang@linux.intel.com>
 <20190718014548.GA14872@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <67f0b529-9cb5-05ae-5e9b-1a207dc605f0@redhat.com>
Date: Thu, 18 Jul 2019 11:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718014548.GA14872@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 0/2] bitmap: refine bitmap_set
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
Cc: corentincj@iksaif.net, quintela@redhat.com, pl@kamp.de,
 qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/07/19 03:45, Peter Xu wrote:
> On Thu, Jul 18, 2019 at 09:04:54AM +0800, Wei Yang wrote:
>> Patch 1 refine bitmap_set a little.
>> Patch 2 add related test case to bitmap_set.
>>
>> v3:
>>   * free bmap
>>   * all 1's set correctly
>>   * expand range to 2 long
>>   * check each possible of offset
>>   * add a skeleton to test both bitmap_set and bitmap_set_atomic
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Queued for 4.2, thanks.

Paolo


