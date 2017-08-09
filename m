Received: from eggs.gnu.org ([2001:4830:134:3::10]:46658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2T-0006DV-Go
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2S-0003z2-D6
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:21 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Aug 2017 17:03:53 +1000
Message-Id: <20170809070357.28723-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170809070357.28723-1-david@gibson.dropbear.id.au>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] ppc: fix double-free in cpu_post_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

When running nested with KVM PR, ppc_set_compat() fails and QEMU crashes
because of "double free or corruption (!prev)". The crash happens because
error_report_err() has already called error_free().

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/machine.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index f578156dd4..abe0a1cdf0 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -239,7 +239,6 @@ static int cpu_post_load(void *opaque, int version_id=
)
         ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
         if (local_err) {
             error_report_err(local_err);
-            error_free(local_err);
             return -1;
         }
     } else
--=20
2.13.4
