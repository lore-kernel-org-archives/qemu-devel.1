Received: from eggs.gnu.org ([2001:4830:134:3::10]:53222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPmiV-0005s8-2i
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPmiR-0007Wz-SS
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:27:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPmiR-0007Wl-OE
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60F0A7D84D
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 10:27:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  4 Jun 2018 11:27:52 +0100
Message-Id: <20180604102752.32260-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vl: don't use RUN_STATE_PRECONFIG unless
 --preconfig is given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The RUN_STATE_PRECONFIG state is not supposed to be reachable unless the
--preconfig argument is given to QEMU, but when it was introduced in:

  commit 047f7038f586d2150f16c6d9ba9cfd0479f0f6ac
  Author: Igor Mammedov <imammedo@redhat.com>
  Date:   Fri May 11 19:24:43 2018 +0200

    cli: add --preconfig option

The global 'current_run_state' variable was changed to have an initial
value of RUN_STATE_PRECONFIG regardless of whether --preconfig is given.

It then relies on the main loop to toggle it back to RUN_STATE_PRELAUNCH
when --preconfig is not given. This is racy because it means that there
is a window where QEMU is in RUN_STATE_PRECONFIG despite --preconfig not
being given. This can be seen with the failure:

  $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
  QEMU 2.12.50 monitor - type 'help' for more information
  (qemu)
  HMP not available in preconfig state, use QMP instead

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 vl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 06031715ac..f776d65801 100644
--- a/vl.c
+++ b/vl.c
@@ -561,7 +561,7 @@ static int default_driver_check(void *opaque, QemuOpt=
s *opts, Error **errp)
 /***********************************************************/
 /* QEMU state */
=20
-static RunState current_run_state =3D RUN_STATE_PRECONFIG;
+static RunState current_run_state =3D RUN_STATE_PRELAUNCH;
=20
 /* We use RUN_STATE__MAX but any invalid value will do */
 static RunState vmstop_requested =3D RUN_STATE__MAX;
@@ -3572,6 +3572,7 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_preconfig:
+                current_run_state =3D RUN_STATE_PRECONFIG;
                 preconfig_exit_requested =3D false;
                 break;
             case QEMU_OPTION_enable_kvm:
--=20
2.17.0
