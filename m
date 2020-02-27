Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12E5C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE63B24680
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/SVj5im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE63B24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Foh-00029u-1B
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jack.wang.usish@gmail.com>) id 1j7Fml-00008D-Ab
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jack.wang.usish@gmail.com>) id 1j7Fmk-00071R-DE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:48:51 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:34012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jack.wang.usish@gmail.com>)
 id 1j7Fmk-0006zu-8v
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:48:50 -0500
Received: by mail-ot1-x32d.google.com with SMTP id j16so2363935otl.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 01:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+cNKFb0+96VQwzrOFR+AZ6ZlVQ+oikZL258uN5swAuk=;
 b=b/SVj5imjwdpSheE8ArLwlHmR9wzO+LjNarqR5z0Hy24HPsBOun08kkCw6/5gKlDn/
 qxETBgQaaGn4NWP10IgZY2z1A/BiLGAuX1es312kkXnUhIPRQiOZGdEGq8jQGRQ4OPwI
 x3TUSbhxfPun4NaDfHt6P8u0CQxpHyp7LhkjWCqUGuZjHPleFQLwHTWCTJZp4DtE/7mA
 TYjtqDOl0wj84uDS7/NnEHdnmxgMb2p+16aewAjCCAn3nDlklN4XsE6xsxWFJZnH7sIq
 BEUAwBJJ8c+Py7Q/XGi4MZlJYzx2NUXlGxx7+0TR1j+1sZaA1nEKcL0Hyi3BLPwc0hps
 jdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+cNKFb0+96VQwzrOFR+AZ6ZlVQ+oikZL258uN5swAuk=;
 b=dr202rhS97YX2cQ10Y+L6H/yGi3OEnUvuOaXb1pG6AtroUqDHBbr5bayWjn5Qs4uM9
 AQ+COsVh9Kn1vJaWUbvicI0OEvXNozlTItRdrblThIU9cdeP/ERl2KQvduUv+GyeSNOK
 Jfg4kAWfNWi52gPZrThp8RqmPSdS9ULeEb9Vk45PjeuJepDXvr9lsSC8srUJIF5318b/
 CpUfZ0ZUj4iIv7Dx/8ZBzp+ewWHfNVVvFVMjPCDyZfsmxhXWFyBHzueC0ysWCtEAR5B5
 ExmnAB7ruphRYXe/yYA4wPKovgfwg3OOgrSq2EHhej5aA3n+rIuUfSJFWNIzUHp4A6dw
 dy0A==
X-Gm-Message-State: APjAAAUz5XFckmLKBD6Q5uTX4k5bOlJo9I9FpVxzg7RPYC6NUN4IMCPu
 ON6SQZeozoA4sc6ltBwm9oIhh0fwHOEXWh2hCqM=
X-Google-Smtp-Source: APXvYqysf8+RZz7Ep9TQHrelh92EJxOMdgp97zN7MOROrthrbqdIoLWwkqaIHoM4snfsbbxKyrsxQJyk1F7LbfZFk5g=
X-Received: by 2002:a05:6830:114c:: with SMTP id
 x12mr2603925otq.324.1582796928614; 
 Thu, 27 Feb 2020 01:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20200227090808.17686-1-chenyi.qiang@intel.com>
 <20200227090808.17686-4-chenyi.qiang@intel.com>
In-Reply-To: <20200227090808.17686-4-chenyi.qiang@intel.com>
From: Jack Wang <jack.wang.usish@gmail.com>
Date: Thu, 27 Feb 2020 10:48:37 +0100
Message-ID: <CA+res+RaoGehJV87ffKSEoHAzvw=2q+enM6nhK-is3TAQoyvWA@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/i386: modify Icelake-Client and Icelake-Server
 CPU model number
To: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chenyi Qiang <chenyi.qiang@intel.com> =E4=BA=8E2020=E5=B9=B42=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8810:07=E5=86=99=E9=81=93=EF=BC=9A
>
> According to the Intel Icelake family list, Icelake-Client uses model
> number 126(0x7D)
0x7D is 125 in hex, so the commit message needs to be fixed.


Cheers
Jack Wang

