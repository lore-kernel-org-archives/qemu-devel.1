Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF922CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 18:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818FA21925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 18:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGOHyYBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818FA21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLtnf-0007rK-ND
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 14:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLtmp-0007Fz-Hw
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 14:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLtmo-000623-2K
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 14:49:11 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLtmn-00061b-QZ
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 14:49:09 -0400
Received: by mail-pf1-x442.google.com with SMTP id q21so5812634pfn.11
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WYv8R5iTBMYYekVYmkjgIHGY+NHC9mILmG+3tHeYA+0=;
 b=WGOHyYBGzVaXlPwg2N3u74GKFKhVGGiuvUD1eFJXb19MGYVUCqJctUbgvKaC14by5h
 dxywNTgFBp9d97UXlsjYtBn8Z26EuqBWras4Grn56A7pSkua9ojz8g8uGaBoG3Wl7Hqj
 aqnwC5dkjf65j1JrUMQS37OQOu9r5fdsW0hnNI4eEVp+g3ZuOpg0ywaief8IWaFV3Wsq
 CMw8NKk5UV4LDpYDz7QX06HQ5wtnBT0Fvra9jsQEripx2WNRPBIsnM08rgKZWp1bn9wr
 etMphmfIyX+tGRIUDGV7NWGBLv8Rzf11B7BLVNmDc7yUaX0pDAV+l02LA8oX8CjxVcPJ
 ipwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WYv8R5iTBMYYekVYmkjgIHGY+NHC9mILmG+3tHeYA+0=;
 b=pFlPYuR9YoB22PF96x1mcMPxvIkI82jglwCJjzkP3v8ZFqRWCCfjf08du7b/Fq3ywF
 R5hYnmhvc8YlnGAMnGuakYr49Utfs8Jk1oTtQPc1Qmt6ImYGmazZxQaTePAESSOSZqq/
 MnlaEQgld5OtDNC8pH91+eEWoMmdIS8uOWUdxSuJKD8ERmld5EnvE1XMIY4ymc70s6ty
 1ualCiGjWoTOC4HJCdyqfH2GqKGBGz6vsmoajZXY9G1sTJ+1B1cgS6tDlhY3wAK6YXJi
 hTkPbMBShuLfnLAPAF1SWcCKoqrRfrpEKVdIxpDJ0En1nXDiP296tKhepHdLEJmaLs5N
 ueng==
X-Gm-Message-State: APjAAAW5RkvjY3PBdbqIHR5wDQ6X/DEJLcqwz/eaUt4UrlMWQ+8LZnsT
 bCIf3RCPKpW5gBX8TYBw2atvMg==
X-Google-Smtp-Source: APXvYqxc3GiQI3Glu+jXUZ+8WPE4hrineGRff/Al5gip0vMIgU24yycgAoXcXwEEnitM/cfNZysjig==
X-Received: by 2002:a63:9751:: with SMTP id d17mr17283480pgo.427.1571510948300; 
 Sat, 19 Oct 2019 11:49:08 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 16sm9767011pfn.35.2019.10.19.11.49.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Oct 2019 11:49:07 -0700 (PDT)
Subject: Re: [PATCH v5 04/13] hw/core: add Resettable support to BusClass and
 DeviceClass
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-5-damien.hedde@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e93e53a0-05f0-43f5-35bf-e2f712b9b43d@linaro.org>
Date: Sat, 19 Oct 2019 11:49:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018150630.31099-5-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, edgari@xilinx.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, pbonzini@redhat.com,
 philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 8:06 AM, Damien Hedde wrote:
> This commit adds support of Resettable interface to buses and devices:
> + ResettableState structure is added in the Bus/Device state
> + Resettable methods are implemented.
> + device/bus_is_in_reset function defined
> 
> This commit allows to transition the objects to the new
> multi-phase interface without changing the reset behavior at all.
> Object single reset method can be split into the 3 different phases
> but the 3 phases are still executed in a row for a given object.
> From the qdev/qbus reset api point of view, nothing is changed.
> qdev_reset_all() and qbus_reset_all() are not modified as well as
> device_legacy_reset().
> 
> Transition of an object must be done from mother class to daughter
> classes. Care has been taken to allow the transition of a mother class
> without requiring the daughter classes to be transitioned at the same
> time. Note that SysBus and SysBusDevice class do not need any transition
> because they do not override the legacy reset method.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/core/bus.c          | 97 ++++++++++++++++++++++++++++++++++++++++++
>  hw/core/qdev.c         | 97 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/qdev-core.h | 27 ++++++++++++
>  tests/Makefile.include |  1 +
>  4 files changed, 222 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


