Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7190C43466
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 07:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE8820708
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 07:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYtRFbIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE8820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJuDL-0005ro-6d
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 03:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJuCR-00058j-BD
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 03:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJuCP-0001Hl-0P
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 03:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600588549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/WDYCvriTDIYQO45NRhlbQemEM2FiJM0YbcHt+DIVw=;
 b=LYtRFbIEW8JygXGcfRyXHtKaLVHZH2qgFmtJfmi72tGHeOjaEqV8J7SKVIMNynB1DSrRG2
 xFOPQH3GPTG6D8+xU+iyj/laBZXi6weGlZR8Ck154PcTDCRU77xvdxQaVY5wNhPhXllwwh
 1VLb7nyXOVtJIKXMQhfwemQ+OBcETbw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-WXSYZp7FPP2H6F64CT-ifQ-1; Sun, 20 Sep 2020 03:55:48 -0400
X-MC-Unique: WXSYZp7FPP2H6F64CT-ifQ-1
Received: by mail-wr1-f70.google.com with SMTP id i10so4334695wrq.5
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 00:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6/WDYCvriTDIYQO45NRhlbQemEM2FiJM0YbcHt+DIVw=;
 b=qZsn1A4yFL7VeIR11w/YlQXJYnoMay7cU5Gj2l/RHmoGDeZVrSIkYrrNmXAKSa+zsi
 FNoIsI1kmmd+vUMy87gkZsWiqFAZupa3xotcXeBEGRaQoiQgWVVUHxia0l2l4n9OYozY
 Xo3B0ts15fRclVlepVFPHbzSjA0Mu5gc2kZ/LsPXJA0ooD2G6Nz8LNuemdy7KKywzMoy
 Xgu9MXCeQeb6Hl1whCcedKj8RGI/JeJwstnehKOf3rxCmuuKGMDDkOjyTdLYeI+J0RY7
 PPv0gALeLfv8Exv5Dxq0B5JQRdinv5NA3elyBnizFCy2pWUsK1cg8zKHDXX509eVZ0Co
 tRjw==
X-Gm-Message-State: AOAM530aaBtrfZyxa3FfdiPAiqqbAE1/dIJnqDmcJORcr40XU2sucFu9
 wGzRfvSZ9oRNNlR2f7TLytTvNsejgxDCACPTzZalEsep7/YNPflLeyV+6a1fc14aoSLxPl0lfqa
 ZnoL9dZA6YZG5VWg=
X-Received: by 2002:a05:6000:124d:: with SMTP id
 j13mr49317916wrx.182.1600588546823; 
 Sun, 20 Sep 2020 00:55:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHzRDWkSV5AI4BGWCHZAXLFMqXxPZDQKaFW7hvKjPS2eCrttSd6McLqTr/ZAheHVSDNK1S5g==
X-Received: by 2002:a05:6000:124d:: with SMTP id
 j13mr49317897wrx.182.1600588546629; 
 Sun, 20 Sep 2020 00:55:46 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id u17sm15167965wri.45.2020.09.20.00.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 00:55:45 -0700 (PDT)
Subject: Re: [RFC 1/4] memory: add memory_region_init_io_with_dev interface
To: Li Qiang <liq3ea@163.com>, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, kraxel@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, alxndr@bu.edu, peter.maydell@linaro.org, f4bug@amsat.org
References: <20200908164157.47108-1-liq3ea@163.com>
 <20200908164157.47108-2-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f2a15ca-3927-a3c5-2652-b48e8fdb473b@redhat.com>
Date: Sun, 20 Sep 2020 09:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908164157.47108-2-liq3ea@163.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 02:12:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/20 18:41, Li Qiang wrote:
> Currently the MR is not explicitly connecting with its device instead of
> a opaque. In most situation this opaque is the deivce but it is not an
> enforcement. This patch adds a DeviceState member of to MemoryRegion
> we will use it in later patch.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  include/exec/memory.h |  9 +++++++++
>  softmmu/memory.c      | 15 +++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 0cfe987ab4..620fb12d9b 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -404,6 +404,7 @@ struct MemoryRegion {
>      const char *name;
>      unsigned ioeventfd_nb;
>      MemoryRegionIoeventfd *ioeventfds;
> +    DeviceState *dev;

There is already an owner field for this.

Paolo


