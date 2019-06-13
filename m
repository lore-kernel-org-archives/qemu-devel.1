Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F89DC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC6F20673
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2XU8lTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC6F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39876 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQEi-00076B-1P
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45198)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPOd-0001C1-Ff
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPOZ-0003H8-7H
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:04:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbPOY-0003FN-Tf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:03:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id d18so20697715wrs.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aQUjRYizH9G8THzqrMF3EZVtta3JckNtj15GDxgtOs8=;
 b=i2XU8lTnqZ0oBkMeIA6F8EaQp2LZDWo62rbCkBx94WrSAT0baqFXUP4j3irxFLz5W4
 1sw9xNHB9vZWYMCD8xQHZJtXaAFqBPTwEGSCb8ss4wWmqNpIig/vpIE0luozwlm953N2
 P9KqWWbtp51gk1m/FHciCHiBBFMgY0c9NCfhlfGkuO+8wgGPaQyrwxTcskfy0W4SWs+z
 iOLlyJ5oWhi6htZpmtQ5MDQmy/2M15z03GobujqGtwJZyzdfCp0Ymyxhs5l8nUNDRfrV
 1SRjPAJqYFfpaaftt/3fMOmj+/XcPDkolZ2pltgAHu/g5UgaiNxJH6n/pkgm2LN9VXOC
 PWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aQUjRYizH9G8THzqrMF3EZVtta3JckNtj15GDxgtOs8=;
 b=MFOpCPHS/qmw+tXAb2iBdYHzMfGdgVRTG++eG+pSpnwz4rXzTI31xM7Z/8l43JrqAn
 mhmHm4ongx2UnxFhzWa1UJwHKbYLoN4+NQNZdo2439l+AuFmznsBdHH22Wy5ipxZR36B
 iahgfF9gvYSTOIxrr8RSBHt/aqwvkOHzcY8R0N+o1NKLO3EXs2bxSI4hs3yFLlJZNrnL
 MkEKCBAFwnlGhfn8yeqnSXnyNT6pJW9gySNf9Ba5HfuP5519GbcdIuGzrQfrHT/oQ6KY
 PIqHGFCF8J60uH4bm981KUMIIobtH0u7XjmGwWQ8dvAfW+3cpQXsjD4XgrQ5WHFgcLV3
 lUPQ==
X-Gm-Message-State: APjAAAUdMQ0aTaHaKSYes92Ai0dgdNCxT3WmcPhxoSdxcmugZ2AP91RX
 IlkkxrTXriiQnw9yn24+iakYrQ==
X-Google-Smtp-Source: APXvYqyG06YCzVmX5Dd/jEBAMqNXnmR5+cHEyGwLj6HMxNSVbV1STLXQ8xx7xbtk73YtlZpN2GEHbw==
X-Received: by 2002:adf:e841:: with SMTP id d1mr60370899wrn.204.1560431036421; 
 Thu, 13 Jun 2019 06:03:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f2sm4808932wrq.48.2019.06.13.06.03.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 06:03:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 47E7B1FF87;
 Thu, 13 Jun 2019 14:03:55 +0100 (BST)
References: <20190520124716.30472-1-kraxel@redhat.com>
 <878suo5ls0.fsf@zen.linaroharston> <87pnniemgo.fsf@zen.linaroharston>
 <d32b4c47-4f46-474c-3c4d-54250a29960a@gmx.com>
 <87muileshz.fsf@zen.linaroharston>
 <20190613095249.hpwaoyfo6ndqr5ae@sirius.home.kraxel.org>
 <87lfy5en1l.fsf@zen.linaroharston>
 <20190613123628.brwmtr7rfg55zz2v@sirius.home.kraxel.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190613123628.brwmtr7rfg55zz2v@sirius.home.kraxel.org>
Date: Thu, 13 Jun 2019 14:03:55 +0100
Message-ID: <87d0jheix0.fsf@zen.linaroharston>
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
 Kamil Rytarowski <n54@gmx.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> If you do a re-spin then could you consider including:
>>
>>   Subject: [PATCH] tests/vm: favour the locally built QEMU for bootstrap=
ping
>>   Date: Fri,  7 Jun 2019 19:53:37 +0100
>>   Message-Id: <20190607185337.14524-1-alex.bennee@linaro.org>
>
> Local seabios is enough, and that'll more reliable work better because
> we don't have to compile something for that.  ubuntu 18.04 seabios lacks
> serial console support, which is one of the problems found so far.

Ahh that makes sense. I'm never quite sure where qemu looks for these
blobs - they seem to me automagically chosen.

>
>> Also your scripts and python3 fixes are already merged.
>
> Yep, saw that.
>
> cheers,
>   Gerd


--
Alex Benn=C3=A9e

