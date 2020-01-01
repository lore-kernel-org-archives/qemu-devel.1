Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F36C2D0DC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 15:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164D12072C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRht2nvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164D12072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1img41-00050k-4j
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 10:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1img3M-0004VK-HV
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 10:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1img3K-0007Om-DH
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 10:36:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56947
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1img3K-0007LK-3B
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 10:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577893013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2wp8c8Vm/BkYowfIv8s8xalS79oFSIrfPFSqUcNFl8=;
 b=FRht2nvmTq9+3jo1ky5hCuqrC3v+P1AzouufgkQM8KPYFCIobiwyCWGuQIQv/nhGoW8yYn
 llv9fLNH6jFxeK4ec6slvAq1dHH3o+iSB42hJce5jAlJNP5u1iqXKcOlOysH8/yFAiPoml
 llsMDkUzFhebfwG3EWlH36fzTYSQCOo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-IhuY2BeVPnWvOdBfpWokvQ-1; Wed, 01 Jan 2020 10:36:52 -0500
Received: by mail-wr1-f70.google.com with SMTP id j13so6289873wrr.20
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 07:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=InWdigkaj9f1sJrMj37sHQGPx8eCL/70fsQKWDz8riE=;
 b=jlTfEW/kfL1YaTY05VHktE852uef1poSt5yBQfHvEQJWkfxwPu1fS+bd+F5sHavFWS
 cY3BAdAm5L02sBkJ+LyynwGj3pzTiEJyJFwZ7VoKjvhH+iv5Wr5wzYD7/tcFMVXshujH
 lcgHOiCCac6w6hHrg0hujdFk8YOWpJshewQrlRDyRd1/OswShme2EQTuF4BgF1XLaZwj
 XMXu96GR2HpbktNsxoDLEm+Y5vCsDeqpCOpZpWH19ZhohZxcDuXmb61uvMHy2Q1HwkoB
 3jcpAWbgmGRgS90UzG6ErjhIr23eSH7WMfySk1nN2U8wzz9FsxEZTFRY6aCB0Jzc52eX
 4FOQ==
X-Gm-Message-State: APjAAAW+AZbFOGDwLRah7ItwZla2GmnR+G5OFJZNBGGkMXOlDmQwDQCQ
 Dikhw+dt4e4MWlUiRjLeQTPW08pyeD0Yu3Ls/v21cWnLpuFbyVBF5cL9RNt20FdvcnnPeR+db+a
 xbDZmcGSI/LaryPY=
X-Received: by 2002:adf:bc4f:: with SMTP id a15mr78032297wrh.160.1577893010779; 
 Wed, 01 Jan 2020 07:36:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9rWT15gvUHNnPKE7fLG3foFz/rexHeGM+Xr7LJj/hH0dIOxe9IUZ6frtuxXV+NTXqNIH9Qw==
X-Received: by 2002:adf:bc4f:: with SMTP id a15mr78032282wrh.160.1577893010556; 
 Wed, 01 Jan 2020 07:36:50 -0800 (PST)
Received: from [10.30.42.123] ([62.102.229.57])
 by smtp.gmail.com with ESMTPSA id l17sm51552244wro.77.2020.01.01.07.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jan 2020 07:36:49 -0800 (PST)
Subject: Re: [PATCH 07/14] hw/ppc/Kconfig: Let the Sam460ex board use the
 PowerPC 405 devices
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-8-philmd@redhat.com>
 <alpine.BSF.2.21.99999.352.2001011223290.5612@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <13a08462-759a-32ab-2628-432dfb9fa47a@redhat.com>
Date: Wed, 1 Jan 2020 16:37:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.99999.352.2001011223290.5612@zero.eik.bme.hu>
Content-Language: en-US
X-MC-Unique: IhuY2BeVPnWvOdBfpWokvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/1/20 12:29 PM, BALATON Zoltan wrote:
> On Tue, 31 Dec 2019, Philippe Mathieu-Daud=C3=A9 wrote:
>> When configured with --without-default-devices, the build fails:
>>
>> =C2=A0=C2=A0 LINK=C2=A0=C2=A0=C2=A0 ppc-softmmu/qemu-system-ppc
>> =C2=A0/usr/bin/ld: hw/ppc/sam460ex.o: in function `sam460ex_init':
>> =C2=A0hw/ppc/sam460ex.c:313: undefined reference to `ppc4xx_plb_init'
>> =C2=A0/usr/bin/ld: hw/ppc/sam460ex.c:353: undefined reference to=20
>> `ppc405_ebc_init'
>> =C2=A0collect2: error: ld returned 1 exit status
>> =C2=A0make[1]: *** [Makefile:206: qemu-system-ppc] Error 1
>>
>> Fix by selecting the PPC405 config.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>=20
> (The 405 and 440 devices are currently entangled by both using similar=20
> parts and maybe not all of them are in 4xx yet. Because of this I'm not=
=20
> sure if it's worth having separate configure options for these or just=20
> have a common PPC4XX option for now until these are cleaned up to=20
> separate them.)

You are correct. Using a config.mak limited to CONFIG_SAM460EX=3Dy also=20
pulls the 440-based machines in.

Building this series with 'make ppc-softmmu/all':

$ ppc-softmmu/qemu-system-ppc -M help
Supported machines are:
bamboo               bamboo
none                 empty machine
ref405ep             ref405ep
sam460ex             aCube Sam460ex
taihu                taihu

Thanks for the review!

>=20
> Regards,
> BALATON Zoltan
>=20
>> ---
>> hw/ppc/Kconfig | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>> index 0cd8d4053e..004b7d5ad5 100644
>> --- a/hw/ppc/Kconfig
>> +++ b/hw/ppc/Kconfig
>> @@ -50,6 +50,7 @@ config PPC4XX
>>
>> config SAM460EX
>> =C2=A0=C2=A0=C2=A0 bool
>> +=C2=A0=C2=A0=C2=A0 select PPC405
>> =C2=A0=C2=A0=C2=A0 select PFLASH_CFI01
>> =C2=A0=C2=A0=C2=A0 select IDE_SII3112
>> =C2=A0=C2=A0=C2=A0 select M41T80
>>


