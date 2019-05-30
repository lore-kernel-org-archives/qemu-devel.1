Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AE8C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 21:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D6826242
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 21:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D6826242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWT5G-0006R1-2S
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 17:59:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hWT3i-0005X9-MO
	for qemu-devel@nongnu.org; Thu, 30 May 2019 17:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hWT3h-0001V6-N3
	for qemu-devel@nongnu.org; Thu, 30 May 2019 17:58:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hWT3h-0001TL-HM
	for qemu-devel@nongnu.org; Thu, 30 May 2019 17:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D34D83F45
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 21:57:59 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
	(virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AD9796404F;
	Thu, 30 May 2019 21:57:58 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 17:57:55 -0400
Message-Id: <20190530215755.328-2-wainersm@redhat.com>
In-Reply-To: <20190530215755.328-1-wainersm@redhat.com>
References: <20190530215755.328-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 30 May 2019 21:57:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/1] vl: make -accel help to list enabled
 accelerators only
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, philmd@redhat.com, ehabkost@redhat.com,
	crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, -accel help shows all possible accelerators regardless
if they are enabled in the binary or not. That is a different
semantic from -cpu and -machine helps, for example. So this change
makes it to list only the accelerators which support is compiled
in the binary target.

Note that it does not check if the accelerator is enabled in the
host, so the help message's header was rewritten to emphasize
that. Also qtest is not displayed given that it is used for
internal testing purpose only.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 vl.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 2e69c9fef2..e5d40c01f8 100644
--- a/vl.c
+++ b/vl.c
@@ -3575,7 +3575,23 @@ int main(int argc, char **argv, char **envp)
                                                      optarg, true);
                 optarg =3D qemu_opt_get(accel_opts, "accel");
                 if (!optarg || is_help_option(optarg)) {
-                    printf("Possible accelerators: kvm, xen, hax, tcg\n"=
);
+                    printf("Accelerators supported in QEMU binary:\n");
+                    GSList *el, *accel_list =3D object_class_get_list(TY=
PE_ACCEL,
+                                                                    fals=
e);
+                    for (el =3D accel_list; el; el =3D el->next) {
+                        gchar *typename =3D g_strdup(object_class_get_na=
me(
+                                                   OBJECT_CLASS(el->data=
)));
+                        /* omit qtest which is used for tests only */
+                        if (g_strcmp0(typename, ACCEL_CLASS_NAME("qtest"=
)) &&
+                            g_str_has_suffix(typename, ACCEL_CLASS_SUFFI=
X)) {
+                            gchar **optname =3D g_strsplit(typename,
+                                                         ACCEL_CLASS_SUF=
FIX, 0);
+                            printf("%s\n", optname[0]);
+                            g_free(optname);
+                        }
+                        g_free(typename);
+                    }
+                    g_slist_free(accel_list);
                     exit(0);
                 }
                 opts =3D qemu_opts_create(qemu_find_opts("machine"), NUL=
L,
--=20
2.21.0


