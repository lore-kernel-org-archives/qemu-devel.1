Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B40EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A0D214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSBvcWkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A0D214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifCPN-0003C2-Uz
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 19:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifCNO-0002B3-DW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifCNM-00071j-Ra
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:30:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifCNM-0006zL-NO
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576110639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Vr9P5A9kEqsqd1Xp2S9A6iF1BZr0AEVVajoJo+Xies=;
 b=VSBvcWkdWlN26B/H6pfVBL/9AX++28qUXrZnzWwbDzQsC5YF9VMojUIUWmmyIxPgT9Umdu
 4/Pn9eWciE9YQ55vKp/VWj1mRm3eXyVxolFL3Zyc2+EEEPCHxCoC6MkabNgzy/oKjzSJ0H
 N/TacLNgwTx4j7Rni6xDwS2B8z5rHTg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-nl_F9ztnO3KfOur9Ug5X5A-1; Wed, 11 Dec 2019 19:30:36 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so301981wrm.16
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 16:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IJTH2QxuZCyLNMte321Sg7VZjmcyryFyDnBE1XiL3w4=;
 b=rM+BcCOZaTKD2rV7Zky+5LaNsvLaCrvzl8QzQIlr+OdYUX6Km5xsUlGY4T3LJIl3Wc
 1XZUcgzWPMDJoJ+9ISRXg8OHWBa9WrFe6gx657tALP28bK6j4BnRag1JQEo0ovNwalcn
 s6rsuJyEIFf8PStUCGJWRaqFhHEh1qioy2bmAd6yt3G6/AG3F2UHv+yh7rOhx4aH7rxE
 8Kxr9S9ZZWtaqv3dYBnn9JIuFf7+GNassozJ7gTOSGw41J00MXTAKi1mw/0GJ3eaOKWs
 1FmWXioJy2Hyx0ffOAilLAkJdC6SEA4SZTWHLi0o6PSP5Q1EwdcX2GVCg6j89vaBxIAu
 zXMg==
X-Gm-Message-State: APjAAAWXzw3BKMGgcezj8RqB4fNIZmC8B3onkAzGq42svRP6ztuBFmgN
 1aq0yGyMu0/fKCzXRHugxdpIjacCeTEqYT/WJHd6zalg37c3HGR7V1afl3Rbzmp17EMKD+hiC9f
 GW2HoV5ag65z9uX4=
X-Received: by 2002:a05:600c:2101:: with SMTP id
 u1mr2955728wml.43.1576110635563; 
 Wed, 11 Dec 2019 16:30:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzuqULwt3cl9UYWfGHw0r3Y1tefmNmu5yI1Bgdjt+/9tSLIkgjuHUqoBGu7b0/LYx3s/vUoQ==
X-Received: by 2002:a05:600c:2101:: with SMTP id
 u1mr2955707wml.43.1576110635336; 
 Wed, 11 Dec 2019 16:30:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id x17sm3756838wrt.74.2019.12.11.16.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 16:30:34 -0800 (PST)
Subject: Re: [PATCH] configure: simplify vhost condition with Kconfig
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1576074296-53617-1-git-send-email-pbonzini@redhat.com>
 <05e89669-dd8d-a6e2-a41a-57391ba6b1d5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9da8528-5542-9017-6ae0-0e3db3812ee3@redhat.com>
Date: Thu, 12 Dec 2019 01:30:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <05e89669-dd8d-a6e2-a41a-57391ba6b1d5@redhat.com>
Content-Language: en-US
X-MC-Unique: nl_F9ztnO3KfOur9Ug5X5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 20:38, Thomas Huth wrote:
> On 11/12/2019 15.24, Paolo Bonzini wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  Kconfig.host            | 5 +++++
>>  hw/virtio/Kconfig       | 3 +++
>>  hw/virtio/Makefile.objs | 4 ++--
>>  3 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/Kconfig.host b/Kconfig.host
>> index bb6e116..55136e0 100644
>> --- a/Kconfig.host
>> +++ b/Kconfig.host
>> @@ -25,6 +25,11 @@ config TPM
>> =20
>>  config VHOST_USER
>>      bool
>> +    select VHOST
>> +
>> +config VHOST_KERNEL
>> +    bool
>> +    select VHOST
>=20
> Don't you also have to add it to MINIKCONF_ARGS in the main Makefile??

Yes, I do.

Paolo


