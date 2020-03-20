Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7993C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B5620767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEWqRpnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B5620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFN0G-0000WG-Kt
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 15:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFMyI-0005aR-L5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFMyH-0000V4-IF
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFMyH-0000Uq-Ed
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584731177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAmyqKwhwrh0ajYsjXgnnfj5OQ7B6gbp+kGYEsb8iLc=;
 b=PEWqRpnC4wvvMkZ0CS7TlGNHahQmwgyyd83SfaQIpSCUgLNt4kE41NvXYX2B6fWO1pkqkw
 L7YZMCCu64uFfcK+JpxfFQD/IVf4G6xwcV0OqZm2CAx2ngsqHrFlPTiIAvpeNQ87OGGOfO
 3O+hxMd4gdIOWl2WdrvWQnpeulLXyNA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-H2q7kIyFNlCNcB6cHJLJsg-1; Fri, 20 Mar 2020 15:06:15 -0400
X-MC-Unique: H2q7kIyFNlCNcB6cHJLJsg-1
Received: by mail-wr1-f70.google.com with SMTP id f13so3051009wro.23
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 12:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HJcf06D8sxzN11xhJWZW2vo0/WKoNsGqvt6TggY9h44=;
 b=U/6N3P7w7sYEly+JkdOH2hIgvkOjuK7FqyW7LTZH9/G306zZBGbl08DwWBVrT/HQw1
 wfmRW3UYyxOMjqu7gN64s74ZfyCQVh7MyqVnlGKtRbPN+pizpZ3oL/N4o62II1P0lhY6
 l8rFBl9KY4XZpf+Cjr9tHmzmPqaflSIpmQA+z8oY39EjfAdowUguPjeomXb4LOuX8n1v
 G1I69/vnw1q6LY84Aztmn2zQ9lAJaibYoQRD9GWBLjdZ9AY5gDOErrpkMZoRWhE25y6y
 I3m1PWirvo22Rhd9QwiH4qVqVpAZh9ywvLV9st8BQTCqGcsbBZfO08Rmov6ckHa1PAEl
 pJgg==
X-Gm-Message-State: ANhLgQ3RMJIy/LJRLMfi970XRS37DGDMwNC8czO9uYLcJh2LfH8Z0mnI
 XADaZgj7S2XwAW/4DX4PHM8ZUsSjoS5ZVJUMoDm+iV3Sx7kbgNK7JukJxltI379c4WcBqm2Y3oF
 QsxBwtMNQSf0HPTk=
X-Received: by 2002:a5d:5290:: with SMTP id c16mr12307447wrv.235.1584731173427; 
 Fri, 20 Mar 2020 12:06:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvFGdm+YF613j8/rU8NFfUMKhGyVccEtSVia23EpGZpiNEW15ALrdNYYmkvkhNdyrQJ0SeBhw==
X-Received: by 2002:a5d:5290:: with SMTP id c16mr12307424wrv.235.1584731173158; 
 Fri, 20 Mar 2020 12:06:13 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id p15sm9394086wro.68.2020.03.20.12.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 12:06:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 3/4] tests/docker: Use Python3 PyYAML in the Fedora
 image
Date: Fri, 20 Mar 2020 20:05:52 +0100
Message-Id: <20200320190553.9363-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320190553.9363-1-philmd@redhat.com>
References: <20200320190553.9363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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

The Python2 PyYAML is now pointless, switch to the Python3 version.

Fixes: bcbf27947 (docker: move tests from python2 to python3)
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfi=
les/fedora.docker
index 019eb12dcb..174979c7af 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -79,8 +79,8 @@ ENV PACKAGES \
     perl-Test-Harness \
     pixman-devel \
     python3 \
+    python3-PyYAML \
     python3-sphinx \
-    PyYAML \
     rdma-core-devel \
     SDL2-devel \
     snappy-devel \
--=20
2.21.1


