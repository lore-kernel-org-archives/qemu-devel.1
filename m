Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A000C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F30C206D5
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQ9Z+9Pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F30C206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2DY-0003b6-ET
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jD2Cn-0003AD-RS
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jD2Cm-0002a9-Ns
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:31:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50245
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jD2Cm-0002ZV-Jo
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584174696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiS9WnAt6x/eLL+i6zqGonHwQ4dDQS8cu3JQ44GE78A=;
 b=SQ9Z+9PdZ56xV+CWCyCvJg2CA0WM+yc9J6XnF/TLGxAROsojvQnyhjhG5WxUwizccBa2IF
 nBjq8MS7BH+g1Jru+UBkNMDMBWbHZPikrdyrKPtime35moOqofVbKH5GO9fpLtuqjZJs+D
 bpv87CPtTiFXGMyivI2Lv+AlYQ7QUuo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-bT3_YbKFPVu688tHZ50ErQ-1; Sat, 14 Mar 2020 04:31:34 -0400
X-MC-Unique: bT3_YbKFPVu688tHZ50ErQ-1
Received: by mail-wr1-f71.google.com with SMTP id p5so5566028wrj.17
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jz7tcXzSHkcJB0Gl8pCzikr1iiQm231RvtqU8hEMPlQ=;
 b=gOiP18PIjePjGAYcA5ZljrkWIGGLYDVIEIgOw0JYzpMvmrrmbNgsPzVUR3SN0z4PMd
 TKMT8C3tXtAHlj69unKPKQvzckZ7kBWBUttpwXdMzZ8U0kq2ZdImTMwHGfWW8On79miE
 +7TRK/E9kkcMWe/SJe4xAA29PkqIm+IpcibWZ39SJiABO4lFlJgB09nTGw3hJnrpK7IT
 CrXsWVES7izUoHvMYVcALdOSZI4QYONIqpakbqcSAuvsNtmeIAYBpWyaD3QE3opTcPU2
 ZAYS3nZdzTqCDlwmhjWr9a1IKb0VIcHFhOlSvGhAVZkv2FlPBLydgnfoIgtCOhflHRBu
 zE9A==
X-Gm-Message-State: ANhLgQ3iZXgLezrFINHzX6308WOi+jlh5P+qteRgdHnpHRAToPvcV3vw
 v23xGiO59ESDdWP28QIerQJJF196VV/pZi9lW8BDGETw9Tq7eMIJ18YFaKHp+Lh7xd8mrq37Bsf
 VzT4NUiZd1XG7xac=
X-Received: by 2002:a1c:5505:: with SMTP id j5mr5133200wmb.170.1584174693400; 
 Sat, 14 Mar 2020 01:31:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vspFsJ9nqBkRuvDZd1UUPBoJT9VVkUbizIwBrjCm2o7J9z0/XC6+s0fX2cXa3nFImdHEnZpyw==
X-Received: by 2002:a1c:5505:: with SMTP id j5mr5133177wmb.170.1584174693237; 
 Sat, 14 Mar 2020 01:31:33 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id i10sm78018980wrn.53.2020.03.14.01.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:31:32 -0700 (PDT)
Subject: Re: [PATCH v3 07/16] hw/i386/vmport: Introduce vmport.h
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-8-liran.alon@oracle.com>
 <13b98a16-6465-e1c9-5f52-0f338c60fbd5@redhat.com>
 <d81dc7a5-2b20-1792-c1df-ecdb8a964fa7@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2f168ddb-34e3-a286-080c-261dcb8ee6bb@redhat.com>
Date: Sat, 14 Mar 2020 09:31:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d81dc7a5-2b20-1792-c1df-ecdb8a964fa7@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:38 PM, Liran Alon wrote:
> On 13/03/2020 21:57, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 3/12/20 5:54 PM, Liran Alon wrote:
>>> No functional change. This is mere refactoring.
>>>
>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>> ---
>>> =C2=A0 hw/i386/pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 hw/i386/vmmouse.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
>>> =C2=A0 hw/i386/vmport.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
>>> =C2=A0 include/hw/i386/pc.h=C2=A0=C2=A0=C2=A0=C2=A0 | 13 -------------
>>> =C2=A0 include/hw/i386/vmport.h | 16 ++++++++++++++++
>>
>> What about moving it to hw/i386/vmport.h (no under include/)?
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>>
> Can you explain the logic that separates between hw/i386/*.h to=20
> include/hw/i386/*.h?

Headers in the include/hw/ namespace can be consumed by all machine targets=
.
If this is a target-specific device, having it local to the target=20
(hw/i386/) protect generic code (and other targets) of using it. This=20
helps detecting wrong dependencies between components.

> If it makes sense, sure I will move it. I just don't know what is the=20
> convention here.

Michael/Paolo/Eduardo what do you recommend?


