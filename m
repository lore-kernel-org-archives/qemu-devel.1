Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F6C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9A72072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyiH6jk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9A72072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTDF-0006pE-1s
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isTCZ-0006P8-UU
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isTCU-00042X-Pk
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:06:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30064
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isTCU-00041v-M9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579273577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYxeoDir4Ru9mpoKATkoReM2kD3XFbNmjiGoEvtfgqw=;
 b=IyiH6jk50QU4QgiCMt2NwQWnNFmDdeBzIROVjxmur5mUVITkD8kZNM/noRP5p4dMpq7Or5
 2ruNUAQK45T4n1GHq52Xkx0r4NH7R7SdDAhIIFGkU7BKOUkTsjKTPX4smiMm2qykC/MEvx
 F/m0ubMEPsDmP9d5v4Y5Cbf9LhwYOrI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-PyrRilV2PPKg4FvWCyS_BQ-1; Fri, 17 Jan 2020 10:06:16 -0500
Received: by mail-wr1-f71.google.com with SMTP id z10so10535852wrt.21
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 07:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BYxeoDir4Ru9mpoKATkoReM2kD3XFbNmjiGoEvtfgqw=;
 b=tzwSx9U4YaZk6mKgdqsB/fS/EDYATWhAkRf8ntxpiZSDrbBqKq0QZmhIl7o1Ta1FHx
 dispSXgNkJaNolxVSmCDTxvnwUgFocve2fUuy+XwgpCZJHdWA7y3Cbs51B2Sf9CAWf9Z
 +XsADf+bpMk95BWfC28yhKxK6Io6DSDC7jJ/Yk5ypjfxN4HknQNnzKTvi+3oYRjjrGLw
 NUdw5ZQ1Vocx6bjSVscvIGMKN10rsbXXBXJ1kGFGw7RPJgEKaanCnyBr4CcVRWVDcjAz
 noFCtLw3qdh9IvWqmUq5Zuj4jxlGOElkRAxWB3bqWtAx7u1yx5oS4PxKODvQKW9lykp0
 ykqg==
X-Gm-Message-State: APjAAAWOxpBalsQGqs9papC6FPUxkXD4weXyP5P+K6GCHlufucyWMa42
 1+aMHSyZBMf9EJlqqS+FInoBMu1VHEyRe57EAXjunIqLu1OTVuZOAlWdhblKv/QjxzmjONcA1tZ
 5kKSisXDaluW85gc=
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr3519728wru.112.1579273575278; 
 Fri, 17 Jan 2020 07:06:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQgcje2JOFR48PT0IOaXFIOU8MLrrgA5y4N4k+X017+YZ+BA4E/fLMbiNylqi1M2yTlQp0Sw==
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr3519710wru.112.1579273575026; 
 Fri, 17 Jan 2020 07:06:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a?
 ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
 by smtp.gmail.com with ESMTPSA id z8sm33961444wrq.22.2020.01.17.07.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 07:06:14 -0800 (PST)
Subject: Re: [PATCH v3 2/2] vhost: Only align sections for vhost-user
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200116202414.157959-1-dgilbert@redhat.com>
 <20200116202414.157959-3-dgilbert@redhat.com>
 <4bf72509-3e60-0d78-c2ba-665a71a978e1@redhat.com>
 <20200117083232-mutt-send-email-mst@kernel.org>
 <ca54fc82-828b-158b-fadb-07abfbb9418f@redhat.com>
 <20200117092147-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b94df6a-9d7e-da7d-03b9-0f06b66a7936@redhat.com>
Date: Fri, 17 Jan 2020 16:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200117092147-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-MC-Unique: PyrRilV2PPKg4FvWCyS_BQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: jasowang@redhat.com, vkuznets@redhat.com,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/01/20 15:25, Michael S. Tsirkin wrote:
> On Fri, Jan 17, 2020 at 02:58:47PM +0100, Paolo Bonzini wrote:
>> On 17/01/20 14:40, Michael S. Tsirkin wrote:
>>> We don't really need v2 just to add a field. Compatibility is maintained
>>> using feature bits. Adding that is a subject for another patch.
>>> But I'm not sure I understand why does remote need to know about alignment.
>>> This patch seems to handle it locally ...
>>
>> Because the remote vhost here will not be able to use the synic regions.
>>  If it did, it would have the same overlap problem as vhost-kernel.
>>
>> The alignment is needed because, even if you are mapping only [768k,1M)
>> of a 2M hugepage, you need to mmap [0,2M).  You can then discard the
>> rest, but IIUC if you only mmap [768k,1M) then the kernel will fail the
>> mmap.
> 
> So right now remote will query the fd passed to get the alignment.

It should, but will it?  It's not in the spec and I assume QEMU is doing
this alignment work because some server is not doing it.  But indeed we
could use a feature bit to say "don't worry I will be doing the right
thing".

Paolo

> You are basically saying it's not enough in some cases?
> 


