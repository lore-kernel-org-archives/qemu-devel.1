Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F92C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619FE206F1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AnVwr6Z7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619FE206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxUr-0000xL-Ml
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxUG-0000PU-KT
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:21:12 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxUE-0007qY-Vg
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:21:12 -0400
Received: by mail-pf1-x442.google.com with SMTP id f3so4387288pfd.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pldV5c0KP0qFT/A+GqTY1yOV4/MYneH4O4UQ/P/PL3k=;
 b=AnVwr6Z7usOyDJzyb9KogN3Y55/6LbY+BRAPDhus3XjoJnGs42iZHpWB/1tVqTwhDO
 D7uk/eQTDDSpvHRBRnRuVGrepJueRIuqdvhcrXRnPU6/1evz3nrdIJf2um4Cl2lMwGvp
 UiZUMu+t1ab5QHEn2EHP0XWpUI1BLcL1q8Cbj3MCo41IbYl8FBYUcGpDAUMVv7sHC3GU
 ZEf7qQ5/tKMSPffuZczv4b7McPlrGRhKZuC+V+ldQOyyZt36VPeQ0Gu8KOMBHMciqXk4
 yXusJAfHIoirxmL1AWHN51o6MXO+HEgpU47wxoqdYlER28tfzuQN3ps0PmmiSZrf2u4k
 H9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pldV5c0KP0qFT/A+GqTY1yOV4/MYneH4O4UQ/P/PL3k=;
 b=BeWhGgPfGDNNE2n8Hiv7pZVtUnF44xkaUwGVelz7KFcv0VS8nWrQxdVPYK8ZUu/BsB
 ubLXEzciNwj2tQ+gWh/klCULiCsnFV0ZMlkzmXp17kH5XHabw9XX53GciwH6TvHvBna8
 OmwsBpglEeXV8HP0weSrJNu0UQ0wxFYiTLkyVIQNrsEh96JNOQ2MxxlrQT4p9UzOMOTl
 uU0k9c67UndG1VMGKR6BUjbRpbaXQXaXIgvGy+v3/+A8B1BatBdkovzKt+y780WsS89k
 6gkhKZ9b8KeiU8kJNK3seEpwLHXxTg+6bTAlXxm+Q+QwGmabIubWqkn/axxR6wdQ80L9
 IOVw==
X-Gm-Message-State: AOAM532MUTPjmDVKS3nBptc311MDd3AeWFtz+UaCEpE84WJ1aAvDAjKA
 VDhnWZOPOWpNIInJO8GIlKRqsQ==
X-Google-Smtp-Source: ABdhPJw8AIn+8/l/R9wESu7wRvcSsnpNuj0whp+rqohxv0z0e+UbBQ8IrknQ0ZPQVs8BLOKjoKxhIA==
X-Received: by 2002:a63:e004:: with SMTP id e4mr20951893pgh.44.1591068069447; 
 Mon, 01 Jun 2020 20:21:09 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o3sm728599pfg.206.2020.06.01.20.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:21:08 -0700 (PDT)
Subject: Re: [RFC v2 11/18] guest memory protection: Handle memory encrption
 via interface
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-12-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <857046d8-2731-66e6-b615-41e1d64b6308@linaro.org>
Date: Mon, 1 Jun 2020 20:21:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-12-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 8:42 PM, David Gibson wrote:
> At the moment AMD SEV sets a special function pointer, plus an opaque
> handle in KVMState to let things know how to encrypt guest memory.
> 
> Now that we have a QOM interface for handling things related to guest
> memory protection, use a QOM method on that interface, rather than a bare
> function pointer for this.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  accel/kvm/kvm-all.c                    | 23 +++----
>  accel/kvm/sev-stub.c                   |  5 --
>  include/exec/guest-memory-protection.h |  2 +
>  include/sysemu/sev.h                   |  6 +-
>  target/i386/sev.c                      | 84 ++++++++++++++------------
>  5 files changed, 63 insertions(+), 57 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


