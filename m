Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF10C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39852085B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GazFI/dR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39852085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlsJ8-0003vA-Or
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jlsGk-0002Gr-E2
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:59:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jlsGe-0003g9-LT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592477975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKYDHbOIwakxAk9gU87oflPaq58X99KzHMMUU7Bumwg=;
 b=GazFI/dRmvwNg/JajfXDGpDKsCn1AbfFp05xSJSEVOn5nAyVC4s9lS+5fviQrOZw7JPlGT
 MRMWDeZ700sHY53roeyjBkS2/oQgwePbfD3rs4j4qBo5pvf9hEerAPXBhJA4Asawz27CjZ
 cIK35HpICBqb5CJBSyfKHZqDkZljc5s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-weDEJByFNr6T1HEGwWw8ow-1; Thu, 18 Jun 2020 06:59:34 -0400
X-MC-Unique: weDEJByFNr6T1HEGwWw8ow-1
Received: by mail-wr1-f72.google.com with SMTP id f5so2628635wrv.22
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JKYDHbOIwakxAk9gU87oflPaq58X99KzHMMUU7Bumwg=;
 b=WKtgK6rTjwM1GUTWclu4A7e+1SHg1cBcj8Zyh9Cn75mreZs/W9hkWTJis/hPOGExYA
 PcAypUwRj12pjHZd1Cryd9+RgmjJ6Dg6Aqli9MhESqGF4ml1nkWzc/DuaPUJj04mFUIX
 ntUHdNBirHaB596mS0DS3JNcZqyLYH58s/XnCooX61VglTM2oGJDni9+pwX9yzRmmCRS
 x4WFHMtLJSajlxoLqmRyrutHhtxMYpAEq22DxZDFPd9SXXF1weGYEaQj/hkHWJyuSfLc
 p575mDetnm9+FnuRpXFlbAX2IqxkbshP+IXR1LvSrVVxcNEAR858Y19GJLp4Dl3p3NRM
 42Lw==
X-Gm-Message-State: AOAM532TTqRJ6xj3q3Ic1VZ1hZZlV/EcF8MH0L9eS21QtZk8eisRKjib
 vsfhLhLRIts7ktNuCo71cdLoTF4tAnjS+T4/lqNiTM7jEvqWH5lDBdMSaiWrayKqfBJuTUz6obX
 +/NcE/tGYjDDgI5o=
X-Received: by 2002:a1c:4189:: with SMTP id o131mr3222178wma.183.1592477973141; 
 Thu, 18 Jun 2020 03:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Iih798uLkV/EDQFj/uqQutOMqIF5xyoZeaOIzY7zBzemZa0ofo2dsNv7mBsvFwbVMwztmw==
X-Received: by 2002:a1c:4189:: with SMTP id o131mr3222158wma.183.1592477972957; 
 Thu, 18 Jun 2020 03:59:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id y16sm3081659wro.71.2020.06.18.03.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 03:59:32 -0700 (PDT)
Subject: Re: [PATCH] target/arm/kvm: Check supported feature per accelerator
 (not per vCPU)
To: Andrew Jones <drjones@redhat.com>
References: <20200617130800.26355-1-philmd@redhat.com>
 <20200617152319.l77b4kdzwcftx7by@kamzik.brq.redhat.com>
 <69f9adc8-28ec-d949-60aa-ba760ea210a9@redhat.com>
 <20200618085726.ti2hny6554l4l5kt@kamzik.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38dc2adb-d567-cd45-21bd-f68cebbab98a@redhat.com>
Date: Thu, 18 Jun 2020 12:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200618085726.ti2hny6554l4l5kt@kamzik.brq.redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Haibo Xu <haibo.xu@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/06/20 10:57, Andrew Jones wrote:
>> If it's a test that the feature is enabled (e.g. via -cpu) then I agree.  
>> For something that ends up as a KVM_CHECK_EXTENSION or KVM_ENABLE_CAP on 
>> the KVM fd, however, I think passing an AccelState is better.
> I can live with that justification as long as we don't support
> heterogeneous VCPU configurations. And, if that ever happens, then I
> guess we'll be reworking a lot more than just the interface of these
> cpu feature probes.

Yes, and anyway configuring "what is allowed" would be separate from
checking "what is supported".

Thanks,


