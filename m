Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A06C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 22:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D2A205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 22:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=corp-zubrcom-net.20150623.gappssmtp.com header.i=@corp-zubrcom-net.20150623.gappssmtp.com header.b="AGIXpndy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D2A205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=corp.zubrcom.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ2kx-00081h-Go
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 18:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex@corp.zubrcom.net>) id 1jJ2To-0002Jx-Gu
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex@corp.zubrcom.net>) id 1jJ2Tn-0003wN-I6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:02:00 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:35715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex@corp.zubrcom.net>)
 id 1jJ2Tn-0003vk-5S
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:01:59 -0400
Received: by mail-lj1-x234.google.com with SMTP id k21so19894457ljh.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corp-zubrcom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=7TmK0qeIjAXyqRG/tCr/XXErnN5DXokZjtcg9k9/E8M=;
 b=AGIXpndykFHoP2vZVXe/sEzuTzO5P+UQXq4OTemE2mvKlfVUFYtPCxdy/awP/slc2e
 JvNfh4EXJM9rIk+OOsbWsNNSa8j2O3b042X05vBjEDFzjaVRbSoG+wMX4GP9gc65gXlN
 5DDOloo6lCk5+/xEzJRZfwoMA9/4oO2JKV51YUnjfkS8QeUJRvIi9eAJRLIq9Z+qPuoO
 kuM6+6z7lgcvwFn56an/Gwn+tPmHTTqKsBnMtYgfRXzYxSRptpyY6vjebsBwOBxPyXTg
 yZTtLNHU8ugMCBwii5axUpOWDRjPK0vDc4o56lqTBmwcW88oXS8aKOTddCGQ/6y/uf7o
 tfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7TmK0qeIjAXyqRG/tCr/XXErnN5DXokZjtcg9k9/E8M=;
 b=PaoOALaW29X1vjx0lV1C+ehXNh+/TBlUrR4OH9HbgfdkFwXJU0KxYRXQEPbG6GehLE
 1E9awe7ws3B9Ta+zPYwRMYbzdMJSrmAsvQw7HtgoWlmWqOkfIFha5fcYjl8XZdw29kRb
 VrBpEzhL/dGhupFbbPJVU/4XIcN1+gJ1HbXRA9yqqNEiM8nZwgYfBTUQkpcKKTe16LXm
 AzUKSdbDaIoLHOtd+3XWHaPnDDi2eldQai8A3kSvvWMaDnv+0WrO3kQGJETNGgKwY4Pe
 iD2pkXtZ7LrqyZICDXxZY0zAUBypYI1ffaPc8i9P0uV4V6MSg1Z71RYFSt3/Mpn6jidW
 DrnQ==
X-Gm-Message-State: AGi0PuZjN3uSVS0mQ6yZBeaVAN1nfGn0FpjoaS8w6Zk758gcAA6sTnyL
 GnoId1ADrCJrVDAurk/AjFsA1HrDXRuf+Dk2Zdr3O5d6
X-Google-Smtp-Source: APiQypIoU77f+Qgwt4ZgAsIiwqrzOcwUOH1Lo7ipqJJGe1INMNNP+yb8HJLfDnK5/QU+IBVQOslbC8tixivuPSt6HGE=
X-Received: by 2002:a2e:a584:: with SMTP id m4mr8413771ljp.194.1585605717032; 
 Mon, 30 Mar 2020 15:01:57 -0700 (PDT)
MIME-Version: 1.0
From: Alexander Yuriev <alex@corp.zubrcom.net>
Date: Mon, 30 Mar 2020 18:02:33 -0400
Message-ID: <CAJRb792WE-mhTDOCdEtP3kQJK8ie7v3LRJ3y28F2DMSabvfyMg@mail.gmail.com>
Subject: Massive memory leak in 4.2.0
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000084b75405a2199931"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::234
X-Mailman-Approved-At: Mon, 30 Mar 2020 18:18:49 -0400
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

--00000000000084b75405a2199931
Content-Type: text/plain; charset="UTF-8"

Hello,

I was wondering if there is any interest in getting detailed reports/having
a tester for a reproducible massive memory leak in qemu 4.2.0 running a
guest with X11 via virgl-0.8.1 acceleration to host using sdl.

Guest limited to 2Gb has qemu RES grow to over 10Gb with while running
Chrome within hours ( single gmail.tab + qemu archive page over last 20
minutes expanded qemu res from 1.9gb to 2.6 gb).

Both host and guest are amd64 debian 10. Qemu is built from source.

Thanks,
Alex

--00000000000084b75405a2199931
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello,<div dir=3D"auto"><br></div><div dir=3D"auto">I was=
 wondering if there is any interest in getting detailed reports/having a te=
ster for a reproducible massive memory leak in qemu 4.2.0 running a guest w=
ith X11 via virgl-0.8.1 acceleration to host using sdl.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Guest limited to 2Gb has qemu RES grow to o=
ver 10Gb with while running Chrome within hours ( single gmail.tab + qemu a=
rchive page over last 20 minutes expanded qemu res from 1.9gb to 2.6 gb).</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Both host and guest are a=
md64 debian 10. Qemu is built from source.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Thanks,</div><div dir=3D"auto">Alex</div></div>

--00000000000084b75405a2199931--

