Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF9C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC522084E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiurY1+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC522084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9eiX-0007mw-92
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 19:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ehI-00065v-H1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ehG-0002zS-3f
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:49:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34418
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ehF-0002yp-W6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583369345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1/u9iZXVbyJdSt5JGwMZWiEEl8OjY1RWbys83kQVoQ=;
 b=EiurY1+04uDnrFT4Fve9hOY2SDNLeeuijthXhsHTdgyWluUBXPBJZHEw8x1mGB3p5WGOd9
 6VLQejXBBOIY8VbmkkZYeSw1BnEmdMnTMByoUgdRYzSsSIMj+Gu8B7l8wmzCHtg5uIh2MR
 c5l5oyZSEWGfORJ1N0MTK2ZdyL4H/ts=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-eJS6WSTuPhiW44jHd7NLzg-1; Wed, 04 Mar 2020 19:49:04 -0500
X-MC-Unique: eJS6WSTuPhiW44jHd7NLzg-1
Received: by mail-wr1-f69.google.com with SMTP id x14so1019488wrv.23
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 16:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9cJi/qVXGYuD7j1Z1sfWwdwoowKBROLKn5uwHYNB34c=;
 b=a/dkj6YxcEYcE7i4WQvPgUxZMjTzyDkHB0XumhEt7iBz6qSAYKo2oH2COBNwlj937S
 UtV7K0hT9ZOYxlmEDfZnheNdu86pm8uUm/1HDGZslu5H6Ax25sFIvCiKBpEbS2mV04na
 MPpV5mULplmbZwEc43YSn+/r9D4fPjhUToL0RmxMdNUkXx3LZW4v/36MzNex12e0JEj9
 kvdlyBmp6x+PUvcIKieshTpd56UMLm8x8yLOnx6xqKF7MNdztEJf6NpNsHUr2uOJzvP1
 g8fjMI6of2NZTTVIUW0Ev0rq0XfjRgf3OjOBJnqizispZ1xmrWRpF0CBGEKPY8Fvi67V
 uLSw==
X-Gm-Message-State: ANhLgQ0tH+r3yvwCYK8w6L3dcnTHxgmdibaoNm2qN3fL93Y9CcGL37uc
 9MulDFRPGz29JxYyXuP6Pqn82aWXtPWSjBsoC5bj0tc5SlqJLaxaSiz7vuhqzaaumcRMskM/Cf9
 Q7SlrQTs7ltGfMLQ=
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr5989084wmh.22.1583369342637;
 Wed, 04 Mar 2020 16:49:02 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtfaLza6tjpbZQ2CFPR9ze5EPsiwwV2hfbKUtQ0xS1aQmtJlTyRBWY/yTNEZCNjp+E65QoD4w==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr5989054wmh.22.1583369342319;
 Wed, 04 Mar 2020 16:49:02 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r19sm6422422wmh.26.2020.03.04.16.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 16:49:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] Makefile: Align 'help' target output
Date: Thu,  5 Mar 2020 01:48:54 +0100
Message-Id: <20200305004855.9665-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305004855.9665-1-philmd@redhat.com>
References: <20200305004855.9665-1-philmd@redhat.com>
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'help' target is displayed unaligned. Add a print-help
function and use it. Now if someone want to change the
indentation, there is a single place to modify.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index aa9cc0b584..a9ede4f428 100644
--- a/Makefile
+++ b/Makefile
@@ -1220,50 +1220,52 @@ endif
 include $(SRC_PATH)/tests/docker/Makefile.include
 include $(SRC_PATH)/tests/vm/Makefile.include
=20
+print-help-run =3D printf "  %-30s - %s\\n" "$1" "$2"
+print-help =3D $(quiet-@)$(call print-help-run,$1,$2)
+
 .PHONY: help
 help:
 =09@echo  'Generic targets:'
-=09@echo  '  all             - Build all'
+=09$(call print-help,all,Build all)
 ifdef CONFIG_MODULES
-=09@echo  '  modules         - Build all modules'
+=09$(call print-help,modules,Build all modules)
 endif
-=09@echo  '  dir/file.o      - Build specified target only'
-=09@echo  '  install         - Install QEMU, documentation and tools'
-=09@echo  '  ctags/TAGS      - Generate tags file for editors'
-=09@echo  '  cscope          - Generate cscope index'
+=09$(call print-help,dir/file.o,Build specified target only)
+=09$(call print-help,install,Install QEMU, documentation and tools)
+=09$(call print-help,ctags/TAGS,Generate tags file for editors)
+=09$(call print-help,cscope,Generate cscope index)
 =09@echo  ''
 =09@$(if $(TARGET_DIRS), \
 =09=09echo 'Architecture specific targets:'; \
 =09=09$(foreach t, $(TARGET_DIRS), \
-=09=09printf "  %-30s - Build for %s\\n" $(t)/all $(t);) \
+=09=09$(call print-help-run,$(t)/all,Build for $(t));) \
 =09=09echo '')
 =09@echo  'Cleaning targets:'
-=09@echo  '  clean           - Remove most generated files but keep the co=
nfig'
+=09$(call print-help,clean,Remove most generated files but keep the config=
)
 ifdef CONFIG_GCOV
-=09@echo  '  clean-coverage  - Remove coverage files'
+=09$(call print-help,clean-coverage,Remove coverage files)
 endif
-=09@echo  '  distclean       - Remove all generated files'
-=09@echo  '  dist            - Build a distributable tarball'
+=09$(call print-help,distclean,Remove all generated files)
+=09$(call print-help,dist,Build a distributable tarball)
 =09@echo  ''
 =09@echo  'Test targets:'
-=09@echo  '  check           - Run all tests (check-help for details)'
-=09@echo  '  docker          - Help about targets running tests inside con=
tainers'
-=09@echo  '  vm-help         - Help about targets running tests inside VM'
+=09$(call print-help,check,Run all tests (check-help for details))
+=09$(call print-help,docker,Help about targets running tests inside contai=
ners)
+=09$(call print-help,vm-help,Help about targets running tests inside VM)
 =09@echo  ''
 =09@echo  'Documentation targets:'
-=09@echo  '  html info pdf txt'
-=09@echo  '                  - Build documentation in specified format'
+=09$(call print-help,html info pdf txt,Build documentation in specified fo=
rmat)
 ifdef CONFIG_GCOV
-=09@echo  '  coverage-report - Create code coverage report'
+=09$(call print-help,coverage-report,Create code coverage report)
 endif
 =09@echo  ''
 ifdef CONFIG_WIN32
 =09@echo  'Windows targets:'
-=09@echo  '  installer       - Build NSIS-based installer for QEMU'
+=09$(call print-help,installer,Build NSIS-based installer for QEMU)
 ifdef QEMU_GA_MSI_ENABLED
-=09@echo  '  msi             - Build MSI-based installer for qemu-ga'
+=09$(call print-help,msi,Build MSI-based installer for qemu-ga)
 endif
 =09@echo  ''
 endif
-=09@echo  '  $(MAKE) [targets]      (quiet build, default)'
-=09@echo  '  $(MAKE) V=3D1 [targets]  (verbose build)'
+=09$(call print-help,$(MAKE) [targets],(quiet build, default))
+=09$(call print-help,$(MAKE) V=3D1 [targets],(verbose build))
--=20
2.21.1


