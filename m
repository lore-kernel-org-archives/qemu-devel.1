Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0606EC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 18:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30564206EF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 18:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9iS6dqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30564206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUxf4-0006vn-LV
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 13:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUxdF-0005LQ-MS
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUxdB-00072N-SX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:44:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUxd9-00071b-Tz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573670678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fl3/8m+pW4nmcaQ4OWFkkkaqhyy2mESR42zlI3mNuCY=;
 b=E9iS6dqz+OZ/ugTXmQ92rTLGzIScq/bDhlNoQ1xGcmm6snP9MxGqmxHDRwM6/1C+Ad2ELU
 lmp8s+PxAHlQ+r+zqpxm4aMNkKdxY9KXk3ZIR+xcwyofP6JLsQSSamR8Vy9BehgDRMzZZq
 lfdwhz7UPg6GYpSc5Ru9OxxwaQRl0So=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-kxkG-lRZOjS6zsGr3soi6w-1; Wed, 13 Nov 2019 13:44:35 -0500
Received: by mail-wr1-f71.google.com with SMTP id f8so2191552wrq.6
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 10:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XzWR+E75UKHfTle3m9oATJfKNsF/86/YX9rJ9YqitJQ=;
 b=HKHjdUtr06PgARPOTAJyV5suuGR46TlVEoIrNmGg9Z8mOWUI3DMuVMYiysD78COzJ1
 mV1NNY/35DiRcSCChNwPdbQGWsX/lQaptJkmylm+tS1S6K+Vaxd8v3D5ELqjO85DU2Gx
 mSgLnjuCf2/K6INbsOXGHo70h8yjrvwPlst+uaI6C/tRYjXEzNQqkC/MMcOXaOe9AaME
 VCSC09ajogTfSfad/Ar49nfYqzJNMBeKdLZrFF6tVYvu+weUBQc/wmFO7xVH7cM5L1Ya
 bRiOccz4muLahZls3vYuCpDKy7FoA4J1nyjL60YKRUi69pNE/FQCoMRdGIQS2/fNmL6y
 CGhg==
X-Gm-Message-State: APjAAAXBd+uFnaiomuSu9Sc5Bc7jkXqTtga/xChN1GA1jH3mget42PvJ
 wlQuiFmwkGgxRhjHPEVf+CiAmOfcd/oYJYGYdzCeS4Zlsa2t2YgyIWogCpOFib9HdPA+OmdGVOq
 yXZOirTpi5iKgde0=
X-Received: by 2002:a1c:de88:: with SMTP id v130mr4334001wmg.89.1573670674719; 
 Wed, 13 Nov 2019 10:44:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwITg0SpGvq13ZAUokvUf5ne9Wun1UgIg2cRIBdXicLUkDPhMPhs0MePBOPoQ8AB6Xd3Z6wOA==
X-Received: by 2002:a1c:de88:: with SMTP id v130mr4333981wmg.89.1573670674544; 
 Wed, 13 Nov 2019 10:44:34 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id x9sm3861877wru.32.2019.11.13.10.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 10:44:33 -0800 (PST)
Subject: Re: [EXTERNAL]Re: [PATCH v1 5/5] .travis.yml: drop 32 bit systems
 from MAIN_SOFTMMU_TARGETS
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191113115952.775-1-alex.bennee@linaro.org>
 <20191113115952.775-6-alex.bennee@linaro.org>
 <d58692dc-b94f-cd6a-c3dd-e9c76e68bdee@redhat.com>
 <BN6PR2201MB125185CB7DABA8AEE6888D92C6760@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <be1cdf57-7eec-ca66-d727-f449b07e8e28@redhat.com>
Date: Wed, 13 Nov 2019 19:44:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB125185CB7DABA8AEE6888D92C6760@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: kxkG-lRZOjS6zsGr3soi6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>, "cota@braap.org" <cota@braap.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/13/19 6:38 PM, Aleksandar Markovic wrote:
>> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>>> -    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,arm-softmmu,i386-softmmu=
,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x8=
6_64-softmmu"
>>> +    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,mips64-softmmu,ppc64-sof=
tmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
>>
>> Aleksandar, since you mostly test 32-bit MIPS, are you OK we keep
>> mips-softmmu and drop mips64-softmmu here? Another job (acceptance-test)
>> builds the mips64el-softmmu.
>=20
> Philippe, thanks for bringing this to my attention. Yes, 32-bit mips targ=
ets are important to us, but, what can we do, time constraints are time con=
straints, so I agree with Alex change, please go ahead, Alex. We can test 3=
2-bit mips targets via other acceptance tests (those that can run longer, s=
o-called "slow" group), and perhaps we can extend them to test more 32-bit =
mips systems.

OK, let's keep mips64 as suggested Alex then.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


