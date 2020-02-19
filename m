Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A66C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938A22176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcjUbfVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938A22176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Q0U-0007SC-R1
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4Pzi-0006A6-JK
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4Pzh-0003xc-J7
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:06:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4Pzh-0003xJ-FA
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582121188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfmkL0gZhjyWIvC5i+PLRpP20pvIBHPE9rw6j4CBAYE=;
 b=AcjUbfVJltfuT67/Anh0e+nWq4qm45n5kPa9c64FYsX/uJ2ocCq9YYG/KrodY0u2iBQTky
 OhmTkTmoC3a5L4vXZ0dfkx6ORkUHYvaxkFRR1hZEpiQDSDypORW8m1IN7FUCte+B/J4aiD
 vD6uammhpcmAYzeSRv+4V8qSxflx7D0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-VBr-3b2_POiTgMkbsG6JGw-1; Wed, 19 Feb 2020 09:06:26 -0500
Received: by mail-wr1-f71.google.com with SMTP id l1so108182wrt.4
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 06:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ro2XegLXeefIG2q8mBH68H69OIBwTGs7JRtCzLjFCNw=;
 b=IN9gROfJ+7k5dKzWJ7M0hoHzgmLKCdB3Ft4SvJSqWJiWgWaKxdug/UAuLpbGJ64wKy
 9FEcPnzKLTTOjCsFSa+VPHGeu8PwUYlWthsNvcq/jiDL1y2X2rQLCto8kmaDIQHj3htI
 SWQUm0CVKEJLtX5ig8lkq/5yZesbrfrivIuQfqlwZas2D2mqWIoNwmHxNUM0OzqxngRw
 yabM4T6V4Gp8SpOtBg+LlNRgczVwE8p6gzai61+RYP/JtditnSoDN48Q46vKqliB8If8
 QUCmADM33EmYVs9Bodhx/huPhBuEcPuKtBG17kBHI1Xts2q6MiKlvz3tjie8lcLujPNq
 oGGA==
X-Gm-Message-State: APjAAAX28/hFddeuvpavbqyaeBuATWvsz1WVxgq8buUAEGShvcm+NmVq
 A30O+hveT66+/KoFrh/McS2Frs1GQ6KJKbYNOcsCToqxODqln0hcR+kPlsCeyDHEhTTXsgOPDQd
 tktZinGpOAs00CgU=
X-Received: by 2002:a1c:a74d:: with SMTP id q74mr9719707wme.152.1582121185362; 
 Wed, 19 Feb 2020 06:06:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGCCFonsD4CRdIIwD40sfs0XlmEf95ow3h7dnf0KnhFriVOtAuNnLxCjILQ3rFekFG15i9kQ==
X-Received: by 2002:a1c:a74d:: with SMTP id q74mr9719696wme.152.1582121185181; 
 Wed, 19 Feb 2020 06:06:25 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v17sm2970570wrt.91.2020.02.19.06.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2020 06:06:24 -0800 (PST)
Subject: Re: [PATCH v5 79/79] tests:numa-test: use explicit memdev to specify
 node RAM
To: Igor Mammedov <imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-80-imammedo@redhat.com>
 <1da9a872-dd64-dd1d-7858-caf263631484@redhat.com>
 <20200219140030.4e68d053@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a384bc9c-44bc-268a-5a0f-63bccea1542a@redhat.com>
Date: Wed, 19 Feb 2020 15:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219140030.4e68d053@redhat.com>
Content-Language: en-US
X-MC-Unique: VBr-3b2_POiTgMkbsG6JGw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 2:00 PM, Igor Mammedov wrote:
> On Tue, 18 Feb 2020 18:51:34 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 2/17/20 6:34 PM, Igor Mammedov wrote:
>>> Follow up patches will remove automatic RAM distribution
>>> between nodes and will make default machine types require
>>> "memdev" option instead of legacy "mem" option.
>>
>> Can we keep this patch for the follow up?
> memdev for numa was there for along time, just untested.
> With this all numa tests switch to it instead of using
> legacy option (+ a test for legacy option).
> I don't think the patch should delayed along with numa
> cleanups.

I guess what confuses me is "Follow up patches *will* remove..."

>=20
> It of-cause could be posted as standalone patch as well,
> I'll leave it upto Paolo whether to merge it or not.
>  =20
>>>
>>> Make tests to follow new rules and add an additional test
>>> for legacy "mem" option on old machine type, to make sure
>>> it won't regress in the future.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>
>=20


