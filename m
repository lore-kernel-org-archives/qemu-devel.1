Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE8C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 19:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B832071B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 19:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/FzdIXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B832071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYEB1-00067y-P8
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 14:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iYE8f-0004Nj-N5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iYE8e-0004i4-9t
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:58:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22778
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iYE8e-0004hD-5v
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574449119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6c410SO+P0ZtjQTZoCEyaFN5j9VSVKk41h5EEUxdPEQ=;
 b=L/FzdIXPg2acK1cnt9lLdLXbpVsm9FUI5/iHGVJLTq4ivEXjDZlTasYgxK/u9pkqjQ804K
 KEauChB8Kl40IZwjlwoqSP7LYtFeVEGmAIlFIn+6T63+/y8IgcmMABi/eMYB280z3V2Ktc
 DDoJXvR+3ftBDQ/z3R77ud6bkUdr5Ao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-ot4li7CuPyyG92j5OotSoQ-1; Fri, 22 Nov 2019 13:58:38 -0500
Received: by mail-wr1-f69.google.com with SMTP id j12so4294716wrw.15
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 10:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WmIIXBH4DqMjSmJBiL3Q9cDBcAdd42iPT5ASSSA60Jc=;
 b=Fy3Qhh+Y6XIuhaDgKygkZ9u4MRkMlNm3h5+0+a8nqmWyMbanL8X8ujPCKyblBFdScw
 Zxafdq5D+kf2HZDeAxvHIg9fSkcRfgJekmUQ7eMFPgJyaFb1qelGs2p6e5xmPySxU6pO
 kwBHmXuEleCUV8l5J84/vsIWInosibXWeTTZqMzdbtLc9tqAXhzDpzS0h/vKNi/Zp74C
 aRbf/VmFpTFlu9ynmWA3DMvDUXK+4PYS00tiEpIEgn7UC1FvGJGxArLYN4B1LuHgkXkI
 NEvM7TfCEhJcihyvYuidlh1/7WS5OwiOspMAmYO64F/BsMEFK4NdfW/YN7rntHmMpBbg
 aX5g==
X-Gm-Message-State: APjAAAVetyVMzmkJRBR6ZRlA4Okm3TAmlAJInVQAhY0pI2MQ1ZeT1aIl
 Rt+1EU6Yv+gSL2AURrhMj3UHQHA7XeFFDiUFL5yKsmfpnyPwbmAOdVfhTd4aUGGmMuO1gW2c1b6
 dLykYw3TMQCs1aJU=
X-Received: by 2002:a5d:67ce:: with SMTP id n14mr19193722wrw.67.1574449116915; 
 Fri, 22 Nov 2019 10:58:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmh+sW+GrT63OCTwqmc0pPLXbd2NXD0jQryG7tLumZ/RVBuVfjeCkZEBiyUb9xYZdneFGgkA==
X-Received: by 2002:a5d:67ce:: with SMTP id n14mr19193705wrw.67.1574449116722; 
 Fri, 22 Nov 2019 10:58:36 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id x8sm8625374wrm.7.2019.11.22.10.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 10:58:36 -0800 (PST)
Subject: Re: [RFC PATCH-for-5.0] hw/pci-host: Add Kconfig selector for IGD
 PCIe pass-through
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191122172201.11456-1-philmd@redhat.com>
 <f25d1c9b-e481-2cd3-ce90-3c2d15505406@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c028f936-2fb5-691f-8e63-93b0041489a0@redhat.com>
Date: Fri, 22 Nov 2019 19:58:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f25d1c9b-e481-2cd3-ce90-3c2d15505406@redhat.com>
Content-Language: en-US
X-MC-Unique: ot4li7CuPyyG92j5OotSoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 7:03 PM, Thomas Huth wrote:
> On 22/11/2019 18.22, Philippe Mathieu-Daud=C3=A9 wrote:
>> Introduce a kconfig selector to allow builds without Intel
>> Integrated Graphics Device GPU PCIe passthrough.
>> We keep the default as enabled.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> RFC because to be able to use the Kconfig-generated
>> "config-devices.h" header we have to move this device
>> out of $common-obj and build i440fx.o on a per-target
>> basis, which is not optimal...
>=20
> IMHO you should move the code out of i440fx.o and into a separate file
> if possible. That's hopefully cleaner than #ifdeffing here, and you
> hopefully only need to move the new code into "obj-" and can keep
> i440fx.o in common-obj.

Correct. I wanted to try a surgical patch first ;)


