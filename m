Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65FAC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9652A215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYK0yt77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9652A215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb7IB-00017l-83
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hb7GZ-0008Gj-Vn
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hb79R-00012j-1Z
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:35:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hb79P-0000yX-3H
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:35:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id g135so7422017wme.4
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=h6hMh1H3+Cik9IScoFVP4h2PDH2sp5ATEjjRCx+Wejs=;
 b=eYK0yt77tkM+WT1YW/O9boJXq3UteCIO7ZSHTcfMESVXXdw8PyqjwCKobGwhmPHQni
 DRnbQEvKEik6uUxm7kSaxhZi1Z+JeDdwPOV97/jK1Uen+c796Es8eAHsPrAW85yDMl0y
 YIcBlj115M6Mr1A0PEuaJmS2I9ExUiPGs05/nqScIBYBUUmTHi9d+Iw6yl3VSHcxDj6s
 CjC0D/xFuiF3509+eeYtgd2bEU1YwUQ2c7umC4YkAViWybBv54jJPh76ftZgZlTJMdza
 s7wjD0mLOfN3PhKAyLfy9t9daj9FxYqn3nktqBTDe38Q/l55gg5FOXUdB6qN/aPYTwIt
 nQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=h6hMh1H3+Cik9IScoFVP4h2PDH2sp5ATEjjRCx+Wejs=;
 b=sd+aetKm0uWkjoNBuneS0bn8puU8YTsr1kWm2ZEY9IkvtryehCCW9sbaTlZC6tUBki
 eDr2vJNY6WOw3RZn9ZqDnyk0eKB5cwqP8+v01pWg2rlmHBtyFgKb/6rjCK9VWGFnpMLV
 r/zGu79iVAVFmidXB/wM6IU4E2H8OcFSFb8VhE55/d3XbMZ7I4O4DwEmvw2bWM2yubAc
 J9FtRJm13uckKK+/RWd7yWFTzuzON8YEmrYT0xZ5uSV1TzXvlAwbDubE2LPLCbc8I0ZT
 DUQnOKHp0iO1bMdGY/zpxVTjH6PDHVc37uL/mPjrZtOyRz9dCVeUnVWDo9rVHXzZHYJD
 xyKA==
X-Gm-Message-State: APjAAAVQf0wfXcNzw4pUKaOnrXpEOrpLDeRgpuZiDIHk12pV+zQecOZV
 HBbnQhJkT2Rcc4bL94agR1BfoYq6zeo=
X-Google-Smtp-Source: APXvYqxhGkmQETlrvH3+oWSt3nsfDs1M6QAu+LBZ0za4TcQ66Qiy2TjJ3OZQuoOovhTEulso8QfzVg==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr271440wma.100.1560360905151; 
 Wed, 12 Jun 2019 10:35:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 32sm452836wra.35.2019.06.12.10.35.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 12 Jun 2019 10:35:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CCE721FF87;
 Wed, 12 Jun 2019 18:35:03 +0100 (BST)
References: <20190520124716.30472-1-kraxel@redhat.com>
 <878suo5ls0.fsf@zen.linaroharston>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <878suo5ls0.fsf@zen.linaroharston>
Date: Wed, 12 Jun 2019 18:35:03 +0100
Message-ID: <87pnniemgo.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Gerd Hoffmann <kraxel@redhat.com> writes:
>
>> This patch series changes the way virtual machines for test builds are
>> managed.  They are created locally on the developer machine now.  The
>> installer is booted on the serial console and the scripts walks through
>> the dialogs to install and configure the guest.
>>
>> That takes the download.patchew.org server out of the loop and makes it
>> alot easier to tweak the guest images (adding build dependencies for
>> example).
>>
>> The install scripts take care to apply host proxy settings (from *_proxy
>> environment variables) to the guest, so any package downloads will be
>> routed through the proxy and can be cached that way.  This also makes
>> them work behind strict firewalls.
>>
>> There are also a bunch of smaller tweaks for tests/vm to fix issues I
>> was struggling with.  See commit messages of individual patches for
>> details.
>
> Queued to testing/next, thanks.
>
> One of the machines I'm testing on seems to have problems with getting
> the installer working over the serial link but it works on my main dev
> box and others have it working as well so I suspect it might be a local
> problem.
<snip>

OK I had to drop this series due to persistent problems with the serial
link on one of the boxes Peter uses to do his merge testing. Some of it
seems to be QEMU specific (Ubuntu 18.04 system qemu just hangs) but I
suspect there is also an issue with BSDs and our serial emulation
generally.

--
Alex Benn=C3=A9e

