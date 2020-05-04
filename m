Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D427CC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3446206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpRxAoJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3446206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcRP-00023C-Kh
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcMV-0001kn-Vb
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:46:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42024
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcMV-0000ZL-20
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588603585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2JBK/uMOQdvvWX7TGXrJcdourkMqGRQ9Ko7W41uqJM=;
 b=TpRxAoJ5eHpg+/0LIDx9q/7VlozHEaWNpOrFMPqR5roBH7regMvOMq5KH3uELvdeoyMgJE
 GB69BGK1wMtRr10NXL2YQ44Mxp0YgqCQxGdbdk9t4XVcO/SqR7eSEVFD+PLjO/1LmhKF/X
 ntCWrhVMk+g5jJxfT7LaDR3qlETxBJU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-tXmHxvIBPS6JvlUpYLKAPw-1; Mon, 04 May 2020 10:46:23 -0400
X-MC-Unique: tXmHxvIBPS6JvlUpYLKAPw-1
Received: by mail-wr1-f70.google.com with SMTP id g7so10840399wrw.18
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O9RDh90rzwYV3ykFDwO2t4I8t1kQv+tVcR5sf+CJblY=;
 b=qoo4ta4AkZ3Sy4uHFeLzE23Yz6sG2rg8PzfeCe2yRacbAnsBdO9CmAJSbWHPR1yYvT
 RL+5Y0NQ9nhKy+X3Cfz9U89tRtzRRuYmume1wkSJjBCc1JK93NvT+Rf4Vv4BTWB3Nplz
 W1yYrHmvsC3sWgtS3UM4lOJ14oXQ/ID7MmReFj2E5Wc4FEFtKxR3DEUgAMkPg2Zb+r8l
 mxOQhoqaVudZmbNTkEcDSdOhrwdhth+pGwS7Sg+jvGW1p9eoTpAQaPDpBYTqQ//XAKIq
 IaYQADsZGVUoY6Uq6dGxqOqLwYNm63qOO1ul2erW2Ed3Dk7ZAaVJQqd5coCVsbp8mIZB
 /C0g==
X-Gm-Message-State: AGi0PuZLSQxk2LJgRmV7yR7+uqeIuw+1O29qLQUSLYrf2GV8YT3En+oh
 FWinL0SwsQCLXn1op8X4IQJfCPNzaDjzdXzxfG8kbZvAgCITJMPW8aRRHJyiY7ul/sJF2hdzPcr
 NNKaHRwAIvOHK4hI=
X-Received: by 2002:a1c:7715:: with SMTP id t21mr14280688wmi.182.1588603582684; 
 Mon, 04 May 2020 07:46:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypIaVsrAAwZydOGIBMnsTlisfPZCSA6dTBrUKT5l2AktIUCKLxqBcXTTqnwArwBHqFOhkJ1b2Q==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr14280671wmi.182.1588603582470; 
 Mon, 04 May 2020 07:46:22 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id v131sm14925252wmb.19.2020.05.04.07.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 07:46:21 -0700 (PDT)
Subject: Re: [PATCH v3 15/15] acpi: simplify build_isa_devices_aml()
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-16-kraxel@redhat.com>
 <64d04e82-c516-c85d-be6a-19a1eb9b8c1f@redhat.com>
 <20200504134652.fdyxndske6u5f4yy@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2838a14e-00c9-6f49-73d6-92b4382cf116@redhat.com>
Date: Mon, 4 May 2020 16:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504134652.fdyxndske6u5f4yy@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Corey Minyard <minyard@acm.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/4/20 3:46 PM, Gerd Hoffmann wrote:
> On Thu, Apr 30, 2020 at 08:48:31AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Cc'ing IPMI maintainer.
>>
>> On 4/29/20 4:00 PM, Gerd Hoffmann wrote:
>>> x86 machines can have a single ISA bus only.
>>
>> I disagree with the comment.
>> Machines can have multiple ISA bus.
>=20
> Note *x86* machines.  Given x86 has a global io address space I still
> think this is true.
>=20
> On some !x86 archs where a mmio window on the bridge is used for the io
> address space multiple isa busses are possible.  I'm not sure whenever
> this is purely theoretical or whenever such machines exist in practice
> and in case of the latter whenever qemu can emulate one.

It currently can't.

>=20
>>>    hw/i386/acpi-build.c | 15 +++++----------
>           ^^^^
> But in any case !x86 doesn't matter here ;)

Oops I didn't notice...

>=20
> take care,
>    Gerd
>=20


