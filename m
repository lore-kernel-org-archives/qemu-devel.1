Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D02C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F6D20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crc4orr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F6D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1QfD-0006UT-LM
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1QeY-0005wy-PV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1QeX-0002YR-DV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:12:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1QeX-0002Xy-8E
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581408736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f56l6U6vjy7cpXRZWOQ7FR84keLCfNAvmcdGuBRGedU=;
 b=Crc4orr8/IOBAs/lNQSAw806QMU1nPDjJx/+P1iMLk7KX8xaKCSPcnP+Spj7rrItS80zt+
 WoSE/b+G6+i0fGfMouxCwUXQY5pWm6we9fdPVfo+vy/Q7844ImSlzyYHiU9tcyfsoYS6zQ
 Qyfl5skZrXcZvISCPWXICnqpJJRUIb0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-4OZuSiAIOLyR3SfD2FwY9w-1; Tue, 11 Feb 2020 03:12:10 -0500
Received: by mail-wm1-f72.google.com with SMTP id z7so737136wmi.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 00:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f56l6U6vjy7cpXRZWOQ7FR84keLCfNAvmcdGuBRGedU=;
 b=r7XUZVp4EesqcIaTsbneXzjR+xrbtRjzFoi+EbqkZIgHzAhj/BN2InVu7bLRW6w+8R
 dCk2NuGuX9wOisr4eda6Z7+Prq5xubUolKL+bzdt9qyAGxrUqRFabShT7zkd+iXxLc32
 +RwiZ8gKncKhv3aSM1DLiRl5LN+oaNjdpLR5YwnXPlx5bf6+X/yq02lifx9cIga+OHlt
 UIF9WVMJ31L0lDVcA+ya1k7P9jNl7FvSl+QsoVxmdlmL5mBwwaztwJnOUhJ8wxdxGtD2
 vElPy5oYyf7tfdtKjB7eXsHohi9upk/4u+/C/635eRwGJhfp8RTBAhn8TeaAoK6c9AxI
 9iXQ==
X-Gm-Message-State: APjAAAUrfmZPzgXXdXV73bQYd/V8xo4ljzw5sh7VRvv4CsmWdUhiJ8Kj
 fnK5NAz6ifmPShcvpBWIs9YESGz1yJBU598O2nXnZSTnRUAeMPwcJaR6t6Wy3qPqfVel/Z/nwtm
 MFvi8vsP3XDb6eQE=
X-Received: by 2002:a1c:960c:: with SMTP id y12mr4106280wmd.9.1581408729737;
 Tue, 11 Feb 2020 00:12:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjg/eUjEzwhsNtCcCUcUMOx6ewikjR00RgF2fIcT9mbjEg9FzCWRhYL5RSjYBoPmsFE5gryg==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr4106259wmd.9.1581408729504;
 Tue, 11 Feb 2020 00:12:09 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c4sm2646791wml.7.2020.02.11.00.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 00:12:08 -0800 (PST)
Subject: Re: [PATCH v2] hw/arm: ast2600: Wire up EHCI controllers
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
References: <20200207174548.9087-1-linux@roeck-us.net>
 <158111304888.591.9861885311267533100@a1bbccc8075a>
 <20200207224850.GA10890@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <445cee18-5de3-3da4-fef4-2e3f4530d96b@redhat.com>
Date: Tue, 11 Feb 2020 09:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207224850.GA10890@roeck-us.net>
Content-Language: en-US
X-MC-Unique: 4OZuSiAIOLyR3SfD2FwY9w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 clg@kaod.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 11:48 PM, Guenter Roeck wrote:
> On Fri, Feb 07, 2020 at 02:04:09PM -0800, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20200207174548.9087-1-linux@roeck-us.net/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-mingw@fedora build test. Please find the testing commands and
>> their output below. If you have Docker installed, you can probably reproduce it
>> locally.
>>
> I forgot to mention that the patch depends on the similar
> patch for ast2400/ast2500. Sorry for that. Not sure though how
> to tell that to the test build system.

You mean the "Aspeed: machine extensions and fixes" series?

Use the 'based-on' tag with the series cover message-id in your cover/patch:

Based-on: <20190904070506.1052-1-clg@kaod.org>


