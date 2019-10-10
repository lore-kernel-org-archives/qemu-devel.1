Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C3ECE58C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 00:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30067206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 00:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePnmr3aZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30067206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIMiM-00075g-Ay
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 20:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIMha-0006Yo-Fy
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIMhZ-0006CJ-JR
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:53:10 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:39113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIMhZ-0006C5-F8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:53:09 -0400
Received: by mail-yb1-xb44.google.com with SMTP id v37so1376675ybi.6
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5cAdBszWO3ycw7CajRtiU60zkj581kBwr+ulfHGBmyE=;
 b=ePnmr3aZymWLHNAIStyecEElrE0/Gu6oeHOf2FMxrvxAsztFZWc02sIZOamQdH/nuv
 OAfxEuxGYLdE723SE0EFdg9IlRiH15s8bHvzCr8JdmxC5sJKzxhEiJYtZJ3jOwRUOSoY
 T9FJsN3h8G35z0rmO0inQ55ZGDI18Xeq8sxu5QcNd+YnEZsYnBgU6pUN9WSQfuQGTy6w
 Pgrq1vyTDLftgS7AIB9CN+3e8cfX/nSC9wmqN9ghb6OHJK9YeA1Wb+Cs52RPGeesDhtc
 rTcCEzSrlnXhmGFJf84UeXVyQX6k62ZItsefi3CPzcKxDdR2s0Oru6TBItd86L0yuMYl
 0Nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5cAdBszWO3ycw7CajRtiU60zkj581kBwr+ulfHGBmyE=;
 b=auE+cr1P29WrPuVtz0RY1yvTs2mT6xWonAzxVRnBSiiTZuKTzfS36ULT/vFAcDcEp1
 0lDcYNbw6z3+6GuaDDuif+9w08Hl2YfTpZ58T6CBLTBJZTVjYPLWxqWIZRX3PPOwVHeu
 HijijApl1Q1aSVBnsMuTD+R7NLR0PT09z5WNRYNsMSGwej7E1B3BcBbxsABdna+sNe5I
 XHH27ai++laL8rHi1RmcHzhR3DPDjnLwT8JTp1bYXzPCBuny7Qo7oj4Pn3f/cKdG2Zpm
 LQpZ/oWXhytGv0NVWpPgXwb2oW9tmTl8kxUQE9z/zvqp0N0MZV7MaYs4sddT9GyR5Wsd
 FiwA==
X-Gm-Message-State: APjAAAXJnqL2/LRNy5C+/xJ/nFUalrdg9KJzBsr/wXMJQtKKn3JQI2gV
 A5xavfjiBm7v6RwNhGiZWDT66g==
X-Google-Smtp-Source: APXvYqypeAYwudLFHCI7nMqfPH4zy+rM/LSc5JNB6vRbB8kDJlESGrjW9WufyXIckyzxF3PC6qP7Dg==
X-Received: by 2002:a25:58d5:: with SMTP id m204mr4106114ybb.325.1570668788588; 
 Wed, 09 Oct 2019 17:53:08 -0700 (PDT)
Received: from [192.168.1.44] (67.216.151.25.pool.hargray.net. [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id s187sm998401ywd.27.2019.10.09.17.53.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Oct 2019 17:53:07 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] target/arm/cpu: Add the kvm-adjvtime CPU property
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191007170622.1814-1-drjones@redhat.com>
 <20191007170622.1814-6-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <53e8d0a7-1796-5caf-3774-38f82c1c8ecb@linaro.org>
Date: Wed, 9 Oct 2019 20:53:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007170622.1814-6-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 1:06 PM, Andrew Jones wrote:
> kvm-adjvtime is a KVM specific CPU property and a first of its kind.
> To accommodate it we also add kvm_arm_add_vcpu_properties() and a
> KVM specific CPU properties description to the CPU features document.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

