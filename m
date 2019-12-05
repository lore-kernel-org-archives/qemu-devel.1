Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA755C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9D020801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcYAfUOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9D020801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icudB-0007wL-AN
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icuYv-0003pc-Jh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icuYp-0000Mm-Vt
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:05:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29012
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icuYn-0000Eg-Kw
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575565499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDS/cdq022vMoC6K5EUhpk7pDrZi5HIxSyoKSYWlXxY=;
 b=UcYAfUODwsKpQU3MUv2cJN4tIOMdEB1s0Oe7I7JESFz1eWfJbMC/UGHGpD6XNwtrrLLQ+E
 9x/mAS2MrlPiNJpbeWDh69IVKSCAiQWvftnv0bA261tqdzC9wYXW5Qjgj4oB3eS9HJKwmx
 KwCNIo3aCFQn+v5oUxxUwaJHhdQa8s0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-AwqZs-j_OcWcW8IgGWi-LQ-1; Thu, 05 Dec 2019 12:04:55 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so1816822wrh.5
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 09:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HmeiVovzN20Mo/lqF0NKn9XWTcz3qzefoH/+i+XhumE=;
 b=qUZixm5uuc8mKvdHIVPspOKgA+LFA5pXa/ZqybM69misHVHH+0A6bISgUWiahr3vIA
 t2XXa/gaS4rt0W2/PwZ76Q1SjBuQ2eCyc0nrjv09wlm1t8ERKYJNlTxBRTgVA+Yeq8Ba
 tk3H4o1aLyvTzQJi0d1eahxmvOyVZOZXR2cG6KRWBDdxKk3Jx+UiN3wTbFkyp6YZXJA+
 r2+H8RxWyD+5Wy/kBOkpE/x7Ieyh7wpULcU9JT+v+E0HMu0xYxiLWTIp2iHqk7Kgh8hI
 lzFBxktbeyJMgfhtC1ernToiMiW2peFbplrze6HAkKR4DdIxt7QOWh9f/PHMm2mPn7m+
 a0eQ==
X-Gm-Message-State: APjAAAUgK7kPm8gI/pLwLNeMpTUcXh3c62VJquWrRZ4SrBqeULdwZ5Pz
 TJtKFtIaQa7jCGFN6BM/dAOBiMLsb6tF/u0hmR/p18ouBkaspmKjqVb7U1RjxvsZTUOasysWjI3
 Tdoo1ZDsOOLGQ9W8=
X-Received: by 2002:a7b:c761:: with SMTP id x1mr6142123wmk.37.1575565494561;
 Thu, 05 Dec 2019 09:04:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWLNi6h5wklywiC9hc+xVV4FmMxAA1I35yaAaAmDVkWi4tyCMm1Z/XQfdL5M4UIwdejv4l7w==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr6142098wmk.37.1575565494377;
 Thu, 05 Dec 2019 09:04:54 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id o21sm425825wmc.17.2019.12.05.09.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 09:04:53 -0800 (PST)
Subject: Re: [PATCH-for-5.0] roms/edk2-funcs.sh: Use available GCC for
 ARM/Aarch64 targets
To: Andrea Bolognani <abologna@redhat.com>, Laszlo Ersek <lersek@redhat.com>
References: <20191204221229.30612-1-philmd@redhat.com>
 <ecbb6c69-1fc1-a730-db9f-656b0a82c3fd@redhat.com>
 <90b6b303-2cb7-aeea-8f10-8520de2511c6@redhat.com>
 <ea6fdfcaef35ed6571c4234b9400a75b429c72ac.camel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f5bafdb9-137d-a77e-edc3-dd61d669cdee@redhat.com>
Date: Thu, 5 Dec 2019 18:04:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ea6fdfcaef35ed6571c4234b9400a75b429c72ac.camel@redhat.com>
Content-Language: en-US
X-MC-Unique: AwqZs-j_OcWcW8IgGWi-LQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 5:47 PM, Andrea Bolognani wrote:
> On Thu, 2019-12-05 at 17:27 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/5/19 5:13 PM, Laszlo Ersek wrote:
>>> If that rules out CentOS 7 as a QEMU project build / CI platform for th=
e
>>> bundled ArmVirtQemu binaries, then we need a more recent platform
>>> (perhaps CentOS 8, not sure).
>>
>> Unfortunately CentOS 8 is not available as a Docker image, which is a
>> convenient way to build EDK2 in a CI.
>=20
> Uh?
>=20
>    https://hub.docker.com/_/centos
>=20
> seems to disagree with you. Is the 'centos:8' image not suitable
> for some non-obvious reason?

Eh, last time I checked=09I had an issue with docker, it was working with=
=20
podman but CI don't provide podman.

I tested again, and now it seems to work, I'll give it another try.
gcc-aarch64-linux-gnu is still older than GCC5 although.

Thanks for the update :)

Phil.


