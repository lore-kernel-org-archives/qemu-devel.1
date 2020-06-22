Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F72C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57EB206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoM3EXOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57EB206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMTb-0007on-8W
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnMSk-00076D-F6
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:26:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59602
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnMSA-0002mf-Bl
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592832337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk52xw64vWxDGhlIinGMYjMjksVgyjUu9/7WgThL+jQ=;
 b=RoM3EXOS7bPSbwCTzmiLO1wfCtsc19pR76HJg9l08VE96rMk3a85exiSwFXdq6dYe7n4s3
 t4CwfUywdempHD6HcI/MpIT3k8I9UA4HCkrOskPMGHtuB8D56Wdz4Ts2KT2Dump8dtvS9g
 6vw4g9vWRsToJiwiR8vi+EGvhaZw0GI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-gHDcV2yMN9uxsBRf6Z0sig-1; Mon, 22 Jun 2020 09:25:35 -0400
X-MC-Unique: gHDcV2yMN9uxsBRf6Z0sig-1
Received: by mail-wr1-f71.google.com with SMTP id r5so10866031wrt.9
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 06:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dk52xw64vWxDGhlIinGMYjMjksVgyjUu9/7WgThL+jQ=;
 b=p4LARRsgsjZlkjTB43RETQMB5veXdmlz+QdfdRimm8EEL1Oy3S11nNbJbRFxsmoPsN
 8lJIC6iDCOPDdpdwwFEj+11PBSfSyKd03g6nDYZ4BiyKDQKEigY0k0X9ujsVdjefr0uv
 T7AzrmURZ4U4wgpBOxxYgj/+YakIkqsFMOTnZf2xDt+41F8Qxiow0/BD6uG1j8r5bQfg
 QZT7DjXlmcajmI2VeVmHinLAKvVJGsCTY4lfFGPwr7zwFDO3/yBiDOd1lYKFuf5Xh1Vh
 Oobr2CKAnJydBf2hbt8rciv+jJXcV1Znfy3GMe9bF+FuKfK7BvpDuEYiPSybnnyWvPrZ
 zGJg==
X-Gm-Message-State: AOAM531IBAnD0JNx00Yn0g4NKyZyUBlmordGcjmjK/2KIwFfzRQrQ858
 R0x2BdcB6PQLvEVRjdk/JM1L/e2+Vf6/o8nkJehgGm1o+o/eFO5C89ItDIh81PvF+gFkH6P17R5
 UN8W+0cIOt5H+g7M=
X-Received: by 2002:a1c:9804:: with SMTP id a4mr18438941wme.109.1592832334652; 
 Mon, 22 Jun 2020 06:25:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxdkLbETQVdBp1mhtno8kUMzL8M3aqTykHL205yKdj1D0iW3lq3gjW6deRLOaNKe8D7EURyA==
X-Received: by 2002:a1c:9804:: with SMTP id a4mr18438911wme.109.1592832334285; 
 Mon, 22 Jun 2020 06:25:34 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id v20sm4058601wmh.26.2020.06.22.06.25.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 06:25:33 -0700 (PDT)
Subject: Re: [PATCH v3 11/19] audio: deprecate -soundhw pcspk
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200622112914.30454-1-kraxel@redhat.com>
 <20200622112914.30454-12-kraxel@redhat.com>
 <47fe0fd8-ab19-b35d-0808-d9a83201c530@redhat.com>
 <1bc80fe2-6ec4-000d-483d-70b34ff15adc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f58d6bd4-95c7-2356-583b-f1fe5e8a236a@redhat.com>
Date: Mon, 22 Jun 2020 15:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1bc80fe2-6ec4-000d-483d-70b34ff15adc@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/20 15:07, Philippe Mathieu-Daudé wrote:
>>> +static int pcspk_audio_init_soundhw(ISABus *bus)
>>> +{
>>> +    PCSpkState *s = pcspk_state;
>>> +
>>> +    warn_report("'-soundhw pcspk' is deprecated, "
>>> +                "please set a backend using '-global isa-pcspk.audiodev=<name>' instead");
> Markus's "Crazy shit around -global (pardon my french)"
> series instead suggest to use '-device ...':
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06667.html
> Could that work here?

No, this is a different issue.  The problem with the floppy is that it
conflated two devices in one (controller and drive), while here the
device is builtin.

In this case -global could be replaced by a machine property, similar to
what is done for the block devices that back parallel flash.  That
however is orthogonal to providing a good CLI for configuring audio.

Paolo


