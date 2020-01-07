Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41969C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA5C20678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apCEjq/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA5C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomVB-0000SB-5e
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iollh-0003ZH-IO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iollg-0004PQ-DR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:07:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iollg-0004PG-6V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578391639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oe6tmbp6970ilmTJSZbCPQnkZw69tO0IoMzHxH7GMdM=;
 b=apCEjq/VTIrLpSbTg7J93HVe4zDzXVFti/R90byQdkUcSnqbD5t8rbqhWWB6lvIEJJ6sCw
 4oyqJ4OXC54MWqbAsSW0QZ7jze61O2+ePdqF6D/YL2TRlvJ+TgzRTOWfped7epWapOHoEE
 RX3O8DLOJCF7JaJZs3w5rleWqmpmedA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-TEV612P7OieSnxbuj01DTw-1; Tue, 07 Jan 2020 05:07:18 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so27195054wrm.16
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=by9ZrA2wBZ8PWCrqn0KLcVqBKZTskPWrlIKzOuGZju8=;
 b=uoLe7bggxUC486QaCcF6xVDmu+mCmxjM9C6P0zq9YClJlA84odyzsaApsBPqOew0wv
 oT/C4IqujeE8+OU5aShHXe8FSGh6/swYnr1h4YG40jkbzdKESA/WTNpTdzKXm91KmVo3
 zgZQkbLyzv7PAiilVw4DZ/M+RERHK2ASXYA1agxHnZnaP6Dw2o25NFyJvsuY9dq4YyTi
 7X6rNUUB1kZ8MC+ATwaBiy+3Uc6pDUCCJulZpacKSiAfi0tEdi4myA2VklF+NFUnbOmH
 bCjRODjaBXdFdK2rZpcpr+toog4Fd8ZdT5ZT4Fiw1b7ipAtWxJyyVBVxAOWKf2XfKKE7
 SZjw==
X-Gm-Message-State: APjAAAVLu/Kg7vWRD/Yne/pI3ckchB+LHKOuAy0C4WBPAHt/L3e/oNv/
 bTijgK7Ws2QiR0eqQQBHJUZKTp4Gu0YeY3ERgDX28HX/b0WCDkN8BZXdMRcH8IoQcfxlCsQdkNy
 eynSFOw4Qm3ejhZs=
X-Received: by 2002:adf:e609:: with SMTP id p9mr105033852wrm.397.1578391637229; 
 Tue, 07 Jan 2020 02:07:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpBfpayfCVqSAgiHi7fQf8bQAXhW6tWX5H6qGNYui6yW1fnOnQ7uefDOpRPnrrD+YEQ08TMQ==
X-Received: by 2002:adf:e609:: with SMTP id p9mr105033834wrm.397.1578391637017; 
 Tue, 07 Jan 2020 02:07:17 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id q15sm78458824wrr.11.2020.01.07.02.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:07:16 -0800 (PST)
Subject: Re: [PATCH 04/14] hw/i386: Restrict fw_cfg to the PC machines
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-5-philmd@redhat.com>
 <a5ba0619-e236-7fb0-8c17-028670b69501@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8aa1238-fe00-5c26-953b-7b7b8d6595e0@redhat.com>
Date: Tue, 7 Jan 2020 11:07:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a5ba0619-e236-7fb0-8c17-028670b69501@redhat.com>
Content-Language: en-US
X-MC-Unique: TEV612P7OieSnxbuj01DTw-1
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 11:01 AM, Paolo Bonzini wrote:
> On 31/12/19 19:32, Philippe Mathieu-Daud=C3=A9 wrote:
>> Only the PC-based machines use the fw_cfg device. In particular,
>> the MicroVM machine does not use it. Only compile/link it when
>> machines require it.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Sergio Lopez <slp@redhat.com>
>> ---
>>   hw/i386/Makefile.objs | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
>> index 6ebb6d0cf0..48f2693546 100644
>> --- a/hw/i386/Makefile.objs
>> +++ b/hw/i386/Makefile.objs
>> @@ -5,7 +5,7 @@ obj-$(CONFIG_PC) +=3D pc.o pc_sysfw.o
>>   obj-$(CONFIG_I440FX) +=3D pc_piix.o
>>   obj-$(CONFIG_Q35) +=3D pc_q35.o
>>   obj-$(CONFIG_MICROVM) +=3D microvm.o
>> -obj-y +=3D fw_cfg.o
>> +obj-$(CONFIG_PC) +=3D fw_cfg.o
>>   obj-$(CONFIG_X86_IOMMU) +=3D x86-iommu.o
>>   obj-$(CONFIG_VTD) +=3D intel_iommu.o
>>   obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o
>>
>=20
> Ah no, this is hw/i386/fw_cfg.c; of course hw/nvram/fw_cfg.c has its own
> Kconfig symbol.  Can you rename the file to pc-fwcfg.c and adjust the
> commit message?

Yes, will do (I'll try to post a new series with only patches you=20
haven't picked already).


