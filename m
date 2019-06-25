Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B35C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D87C216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D87C216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfgba-0002Sb-3p
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 04:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hfgaG-0001Uv-Is
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hfgaF-0000Sx-G7
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:13:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hfgaE-0000Qr-MU
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:13:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5995D308A9BE
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 08:13:41 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-27.ams2.redhat.com
 [10.36.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80FBF5C231;
 Tue, 25 Jun 2019 08:13:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 10:13:39 +0200
Message-Id: <20190625081339.9176-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 25 Jun 2019 08:13:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] minikconf: do not include variables from
 MINIKCONF_ARGS in config-all-devices.mak
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
Cc: Christophe de Dinechin <cdupontd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When minikconf writes config-devices.mak, it includes all variables inclu=
ding
those from MINIKCONF_ARGS.  This causes values from config-host.mak to "s=
tick" to
the ones used in generating config-devices.mak, because config-devices.ma=
k is
included after config-host.mak.  Avoid this by omitting assignments comin=
g
from the command line in the output of minikconf.

Reported-by: Christophe de Dinechin <cdupontd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 0ffc6c38da..3109a81db7 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -688,11 +688,13 @@ if __name__ =3D=3D '__main__':
=20
     data =3D KconfigData(mode)
     parser =3D KconfigParser(data)
+    external_vars =3D set()
     for arg in argv[3:]:
         m =3D re.match(r'^(CONFIG_[A-Z0-9_]+)=3D([yn]?)$', arg)
         if m is not None:
             name, value =3D m.groups()
             parser.do_assignment(name, value =3D=3D 'y')
+            external_vars.add(name[7:])
         else:
             fp =3D open(arg, 'r')
             parser.parse_file(fp)
@@ -700,7 +702,8 @@ if __name__ =3D=3D '__main__':
=20
     config =3D data.compute_config()
     for key in sorted(config.keys()):
-        print ('CONFIG_%s=3D%s' % (key, ('y' if config[key] else 'n')))
+        if key not in external_vars:
+            print ('CONFIG_%s=3D%s' % (key, ('y' if config[key] else 'n'=
)))
=20
     deps =3D open(argv[2], 'w')
     for fname in data.previously_included:
--=20
2.21.0


