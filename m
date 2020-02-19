Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B23EC34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B282464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KftVCp76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B282464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4KmT-00068p-BW
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 03:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4Klf-0005dX-6t
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4Kld-00063G-IX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:31:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32475
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4Kld-00062t-E6
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582101096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZII3bsNqTRouTmmWrRKya4i/TbzmdWAzTDr2aXLAQSY=;
 b=KftVCp76CQutyFjtALRRd7Wo0wasbnWHh+fSX2PsR0i8oxpngRwyWHhR7hhoNZKY1EOpK2
 c/O41YaKtlCOQO9jZ1lRWvgxmGx8RMjJP6mONlBEEARaFOI8ZBrkXL48smvGmnIDi2Qvpi
 8pAT8GWrqLd3Q2Zirr6PJePuWeMaev4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-CSQEk8UtNOiWJvrS7TRwRA-1; Wed, 19 Feb 2020 03:31:34 -0500
Received: by mail-wm1-f70.google.com with SMTP id y125so1502641wmg.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 00:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gd9/YPbEDzLpdrImM1dLM7TybGTesqM4zWGpvLoRqkI=;
 b=PPQQksRZLYT9E5n8tymTpJzCQrr6y6dRZA54HB6Ux0K2kCnEanB/7wbg6XSueOmn0i
 sCc+DNhaAkndhJtieNhAQbCgatpeMGr9uI0Gowms/Por471ewk1ClO1nzkpxoMk4Vupt
 RufQsQOjsnidMEX1Iy8vzNYg64OKv15THm8YvNovHtRh2f+UO+Cb7QFoknQ3B1/Qqz33
 YAJF8wK8+AL2QoFB41wgsOF2Mh5Hp4SorIZwB2lq5zKbj5WCPxNX+1jAZUPvYYiRozpn
 nsexHVuMKy1/xG0iuwYE8PQprpC82eSCz1Xfj+cpM+cZ7iaDITYAuZypPMHy+f8LYsqp
 UXvA==
X-Gm-Message-State: APjAAAWsje70BOoCj9TJzwmPmbqgeeIqy7F+JwzUQ2kr4y/kImu4SWvF
 zOPen7n35dKNLt3CwQ9icz/94FlyZE1z1l+5jsV8DdDasAGP/U1mo1bBBUhUZDmNj4LQ+2LEMWy
 mtre7TMcXBOhxl64=
X-Received: by 2002:a1c:2282:: with SMTP id i124mr8238720wmi.109.1582101092707; 
 Wed, 19 Feb 2020 00:31:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwtWtc1js/pvBFHRnQbKBWdAL/0Q1D7ePqYOjFoJcxM2Y5HoZIUxZKGWUxxTDBuGhQ9XQTYlw==
X-Received: by 2002:a1c:2282:: with SMTP id i124mr8238701wmi.109.1582101092517; 
 Wed, 19 Feb 2020 00:31:32 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id f8sm1948756wrt.28.2020.02.19.00.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 00:31:31 -0800 (PST)
Subject: Re: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor Platform
To: "Justin Terry (SF)" <juterry@microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
References: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <BN8PR21MB1297D3D88C41B6AFADE36DCCB6110@BN8PR21MB1297.namprd21.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ecc9b0c5-7cd7-1f8d-d10c-bee7aff8fa01@redhat.com>
Date: Wed, 19 Feb 2020 09:31:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BN8PR21MB1297D3D88C41B6AFADE36DCCB6110@BN8PR21MB1297.namprd21.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: CSQEk8UtNOiWJvrS7TRwRA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you Sunil!

On 2/18/20 9:51 PM, Justin Terry (SF) wrote:
> Looks good to me! Thanks Sunil.
>=20
> Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>

Justin, I suppose you meant:
Reviewed-by: Justin Terry (VM) <juterry@microsoft.com>

>=20
>> -----Original Message-----
>> From: Sunil Muthuswamy <sunilmut@microsoft.com>
>> Sent: Tuesday, February 18, 2020 12:39 PM
>> To: Eduardo Habkost <ehabkost@redhat.com>; Paolo Bonzini
>> <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>
>> Cc: Stefan Weil <sw@weilnetz.de>; qemu-devel@nongnu.org; Justin Terry
>> (SF) <juterry@microsoft.com>
>> Subject: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor
>> Platform
>>
>> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>> ---
>>   MAINTAINERS | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1740a4fddc..9b3ba4e1b5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -404,6 +404,14 @@ S: Supported
>>   F: target/i386/kvm.c
>>   F: scripts/kvm/vmxcap
>>
>> +WHPX CPUs

Using "X86 WHPX CPUs" instead:

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>> +M: Sunil Muthuswamy <sunilmut@microsoft.com>
>> +S: Supported
>> +F: target/i386/whpx-all.c
>> +F: target/i386/whp-dispatch.h
>> +F: accel/stubs/whpx-stub.c
>> +F: include/sysemu/whpx.h
>> +
>>   Guest CPU Cores (Xen)
>>   ---------------------
>>   X86 Xen CPUs
>> --
>> 2.17.1
>=20


