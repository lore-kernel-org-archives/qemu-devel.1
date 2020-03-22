Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4591BC4332E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056D62070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FA3Az5JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056D62070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFzJG-0001HU-26
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 08:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFzI1-0000Qk-38
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFzHz-0001Np-Ih
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFzHz-0001Na-Ed
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584878471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=loVZkCaGgvHWmWy+LABlV061e4AvFKYcIsAkccwDWKQ=;
 b=FA3Az5JXqOr+IIjjjcJw8OXWhwsokr2FXX0cn9INb6qyS+wE4+nsM7rodPrqSODtsJj+Bh
 XVfpTWdDDHJTc19nqST30XieBt909MQWHqdh+D5c8jPXZk2KhVQMev7OAIApcYgV7ql+vO
 CkRp5RfkweXmAgHBe5GiICNFpRhagYc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-4lLMkqxqMV6S_IlE81bVdw-1; Sun, 22 Mar 2020 08:01:08 -0400
X-MC-Unique: 4lLMkqxqMV6S_IlE81bVdw-1
Received: by mail-wm1-f70.google.com with SMTP id g9so1124829wmh.1
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 05:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=22TtJgPLggWAOyBtUGWkiB5PJ0wnCA+37RwflFV65XI=;
 b=RYv5OMvLaNmMS3OpoA+kV+9cuPysomGrKy0zsOSgyYsP8nIYt8bWaaMgYEf/J2M6uq
 B4UfzrGDxfZ9C4CXp/tNgjpzMGhxIfXlbL8c51izcNzo30hoROHi5AppFNc7yK05d06K
 CMrjDZb81ftxiZWCSbpb73ZzS61TstcEAE9fxVFXkU1ABTS88DAKcaIePf+DQU7oc4yv
 hCq1qDBUhMl5jvzbWZ7LLjuamcjCa5LFJ0a2skkeApUwo0RQFc/O5UFx1Eeipw6y9JbH
 pQlgAO5nQMU65K4FN69Pkaja87zDaVjoHvsZdTLBojEWsDyzrCIk0BtKud6Eyv0Y/8Sj
 oB+A==
X-Gm-Message-State: ANhLgQ33R1nUS0pXuP4wv4N20NQQBiSzRzbWXaGibe4Tm5c01dRvYw9y
 dcKxKLD/+Z09zbbC11IhJU9w8E+9al+nv1tgVIpEwmolKE/gpaXcWNgIzVvl2n5bbWl/6yzKY71
 3ivLVDni6QHGqadw=
X-Received: by 2002:a1c:9c49:: with SMTP id f70mr12195668wme.15.1584878467519; 
 Sun, 22 Mar 2020 05:01:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvgYt13FWv+jLT2fL0znoiBmqfFeUjp77kSD/ehs022CpYQifds82UtSzaLTwK5niaCSfAyEA==
X-Received: by 2002:a1c:9c49:: with SMTP id f70mr12195646wme.15.1584878467264; 
 Sun, 22 Mar 2020 05:01:07 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id b67sm16807205wmh.29.2020.03.22.05.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 05:01:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 0/4] tests/docker: Fixes for 5.0
Date: Sun, 22 Mar 2020 13:01:00 +0100
Message-Id: <20200322120104.21267-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Easy fixes for our Docker images.

Since v1:
- Reword gcrypt patch description (requested by Aleksandar)

Philippe Mathieu-Daud=C3=A9 (4):
  tests/docker: Keep package list sorted
  tests/docker: Install gcrypt devel package in Debian image
  tests/docker: Use Python3 PyYAML in the Fedora image
  tests/docker: Add libepoxy and libudev packages to the Fedora image

 tests/docker/dockerfiles/centos7.docker      |  6 ++++--
 tests/docker/dockerfiles/debian-amd64.docker |  1 +
 tests/docker/dockerfiles/fedora.docker       | 10 +++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

--=20
2.21.1


