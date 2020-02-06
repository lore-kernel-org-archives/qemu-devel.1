Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208AC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6EB21927
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOLl4WXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6EB21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izpwH-0000NJ-He
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izpvE-0008MX-F9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izpvD-0004Jq-F6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:46:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30774
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izpvD-0004It-BQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581029215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCEZLzt8v9R7pOW+VGG0rFQD3/gBdanOGDA2YtbnkJk=;
 b=KOLl4WXzpLOfIS0sms1KzMV8+336bW18HgFlqGQEpFn1a9lO9TNOtrLLm/AI4MvQw1flXN
 wQzhpGhcR7rxadP0v1CXlv2f2hQK5S8ZtU4WpHD9aliNGR4BE6s13QdRc+lvqmmxPXc+fA
 9a5Khk7dAuX1N1JRmraLOD09hqDPDjc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-ABkYXmXTPnuKkm4Qr3HG9w-1; Thu, 06 Feb 2020 17:46:53 -0500
Received: by mail-wm1-f70.google.com with SMTP id l11so1007369wmi.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 14:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1sQfy5CZkexIYWhsq9vDkm7vscngCPYBVuRhn08mIRs=;
 b=EG962swsSiftLQ7AVUSaufO2kqgWxTcyxUpb6+gnchmeSvoxxHKiFahQc4mEVMVxw/
 URofWCP/Dj5xMHWG7+ix4bYWYoGdftJv+jZyZpdLiiJ3Ch+O7yb+/W9zDzGh7WwACYHM
 Fta6ffD3HYGhKnj2LhvUjmK5zWJrpxZFgCmCgHTICsMoqUSEodZ/nVG1mmH1kpxt4/3G
 P81biLa0PtwmXaARDirkY/Bo/atXq7H75acmlTh0R2JfJsrIv8wM+CbUVsjr2W0GGIMd
 eADDFGxra5gn2qWJan2kau02fLmf2jyOg56aBIw4XE9rkLg/F3KboKKLpseSDQldYW8g
 4czw==
X-Gm-Message-State: APjAAAXfhQ5HBOWBsm0dBFy4hLc2zvKYZn99MczGfSBEBox/RMe327NA
 MaCcxYQe7GsE2FBlVfa/YPswzHobgY7rq4Ka/drEI9SVE6eIquvdlF4ztJMtzajJlsYX26grW//
 ClcZ3rTUk+8rm3tY=
X-Received: by 2002:a1c:638a:: with SMTP id x132mr60585wmb.43.1581029212048;
 Thu, 06 Feb 2020 14:46:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPBp+jDECqJlTTUVzv41PiszwN+dWlH4uzjOG7+gu1nyVEu4hLLJSFuqNVOIXHy9P0CXUtIg==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr60565wmb.43.1581029211860;
 Thu, 06 Feb 2020 14:46:51 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g15sm936275wro.65.2020.02.06.14.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 14:46:51 -0800 (PST)
Subject: Re: [RFC PATCH v2 5/5] target/arm/cpu: Add the kvm-no-adjvtime CPU
 property
To: Andrew Jones <drjones@redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-6-drjones@redhat.com>
 <CAP+75-Vt3apV8i64oFTC6pAATXkrE1g+tVskr_3ohBHtZ1LNdQ@mail.gmail.com>
 <20200206124047.o4sy52jgbkqeravd@kamzik.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2522956e-5dae-3ebc-76d2-010a918e0d19@redhat.com>
Date: Thu, 6 Feb 2020 23:46:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206124047.o4sy52jgbkqeravd@kamzik.brq.redhat.com>
Content-Language: en-US
X-MC-Unique: ABkYXmXTPnuKkm4Qr3HG9w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, bijan.mottahedeh@oracle.com,
 Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 1:40 PM, Andrew Jones wrote:
> On Thu, Feb 06, 2020 at 01:08:53PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> ...
>>> +/* KVM VCPU properties should be prefixed with "kvm-". */
>>> +void kvm_arm_add_vcpu_properties(Object *obj)
>>> +{
>>> +    if (!kvm_enabled()) {
>>
>> This can't happen, right? Can we turn that into an assertion, or
>> remove the check?
>=20
> You're right. An assert would be more appropriate. Will you send a patch?

Apparently this can be called with KVM_CONFIG && !kvm_enabled():

See kvm_arm_set_cpu_features_from_host()
{
     if (!arm_host_cpu_features.dtb_compatible) {
         if (!kvm_enabled() ||
             !kvm_arm_get_host_cpu_features(&arm_host_cpu_features)) {
             /* We can't report this error yet, so flag that we need to
              * in arm_cpu_realizefn().
              */

I won't modify your patch (until I have a better understanding of=20
TYPE_ARM_HOST_CPU).


