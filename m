Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57FFC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA8222277
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5ER/UQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA8222277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmz6-0001ib-V6
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQmxj-0001FC-11
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQmxh-0007PX-4f
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602229028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIdQhgt0E06qvYHAWpF/kPvjinJryG9+XsqL2A4ukNw=;
 b=R5ER/UQp78VT8d7IEMlceptzehePautAkaNv+joNw1OSJhKnVtjYTKhEVPMj/RC/FqukXx
 G3VopCaWDXCPcr6NLFWLjRyCyl/F/ML7gwSdFJBH4yziIG6R958pfBapaBhs9B7CNq0onE
 Nxtyx4pSuqnIq5UQYZ4vKyucvx5mix8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-iH4pwj6-MoKVM3DEKoU4Mg-1; Fri, 09 Oct 2020 03:37:06 -0400
X-MC-Unique: iH4pwj6-MoKVM3DEKoU4Mg-1
Received: by mail-wm1-f71.google.com with SMTP id f2so3809786wml.6
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 00:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xIdQhgt0E06qvYHAWpF/kPvjinJryG9+XsqL2A4ukNw=;
 b=JVsH/KxoHDu9p9WbMJ3ALNA2OtblftJ9Gbu3fG4ryVBZ5RYPe1om6TmUa6xZL09F6+
 JjKS1eczGhJfMj3nJD0LuSk+BiytQnw8pG1FieB1OL16BnQZfFJWtAzefUFM5gYKtCZo
 Rexnn0yxr4sDl/7MFiD3gG2x+3dwWCJ1dN+iv1ysac5znxcsYel0eBNxF8fyf2r5Z/to
 iHwGs0HqHFT/vG4NFPWfI2VI2lrqrPbwywrCyw9JYfPmNRop8ziITFICK3Ne2K/rdlc3
 bWpp+ed6fA0ZEk+Y8vC0u2FJYTwEfgRa66z/SvdsHy43eth1a+cAJkVP6lIT7okWyRUL
 XECA==
X-Gm-Message-State: AOAM530Biq0MQLDnzntAj8F+Ms9oxJ52FOvi6aM9HCLXBkO1aJX5dN3d
 WagbAAs7CNM8rKXaWcQ0DsQIcHzuGWbNrnohtJTiz72IcQ0Ko+kLOMhoPZot+tpdXMGCYC2hQUV
 bwnLZgTA/0jJbu2M=
X-Received: by 2002:adf:9507:: with SMTP id 7mr425529wrs.365.1602229025365;
 Fri, 09 Oct 2020 00:37:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2emzv8rW5E4rMNZlwUJWKbEzz5hoVY+EHO1CGIKrfe+7yj2wpROjXjT3XF+8hlzQ+LnPXuw==
X-Received: by 2002:adf:9507:: with SMTP id 7mr425491wrs.365.1602229024906;
 Fri, 09 Oct 2020 00:37:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cee1:4797:6958:7698?
 ([2001:b07:6468:f312:cee1:4797:6958:7698])
 by smtp.gmail.com with ESMTPSA id o129sm10765615wmb.25.2020.10.09.00.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 00:37:04 -0700 (PDT)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
 <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
 <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
 <CABgObfYWK2E8PsSFOcHpuA2vuA3HWgvtuLbrtQCWA=9=r07=5w@mail.gmail.com>
 <061f1bde-db0e-bc34-dae0-161606092bb0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb916248-ac1a-8e46-8808-4b4cc743672c@redhat.com>
Date: Fri, 9 Oct 2020 09:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <061f1bde-db0e-bc34-dae0-161606092bb0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Alex Bennee <alex.bennee@linaro.org>, Claudio Fontana <cfontana@suse.de>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/20 09:21, Thomas Huth wrote:
> On 08/10/2020 20.24, Paolo Bonzini wrote:
>>
>>
>> Il gio 8 ott 2020, 20:05 Richard Henderson <richard.henderson@linaro.org
>> <mailto:richard.henderson@linaro.org>> ha scritto:
>>
>>     Ah, TARGET_DIRS isn't being pruned anymore when a target is disabled for
>>     lack
>>     of accelerator.
>>
>>     Paolo, side effect of 8a19980e3f ("configure: move accelerator logic to
>>     meson")?  I guess we should move the setting of TARGET_DIRS to meson as
>>     well.
>>
>>
>> TARGET_DIRS is pruned by Meson, I didn't add any back propagation to make
>> because it is not really needed; qemu-iotests only every uses the "host
>> architecture" QEMU binary (see tests/qemu-iotests/common.config),
>> check-block + --target-list has never worked.
> 
> I haven't tried since the meson conversion, but at least a couple of months
> ago, it was perfectly fine to run configure with
> --target-list=tricore-softmmu and then to run "make check-block" afterwards.

Thanks, I didn't know.  Actually it's possible to get the targets from
Makefile.ninja.  I'll send a patch.

Paolo


