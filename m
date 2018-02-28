Received: from eggs.gnu.org ([2001:4830:134:3::10]:53809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90Z-0001bL-Gd
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90V-0006Da-I7
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:27 -0500
Received: from mail-dm3nam03on0612.outbound.protection.outlook.com
	([2a01:111:f400:fe49::612]:53061
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1er90V-0006CB-Bx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:23 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 28 Feb 2018 15:10:28 -0600
Message-ID: <20180228211028.83970-29-brijesh.singh@amd.com>
In-Reply-To: <20180228211028.83970-1-brijesh.singh@amd.com>
References: <20180228211028.83970-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 28/28] tests/qmp-test: blacklist sev
 specific qmp commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>

Blacklist the following commands to fix the 'make check' failure.

query-sev-launch-measure: it returns meaninful data only when we launch
SEV guest otherwise the command returns an error.

query-sev: it return an error when SEV is not available on host (e.g non
X86 platform or KVM is disabled at the build time)

query-sev-capabilities: it returns an error when SEV feature is not
available on host machine.

Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
Hi Dave,

I updated the patch to include other SEV specific QMP command so that
build passes on non x86 arch, I have still kept your R-b, if you don't agre=
e
with changes then let me know.

thanks
 tests/qmp-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 580848307ad1..50573dbf4fbd 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -203,6 +203,11 @@ static bool query_is_blacklisted(const char *cmd)
         "query-gic-capabilities", /* arm */
         /* Success depends on target-specific build configuration: */
         "query-pci",              /* CONFIG_PCI */
+        /* Success depends on launching SEV guest */
+        "query-sev-launch-measure",
+        /* Success depends on Host or Hypervisor SEV support */
+        "query-sev",
+        "query-sev-capabilities",
         NULL
     };
     int i;
--=20
2.14.3
