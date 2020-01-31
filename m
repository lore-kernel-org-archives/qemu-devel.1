Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BBBC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 07:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDD820705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 07:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ucqds0ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDD820705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixR2y-0005Sp-Mj
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 02:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ixR2B-0004wD-HL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ixR2A-00039T-GS
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:48:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ixR2A-00037p-C7
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580456888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbjwfHa7qTqPFZE2E9XfvXV33kSfmO4HEe7aw7Zu1pY=;
 b=Ucqds0tiG3RowUA5fAIom9ictwFxumcw9y6iEzutgvkS9EwxM6dqY/9VxjShNDROaRlnvx
 wVu1/fKy0+yvytD19so7zikBaNt+oumBJjAhEzVAY91TkwgbQ/gQm8bk8gKI0MI6vkGR9o
 VDkwGz7VJ97KSVZR1+BO971pIKRW6rM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-SsIDEwn9Pm-w8gGfkMGyoA-1; Fri, 31 Jan 2020 02:48:06 -0500
Received: by mail-wm1-f71.google.com with SMTP id p5so2455655wmc.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 23:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IbjwfHa7qTqPFZE2E9XfvXV33kSfmO4HEe7aw7Zu1pY=;
 b=iUHe24PvR6H2M2IU9O1i85kHdmjJ6rgGgd5+c5uMVHoiBfeZ2dRye2Rtnyh57MmE2H
 hg3fmhVrubOR5MZzxNG/ePQ+yLc5VPyvdvwYUgNzv53irOmm/47Ap1r44y5N9Jbih1FQ
 qOQfgGpYBwzgYMQimnU2IgIp5BBWAwv6WesTieF5qOy71ef1q2Ilg0TqjJYpCWXGymr3
 +vSYZwqN5vkBKBEQVLKdo25VmNJcGYA8G7LW4apUh3siF5VyVl8dPjJRMrstw/z9EedZ
 R/ILnZt1MO08bncm8qQgFLjaE+zx5TWVLSWdIhcAuh2AlDfK+8WiiolE3A9VPLVp+mGl
 3oPA==
X-Gm-Message-State: APjAAAU54OIiNM/1dY2f635oi/55oj3TvO8a1EBkjYsziUNAn/1lbwoO
 NhcjpP/PxPqk0RmJVASBCu0wpDdCGIdAyhnIYfF5GnBOmBWQvfkFupyYwJSyzHQqyDtNVH4WdAX
 eMwIg+MNQRiff33Y=
X-Received: by 2002:a5d:5091:: with SMTP id a17mr10317349wrt.362.1580456885723; 
 Thu, 30 Jan 2020 23:48:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3Lnds/IrYjNY9zkuo6AbaoqBGWjcrg7bp39k1MzXCDj8iGGpzqSCslCYBMrHLf8Iu7wj0eQ==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr10317326wrt.362.1580456885490; 
 Thu, 30 Jan 2020 23:48:05 -0800 (PST)
Received: from [10.1.251.141] ([80.188.125.198])
 by smtp.gmail.com with ESMTPSA id z19sm9178597wmi.43.2020.01.30.23.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 23:48:04 -0800 (PST)
Subject: Re: Making QEMU easier for management tools and applications
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org> <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org> <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
 <20200128102855.GA6431@linux.fritz.box> <87mua7bvwf.fsf@dusky.pond.sub.org>
 <20200128125409.GF6431@linux.fritz.box> <878sloi0fp.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e52f0561-5094-cacc-846e-086bad840f56@redhat.com>
Date: Fri, 31 Jan 2020 08:48:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <878sloi0fp.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: SsIDEwn9Pm-w8gGfkMGyoA-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/01/20 07:50, Markus Armbruster wrote:
>>> Consider chardev-add.  Example:
>>>
>>>     {"execute": "chardev-add",
>>>      "arguments": {"id": "bar",
>>>                    "backend": {"type": "file",
>>>                                "data": {"out": "/tmp/bar.log"}}}}
>>>
>>> The arguments as dotted keys:
>>>
>>>     id=bar,backend.type=file,backend.data.out=/tmp/bar.log
>>>
>>> Observe there's quite some of nesting.  While that's somewhat cumbersome
>>> in JSON, it's a lot worse with dotted keys, because there nesting means
>>> repeated key prefixes.  I could give much worse examples, actually.
>> This is true, but even without the repeated keys (e.g. in a syntax that
>> would use brackets), it would still be unnecessarily verbose and
>> probably hard to remember:
>>
>>     id=bar,backend={type=file,data={out=/tmp/bar.log}}
> No argument.  It's unnecessarily verbose in JSON, too.
> 

I think we should be able to switch chardevs to -object/object_add these
days.  Not right now, but it may be possible.  Introducing a warning
when chardev and object ids conflict would be a start.

Paolo


