Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A33C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AFC206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9gPyaLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AFC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv6y-0004c4-Hd
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihura-0008Ty-53
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurY-0001HS-AA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46719
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurY-0001DZ-1r
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xScWpd/1C0/iEBxf92MCAY1mKNBXL5XSJxDprBKrzs8=;
 b=h9gPyaLJ4x0Qp3/etm65+penJISt/exnQPXg0Xx3PrpjMCm/Rh+yjnXLwSUIsJGQfj/b3W
 nTChGZV+dyMDCZ7eNDmC8igK5h2Mq9g4kjwnnj4fR3/jc76M/kxkyEv7PulaW7z6JMruIS
 V7u6xOEtq0Aei57Z6emYuaN9zUL0CZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-jnMsodF3MCy5pdcsq90hmw-1; Thu, 19 Dec 2019 07:25:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DBFC184BEC0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:01 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 166A660C18;
 Thu, 19 Dec 2019 12:24:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 113/132] systemtap
Date: Thu, 19 Dec 2019 13:23:33 +0100
Message-Id: <1576758232-12439-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jnMsodF3MCy5pdcsq90hmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target   | 84 ++-------------------------------------------------=
----
 meson.build       | 26 +++++++++++++++++
 trace/meson.build | 14 +++++-----
 3 files changed, 35 insertions(+), 89 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 8ee4c78..4f72a89 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -6,88 +6,8 @@ include ../config-host.mak
 include config-target.mak
 include $(SRC_PATH)/rules.mak
=20
-$(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
-
-ifdef CONFIG_USER_ONLY
-# user emulator name
-QEMU_PROG=3Dqemu-$(TARGET_NAME)
-else
-# system emulator name
-QEMU_PROG=3Dqemu-system-$(TARGET_NAME)$(EXESUF)
-endif
-
-STPFILES=3D
-
-ifdef CONFIG_TRACE_SYSTEMTAP
-stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletrace=
.stp $(QEMU_PROG)-log.stp
-
-ifdef CONFIG_USER_ONLY
-TARGET_TYPE=3Duser
-else
-TARGET_TYPE=3Dsystem
-endif
-
-tracetool-y =3D $(SRC_PATH)/scripts/tracetool.py
-tracetool-y +=3D $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
-
-$(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace/trace-events-all $(tracetoo=
l-y)
-=09$(call quiet-command,$(TRACETOOL) \
-=09=09--group=3Dall \
-=09=09--format=3Dstap \
-=09=09--backends=3D$(TRACE_BACKENDS) \
-=09=09--binary=3D$(bindir)/$(QEMU_PROG) \
-=09=09--target-name=3D$(TARGET_NAME) \
-=09=09--target-type=3D$(TARGET_TYPE) \
-=09=09$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG).stp-installed")
-
-$(QEMU_PROG).stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
-=09$(call quiet-command,$(TRACETOOL) \
-=09=09--group=3Dall \
-=09=09--format=3Dstap \
-=09=09--backends=3D$(TRACE_BACKENDS) \
-=09=09--binary=3D$(realpath .)/$(QEMU_PROG) \
-=09=09--target-name=3D$(TARGET_NAME) \
-=09=09--target-type=3D$(TARGET_TYPE) \
-=09=09$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG).stp")
-
-$(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace/trace-events-all $(tracet=
ool-y)
-=09$(call quiet-command,$(TRACETOOL) \
-=09=09--group=3Dall \
-=09=09--format=3Dsimpletrace-stap \
-=09=09--backends=3D$(TRACE_BACKENDS) \
-=09=09--probe-prefix=3Dqemu.$(TARGET_TYPE).$(TARGET_NAME) \
-=09=09$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG)-simpletrace.stp")
-
-$(QEMU_PROG)-log.stp: $(BUILD_DIR)/trace/trace-events-all $(tracetool-y)
-=09$(call quiet-command,$(TRACETOOL) \
-=09=09--group=3Dall \
-=09=09--format=3Dlog-stap \
-=09=09--backends=3D$(TRACE_BACKENDS) \
-=09=09--probe-prefix=3Dqemu.$(TARGET_TYPE).$(TARGET_NAME) \
-=09=09$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG)-log.stp")
-
-else
-stap:
-endif
-.PHONY: stap
-
-all: stap
-
+all:
 clean:
-=09rm -f *.a *~
-=09rm -f $(shell find . -name '*.[od]')
-=09rm -f hmp-commands.h gdbstub-xml.c
-=09rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
-ifdef CONFIG_TRACE_SYSTEMTAP
-=09rm -f *.stp
-endif
-
 install: all
-ifdef CONFIG_TRACE_SYSTEMTAP
-=09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset"
-=09$(INSTALL_DATA) $(QEMU_PROG).stp-installed "$(DESTDIR)$(qemu_datadir)/.=
./systemtap/tapset/$(QEMU_PROG).stp"
-=09$(INSTALL_DATA) $(QEMU_PROG)-simpletrace.stp "$(DESTDIR)$(qemu_datadir)=
/../systemtap/tapset/$(QEMU_PROG)-simpletrace.stp"
-=09$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../syst=
emtap/tapset/$(QEMU_PROG)-log.stp"
-endif
-
+=09
 .PHONY: all clean install
diff --git a/meson.build b/meson.build
index ab53b62..4fb3bdc 100644
--- a/meson.build
+++ b/meson.build
@@ -749,6 +749,7 @@ common_all =3D static_library('common',
                             name_suffix: 'fa')
=20
 feature_to_c =3D find_program('scripts/feature_to_c.sh')
+tracetool =3D find_program('scripts/tracetool.py')
=20
 foreach target : target_dirs
   config_target =3D target_config[target]
@@ -850,6 +851,31 @@ foreach target : target_dirs
                c_args: ['-DNEED_CPU_H',
                         '-DCONFIG_TARGET=3D"@0@-config-target.h"'.format(t=
arget),
                         '-DCONFIG_DEVICES=3D"@0@-config-devices.h"'.format=
(target)])
+
+    if 'CONFIG_TRACE_SYSTEMTAP' in config_host
+      foreach stp: [
+        {'ext': '.stp-build', 'fmt': 'stap', 'bin': meson.current_build_di=
r() / exe_name, 'install': false},
+        {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') / get_o=
ption('bindir') / exe_name, 'install': true},
+        {'ext': '-simpletrace.stp', 'fmt': 'simpletrace-stap', 'bin': '', =
'install': true},
+        {'ext': '-log.stp', 'fmt': 'log-stap', 'bin': '', 'install': true}=
,
+      ]
+        custom_target(exe_name + stp['ext'],
+                      input: trace_events_all,
+                      output: exe_name + stp['ext'],
+                      capture: true,
+                      install: stp['install'],
+                      install_dir: config_host['qemu_datadir'] / '../syste=
mtap/tapset',
+                      command: [
+                        tracetool, '--group=3Dall', '--format=3D' + stp['f=
mt'],
+                        '--backends=3D' + config_host['TRACE_BACKENDS'],
+                        '--binary=3D' + stp['bin'],
+                        '--target-name=3D' + target_name,
+                        '--target-type=3D' + target_type,
+                        '--probe-prefix=3Dqemu.' + target_type + '.' + tar=
get_name,
+                        '@INPUT@',
+                      ])
+      endforeach
+    endif
   endforeach
 endforeach
=20
diff --git a/trace/meson.build b/trace/meson.build
index b113425..eb28aff 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -55,13 +55,13 @@ foreach dir : [ '.' ] + trace_events_subdirs
   endif
 endforeach
=20
-custom_target('trace-events-all',
-              output: 'trace-events-all',
-              input: trace_events_files,
-              command: [ 'cat', '@INPUT@' ],
-              capture: true,
-              install: true,
-              install_dir: config_host['qemu_datadir'])
+trace_events_all =3D custom_target('trace-events-all',
+                                 output: 'trace-events-all',
+                                 input: trace_events_files,
+                                 command: [ 'cat', '@INPUT@' ],
+                                 capture: true,
+                                 install: true,
+                                 install_dir: config_host['qemu_datadir'])
=20
 foreach d : [
   ['generated-tcg-tracers.h', 'tcg-h'],
--=20
1.8.3.1



