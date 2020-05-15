Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7165CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5F8205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djAKygzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5F8205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVJt-0008IJ-DS
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZVJE-0007kP-W9
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:03:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZVJD-0000kd-DQ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589529785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRAmIHT/559a7+fqaRrSQH0tGo8TwnC/223UCasPjD4=;
 b=djAKygzn9lVRxfX1EFkzVWF2CAaZD5kQEoRmgicGQDozgwW2q814l5p90Zf6gkJRCW3JFP
 6mo797ZXHcvhrutN5B23Ftdy3oxOLkKOO/0UCySQrj7LxC71Wv9e1V4/EodT5UN1eIV6N6
 LBMK659JGNcQJgTuHdOfUmmm1xPIJHc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-uHQPqFjYMhaiwy_MK2hoBA-1; Fri, 15 May 2020 04:03:04 -0400
X-MC-Unique: uHQPqFjYMhaiwy_MK2hoBA-1
Received: by mail-wr1-f70.google.com with SMTP id r14so780332wrw.8
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 01:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bRAmIHT/559a7+fqaRrSQH0tGo8TwnC/223UCasPjD4=;
 b=jvdXaE9NFiAd1B12Lyn8GGPjXXnwe1/90lv6AKd1mopl+Vx3ldMPZFbxIbHMUy58pv
 9pMWE1FX5xYtJgVghTVAMUKcuLYltppYG4bHlbsmKoyXrFadMo/7cVfAO0rtMZevAb6c
 IdsvPCvgSBrcnkT8LSFl/SUD44Ju2iAIZBnCWIvIaEx3ELNw2ygELEbjCWxVnu5tNMcK
 o4dM8nLwJ8oHdDLvAiDeCU0kApLD6hOwmdiMrKqNXUEZGthh9AZxuJHnHTuSq2Po9eO8
 TVkiDIGpBSQgi1fESx3COl12Xat+Bz/jo6zoMqWTaO4yDL8X2/ZcdtRjoWSeS0xhVXJd
 x/zg==
X-Gm-Message-State: AOAM532oYgkaS5ej/kR4SgA3Rqdza4o0pZ3sjb4Aj4JCKLZkBIZ2whU4
 h+snlXDeQANKlQirrVjZvsGXXZlLy4srB7e8K3iq0NEA9/QH3laMyeXiDjE4sEtMWnJ+n1p8Pro
 cgmHJ3ptYxPYnlUo=
X-Received: by 2002:a1c:b60b:: with SMTP id g11mr2674234wmf.49.1589529783113; 
 Fri, 15 May 2020 01:03:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPZ2Nb7tBjSVVeGQyH4Zf5ArKpaS7SaE4MubelUS8DKKXXjb9MIfqr+7T+4wQNuUBOKHn7KQ==
X-Received: by 2002:a1c:b60b:: with SMTP id g11mr2674200wmf.49.1589529782837; 
 Fri, 15 May 2020 01:03:02 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f5sm2369881wrp.70.2020.05.15.01.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 01:03:02 -0700 (PDT)
Subject: Re: [PATCH 0/5] docs/system: Document some arm board models
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <CAFEAcA_p1x6S10yswHgOkMd=KrxcTGh9TD47+k1LRKM0xy5x+Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <567755c6-3bb1-b16e-af26-431dec4616ba@redhat.com>
Date: Fri, 15 May 2020 10:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_p1x6S10yswHgOkMd=KrxcTGh9TD47+k1LRKM0xy5x+Q@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

+Markus

On 5/14/20 3:28 PM, Peter Maydell wrote:
> Ping for review?

For the series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

However I'd rather see the board documentation in the source code, and 
extract it when building. It'd be harder to miss updating the 
documentation when modifying the code.

Another way (rather than using external program to extract from source 
code) can be to add a method/field to MachineClass, and once a build is 
finished, we could run 'qemu-system-arch -M gendoc' which go thru all 
machines and display the documentation properly formatted.

> 
> thanks
> -- PMM
> 
> On Thu, 7 May 2020 at 16:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> This patchset adds (minimal) documentation of these Arm board models:
>>
>> vexpress-a15         ARM Versatile Express for Cortex-A15
>> vexpress-a9          ARM Versatile Express for Cortex-A9
>> mps2-an385           ARM MPS2 with AN385 FPGA image for Cortex-M35
>> mps2-an505           ARM MPS2 with AN505 FPGA image for Cortex-M33
>> mps2-an511           ARM MPS2 with AN511 DesignStart FPGA image for Cortex-M3
>> mps2-an521           ARM MPS2 with AN521 FPGA image for dual Cortex-M33
>> musca-a              ARM Musca-A board (dual Cortex-M33)
>> musca-b1             ARM Musca-B1 board (dual Cortex-M33)
>>
>> to the system emulator manual.
>>
>> Patches 1 and 2 are minor tidyup of the board table-of-contents
>> before we start adding new entries with patches 3-5.
>>
>> I'm aiming more for "at least note that the boards exist" than
>> "fully comprehensive" documentation here -- there are still another
>> 37 Arm board models with no documentation at all...
>>
>> thanks
>> -- PMM
>>
>> Peter Maydell (5):
>>    docs/system: Add 'Arm' to the Integrator/CP document title
>>    docs/system: Sort Arm board index into alphabetical order
>>    docs/system: Document Arm Versatile Express boards
>>    docs/system: Document the various MPS2 models
>>    docs/system: Document Musca boards
>>
>>   docs/system/arm/integratorcp.rst |  4 +--
>>   docs/system/arm/mps2.rst         | 29 +++++++++++++++
>>   docs/system/arm/musca.rst        | 31 +++++++++++++++++
>>   docs/system/arm/vexpress.rst     | 60 ++++++++++++++++++++++++++++++++
>>   docs/system/target-arm.rst       | 15 ++++----
>>   MAINTAINERS                      |  3 ++
>>   6 files changed, 134 insertions(+), 8 deletions(-)
>>   create mode 100644 docs/system/arm/mps2.rst
>>   create mode 100644 docs/system/arm/musca.rst
>>   create mode 100644 docs/system/arm/vexpress.rst
>>
>> --
>> 2.20.1
>>
> 


