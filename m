Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2611C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840322073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXcd3nO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840322073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1lmX-0001jj-P7
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1llV-0000oF-PY
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1llU-0000et-7K
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:44:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1llU-0000ee-3t
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581489891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SP2tr43GD7Z0njyeLAo5/HgyMhNxnZV6zWHZQp9QlQ0=;
 b=RXcd3nO0Y8lGBp9fH6DRob2b4+HwV3JPnJ2SbSKaIe30X59fmW66ERHfI+mE0tRaOIF/XV
 Iyj2B+EJSFUmT6sNUbek4BOkNRI9kMI9bFuu3lmJ6sEawyK9FFNZXxcdpi6zOr3KiBDqwQ
 CjKJ92yjgXdivTNGePvtscDbPARsfdc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-cAZ6PX8CP0KQWVH1skBg7A-1; Wed, 12 Feb 2020 01:44:49 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so408767wrq.12
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 22:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kOVI+lJFLQ8dlHW+nq+JRF8uhsb/x3I0u9zXjLprFcM=;
 b=t7gudEgGp1M1H5m9BYOzdLIj3pVna5WJaoT4SwjW0a7BuQ4cvtr4AjncB0WcuHaufY
 WQzntj/Cy2cHmXKis3rGh86+m8n1/4XkHcc3m0MMptXT+XI9IxVeBDUvuXet4WNrq/GN
 Sd7NAnjECyapyyhXbZOzN5XZEs4nayNLEUoFOAQRMHJ5o/kjIVk1AKhiqInRvN+fISDK
 R5EXXnW2HJxgqv27ZicGQKA5jypTd2IEVW3KGNEARFXM7g8o58YFF7Vkgaji8ek9u+rp
 lbXLkZ5o5Qk9SqergfAs1eJYU3WkMhs6prmBHKt2GPvmgrkK+Gp2zggOFv8m1T4KUqoy
 ZOPQ==
X-Gm-Message-State: APjAAAXH+mrJKVi7vy4vmbNcemCj5aimONaHZ+y/w82ba+mwWOMJhgx2
 LDQuvccDeCrXgY2lQ53p92fQvbVCj+bUZUfzWLAJ+VGCiGxgI9Ie+LyFL306WTQD+hrKe6zoHsB
 VeHyPpkr8DtV7koE=
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr10273887wme.23.1581489888490; 
 Tue, 11 Feb 2020 22:44:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKxd9PRV+8DYIP2tXrPOkoEbMJl8T6BD7Icy4dGiF8xDNJMUG9M+CuGMUpppE8EEI0wuwtxw==
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr10273846wme.23.1581489888151; 
 Tue, 11 Feb 2020 22:44:48 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g128sm6721489wme.47.2020.02.11.22.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 22:44:47 -0800 (PST)
Subject: Re: [PATCH 05/13] target/arm: Add and use FIELD definitions for
 ID_AA64DFR0_EL1
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-6-peter.maydell@linaro.org>
 <6a75d967-513d-93ef-b983-b8a35f78c2bf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b4390a82-2780-c639-ada3-6d317a7558aa@redhat.com>
Date: Wed, 12 Feb 2020 07:44:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6a75d967-513d-93ef-b983-b8a35f78c2bf@linaro.org>
Content-Language: en-US
X-MC-Unique: cAZ6PX8CP0KQWVH1skBg7A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 7:34 PM, Richard Henderson wrote:
> On 2/11/20 9:37 AM, Peter Maydell wrote:
>>       if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>> -        assert(extract32(cpu->id_aa64dfr0, 12, 4) =3D=3D brps);
>> -        assert(extract32(cpu->id_aa64dfr0, 20, 4) =3D=3D wrps);
>> -        assert(extract32(cpu->id_aa64dfr0, 28, 4) =3D=3D ctx_cmps);
>> +        assert(FIELD_EX32(cpu->id_aa64dfr0, ID_AA64DFR0, BRPS) =3D=3D b=
rps);
>> +        assert(FIELD_EX32(cpu->id_aa64dfr0, ID_AA64DFR0, WRPS) =3D=3D w=
rps);
>> +        assert(FIELD_EX32(cpu->id_aa64dfr0, ID_AA64DFR0, CTX_CMPS) =3D=
=3D ctx_cmps);
>=20
> Should really be FIELD_EX64.  Otherwise,

Similarly to the other previous call, FIELD_DP64:

        cpu->id_aa64dfr0 =3D FIELD_DP32(cpu->id_aa64dfr0, ID_AA64DFR0,=20
PMUVER, 0);

So far the code is safe because the >31 bits macros aren't used:

   FIELD(ID_AA64DFR0, PMSVER, 32, 4)
   FIELD(ID_AA64DFR0, DOUBLELOCK, 36, 4)
   FIELD(ID_AA64DFR0, TRACEFILT, 40, 4)

But you are right, let's fix it now to avoid copy/pasting 32bit macros=20
and unpleasant debugging sessions.

>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Using 64bit macros:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


