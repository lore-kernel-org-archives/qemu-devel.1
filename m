Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1C9C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C858C21743
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T22lVfdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C858C21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbODw-0008U7-2j
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 07:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbOC6-0006UL-TJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbO0I-0006Pg-6t
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:34:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbO0H-0006Nr-Q0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:34:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id a15so9802487wmj.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 04:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mqQpCAaIcqTJ64VRGmkbaqTjhAJu6yxpOGs2uWLfUWU=;
 b=T22lVfdbfvtLwem06Id7k2N5z154cWMBRU+KHABE7OMnqrJAWiGeTEeGu7sh9dAxjq
 ttK4ADyNri/goTQneFa4m/6QFYPVmvzb0wDOmmVTEJNu1uCTUfPSmUTLpDH4U75GDLZy
 CFdyd0NZKOc6l9uIczOD/jdcu+rhB02MVLboRPvAljP82RfOrp9rZWzdNFw17PRT9BMr
 IYES4MiuraOi7JYTx15gkQZoUGaa8Yn7T0h8zBxuKi/o8SeCW6EK1srFppXhIdhb28vI
 4797tQS3faT49Sqs4iqYq5q7R7N3mHGCypJohI6dnpRDsO7aj8Z0vyzdx2EPo0sHtWGS
 Jv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mqQpCAaIcqTJ64VRGmkbaqTjhAJu6yxpOGs2uWLfUWU=;
 b=SSmDvCONXAM9LJABgNXH4b7LArPdYpU5/SFImE6qr5NJ/BkVZY7qMaVq7MZZoBKkdX
 VhV5e51kKtcy3ylj5NzZux3wg1wg8JqYx/LQkh1YCtwlmVmgLPz3/gAzDpkxOwP30Iqy
 IJ56vqqvT+SyvhPvqoajLfQUDKKFqkT0rLMMdIr4eZ+OOhh3ioYxMk68keQoKxsPxA+7
 qPO0uv/wrca5eEnAl/ZnEerbco6ZzXJdB2lfnlqSzcaHCJNqSJWM165qG2M1cmvJgrZv
 NKtjnqrZGpQS0iJrWyIFN1xMvTH79syST3eNM0Z42ZQz5/XU+JkBJowd0aNcUEGmGqQH
 qK1w==
X-Gm-Message-State: APjAAAXbkCRgEPeBw/lrHzC/myrr4+nqALNbn9naP6l+ZMgS+MVKOSSn
 LOdbZtgN2kocTMlFxDUT0pzV+Q==
X-Google-Smtp-Source: APXvYqx+zg0rXfV+z4wjKBmgCoMgQQwND4lU1yqyVG/ddPkhyK0W60ka+pX0itnR1hXxCeQ/cYzb1Q==
X-Received: by 2002:a1c:c255:: with SMTP id s82mr3627860wmf.6.1560425687972;
 Thu, 13 Jun 2019 04:34:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f2sm4396903wrq.48.2019.06.13.04.34.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 04:34:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 84CB11FF87;
 Thu, 13 Jun 2019 12:34:46 +0100 (BST)
References: <20190520124716.30472-1-kraxel@redhat.com>
 <878suo5ls0.fsf@zen.linaroharston> <87pnniemgo.fsf@zen.linaroharston>
 <d32b4c47-4f46-474c-3c4d-54250a29960a@gmx.com>
 <87muileshz.fsf@zen.linaroharston>
 <20190613095249.hpwaoyfo6ndqr5ae@sirius.home.kraxel.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190613095249.hpwaoyfo6ndqr5ae@sirius.home.kraxel.org>
Date: Thu, 13 Jun 2019 12:34:46 +0100
Message-ID: <87lfy5en1l.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

>> > What version of NetBSD did you test? There was recently a short lived
>> > regression in curses(3) that affected sysinst(8) (installer) in HEAD,
>> > but it was fixed.
>>
>> The error for NetBSD was navigating the installer which was dumping a
>> lot of q's in the stream (unicode bar characters?).
>
> Not unicode, but yes these are bars for boxes.
>
> The console trace you get printed to stdout with V=3D1 or DEBUG=3D1 has
> terminal sequences and non-printable characters stripped off, so the
> switch to the box drawing charset doesn't happen and you get those
> q's instead.
>
> cheers,
>   Gerd
>
> PS: /me is busy installing ubuntu 18.04 guest to have a look ...

Thanks.

If you do a re-spin then could you consider including:

  Subject: [PATCH] tests/vm: favour the locally built QEMU for bootstrapping
  Date: Fri,  7 Jun 2019 19:53:37 +0100
  Message-Id: <20190607185337.14524-1-alex.bennee@linaro.org>

Also your scripts and python3 fixes are already merged.

--
Alex Benn=C3=A9e

