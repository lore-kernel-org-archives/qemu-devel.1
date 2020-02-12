Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0428CC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24BB2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Csx/3PND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24BB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1zk1-0005pi-Ub
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 16:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1zjO-0005Lm-A9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1zjM-00047V-Ki
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:39:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1zjM-00046a-Hm
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581543575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qquN2CqCDX1aHa1RbpIdU+TKmi8DhASx8szKauwNduM=;
 b=Csx/3PNDnLpJvLiDATzDWyiZIePe3CCJuCAp0kOpILdZBS6KayW01xf6KQuoh4yAOxUXzP
 uluw+RzxOE6PcixpfbkvgeS3Y+XVNhPkEtPBNv18c3Hl890mJwYuPNho1SzZAalymtb/l4
 Dd23jNv2x7wAUh4wCgzhhLvUhFU3MrA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-q94odP3RMc-YXHqkKPKU5Q-1; Wed, 12 Feb 2020 16:39:33 -0500
Received: by mail-wr1-f71.google.com with SMTP id u8so1381462wrp.10
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 13:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qquN2CqCDX1aHa1RbpIdU+TKmi8DhASx8szKauwNduM=;
 b=gTdw94ZQPgpbSqWR7LjxBnPSB010p5CKjsG2eyyyQOMAtYsjqKQ9X3RgQJKblwe/8w
 mwiwNMazKL4KKYOujmS2n7oiPDEGtjkO/BZ0SLZRXsx01mg3Uk5PHdlZTCvfZf+1sPk8
 AacXZOZOTiCqHIq+3lZAHrc2kzk/4xBLJoPAcl5z/jTHAleEjbowc0LU3Tya6WjRdq22
 VkIz8yBf+Lntb2AqSZhCDz2BcJhB6FE5JTjmOOqjyg3ypmpFMDw/U/tuAGnFsBflFWk8
 UXFqlPdaUxDeLUjEI4WTrfVIJ6p2BJAx3Bh+zQR8/n211EzM51oLEDA6fXV0I91ZCjhA
 3Oog==
X-Gm-Message-State: APjAAAXycZM/OciROuucGv2hhvTGAaQfnGrebdYx/VWDghIq6nVtYHPU
 9416QryTyNnn5o6OaWi3vqi/CZ+/1MHh3p+8sPzGtzIGiF02SOvQc1WymbwrNLsHsgiSj+mhdVV
 LlLwsxNR99VUTq6Q=
X-Received: by 2002:a1c:7419:: with SMTP id p25mr1036214wmc.129.1581543572730; 
 Wed, 12 Feb 2020 13:39:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNQqwpF17DS8hAh+sB1Ze0mBRe7lT2gwJHF2WhDIiguHYFxitsdlXOhuhdCAceLgHxQnZOsQ==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr1036198wmc.129.1581543572430; 
 Wed, 12 Feb 2020 13:39:32 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o77sm131468wme.34.2020.02.12.13.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 13:39:31 -0800 (PST)
Subject: Re: Question about (and problem with) pflash data access
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
References: <20200212184648.GA584@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <504e7722-0b60-ec02-774d-26a7320e5309@redhat.com>
Date: Wed, 12 Feb 2020 22:39:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212184648.GA584@roeck-us.net>
Content-Language: en-US
X-MC-Unique: q94odP3RMc-YXHqkKPKU5Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Jean-Christophe and Peter.

On 2/12/20 7:46 PM, Guenter Roeck wrote:
> Hi,
> 
> I have been playing with pflash recently. For the most part it works,
> but I do have an odd problem when trying to instantiate pflash on sx1.
> 
> My data file looks as follows.
> 
> 0000000 0001 0000 aaaa aaaa 5555 5555 0000 0000
> 0000020 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0002000 0002 0000 aaaa aaaa 5555 5555 0000 0000
> 0002020 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0004000 0003 0000 aaaa aaaa 5555 5555 0000 0000
> 0004020 0000 0000 0000 0000 0000 0000 0000 0000
> ...
> 
> In the sx1 machine, this becomes:
> 
> 0000000 6001 0000 aaaa aaaa 5555 5555 0000 0000
> 0000020 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0002000 6002 0000 aaaa aaaa 5555 5555 0000 0000
> 0002020 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0004000 6003 0000 aaaa aaaa 5555 5555 0000 0000
> 0004020 0000 0000 0000 0000 0000 0000 0000 0000
> *
> ...
> 
> pflash is instantiated with "-drive file=flash.32M.test,format=raw,if=pflash".
> 
> I don't have much success with pflash tracing - data accesses don't
> show up there.
> 
> I did find a number of problems with the sx1 emulation, but I have no clue
> what is going on with pflash. As far as I can see pflash works fine on
> other machines. Can someone give me a hint what to look out for ?

This is specific to the SX1, introduced in commit 997641a84ff:

  64 static uint64_t static_read(void *opaque, hwaddr offset,
  65                             unsigned size)
  66 {
  67     uint32_t *val = (uint32_t *) opaque;
  68     uint32_t mask = (4 / size) - 1;
  69
  70     return *val >> ((offset & mask) << 3);
  71 }

Only guessing, this looks like some hw parity, and I imagine you need to 
write the parity bits in your flash.32M file before starting QEMU, then 
it would appear "normal" within the guest.


