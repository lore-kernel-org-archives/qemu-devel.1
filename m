Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C560C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9BD208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyevSe0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9BD208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqf9-0000pn-Dj
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ioqHn-0004Cb-Ub
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ioqHm-0005jm-Op
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:56:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60112
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ioqHm-0005jM-L9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0RrzZgv66jhK7LMA3RAoxyp5F5E4qkxn7mKXQVUqJE=;
 b=OyevSe0yZwHwRET9YXtmu0bvf7ECaWTLFAD++jOHURpykOwD7FYRU4vcl3qLKs5eIQ2Y4F
 YNjYLxiTTn13ArPXsZrD92sfNVfWYsIC2UmpIl1I0uXQ5r8Zt6yCQbjjvGNFm9E1tjhTyy
 0wXg/jKxj8V1v4Fw0RW86d8XQGCUL3g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-M81Z2FRZOe2VEjpZcv5mpA-1; Tue, 07 Jan 2020 09:56:43 -0500
Received: by mail-wr1-f71.google.com with SMTP id j13so29376wrr.20
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R0RrzZgv66jhK7LMA3RAoxyp5F5E4qkxn7mKXQVUqJE=;
 b=idI/XP+dkld/dZeyRoVB3oW6t4AVm0C04ZrwcET7v1Sgca3JP9MykeyrQ0+wkObq9O
 P9kfyCrgUzvGDhnBX0wH5hUWHgKOrg/sbuYdUnBXnmvDiXruYJz9wvevD3eltcOfBpki
 qHa4RHwC5GK8lRXEG90jSlf1KMGpoaW0qq3NgCKgLXYmSlDSMg2K+/HvakcWjnxxIIWg
 +uFk2iuKumZUeFB18jCU410ccBMWjFonYbxm4Du0ZHwJcfpbL98Xu+aw0FtH1yymVX8F
 IDfDgIszQBUk+taEfZ9u/F8evcgJvQpSGzyLx2VKgoZ65ckxO6JT84ATZNG6TRzom8VD
 IGiQ==
X-Gm-Message-State: APjAAAW2Qbtv/Vrk1u6WSazaCIRFrk9UEARvDs2rCCNgu0Z9khRldTyP
 URTjEkgX7Bdx4QtTILmzcUPy/gDhWzHEtX6Sjf/1aNZmsUvhxxezEprCyi0P16lhe5+YUCtChyD
 TISel3Iv550OprxA=
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr42395389wmm.1.1578409001864;
 Tue, 07 Jan 2020 06:56:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFXZz5Lvb9UTJc8bmGOVgoKv5Yn5b0xYiia9ZaeHgK1hfq+LjN+nSIjE0UdrtwU4y5bCFvJw==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr42395374wmm.1.1578409001640;
 Tue, 07 Jan 2020 06:56:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id o4sm109503wrx.25.2020.01.07.06.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 06:56:41 -0800 (PST)
Subject: Re: [PATCH 5/6] hw/scsi/megasas: Silent GCC9 duplicated-cond warning
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-6-philmd@redhat.com>
 <b29f856a-5199-6f62-4aee-5a2cfc9f05a3@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e06e74a-901d-acb3-67f0-006732abdba9@redhat.com>
Date: Tue, 7 Jan 2020 15:56:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b29f856a-5199-6f62-4aee-5a2cfc9f05a3@linaro.org>
Content-Language: en-US
X-MC-Unique: M81Z2FRZOe2VEjpZcv5mpA-1
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 Hannes Reinecke <hare@suse.com>, Hannes Reinecke <hare@suse.de>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/19 05:03, Richard Henderson wrote:
>>      if (!s->hba_serial) {
>>          s->hba_serial = g_strdup(MEGASAS_HBA_SERIAL);
>>      }
>> -    if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
>> +    if (MEGASAS_MAX_SGE > 128
>> +        && s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
>>          s->fw_sge = MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE;
>>      } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
>>          s->fw_sge = 128 - MFI_PASS_FRAME_SIZE;
>>      } else {
>>          s->fw_sge = 64 - MFI_PASS_FRAME_SIZE;
>>      }
>
> I'm not keen on this.  It looks to me like the raw 128 case should be removed
> -- surely that's the point of the symbolic constant.  But I'll defer if a
> maintainer disagrees.

I don't really understand this chain of ifs.  Hannes, does it make sense
to just remove the "if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE)" case,
or does Phil's variation (quoted in the patch fragment above) makes sense?

Or perhaps this rewrite:

        max_sge = s->fw_sge + MFI_PASS_FRAME_SIZE;
        if (max_sge < MEGASAS_MAX_SGE) {
            if (max_sge < 64) {
                error(...);
            } else {
                max_sge = max_sge < 128 ? 64 : 128;
            }
        }
	s->fw_sge = max_sge - MFI_PASS_FRAME_SIZE;

Paolo


