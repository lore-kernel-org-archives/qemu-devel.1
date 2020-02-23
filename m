Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2098CC35670
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 09:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B5620656
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 09:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBuTCP5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B5620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5nD3-0001XR-V0
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 04:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j5nCG-0000ro-23
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 04:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j5nCF-0000TC-2D
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 04:05:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35486
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j5nCE-0000Sd-Tn
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 04:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582448705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+qfRDJ631+3BrpIbQmZINXk2gQQnyP0CW4SShz+z8s=;
 b=QBuTCP5Y9dynw5qtXOWBMyNMf/6J2V5cpUJR1heGJ204Jze4o3TBPGHBZnuJRjii0jZU1C
 6VQNPp+toTwtPicvp3lznMAwfiC3I7r6mFtpupzrt/3WW6Otwt4q1ANnwHJ4NW/I16ZEln
 TkSm0T7cemk68ccKyDAHmFm0BWVqiU0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-2szrkMDIOwOICHv8vDH9sg-1; Sun, 23 Feb 2020 04:05:04 -0500
X-MC-Unique: 2szrkMDIOwOICHv8vDH9sg-1
Received: by mail-wm1-f69.google.com with SMTP id m4so1789234wmi.5
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2020 01:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9+qfRDJ631+3BrpIbQmZINXk2gQQnyP0CW4SShz+z8s=;
 b=WM/woX/I6K70SpGx8XqlUYfTtyZ+e9Jc1Y+Fn6MQ5NXN/r15/8gmaOPXixoZ3zXXO9
 W4ZqQ0K3HqdPdkKdWYuA32qa34UkzchqDcxepzYhd/N5MqJfznovkiwk2EPbKcjk2I/r
 Sn7PP+MdtjZiw9WP+NUgTShrjtzgT1UWlrcDpSJ7mfgBTCjd004Mpoydek61sRBDzqZq
 X4zm1RZ0c0nuabCxLOEu2i8myoAtkFM/BrIzyBUBI12S98Sudo50hXkKa3Q4CV0W9R48
 kNH/0AAwooIUi5WBP/C+owbk5VBxwAEIVv0YKndovkGWrn3XHM4TRQYYFl55p98k099b
 9dig==
X-Gm-Message-State: APjAAAW+W2UJ8mWbY0Wmt8iiNKhF10JS/1g968qEnvH+gVlRTg6PrvZS
 mJNQvW44nEm8I74HUjD8zRPY0qkYV558L/S1eQLuvsx0wsRm/IB0K6CVdmwZorbPglq4nA+7Qan
 mavqU8gM8Yd+x3LA=
X-Received: by 2002:a7b:c416:: with SMTP id k22mr15868212wmi.10.1582448703172; 
 Sun, 23 Feb 2020 01:05:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyITY7Qxt5lA0/QWLVp60oNQOPXzXfoCcVMOHbTs40SM+MbNUVweR2hRsFcxTU3r5XAUUkhWg==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr15868151wmi.10.1582448702893; 
 Sun, 23 Feb 2020 01:05:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51?
 ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
 by smtp.gmail.com with ESMTPSA id o2sm12051784wmh.46.2020.02.23.01.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2020 01:05:02 -0800 (PST)
Subject: Re: [PATCH v3 2/3] hw: Make MachineClass::is_default a boolean type
To: "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20200207130453.16666-1-philmd@redhat.com>
 <20200207130453.16666-3-philmd@redhat.com>
 <20200207091138-mutt-send-email-mst@kernel.org>
 <16ec9b38-94e4-bd2d-a47f-83a27289ab47@vivier.eu>
 <20200207092450-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9dfd96b4-e924-5803-2d8b-182458fc936b@redhat.com>
Date: Sun, 23 Feb 2020 10:04:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200207092450-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, Magnus Damm <magnus.damm@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/02/20 15:25, Michael S. Tsirkin wrote:
>>>> @@ -841,7 +841,7 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
>>>>      mc->desc = "Sun4v platform";
>>>>      mc->init = sun4v_init;
>>>>      mc->block_default_type = IF_IDE;
>>>> -    mc->max_cpus = 1; /* XXX for now */
>>>> +    mc->max_cpus = true; /* XXX for now */
>>
>> and here ^^
>>
>> Thanks,
>> Laurent
> 
> Ooh good catch. Which probably means we don't have a unit test for these

"= true" just becomes "= 1".

Paolo


