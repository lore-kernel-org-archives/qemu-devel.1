Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A97EC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F132073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4GZh/FS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F132073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIUV-0000u5-F6
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEITO-0008B0-64
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEITN-0003oF-4Z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:05:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEITM-0003lQ-Ve
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584475556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/HZmWIIHfnHmTdUZzrupKrEMlqcM1d6Bo691jseyEo=;
 b=c4GZh/FSAEK2+H3nBcZh0VekvdMX0rUjqhit/N36j1dcnIL7MZ4gAxudDK5AonNyrkGzIw
 5iE5p4g+68MHFJIUdRg+Dpn0PX/oC216jRDeseRUnHCy4CLc1uNb/2BEsNTjbcaY+Igj1N
 QdBX2XgsyJOlyfgdHzY4p+YSu3Czqm4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-yOgP6AjwNR-S9ot7pVBUsA-1; Tue, 17 Mar 2020 16:05:54 -0400
X-MC-Unique: yOgP6AjwNR-S9ot7pVBUsA-1
Received: by mail-wr1-f69.google.com with SMTP id t4so8258697wrv.9
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 13:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NHp6AQsVQYWhdJl/pzLHGNq2w7hMQpu50+SKuporuyI=;
 b=OIW46WleFl0j52MQVPuOzsk969WV/JAj/oBsSe9xAE0ft7x0TxrhnCmrv3NnOo96fr
 kWHlzr0sKj37kW1XrXTkNsO3SuWBw2D6Gfh+e7QTht9p8v1AtzOzAyxLZ3oLQjrD3uFu
 sPCt6xZeJSwKCAW3KqJqGCdivEgt58b5Go6Q64cdWHMAJfqwokkM9QxqYPCXylKF4glU
 zbVIdUJhpxDzc/boaJzpbwDkvEewtuQCuS/q/dwS+PtC7cFBBrG/XyV33HnSskflPbTx
 k4WgK39OXhtN3m5EpEqspbhrffHwzH56M9Einel8WsY8+c9ggZvoYR7yN6ODNF7ZlfRx
 7Tfg==
X-Gm-Message-State: ANhLgQ2SKaMwxTZMzn7yWY9Yqiwm8zVEYAebHFLmbqj9Bs/ZP3vSczU+
 D06kpu7jadv48GTkSKUFcVk7sRLIf+645DpJku1lUlnsTkJnzaLJmm0dshM8Uo4/6HMGVB1OtCT
 4TxoKPTSBOVxqjU0=
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr767616wrq.246.1584475553517; 
 Tue, 17 Mar 2020 13:05:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtB9s6ul08C7udL9wGC88e8Is+vhALABZrg4E14KNNewEEQsym4WaSyQcHk6gSpGhlbv5jTVg==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr767599wrq.246.1584475553301; 
 Tue, 17 Mar 2020 13:05:53 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id s131sm616075wmf.35.2020.03.17.13.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 13:05:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] tests/test-util-sockets: Skip test on non-x86 Travis
 containers
Date: Tue, 17 Mar 2020 21:05:39 +0100
Message-Id: <20200317200541.6246-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317200541.6246-1-philmd@redhat.com>
References: <20200317200541.6246-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit 4f370b1098, test-util-sockets fails in
restricted non-x86 Travis containers since they apparently
blacklisted some required system calls there.
Let's simply skip the test if we detect such an environment.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/test-util-sockets.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 5fd947c7bf..046ebec8ba 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -231,11 +231,18 @@ static void test_socket_fd_pass_num_nocli(void)
 int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
+    char *travis_arch;
=20
     socket_init();
=20
     g_test_init(&argc, &argv, NULL);
=20
+    travis_arch =3D getenv("TRAVIS_CPU_ARCH");
+    if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
+        g_printerr("Test does not work on non-x86 Travis containers.");
+        goto end;
+    }
+
     /* We're creating actual IPv4/6 sockets, so we should
      * check if the host running tests actually supports
      * each protocol to avoid breaking tests on machines
--=20
2.21.1


