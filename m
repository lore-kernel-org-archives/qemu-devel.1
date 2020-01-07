Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314DC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7D32077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfzEIbfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7D32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq9c-0005rO-8R
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iooxk-0003Vz-J0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iooxj-0005OY-Cx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:32:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iooxj-0005OJ-8v
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578403918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQ8k4187maCsiVkv/BlfiwiJbwIWL5nyIopjleGN2iA=;
 b=cfzEIbfwNmaSzrrzarFjdMlZqWeb3o336EioqfEHZyUB7Qgcpt0ofH34UNc9XQSQ6lKyPC
 3V+4mLuRzFi8vnx8hef+4iv/Tx7t8vq6EtAo6EeItA1pmMuNi5uYurK2TuwS1/nHUgsuja
 Bbq8v3ZBMWHCrvJW58pdnjVEF8FdZWk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-WXz1c3AxOy-aPo_381YY7A-1; Tue, 07 Jan 2020 08:31:57 -0500
Received: by mail-wm1-f70.google.com with SMTP id m133so1950250wmf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nQ8k4187maCsiVkv/BlfiwiJbwIWL5nyIopjleGN2iA=;
 b=PWMkMEiSA82NJnHAcsUbNf1ZMv29iMmM+GkAQsoFsg7M/mJW6FMdXmthjh9vkQNqSs
 ViaQkSB/rKRa5+XJ/+dDL6sfCA0VD1WgcrmzpcMC6QkzEW0S3sbwZSeOD+j4zdkZUWXM
 Q/0i5iIwkasyuTSRffcj/uuYrTEDkvt2PpkPcEF60fCn/LP6PcmezT1Eb+rufbktZ7fA
 Ws9C4Skduk+U1bq5Al2qbAZFyD+Ok2StyZHckwrhIvD+alFiQ0FL6z77SdVqipZsmBnA
 1KdW8ZPXkRScBkIRBflWbnUNUzR+vKAesdPyUMWupRnjFafNNNNdBtoIp9x4TRq8WzFG
 Ho3A==
X-Gm-Message-State: APjAAAU2sBqekeQ85JnSlsSd4zgkky7CZnCwk7/BjxiRRH6kvDXUNBkp
 WvwpXEchRFPGphOO4kZVblELJqr4X6/MvqN0f3af0VfF7CsqEWEGp0XThlwSaC2TYYRC5/uVyp3
 +qYKqNlOyZZZx0dQ=
X-Received: by 2002:adf:f308:: with SMTP id i8mr49050753wro.42.1578403916634; 
 Tue, 07 Jan 2020 05:31:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmdNxCxvc9k02zJuROx2zg1Xu3uFx3m2LXaQbKd4m6cPmsfKqYWE4pn3SDa5fw427OKIu2dg==
X-Received: by 2002:adf:f308:: with SMTP id i8mr49050730wro.42.1578403916430; 
 Tue, 07 Jan 2020 05:31:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id a14sm81681169wrx.81.2020.01.07.05.31.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 05:31:55 -0800 (PST)
Subject: Re: [PATCH 0/2] Fix Cooperlake CPU model
To: Xiaoyao Li <xiaoyao.li@intel.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191225063018.20038-1-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <93c9cc8c-09ec-d13f-f012-edf86fd945ab@redhat.com>
Date: Tue, 7 Jan 2020 14:31:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191225063018.20038-1-xiaoyao.li@intel.com>
Content-Language: en-US
X-MC-Unique: WXz1c3AxOy-aPo_381YY7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
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
Cc: Cathy Zhang <cathy.zhang@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/12/19 07:30, Xiaoyao Li wrote:
> Current Cooperlake CPU model lacks VMX features which are introduced by Paolo
> several months ago, and it also lacks 2 security features in
> MSR_IA32_ARCH_CAPABILITIES disclosed recently.
> 
> Xiaoyao Li (2):
>   target/i386: Add new bit definitions of MSR_IA32_ARCH_CAPABILITIES
>   target/i386: Add missed features to Cooperlake CPU model
> 
>  target/i386/cpu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
>  target/i386/cpu.h | 13 +++++++-----
>  2 files changed, 58 insertions(+), 6 deletions(-)
> 

Queued, thanks.

Paolo


