Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B369C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095C320850
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FklvIOcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095C320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1F6c-0004EQ-PH
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1Erh-0005wQ-D8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1Erf-0001hR-6Q
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:04:48 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1Ere-0001g6-MB
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:04:47 -0400
Received: by mail-pl1-x642.google.com with SMTP id gn20so6061094plb.2
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Me3uBy3nz24VlnsYg7ubJxvYpiVCyDYT57dyN5yHXWQ=;
 b=FklvIOcS5eH4CtRFKKVakN0tas8V8Gutu1c/n24hKC/+d8D6+W6OZautRwUxiQADId
 nJbHFm7ramD5VRELOezozDWEHwCOzBhk+zllh2QT1SynsAKkx76mBQLNaSNjc2Xfhkxk
 lz/iMWJ+179tiSIuwuOcYjfXk2Mkou817ygBrSkf3FWkvaY+VNQs9/KMauU2RVqC6mBC
 b6gOfAYP5GrEUvILNWQKwAz5vvxXfRZ3lNnCNTeaSDUggKlDoUqSPZio+3YeWII9U9EV
 l2u+ZRK2K3dqmrOMg7/V2pR55w8KyTHlGb+BdxID7/o0sOBlSJY9yZFICZ84kMcySQ90
 8k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Me3uBy3nz24VlnsYg7ubJxvYpiVCyDYT57dyN5yHXWQ=;
 b=LwZpTh+5xF6lvBFjflZuc06pc7VcGNxAM/ee44YZn1pvcURjCXBt7j0IhMRjXRn2VS
 TYeuz8NTf2CMNhwEC4WKmDQva4c4V/U+AAU3oDTxU8oUMBTY26MqQ2SGoWSMxMwLq7Kl
 zoc0RLVNJybKGRYAeImMlOISRMZXunR/2eL4S0rojAf7zKDJEJ+8Hf2ZtQJ4CNj+C9PG
 fc2KbTsN0BwKwL2kzl6Na5LkvtBe9BYGmYtiDVVUjmLzc0jRGpqbP/rgEVNec5a8uuJH
 LaAUEzrl/N3mZFAJuR1Lt0Fe+M4Tk2phhWdvEH2ED6AV4c+tVDthVlOfcbcBWJLD5t0S
 TQgQ==
X-Gm-Message-State: APjAAAVboz03joqw6AUTLxlczUC5Zc0ixQM1XmJQ6r5dsIWOr6tGSaxm
 IzVRCIFr+bkwU0vhqkNKYKqraA==
X-Google-Smtp-Source: APXvYqyC0Js2fu2rOsc7tlBl56hJ54fndhaP5447vz08B1iVw5tAC/zALRscIuhaUJ9JMbc6k9YxvQ==
X-Received: by 2002:a17:902:8a87:: with SMTP id
 p7mr6501318plo.124.1566587085432; 
 Fri, 23 Aug 2019 12:04:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a5sm2901697pjs.31.2019.08.23.12.04.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 12:04:44 -0700 (PDT)
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <cover.1566466906.git.tony.nguyen@bt.com>
 <8066ab3eb037c0388dfadfe53c5118429dd1de3a.1566466906.git.tony.nguyen@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f0b797c8-7801-d2cc-5ad5-7bf7b46a790e@linaro.org>
Date: Fri, 23 Aug 2019 12:04:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8066ab3eb037c0388dfadfe53c5118429dd1de3a.1566466906.git.tony.nguyen@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v9 14/20] memory: Access MemoryRegion with
 endianness
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Collin Walling <walling@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 11:36 AM, Tony Nguyen wrote:
> Preparation for collapsing the two byte swaps adjust_endianness and
> handle_bswap into the former.
> 
> Call memory_region_dispatch_{read|write} with endianness encoded into
> the "MemOp op" operand.
> 
> This patch does not change any behaviour as
> memory_region_dispatch_{read|write} is yet to handle the endianness.
> 
> Once it does handle endianness, callers with byte swaps can collapse
> them into adjust_endianness.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  accel/tcg/cputlb.c       |  8 ++++++--
>  exec.c                   | 13 +++++++++++--
>  hw/intc/armv7m_nvic.c    | 15 ++++++++-------
>  hw/s390x/s390-pci-inst.c |  6 ++++--
>  hw/vfio/pci-quirks.c     |  5 +++--
>  hw/virtio/virtio-pci.c   |  6 ++++--
>  include/exec/memory.h    |  3 +++
>  memory.c                 | 18 ++++++++++++++++++
>  memory_ldst.inc.c        | 24 ++++++++++++++++++------
>  9 files changed, 75 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

