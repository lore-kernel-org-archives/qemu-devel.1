Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF77CC31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924C320896
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/cACQ81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924C320896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMLm-0004Qt-Re
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 05:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52282)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbMIl-0002Y4-K7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbMAG-0008DN-3Q
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:37:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbMAF-0008C7-Sy
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:37:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so17330498wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YtoMxTKdt0kE7R+dbBlp2u4Lrwir2c/VRcNrc3ga4lY=;
 b=P/cACQ81zP0ZsoRg/b+6bp85JSlA3EO3gXGjHwmnAfRz9BiOGpSgINYfr8PRHhV8Wr
 dv8KLulXT4tjjZh13VZ3SjKR6CKIP1vAFDymJ7iET02wNV2XfMtf1OlTPCLEAlbSS6hU
 cnnfBAzAFaxEYw6Luzhovh/ewzESd9llysr1o062GU0E2sXwZv+COHyH2AVmGbmnj/1H
 45Oy8pEIZRT7TYNeUL5/6trCCE0IE68hWb7cLnSTajuzDkwq5fP+j4StDjwTCOThglBi
 fmwU+KcOK8gGtdBdTq5tYrlO7glALdZsVORwSW+946ikbLcCQE0GVJjsByfRGilnoOnk
 a88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YtoMxTKdt0kE7R+dbBlp2u4Lrwir2c/VRcNrc3ga4lY=;
 b=Gj65ezQgME0PTRwXsHcvR+ycgM0BEPvXba2B9JnK4vMuK9zPDmG7scKa8kVXHYIqRV
 VpRMPGlWe2O3kr3ImYjOmNtSyozV5vgBB8WN9++9crO16heq+PFIwtxnmwXlH8ymDtaO
 G9w6HcMico3i5K+60ckW8QE5BpWafDxflsYkATP04s8kCWEZA6uONGPoHwiQpUAR8/35
 RVMk2/IDNZoRlrUQVAIaEdQNAWuSoBH5qmvIwz7UfAulHNx2yiBqnMtTfsC48JCqQrQu
 P9cjRVWHyVPN08AI7iOr3LVnYcPea7LWT2lweHEDgj58HNO8K8Z9vIqnxMLabr8sLavg
 JoEg==
X-Gm-Message-State: APjAAAWQKZE2t1PeVbhmGBlpiniF+/BJwGcd+i0hRl+4UcprzaJlaYOF
 YCFBDPcXXXpODjJfQ+sHkuCIcQ==
X-Google-Smtp-Source: APXvYqyd/my59v41E0k4MljblPFQeC62D3lSXhu10FVA3bFMp+53MxYGrk4yzh7vLDQAFvbrXCPCeg==
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr8870981wre.93.1560418617626; 
 Thu, 13 Jun 2019 02:36:57 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id m21sm2296471wmc.1.2019.06.13.02.36.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 02:36:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8608E1FF87;
 Thu, 13 Jun 2019 10:36:56 +0100 (BST)
References: <20190520124716.30472-1-kraxel@redhat.com>
 <878suo5ls0.fsf@zen.linaroharston> <87pnniemgo.fsf@zen.linaroharston>
 <d32b4c47-4f46-474c-3c4d-54250a29960a@gmx.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kamil Rytarowski <n54@gmx.com>
In-reply-to: <d32b4c47-4f46-474c-3c4d-54250a29960a@gmx.com>
Date: Thu, 13 Jun 2019 10:36:56 +0100
Message-ID: <87muileshz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 00/14] tests/vm: serial console
 autoinstall, misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Kamil Rytarowski <n54@gmx.com> writes:

> On 12.06.2019 19:35, Alex Benn=C3=A9e wrote:
>>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>>
>>>> This patch series changes the way virtual machines for test builds are
>>>> managed.  They are created locally on the developer machine now.  The
>>>> installer is booted on the serial console and the scripts walks through
>>>> the dialogs to install and configure the guest.
>>>>
>>>> That takes the download.patchew.org server out of the loop and makes it
>>>> alot easier to tweak the guest images (adding build dependencies for
>>>> example).
>>>>
>>>> The install scripts take care to apply host proxy settings (from *_pro=
xy
>>>> environment variables) to the guest, so any package downloads will be
>>>> routed through the proxy and can be cached that way.  This also makes
>>>> them work behind strict firewalls.
>>>>
>>>> There are also a bunch of smaller tweaks for tests/vm to fix issues I
>>>> was struggling with.  See commit messages of individual patches for
>>>> details.
>>>
>>> Queued to testing/next, thanks.
>>>
>>> One of the machines I'm testing on seems to have problems with getting
>>> the installer working over the serial link but it works on my main dev
>>> box and others have it working as well so I suspect it might be a local
>>> problem.
>> <snip>
>>
>> OK I had to drop this series due to persistent problems with the serial
>> link on one of the boxes Peter uses to do his merge testing. Some of it
>> seems to be QEMU specific (Ubuntu 18.04 system qemu just hangs) but I
>> suspect there is also an issue with BSDs and our serial emulation
>> generally.
>>
>> --
>> Alex Benn=C3=A9e
>>
>
> What version of NetBSD did you test? There was recently a short lived
> regression in curses(3) that affected sysinst(8) (installer) in HEAD,
> but it was fixed.

The error for NetBSD was navigating the installer which was dumping a
lot of q's in the stream (unicode bar characters?). We were starting
with:

  link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetBSD-8.0-=
amd64.iso"

--
Alex Benn=C3=A9e

