Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A20C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 13:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0355E2080C
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 13:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AsLXHT77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0355E2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1skS-0006Bt-34
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 09:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41132)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3d49iXQYKChIAs4w0vy66y3w.u648w4C-vwDw3565y5C.69y@flex--sameid.bounces.google.com>)
 id 1i1sja-0005kF-LO
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 09:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3d49iXQYKChIAs4w0vy66y3w.u648w4C-vwDw3565y5C.69y@flex--sameid.bounces.google.com>)
 id 1i1sjZ-0006y4-HX
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 09:39:06 -0400
Received: from mail-vk1-xa4a.google.com ([2607:f8b0:4864:20::a4a]:48395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3d49iXQYKChIAs4w0vy66y3w.u648w4C-vwDw3565y5C.69y@flex--sameid.bounces.google.com>)
 id 1i1sjZ-0006ux-EK
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 09:39:05 -0400
Received: by mail-vk1-xa4a.google.com with SMTP id l3so6286077vkb.15
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=g7qkMlAlXmJE5OGAre+yPdwL+yzkW5Cktd2SxoDAaMQ=;
 b=AsLXHT77hWFM79q2/kzmtt1pC5kqXZTrulXn3OlcqHMHhFo5Bac3JjZP6bhAwFQl+Z
 nQxNj/zdtT41LaCPI6aAksGLlEGEFRza1NXIP/0G5s6oAsKiwjUgQ9CqrUQzDe8bk54n
 pXqyDRhfsJ4frrVM7rBXvBHE2+oBvJ+UuFksKxat2kESS8Ydhw8mitG9mXJkmzJ/m3CS
 uV6dMcDwOsT7HfIkVMqtjVyT2Dk2HW+UbyYaaKqzb/MCqYoBcf1/sKjdTHBroG6nItYy
 y//HoECZM4A27gOc1WZucpaIz443sUgz02np9wNM+qkBAuLabA6v/raPy7aU56oobhrt
 XlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
 :from:to:cc:content-transfer-encoding;
 bh=g7qkMlAlXmJE5OGAre+yPdwL+yzkW5Cktd2SxoDAaMQ=;
 b=mE7UM8rchxl620vuBzHb9gnouyrPaKU1HD3As0W/MzmKvNmNF1w+Yv8aAGOhjWYACR
 Us+MA8IYP9pZkJhgxw6t20iJ/o5pS9UgjOEUEt5sjTlZDUNk4k29jZFT4+WSRnryyA8B
 QOnSH0qdkD3zUZcGgvx/UoB4H+VLVQqO0vKdJToAhokfrCfDIGtSZITbLYxxmGrfVEJF
 iBNK4V9wJqQO8ngkG1299dAlMWUaDhN2CUuWJcDZq2PSI81CoGV2UyL6ge25opaOxnNa
 vZrH6Bu9xUeTvMuWHPVbBvMUoRJU+g6vILgPqAKMI3dvpXwzYfd4yL9ZdkSA79xX2b0r
 Pf2w==
X-Gm-Message-State: APjAAAWHBulsiscjb6eX7UlM3ROxG3NheX5aAY4m+cHRBTpF0wduNPg4
 mGti6UGdlOo1gHcQbyZROPWGMuciUT0=
X-Google-Smtp-Source: APXvYqwaegjQEKft6jxnsJypqmpXMegBeqeYoM9zs43ICXdQ9ubeCyA6uej9O5lRn10XDCErM50YqH7d+tA=
X-Received: by 2002:a1f:b511:: with SMTP id e17mr5596823vkf.86.1566740343715; 
 Sun, 25 Aug 2019 06:39:03 -0700 (PDT)
Date: Sun, 25 Aug 2019 16:38:58 +0300
In-Reply-To: <8e54c29d-119b-e02b-8966-56fa7ea91f9e@redhat.com>
Message-Id: <20190825133858.241842-1-sameid@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: Sam Eiderman <sameid@google.com>, kwolf@redhat.com, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, seabios@seabios.org, kraxel@redhat.com, 
 kevin@koconnor.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a4a
Subject: Re: [Qemu-devel] [QEMU] [PATCH v5 5/8] bootdevice: Gather LCHS from
 all relevant devices
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
From: Sam Eiderman via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Sam Eiderman <sameid@google.com>
Cc: liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Only scsi-hd has the lchs properties, though, so what=E2=80=99s the purpo=
se of
> defining the unrealize function for all other classes?
>
> Max

- shmuel.eiderman@oracle.com
+ sameid@google.com

The only purpose is to already have them mapped to the correct existing
function, in case it will be used later on.
I can resubmit without the unrealize for the other classes, WDYT?

Sam


