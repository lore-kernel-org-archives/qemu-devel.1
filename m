Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B74CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 17:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6A42064A
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 17:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ata0KIvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6A42064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLseL-0005vh-EV
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 13:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLsdU-00059b-Aa
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 13:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLsdT-000204-36
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 13:35:28 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLsdS-0001yu-Rc
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 13:35:27 -0400
Received: by mail-pg1-x542.google.com with SMTP id w3so5140928pgt.5
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P4IA42ejsixRMBgMIMOh6M/+n81HIaQ/gu3TCojfckY=;
 b=Ata0KIvOf4KMGAqAu2qXuKFQhjqIue5/X0bFyWDeMH2/VOICdOyqQup/UOrPIjBrcs
 l20lhhiYGVWaI3rrBFL2/W00yunjZf70jWcuPvJpvxnrDTZOPAut2demP1UKdV4LuI4i
 J/RY6POMACdCS8dD/ZKenO2fdhR+P+kbp2c8UEeRpRNy9p00TjBhedCT7LsOFMsElHVS
 qC2HmhybMlRg726ADnnHbmk+XvztyRMwlT3lHk3R0EbJKHWVxi30xfVxotgt1oltS35L
 G9LHsPSgB2PlHDZZWofRhmGAc2sAWBUm6etIo7RLX7RGWjagDn68QW3JHqtQzkO+gAo0
 gb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P4IA42ejsixRMBgMIMOh6M/+n81HIaQ/gu3TCojfckY=;
 b=H7hXlyrVNfrpkX6bVR24BfRRNCpATB+Xz0uJLx9ogtNAMPiUZKNXlXld1ZFVVuNiVv
 WzjKs5zhBRQnEGnGIglK6XaSBQBksVYDapnpmBmVDhv3K8W6n232jh2G2Ra/AsTsoBKm
 V4A7mx0rgPRYFFavriqH3F/yTZ2JYFJka5bNtMnUOm/b06SmSl/Oo8a1f+aizUZqXMl3
 AIsqJT6CiWd9ZFhRXL4JlYWdXfvX9oDNj7DxVT9OKlAnMyi/KedCQ/04lUISslAPa3fI
 ClohFA9yNGUvjbzq/bMrABU2O7XpxC632KV3SAIDM8IHXQIhwkvrP5Pukq3A/ScrHMBB
 DkIg==
X-Gm-Message-State: APjAAAW6INxC6/WMTRZpdCsau2Ig7hl9XtDnPmhgq5LxyLNfbKMDkb6R
 kcDqJqUmK5B/0AOIFomfv+S3Kg==
X-Google-Smtp-Source: APXvYqyyBK3RI/+31c9cZKj8+AGE1N/pP4zTBeeU1f3KgTGT1jY9tpa81e37PHX8wuxB3eFKHKyw2g==
X-Received: by 2002:a62:1454:: with SMTP id 81mr13610721pfu.188.1571506525230; 
 Sat, 19 Oct 2019 10:35:25 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm10044929pfy.56.2019.10.19.10.35.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Oct 2019 10:35:23 -0700 (PDT)
Subject: Re: [PATCH v5 01/13] add device_legacy_reset function to prepare for
 reset api change
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-2-damien.hedde@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a6c43bd5-9119-f8d3-5046-eeece7d842d7@linaro.org>
Date: Sat, 19 Oct 2019 10:35:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018150630.31099-2-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, david@gibson.dropbear.id.au,
 philmd@redhat.com, ehabkost@redhat.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 edgari@xilinx.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 8:06 AM, Damien Hedde wrote:
> Provide a temporary device_legacy_reset function doing what
> device_reset does to prepare for the transition with Resettable
> API.
> 
> All occurrence of device_reset in the code tree are also replaced
> by device_legacy_reset.
> 
> The new resettable API has different prototype and semantics
> (resetting child buses as well as the specified device). Subsequent
> commits will make the changeover for each call site individually; once
> that is complete device_legacy_reset() will be removed.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

