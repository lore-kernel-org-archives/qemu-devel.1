Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E179EC33CAC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7BA20732
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mfPG6ipa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7BA20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyoPZ-00009L-RK
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 21:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1iyoN9-0003yM-3d
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1iyoN8-0000Le-6z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:55:31 -0500
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:33103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1iyoN7-0000HS-Qq
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:55:29 -0500
Received: by mail-ua1-x941.google.com with SMTP id w15so1992180uap.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 18:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7aH63xDlxHq3KpOihKora39AjybOP7cm/vOXc+9uo+I=;
 b=mfPG6ipaHqWHAMuA/1+fUJTFxL7+96ug9GKbS/HymFjQrW/a5sX/JHVfSlrdJj3aLh
 O76xD+amC8SCXMj/3vq+fiQMgXOSmCQfQDEW2b5osaHpv1FoGJJbK7Pf6/NAvApHEqsM
 XsNujSGkM5rQfERY2BqjyPhW5yHpewSy9mzzKjUnJgTN7pAgbvGmDc4ctpsd3ray3Yan
 W0Xd+8hQbLdS35CB8LCVL3zUeo9ahpNZlweFCr56Mfmrp9/UBLLzFmvC9f3hDVREUY8/
 2aLF8zurDOwSyQVnUjeA947VWh6jcugcrehtVrMblTBYBTAb2PLE5sS7AMPI5/rfWyzj
 3bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7aH63xDlxHq3KpOihKora39AjybOP7cm/vOXc+9uo+I=;
 b=KfiN73hGiV/qifsfqcSnRq9FMpPuFPVPlEE1KNK7DO5VsdildPZSXwg9mG0lBfSjSQ
 353znQxHEL4jxeurX1K5us+7vsLQNvHU+5F9xiwU77iKRjNMrgmDQLMzvSuEqUvmkkbx
 4K9X2KmHJbq57aX4fB7cDA9Ea3wJw7maf8ZFxz546jXVQztNaMx3iws7BXPh1boQeUaC
 H+UJwj8m3UEsvtLa4wFJ7k3loHu8lG5o9dYlCfe7Hop/iGFA8VYML533fIf+j0ZikutN
 SS30gDMytpWVjrB4GHI/PYV/ZQL7hxkiEqaPVyKp40XOZUSwvenq7zjm9RVPIffnX2yv
 iB4Q==
X-Gm-Message-State: APjAAAUds4gbOC7brdy/V9yAbyOQib7ZPTxBIgz96JXaQQYeWckCJ9gs
 craw259uiYddjJjA0CnevTxQDmkL3DVCdBGlc15XEA==
X-Google-Smtp-Source: APXvYqxnP8Jspr7UDngllppQUidySYDR4T11EaADGEtzJHE8RzRmN8Vp372bX4DfFK7f+tQSVYBIQ93Zs6HkQsEjrOc=
X-Received: by 2002:ab0:4ea0:: with SMTP id l32mr16506280uah.69.1580784928922; 
 Mon, 03 Feb 2020 18:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20200114030138.260347-1-jkz@google.com>
 <87h80ymhcd.fsf@linaro.org>
 <CADgy-2vNk5RKV5VdcaFANiopezPKEgdSSHsQc=a_WaWgsAvxzA@mail.gmail.com>
 <87y2u22wd8.fsf@linaro.org>
In-Reply-To: <87y2u22wd8.fsf@linaro.org>
From: Josh Kunz <jkz@google.com>
Date: Mon, 3 Feb 2020 18:55:16 -0800
Message-ID: <CADgy-2stLH1Kts-jsozwXd-3rA_6+6LA6M88a5gz5NpfdVCQ9A@mail.gmail.com>
Subject: Re: [PATCH 0/4] migration: Replace gemu_log with qemu_log
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::941
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 20, 2020 at 3:36 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> Ahh the default build target for the BSDs is "check" but as bsd-user
> doesn't have any checks it doesn't end up building. You can force it
> with
>
>   make vm-build-netbsd EXTRA_CONFIGURE_OPTS=3D"--disable-system" BUILD_TA=
RGET=3D"all"
>
> It would be worth plumbing in the tests/tcg tests at some point. I
> suspect most of the user-mode tests are more POSIX than Linux.

Neat, thanks Alex! I've run this and verified the BSD user-mode binaries bu=
ilt.

