Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8B2C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AE2205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEKk4obO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AE2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDcuH-00087t-9l
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 19:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDchA-0005sX-GV
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDch8-0007mA-9X
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:29:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDch8-0007hu-3M
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584314961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WumEjFpLdGXtIVB+lKkCaTKMvo703FUA4qb/lVmZ4U=;
 b=bEKk4obOw+fTf9kwg2bEqJbvdkUmWn9UOPi1ALo9kjdD9itCC8qnDlWgHQKKEFhGecqEGO
 uF12Axk8uy1KMsGxkza/6ce6/st82vD1Uk0w9Edp7RYZj551VS/XjQBXHnLd9hmXiULyd8
 /J33AoYR5Qm+bDbLj+fHKhqtwMmLAtM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-Xmdyg5s4N5uhswyEVCGM8Q-1; Sun, 15 Mar 2020 19:29:18 -0400
X-MC-Unique: Xmdyg5s4N5uhswyEVCGM8Q-1
Received: by mail-wr1-f71.google.com with SMTP id c16so8155928wrt.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GcXHnaqHRCexDMQKxXRREMxgznnfbEwtSJrVCXJw9kE=;
 b=g5cBzEMN+vqj+se6/sNOMyVk3udvZXDcfavqhzKuwrPUG9d9e9XylnNaByhRfHY+6V
 +t1iEthf4kiGLqrkcptwWv8rKLfpPtdcVa0yVZHrHPO1vqnkRwVfD/gHC+jugEWVWomP
 PRPupAgssiwx3peu/awVpDfvZCnp1T2Yvo5xOfVSw39sjOPK6GbUVsfih3iTqd7Fzsno
 ykwFF8YkR4VZFR1ZR13hPMgO9wvdTZGyeAlnjn8/W3KkLGSMepQ53bRWM3D3tleNBdc1
 FNgKtxQq1nJNpGsTFNzebBQrfNMNT4YhiCnCLtmGX9K/z7UJ3e449V4D7EZPDMnX1GNK
 x3EQ==
X-Gm-Message-State: ANhLgQ34lUmXP2Oh1I9ALd2ywP/gCIPp7Cex5Xyn5o/TDciWJ9BftyZM
 fJ2A4FT8Mn4M3HXrIY3cPLJXYWDVTRzxNpSUPoxy3R6I04vbm/6rIBqLIL1utkZWbwrin3ELtDL
 lPBYxvA5vMrgxeIc=
X-Received: by 2002:adf:8023:: with SMTP id 32mr21691296wrk.189.1584314957879; 
 Sun, 15 Mar 2020 16:29:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtbkXp6lrfy8keAFwi9Nk+31/DC50pnjme/fFfdMlfjyt2SkbWgxcCkk5l/ETfYkj7nFz0Z2Q==
X-Received: by 2002:adf:8023:: with SMTP id 32mr21691278wrk.189.1584314957689; 
 Sun, 15 Mar 2020 16:29:17 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id b202sm2308921wmd.15.2020.03.15.16.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 16:29:17 -0700 (PDT)
Subject: Re: [PATCH 8/9] hw/core: Add qdev stub for user-mode
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-9-philmd@redhat.com>
 <7775dd60-7c5d-e973-162d-5eb742b41c07@redhat.com>
 <9118c5b3-196b-9002-dcb8-1d3b91b59fc3@redhat.com>
 <3e06976a-b58d-a66e-8a13-5e3d7a325dc1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4564cb14-2fdb-2ea1-aef4-558160ea99cd@redhat.com>
Date: Mon, 16 Mar 2020 00:29:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3e06976a-b58d-a66e-8a13-5e3d7a325dc1@redhat.com>
Content-Language: en-US
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 11:57 AM, Paolo Bonzini wrote:
> On 14/03/20 11:49, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>
>>>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>>>> index 6215e7c208..89bf247173 100644
>>>> --- a/hw/core/Makefile.objs
>>>> +++ b/hw/core/Makefile.objs
>>>> @@ -8,6 +8,7 @@ common-obj-y +=3D vmstate-if.o
>>>>  =C2=A0 # irq.o needed for qdev GPIO handling:
>>>>  =C2=A0 common-obj-y +=3D irq.o
>>>> +common-obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D qdev-stubs.o
>>>
>>> This should be:
>>>
>>>  =C2=A0=C2=A0=C2=A0 obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D qdev-stubs.=
o
>>
>> Actually I moved it to stub-obj-y which makes things easier.
>=20
> No, common-obj- is the right thing, followed by
>=20
> common-obj-$(CONFIG_ALL) +=3D qdev-stubs.o

I don't understand CONFIG_ALL magic, why is that different to common-obj-y?

Anyway your suggestion works, so I'll blindly use it, thanks.

>=20
> Paolo
>=20


