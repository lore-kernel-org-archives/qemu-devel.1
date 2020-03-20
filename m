Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F862C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD10720739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtpM/XHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD10720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKGY-0000lx-1P
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFKFY-0008OE-Uy
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFKFW-0000KK-Sy
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:11:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFKFW-0000II-Ii
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584720714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vi2+cUTplQIsxcHlwT6pFwDKhGO0poN2Scs6THzliaU=;
 b=gtpM/XHnWZPsnP80iJCVA4B6wS+eHveYDptRhi20nS5EBFSLj2GteNpDouV/8ni/635H2y
 SluE08H0xh2Me4jiGTvGrCuFZEE8/X2viLHVDHFyWRNcDHDqYooTvW8OlP7ouH8SpINYSX
 iBDARS4SXhQjZMgONByNN2D9cvsB2Gg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-ciZEYqauMsG8pryMWRuqwQ-1; Fri, 20 Mar 2020 12:11:37 -0400
X-MC-Unique: ciZEYqauMsG8pryMWRuqwQ-1
Received: by mail-ed1-f70.google.com with SMTP id u1so5447732edr.4
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vi2+cUTplQIsxcHlwT6pFwDKhGO0poN2Scs6THzliaU=;
 b=rnQI33gJ9qDCyE+1Hwjika7cNlnTztDKrkmsSJJFeoL0IWy1iCnNo9MkFOR4uHYQVV
 WkCCseQ7WVDY+wwu647V62HCtK75wX7CLpWcrZK9onC2Bt/64X5EYgNGT2OmykfJX2zW
 f3t3gRJs+hf4JunLSZywAuFHqcvtopKxRlern5C3Vl6V9HJcuZ6MPm6+WZfiAKk3+YIq
 /8Sd94ee7Ireuw8RC5jO/gXhHBNGD95KJ1HfWapz0sbG7xj/NAysO8aCjx35ks8OjU9E
 HpjvULthcwnyQdkx/idwKg772AWnVUtUs7BvxsJ2PhYFvUMAYG90nazE9Hav/DVIiZ93
 ouSg==
X-Gm-Message-State: ANhLgQ0xItrAs7/eRBnLdN1EQ9ZQZuejBHGfN7XD+qTUT+sv0LcDUJ+4
 tP79NLErUnv8Cux6LMHODCEHce0DvUSBRiEZhb1kbsxVE93nge/yb7tVeIXMMsmTcoIG5zN05XT
 gcoHDtYxYN1wuPJg=
X-Received: by 2002:aa7:d683:: with SMTP id d3mr8503203edr.321.1584720696377; 
 Fri, 20 Mar 2020 09:11:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv+zD6mfOpj+cTUKOEr0jPp/plcv39swsn1GHtT0+FFf48ou2NwjivecUnksP1dgbyhElsK8g==
X-Received: by 2002:aa7:d683:: with SMTP id d3mr8503171edr.321.1584720696081; 
 Fri, 20 Mar 2020 09:11:36 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id d4sm423499edt.28.2020.03.20.09.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 09:11:35 -0700 (PDT)
Subject: Re: [PULL 0/4] Python queue for 5.0 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200318011217.2102748-1-ehabkost@redhat.com>
 <CAFEAcA_6i1ponfRK6vUA_KCz_F=2c886CPQNKE8Kn4SifaRRxw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae222b3b-04ef-7dc7-4560-2e24d32b69b5@redhat.com>
Date: Fri, 20 Mar 2020 17:11:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6i1ponfRK6vUA_KCz_F=2c886CPQNKE8Kn4SifaRRxw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 4:59 PM, Peter Maydell wrote:
> On Wed, 18 Mar 2020 at 01:12, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>> The following changes since commit d649689a8ecb2e276cc20d3af6d416e3c299cb17:
>>
>>    Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-03-17 18:33:05 +0000)
>>
>> are available in the Git repository at:
>>
>>    git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>>
>> for you to fetch changes up to f4abfc6cb037da951e7977a67171f361fc6d21d7:
>>
>>    MAINTAINERS: add simplebench (2020-03-17 21:09:26 -0400)
>>
>> ----------------------------------------------------------------
>> Python queue for 5.0 soft freeze
>>
>> * Add scripts/simplebench (Vladimir Sementsov-Ogievskiy)
>>
> 
> 
> Applied, thanks.

I guess there was a mis understanding with Eduardo, he was going to 
resend this pullrequest due to:

ERROR: please use python3 interpreter
#21: FILE: scripts/simplebench/bench_block_job.py:1:
+#!/usr/bin/env python

This was replied on the series cover:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg690373.html

Can we apply Vladimir directly patch as a build-fix on top of the merge 
commit 3d0ac346?
https://www.mail-archive.com/qemu-devel@nongnu.org/msg690385.html

> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
> for any user-visible changes.
> 
> -- PMM
> 


