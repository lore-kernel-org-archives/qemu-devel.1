Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF95C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DA12087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxoL/ygN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DA12087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzooV-0007UV-NC
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzomS-0006EN-MH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzomR-00073V-CX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:01:32 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzomR-00072C-64
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:01:31 -0400
Received: by mail-pf1-x441.google.com with SMTP id v12so1882494pfn.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vGBzrXO7KGpJ/NUWc/Wz8OhRnfw9xF17a3ctMtsK7KU=;
 b=FxoL/ygNz+Ksftm1RuYm/hG7E+xUwHOeXleAvU5RKlIsyWRQv8RINw3kW0ZJByEwo0
 qguqHCPMGOnOa+JMyt2Xwlv2pqzilmdFTcReSsfN6Ms8DIzBRqW1zByU3jMKV6A8MKUd
 Ey3Co++zv2CtWWhtWKSWRA06PcwxEPwJijUHnQXpmVIriIaWqnF3XwHYCWss8+xa440m
 W+qxDOjbHZpamKwURVa1T4q7BTMqMydWd9i8NzVovYN2blADLG3kJVQBic4LQgyy3vlX
 Z06lyjJsf5W39pmQ8zid0Tq07PX/wgluHJ4U9/nidce7U2v5Uo8AzFvmwrpT/uSsFgmQ
 aH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vGBzrXO7KGpJ/NUWc/Wz8OhRnfw9xF17a3ctMtsK7KU=;
 b=Pr4J6Hjcg+5XI4+q/7atUTbCIU3iLsFtay7M2zJt4mRmXacZKJ3Ky1PIPqFKPGwX5r
 AtbWo5fVVdJY/jMnKQYEmSgOWwu4nOdjLG/gPQ+a8t0sZLa+n+2hS7z0AXxNyNMpMYKB
 F7mux0qtOZzqYu/DhpoV6jnPsbkSvV8VhPK1DbH40TjhbXjRqTglm37R3ruiBK4odsj0
 Gr11AqGe245Q88VmOMVrMV3uly4o1AQxN7DWo9lMvgViaIT2TLlZZeaRnJOhAf9svDRf
 PYuXZtv2s42UikqYNLbJmMdqi+CPTgBR9gR/lygm+LfYrom0p8P87SfAnvMfrP0P9LdV
 TDLw==
X-Gm-Message-State: APjAAAX/FOmEfFDAw+yRnqq1FqdHGtEQVkU1oGqU8xcqvMEkvfbSsoU3
 S3Ed0tqfDP0rAV7ftrgGDqHucA==
X-Google-Smtp-Source: APXvYqyxYKmwhkk2+hBSFj74Kf7MG7+XWa94OJ2Sw4xj2uOGNS5PTiiDALcNZLOc7wR94aBemA/2WA==
X-Received: by 2002:a65:6104:: with SMTP id z4mr21186266pgu.27.1566248488612; 
 Mon, 19 Aug 2019 14:01:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id c2sm7562265pjs.13.2019.08.19.14.01.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Aug 2019 14:01:27 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <1565941032362.60179@bt.com>
 <1b5f5a92-1b75-f0d9-d7bc-4605094ad8e7@redhat.com>
 <8d8b37c9-3daf-d241-df92-1a5467bca451@redhat.com>
 <3b983f77-8503-3fcd-7c42-45d0121845e6@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b79a173d-a682-21da-6e7f-489ce06c8f7a@linaro.org>
Date: Mon, 19 Aug 2019 14:01:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3b983f77-8503-3fcd-7c42-45d0121845e6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v7 33/42] exec: Replace
 device_endian with MemOp
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 cohuck@redhat.com, jan.kiszka@web.de, sagark@eecs.berkeley.edu,
 david@redhat.com, green@moxielogic.com, palmer@sifive.com,
 mark.cave-ayland@ilande.co.uk, i.mitsyanko@gmail.com, keith.busch@intel.com,
 jcmvbkbc@gmail.com, frederic.konrad@adacore.com, dmitry.fleytman@gmail.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 pburton@wavecomp.com, xiaoguangrong.eric@gmail.com, marex@denx.de,
 robh@kernel.org, hare@suse.com, sstabellini@kernel.org, berto@igalia.com,
 chouteau@adacore.com, qemu-block@nongnu.org, arikalo@wavecomp.com,
 jslaby@suse.cz, deller@gmx.de, mst@redhat.com, magnus.damm@gmail.com,
 lersek@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 mreitz@redhat.com, hpoussin@reactos.org, joel@jms.id.au,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org,
 david@gibson.dropbear.id.au, philmd@redhat.com, jasowang@redhat.com,
 atar4qemu@gmail.com, antonynpavlov@gmail.com, jiri@resnulli.us,
 ehabkost@redhat.com, minyard@acm.org, qemu-s390x@nongnu.org, sw@weilnetz.de,
 alistair@alistair23.me, yuval.shaia@oracle.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au, clg@kaod.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, shorne@gmail.com, jsnow@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, qemu-riscv@nongnu.org, proljc@gmail.com,
 andrew@aj.id.au, claudio.fontana@suse.com, crwulff@gmail.com,
 laurent@vivier.eu, Andrew.Baumann@microsoft.com, sundeep.lkml@gmail.com,
 andrew.smirnov@gmail.com, michael@walle.cc, paul.durrant@citrix.com,
 qemu-ppc@nongnu.org, huth@tuxfamily.org, amarkovic@wavecomp.com,
 kbastian@mail.uni-paderborn.de, imammedo@redhat.com, jcd@tribudubois.net,
 aurelien@aurel32.net, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/19 11:29 AM, Paolo Bonzini wrote:
> On 19/08/19 20:28, Paolo Bonzini wrote:
>> On 16/08/19 12:12, Thomas Huth wrote:
>>> This patch is *huge*, more than 800kB. It keeps being stuck in the the
>>> filter of the qemu-s390x list each time you send it. Please:
>>>
>>> 1) Try to break it up in more digestible pieces, e.g. change only one
>>> subsystem at a time (this is also better reviewable by people who are
>>> interested in one area)
>>
>> This is not really possible, since the patch is basically a
>> search-and-replace.  You could perhaps use some magic
>> ("DEVICE_MEMOP_ENDIAN" or something like that) to allow a split, but it
>> would introduce more complication than anything else.
> 
> I'm stupid, at this point of the series it _would_ be possible to split
> the patch by subsystem.  Still not sure it would be actually an advantage.

It might be easier to review if we split by symbol, one rename per patch over
the entire code base.


r~

