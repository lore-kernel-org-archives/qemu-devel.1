Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E209C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D2220657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnd9sjmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D2220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jadIV-0001MZ-Gx
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jadHZ-0000mv-5X
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:46:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jadHY-0007Cy-61
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589798762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nKWrvufT6azW/0owsY2rxsNTCLCPi2PpVU3UF6/ZXU=;
 b=dnd9sjmnJq0cdM2qVpjf0khcmvX9CdKsUn0OJztiVcRWL8c3Oq+IA2j9kMVSeeXgasjEPb
 /Kyod8KQLSGj3cXp7PgJS1LcLml8S0wBO5xRGrVtVi/D+VOLqCg/bDIDJWrsnLBub/kKbx
 ZsvsJ1T7Kq2Tm3PlTtiB4hZ9Q8UaPnI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-dzIMyZVkMGiDsRqGd-4fMw-1; Mon, 18 May 2020 06:46:01 -0400
X-MC-Unique: dzIMyZVkMGiDsRqGd-4fMw-1
Received: by mail-wm1-f70.google.com with SMTP id t82so2825720wmf.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 03:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9nKWrvufT6azW/0owsY2rxsNTCLCPi2PpVU3UF6/ZXU=;
 b=fYzfUU3t22JTZk/GXMUWe9Nu7mWwhHOJ+rZEgokMfGIRiE2f13NIhdUUIVfTiGxLKN
 0+Hj1kqSRMq75AkaVuGvU6Zv+WeXDFMvFG1F77FsoYOlypL50ZVuxbTEoaE20+0QTnL5
 pjoW0t/iiLFFcIvGdfBrRn4nK7slYSEJ/ZxAKCuEbM2OeyelcumCmY3pUu4dDmOnfIzP
 PIfAgwPTdPsWrcgW+hhXKuJHqjDvvVzP1VzyQGkKo03Xs7yKmyr0YRYWbh2FMnfXGerC
 lRBaG8V8aHo+bmQ771kjo1KoSRWj4TXyvYMwv7/sGpTGSQKRnL6RTWrrZqU9hEP19Ajp
 8U+g==
X-Gm-Message-State: AOAM533S/IxG7Gbw0HOBwAFLtFHdVWysb75Iji7H37wtdajV2smk4qAM
 RchMmWRThoKZFzD7HMui5xyUZcVtRPTZ9eII0QbW9lBBoq8polIc06zxqA98+yz7qY+wYJf5ldZ
 d/wi739epr+8pLaI=
X-Received: by 2002:a05:600c:206:: with SMTP id
 6mr18866726wmi.170.1589798759614; 
 Mon, 18 May 2020 03:45:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD+HVZXozukSeRYvbSRaNYgIBnNlgVQ17WZm8wdbWVmPQBn5Xr/p+EBkPUiRRTseUC+CwiYg==
X-Received: by 2002:a05:600c:206:: with SMTP id
 6mr18866704wmi.170.1589798759399; 
 Mon, 18 May 2020 03:45:59 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x5sm16722613wro.12.2020.05.18.03.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 03:45:58 -0700 (PDT)
Subject: Re: [PATCH 18/24] display/sm501 display/ati: Fix to realize "i2c-ddc"
To: BALATON Zoltan <balaton@eik.bme.hu>, Markus Armbruster <armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-19-armbru@redhat.com>
 <alpine.BSF.2.22.395.2005181238010.5961@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <43c11226-9bbd-103d-4f9c-4b94c5d95f99@redhat.com>
Date: Mon, 18 May 2020 12:45:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2005181238010.5961@zero.eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Magnus Damm <magnus.damm@gmail.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 12:39 PM, BALATON Zoltan wrote:
> On Mon, 18 May 2020, Markus Armbruster wrote:
>> sm501_init() and ati_vga_realize() create an "i2c-ddc" device, but
>> neglect to realize it.  Affects machines sam460ex, shix, r2d, and
>> fulong2e.
>>
>> I wonder how this ever worked.  If the "device becomes real only on
>> realize" thing actually works, then we've always been missing the
>> device, yet nobody noticed.
>>
>> Fix by realizing it right away.  Visible in "info qom-tree"; here's
>> the change for sam460ex:
>>
>>     /machine (sam460ex-machine)
>>       [...]
>>       /unattached (container)
>>         [...]
>>    -    /device[14] (sii3112)
>>    +    /device[14] (i2c-ddc)
>>    +    /device[15] (sii3112)
>>         [rest of device[*] renumbered...]
>>
>> Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a
>> Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a
> 
> One of these is probably meant to be 
> c82c7336de58876862e6b4dccbda29e9240fd388

:)

> although I'm not sure having a Fixes tag makes sense for this commit.

AFAIK the 'Fixes' tag is not well defined in QEMU.
I personally find it handy to navigate between commits in gitk, not 
having to go via unrelated commits, which is why I use it.
Linux kernel seems to have a stricter approach, only using it for 
security bug fixes. For this QEMU uses 'Cc: qemu-stable'.

Do we need to clarify its use on the wiki?

> 
>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>> Cc: qemu-ppc@nongnu.org
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> hw/display/ati.c   | 1 +
>> hw/display/sm501.c | 1 +
>> 2 files changed, 2 insertions(+)
>>
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index 58ec8291d4..7c2177d7b3 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -929,6 +929,7 @@ static void ati_vga_realize(PCIDevice *dev, Error 
>> **errp)
>>     bitbang_i2c_init(&s->bbi2c, i2cbus);
>>     I2CSlave *i2cddc = I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC));
>>     i2c_set_slave_address(i2cddc, 0x50);
>> +    qdev_init_nofail(DEVICE(i2cddc));
>>
>>     /* mmio register space */
>>     memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index acc692531a..132e75b641 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -1816,6 +1816,7 @@ static void sm501_init(SM501State *s, 
>> DeviceState *dev,
>>     /* ddc */
>>     I2CDDCState *ddc = I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2CDDC));
>>     i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
>> +    qdev_init_nofail(DEVICE(ddc));
>>
>>     /* mmio */
>>     memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", 
>> MMIO_SIZE);
>>


