Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B3CC35642
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324BC24670
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF6G1PEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324BC24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j53fu-0008JT-B0
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 03:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j53fG-0007n0-Vl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:28:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j53fG-0003KC-34
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:28:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43265
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j53fF-0003DA-VN
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582273681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fXfdn/DkVZu2GlUU3zCgAtzPM8XjXO81xiXzlH7lQTM=;
 b=MF6G1PEvXZLrChrlLm6YeSMN1NK892xl0qSoQthH2I4GLSOITQJHdRJmM+ujf0KXyngNAn
 m6k6uGX9mG+q9xmbcFWpoC+mk9kamElv8X1Tg/VKiFrnpfZBrcTj5lKjT1AidKNUj6by7E
 iVg9tvTvgDPZxlbUcQjeDNeSs2cbptk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-Kf15T8m8MKG7MYErt8odLA-1; Fri, 21 Feb 2020 03:27:59 -0500
Received: by mail-wr1-f72.google.com with SMTP id w6so688174wrm.16
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 00:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fXfdn/DkVZu2GlUU3zCgAtzPM8XjXO81xiXzlH7lQTM=;
 b=ADydhobw6YVj4oxe2jjh9z6EvRUmYtRX8VdWSlwMHiF5keFJ8rlmNcyNLC6pwmR757
 rjyGJ80be6cJa/zRRiSR5LdXdwCyKlKJbVPqnf6qo0wCdJFMe/Iw6vSLzoO/Rroademx
 IRRhnKnJLRg+jY3lrjIObaqPtwy79AK/hbd6TYSbO8fNt/qmeVIVxnreAPqO1Fta/wS+
 oA7+8lctSxUzaP0gYBND6PeVy2rzA+H/3I9WmozSSlsdXZL8zNoW+qkovbujVpmC0OCp
 biJ9O048IkZlFiJ4t2+P4QqhdQbvntA+nitIo6KbKyGt2VC6300cnAY9KXaXCNXDYrDA
 rpQQ==
X-Gm-Message-State: APjAAAWHZp3S0qa0Y1vPJ7toeSRvjdBT/VtCYavUHmX1XlRZWqDqtD5l
 /wQ8chdaxjSCeRSC5YhWmJUY8scTGXblNjnPpTJCEsgtK6iHWUcq8XZkArhnCLaP3S9RlhaAAlw
 2bk++84fFfcJK4EE=
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr48374730wrp.203.1582273677914; 
 Fri, 21 Feb 2020 00:27:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzlLuw2UKDVE28cLTSWdv59QaVg3lPmmcTPiNUA/JjJ/P62Bjg37vHhm4CnacdXU8IuzAPCWA==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr48374703wrp.203.1582273677586; 
 Fri, 21 Feb 2020 00:27:57 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id f127sm2675804wma.4.2020.02.21.00.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 00:27:57 -0800 (PST)
Subject: Re: [PATCH qemu v7 0/5] spapr: Kill SLOF
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20200220061622.15064-1-aik@ozlabs.ru>
 <db675fc6-9d07-1780-134d-6a9279328b29@redhat.com>
 <68b71292-48db-e2ec-5f22-fe4580c2938e@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4109357e-0912-9633-20ad-28269efb2422@redhat.com>
Date: Fri, 21 Feb 2020 09:27:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <68b71292-48db-e2ec-5f22-fe4580c2938e@ozlabs.ru>
Content-Language: en-US
X-MC-Unique: Kf15T8m8MKG7MYErt8odLA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/02/20 01:18, Alexey Kardashevskiy wrote:
> I am not quite sure I understood the request.  Write my own small
> firmware and replace GRUB with it? The firmware from 5/5 reads first 2
> sectors and the entire PReP, I could add there stuff if that helps (I
> have "work in progress" patch for the firmware with printk/etc borrowed
> from SLOF).

Okay, that's great!  I'll take a look next week.

Thanks,

Paolo

>>  (Also, I lost the pointer to your super-minimal
>> pSeries firmware).
>
> It is incorporated into these patches under /pc-bios/vof - 4/5 has the
> minimum (may be even too much), 5/5 has MBR+GPT+ELF.



