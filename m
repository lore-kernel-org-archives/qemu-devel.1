Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A301C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F802146E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1Xt9iaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F802146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVOB-0007yM-42
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioVMv-0006dj-Ch
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioVMt-0004HM-Vy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:36:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioVMt-0004GT-S1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578328598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0blC2g41qc6jf6yQhJLvwZ/gkOMm5mH+yWeZc5WWkbc=;
 b=d1Xt9iaRQN4ed6QoWcH/RNay3TRZO+kvr7eGnSNroIZunpXkXygKsJgfbYAQO3HxeBZiju
 vNNk4+y0HeiRVtBWjshCGsuh2ErB/V9IpGBd103fngxLGAhVVf6zCUziMCNXAtiXbzr2or
 W7fIpRqyu9hguXQuj/cFdVeGCdP+lS0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-AmY2iVXMO9Sjcn4IpssmaQ-1; Mon, 06 Jan 2020 11:36:37 -0500
Received: by mail-wr1-f72.google.com with SMTP id h30so18579043wrh.5
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 08:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MY9sljiDNM4Ih//dCNSRNDlHAjYNfvOEdQ5FMq5WzfE=;
 b=VLnahOu+M/17r56ObNynudoR7qcwxmL10LzwQywNdaVtw4KAc16NGuaRcJsX5ngLR0
 j1y+928piW2cIgaI3RtDdKEfvSpd8PFjtRMKpko+SmjwLGD6V4zu/oalJgPAkvMTK/36
 kC2MJCQmk4SVYhU0s769LgT5yYVS0DCsIorAyu5nJxe0QNsh1c+ZbEA/Q8iFVXWOe8gG
 siIvSp2b/2QH8Bzs45Bi1ErGHHXQLj8/Z1iAQQ+lX6rEXYm+NufCa6s05PXj1Jysp7+Z
 Saq/H6TCLRPFE0ssYFyc56WyD2goJJWTTdjyvqgynPvUgtVt+Yp43pf1M7vt6VUjmTAZ
 vGYQ==
X-Gm-Message-State: APjAAAUlj92GvsVb6xVEltMawgq9KwejI+4kWNvBeUDenAAx3chF8ju7
 MJdwJmqqJ6wwnlIrZOvrS+onJYI7FVjUzhKGnmiBsvOaKsEUVmJ+4ANV5YLA3JPHRRo4j6kitkF
 uAjKvdFpIYouyrU0=
X-Received: by 2002:adf:eb0a:: with SMTP id
 s10mr109197968wrn.320.1578328596601; 
 Mon, 06 Jan 2020 08:36:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwtNIwXn97q82TCs192emBgxYffFw1PGlw2mracuRU+PplrVs8fNuQ9/2GbOtTCxkNtKtFvxg==
X-Received: by 2002:adf:eb0a:: with SMTP id
 s10mr109197939wrn.320.1578328596387; 
 Mon, 06 Jan 2020 08:36:36 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id a5sm23568558wmb.37.2020.01.06.08.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 08:36:35 -0800 (PST)
Subject: Re: [RFC PATCH 6/6] hw/arm/cubieboard: Disable unsupported M-USB in
 device tree blob
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20191230110953.25496-1-f4bug@amsat.org>
 <20191230110953.25496-7-f4bug@amsat.org>
 <CAFEAcA_MTPuvHvijgeFkeLu2e96Tn90iAop0Lp5eER=7QnU_Nw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <092926a0-cc84-a9b4-4e7d-61219388a6f5@redhat.com>
Date: Mon, 6 Jan 2020 17:36:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_MTPuvHvijgeFkeLu2e96Tn90iAop0Lp5eER=7QnU_Nw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: AmY2iVXMO9Sjcn4IpssmaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/6/20 5:07 PM, Peter Maydell wrote:
> On Mon, 30 Dec 2019 at 11:10, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>>
>> We do not model the Sunxi Multipoint USB.
>> The Linux kernel OOPS when booting:
>=20
>> This is not critical but confusing. To avoid the Linux kernel to
>> probe this device, mark it disabled in the device tree blob.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> I'm not sure if this is a QEMU anti-pattern or bad practice.
>> I know we prefer to be as close to the hardware as possible,
>> but here the hardware is not changed, the dtb is. However
>> this makes the guest behave differently. At least we don't
>> have to manually edit the dts. If this is only annoying for
>> acceptance testing, we might consider manually editing the
>> dts in the tests setup().
>=20
> In general I'd definitely prefer it if we avoided editing
> the DTB for things like this (we have very few boards that
> edit the DTB and none of them do it as workarounds for
> buggy/missing device emulation).

Yes I understand (I was expecting this answer, but better to have it=20
explicit).

> Is it possible to have
> at least a dummy implementation of the controller that's
> enough to make the probe function fail more cleanly?

Niek gave some pointers. Anyway The kernel is not crashing, it is just=20
oopsing, so this is not fatal (the VM is still usable).

Thanks!

Phil.


