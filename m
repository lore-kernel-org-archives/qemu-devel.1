Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08F5C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD4820659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZmUGHBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD4820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFoK-0000mt-OK
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEen-0002Kp-3n
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEel-0008VE-Up
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:32:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26949
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEel-0008UJ-PF
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fr61vwBScbXM6IsyJi3J9YGGV9HMgJOz47c5PUdZNmA=;
 b=HZmUGHBhU/3deXJzRu8YI/uwBVDFRbIn+NSwgp7tFFxWDc4ddCjstKDk2VfWqUgSItHjHM
 wo4USLSdMtjlWpGEZYMRbu6X3AJl4g6noLIjoy3U7H57LJPZg+7UMMZxvnJrrpB2dRuyOE
 F8aY+r83s20II55VWGvC4SkjjG+S18E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-eqWUeaGAOomOc3NvwC2JeA-1; Fri, 06 Dec 2019 02:31:31 -0500
Received: by mail-wr1-f69.google.com with SMTP id z15so2791490wrw.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 23:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fr61vwBScbXM6IsyJi3J9YGGV9HMgJOz47c5PUdZNmA=;
 b=QIJU0nTd5UFBXAnu3F0u8a+NcbypjHAfebvZwHvwfF0yQFjVBj1r66ergXfRBY9Jm4
 +BFvUWbL4SkqA7kD1ybWx2RkPfQj98RHq8pc5fgEw9TZ/tvh7sTFjNAMnsGW254KAKXc
 ioykV+kxRPMUC7qNY/ABlMpqm8v/dd5jvFscLPHwbeyXmSNjcJln3/2Kj+Q69ufPngz6
 cTUE7uWv0SwzuHmYIId0/TuBBizLd+3nQHHoA9sEowYsXG8PWYDBXValXxL1k5k3i0YB
 ukEclOtzJiJ1imIZyrswWw7K1HmeZKVCul1FqpZY5Xl70V5Qh1ncS1FNVYeG7Uaf0Zez
 Xgig==
X-Gm-Message-State: APjAAAXpMDcgSQsfv/PzXPi4NB74eLr081qVY+vwygEVE3enMrwtG3/q
 adzHnicHSIQeyvKJVwzRNwBX3gkLVZT0K4E+NLvEvWGVo/Y4wEw9UuxqAt+59JMsMU8D0zk/pOB
 dUGEc5Yp4YrMENbY=
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr9105731wma.134.1575617490711; 
 Thu, 05 Dec 2019 23:31:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqynS+fnuP8i/QHDvvcOrjTLdFtywSP3F2asY8c8z9hx5UqaYPvCQn0ygG1Gd/UeZyYzP7+bwg==
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr9105719wma.134.1575617490560; 
 Thu, 05 Dec 2019 23:31:30 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id o189sm96435wme.29.2019.12.05.23.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 23:31:30 -0800 (PST)
Subject: Re: [PATCH v8 06/21] qdev-monitor: well form error hint helpers
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-7-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4f1c7766-d5f9-c8d4-931c-9db5624e661d@redhat.com>
Date: Fri, 6 Dec 2019 08:31:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-7-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: eqWUeaGAOomOc3NvwC2JeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, armbru@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Make qbus_list_bus and qbus_list_dev hint append helpers well formed:
> switch errp paramter to Error *const * type, as it has uncommon

"parameter"

> behavior: not change the pointer to return error, but operate on
> already existent error object.
> Rename functions to be error_append_*_hint.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


