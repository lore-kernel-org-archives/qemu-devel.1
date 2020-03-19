Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B80C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9C62071C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPG1S2WL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9C62071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEz5V-0007M1-NO
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEz4g-0006Rq-21
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEz4f-00007l-5r
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:35:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEz4f-00006f-1e
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584639316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=llJtSNBNCjqQ7s1SODFTSW99imKa53aZMgZTs6ispdg=;
 b=OPG1S2WLp3UeSzg2tQ/Kqk7DAhE/3iyf9A84myZEbkxdvz7XHRv9OcfCYnMEmC5yihCpGp
 b2g4t7nlHgimT2uiVI/SUeCyYrt82D2Hx2CfypisBpWja0nEFHXC7/DkquTOymr2hVmvH7
 00ijZvxQzcsPq4ofE9VJmCpanNvUkQE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-7f0Ftt_mMi-LrRbNMmEYpw-1; Thu, 19 Mar 2020 13:35:15 -0400
X-MC-Unique: 7f0Ftt_mMi-LrRbNMmEYpw-1
Received: by mail-wm1-f72.google.com with SMTP id r23so999447wmn.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=llJtSNBNCjqQ7s1SODFTSW99imKa53aZMgZTs6ispdg=;
 b=VMIPltKfyjMs8n/TA75YU7Sv0Tj+8ayYOEb8O95BiDEn+CKDpWKI9MeCakJA/S7kC0
 Pj6nljFDpnmpQkZL8QD0d0p9NrXUK12i+/vDzl+fY295UJJSjoMsYi+qaRG2IXQDWY2B
 ARSk7Gq1dRXJHKRqnB29QkVDMbp48C0IS0t622fTQdtHm08V1cqgZwtQbeAZxl7TBam0
 oaaIuOvQ4P8Ox+AgAcHwg3ovd0YTd+PAxiFxSCIw4znit845Mwv7G3dPWySFHWNYsyaV
 1PuzWchgYNdrdzFBbTyCQsHpUsgGslVwpQ5dkMiPt3treHPy/UuFFf+7RDx5iZ+4Y+/L
 xSgg==
X-Gm-Message-State: ANhLgQ1AL+aubVnndbVQzthLGcoomZOYd4b3sZ7+8KG9FkRMuAUpqsR8
 W8vpWp/Yi6PC/aJ0Q3SU7Pk+ek3u9/tlsZe1AUk76EbTl3PMisC+14uJ2aA1te+u4DK0FnRSY2A
 H/HfDCQADe/0jbE4=
X-Received: by 2002:a05:600c:2c09:: with SMTP id
 q9mr4763861wmg.167.1584639313599; 
 Thu, 19 Mar 2020 10:35:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvL2v8qADvqJq39O4utNgfsDClXIP2SKi5zmw/iDPIPJXcG0eOvkUx6IZeVk4R2g/kPxVePXw==
X-Received: by 2002:a05:600c:2c09:: with SMTP id
 q9mr4763828wmg.167.1584639313293; 
 Thu, 19 Mar 2020 10:35:13 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id e1sm4539208wrx.90.2020.03.19.10.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 10:35:12 -0700 (PDT)
Subject: Re: [PATCH v2] MAINTAINERS: Add an entry for the HVF accelerator
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200316171825.42544-1-r.bolshakov@yadro.com>
 <cb70fb93-7b2d-b684-c25f-f2fe6774381c@redhat.com>
 <20200319134348.GB77771@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff94d4a9-e793-d911-43c2-e0493aa58e52@redhat.com>
Date: Thu, 19 Mar 2020 18:35:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319134348.GB77771@SPB-NB-133.local>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Patrick Colp <patrick.colp@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/03/20 14:43, Roman Bolshakov wrote:
> On Wed, Mar 18, 2020 at 11:47:15AM +0100, Paolo Bonzini wrote:
>>
>> Queued, thanks.
>>
> 
> Hi Paolo,
> 
> I'm going to send v3 shortly to include Cameron as maintainer.

Okay!

Paolo


