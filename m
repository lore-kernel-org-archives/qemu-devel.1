Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31850C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BC020737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmKhCuHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BC020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQEz-0007Xa-SE
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQ8w-0008QX-4T
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQ8u-00074L-Rq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQ8u-00073s-2L
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585935007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zhE6ee/ewhN32Cd9UeMbNB2UOfC6MpshlD+Ij+vmjsE=;
 b=HmKhCuHdHOgPCFls9UsDG4O/Hue8zwbcCsKjL2M1CYsfGs1uMcf2jl1RVcu8Q9AUlZes1+
 RiDZqnq/lB6UHhh7h5HN8gaAGPV/5BDzQBo94+rozSPRFfouw2hBpHdvSCkg50jHoAinx8
 XyEhNIyV6edA5A15VtF/IpB3kqlk7CY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-RDNQLKL0NHyNAKppCSUYeA-1; Fri, 03 Apr 2020 13:30:02 -0400
X-MC-Unique: RDNQLKL0NHyNAKppCSUYeA-1
Received: by mail-wm1-f70.google.com with SMTP id a4so843204wmb.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EXy8ZCpw1lCGxySpZOzMTritO+pUIO0dQLsKOUlH3g8=;
 b=UiArJ5Y/ripn2Q8lStQrmWEO/j1T7zsg3eWDNwF3XlQkKgvcNw79QI6PURRAs+0bee
 P2/nvGzszIf2no4k0ClUlHI6/kgKZbiGYx9cxOLmpWzs1Tk1xk7WsKF0SNIHTYCFY6/4
 YtsUPxa6ojefjULElQo18JshMcOmcyVLtFjn1C62P9DKOFzieHsyw/guo6ez73Zfv3Lt
 rMwCGu6e/9KpkbFByvUhnRO0EJw9Ew/J+u6So666EMAT8HEpJSTkI8UJDab6IjLqXc+6
 XjtjqVjpDN/twOVGjYK5uF+5kA4rCYG+te2mZ0SRAzsuUs8FAdchAQaoUJOkMZBDO36f
 B4Gw==
X-Gm-Message-State: AGi0PuY8FNtrqRfgVlKb8yO9ZoSLP6vCIXPT4lRuO7rJPwLxhDkDfL6o
 yFXINPbThmJYQjxJTtNWmApY/GkdO71VvmnAdLhhfTdDbkztmB5y59fPGtm4Omy48Xef/y+FiXK
 npVezBOyNL8X46rs=
X-Received: by 2002:a05:600c:20c:: with SMTP id
 12mr6234043wmi.96.1585935000548; 
 Fri, 03 Apr 2020 10:30:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ/XbtJXXF/pJAghysMSc2hCY8PNyClOntk2mi3nrEVsoQVtExf04Qid1vFkHDX8/WLqMUV5A==
X-Received: by 2002:a05:600c:20c:: with SMTP id
 12mr6234028wmi.96.1585935000370; 
 Fri, 03 Apr 2020 10:30:00 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q14sm11677974wrx.57.2020.04.03.10.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 10:29:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 6/8] tests/Makefile: Add fetch-acceptance-assets rule
Date: Fri,  3 Apr 2020 19:29:17 +0200
Message-Id: <20200403172919.24621-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403172919.24621-1-philmd@redhat.com>
References: <20200403172919.24621-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 51de676298..90f457593c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -906,6 +906,13 @@ get-vm-image-fedora-31-%: check-venv
 # download all vm images, according to defined targets
 get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDORA_=
31_DOWNLOAD))
=20
+fetch-acceptance-assets: check-venv
+=09$(call quiet-command, \
+            $(TESTS_VENV_DIR)/bin/python -m avocado \
+            --show=3D$(if $(DEBUG),avocado.test,$(AVOCADO_SHOW)) assets fe=
tch \
+            tests/acceptance/*py, \
+            "AVOCADO", "tests/acceptance")
+
 check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 =09$(call quiet-command, \
             $(TESTS_VENV_DIR)/bin/python -m avocado \
--=20
2.21.1


