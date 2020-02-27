Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9888FC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CE62469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ch9zyCNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CE62469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7J2c-0002Gz-Kq
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7J1h-0001pM-KZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7J1g-00019o-Id
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:16:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7J1g-00019e-E5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582809388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5DHX4Bvypx9OJiggN4wz1ki4bStbCMzPji78qtFaC8=;
 b=Ch9zyCNgt/TSXd/e5CxE6EhO3pwfyA5DjuYP3gU8GXGt7vkWUidd9tWDoLQxchtY1ESdni
 VDFDifvXHC9R5UYOQSIciW8hvuUuanXmEdZbH0SWcVmdac8zGkocn0q8g8MNYueYxkXDSl
 cASM6DYeVLrnabttgF9FEjquXX5o/WI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-QZzIBlQwMzKYjoibcIc_jg-1; Thu, 27 Feb 2020 08:16:24 -0500
X-MC-Unique: QZzIBlQwMzKYjoibcIc_jg-1
Received: by mail-wr1-f72.google.com with SMTP id z1so1297553wrs.9
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o5DHX4Bvypx9OJiggN4wz1ki4bStbCMzPji78qtFaC8=;
 b=ebKd2pnUJK4tFazbAj61c75iOn3OyHGKY1tP72GeYG4rsPYm7YZj3gZMHM6TNfp37N
 BCT3/KcWFGRPn9b/dMqwKZ6KLMOGTunsBR53FAfyZOx8PzfhGZmkjuU4dHz0omoC9AYN
 dB0G/7fT/uRkBBHLXBDs+k3mej5TtfCA9ibZ7pEv9HzQmZQ44gcu359gn/OFj4G7QzVQ
 fTc5xWpggL+N1bBvlG58QPjBUOBV4ZGdWeCpno0EVYqmyd4z7JmmS1bfLPoYSmKBMZ3v
 XTcfGlia0yv5+Sy9J/4zPFAAPST7GENBpHyAlgTc2OZYhfXrqJS7z0k1S5/iY56UxGr+
 uOsQ==
X-Gm-Message-State: APjAAAW0QktwxS8VVDdsUf3HxWBJNMqXye3ST7hrMsIrBacRnxe5zsFa
 QL32gL5+raxYoJvhyuvUeg+D4QExdS8siVp8cabSf9Zn+3KPPyNfjhwK1VNJA8uipWDURwSEod2
 o60rg+Z5ZYsoFKAQ=
X-Received: by 2002:a5d:69c6:: with SMTP id s6mr4732899wrw.32.1582809383600;
 Thu, 27 Feb 2020 05:16:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2f9+NzY+61niOnEkURvGWRYEEIJ+cSPYLoHXYcjaq8OdFu2S7bdBsjBrfsbTyjizsOf17aQ==
X-Received: by 2002:a5d:69c6:: with SMTP id s6mr4732879wrw.32.1582809383303;
 Thu, 27 Feb 2020 05:16:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:30cb:d037:e500:2b47?
 ([2001:b07:6468:f312:30cb:d037:e500:2b47])
 by smtp.gmail.com with ESMTPSA id c74sm8087743wmd.26.2020.02.27.05.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:16:22 -0800 (PST)
Subject: Re: [PATCH 14/18] docs/system: Convert qemu-cpu-models.texi to rST
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-15-pbonzini@redhat.com>
 <CAFEAcA-ps7dmo_7Lgf2kTsy0nvFgU6qopS8HvZMu3DY81VvE_g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30ac44ae-bd44-1182-f6dd-d16a8062bf2e@redhat.com>
Date: Thu, 27 Feb 2020 14:16:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ps7dmo_7Lgf2kTsy0nvFgU6qopS8HvZMu3DY81VvE_g@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Part of the comments are either obvious or relevant to Kashyap's
original patch, I'm replying to those that are more directly for me.]

On 27/02/20 13:10, Peter Maydell wrote:
>>  create mode 100644 docs/system/cpu-models-mips.rst.inc
>>  create mode 100644 docs/system/cpu-models-x86.rst.inc
>>  create mode 100644 docs/system/defs.rst.inc
>>  create mode 100644 docs/system/qemu-cpu-models.rst
>>  delete mode 100644 docs/system/qemu-cpu-models.texi
> Why don't we also delete cpu-models-x86.texi and
> cpu-models-mips.texi ?
> 

They are included in the main manual.

>>
>> +rst_prolog = '''
>> +.. include:: defs.rst.inc
>> +'''
>> +
> 
> Maybe we should do this in docs/conf.py where we update
> rst_epilog with the CONFDIR replacement ?

Yes, that makes sense.

> Doing the "put these replacements into a generic defs.rst.inc"
> would also be clearer in its own patch, I think.

Agreed.

Paolo


