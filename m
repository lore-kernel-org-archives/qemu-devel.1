Received: from eggs.gnu.org ([2001:4830:134:3::10]:47118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duK0x-0005aE-VR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duK0s-0001ct-F0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duK0s-0001cJ-9R
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:00:38 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:33 +0200
Message-Id: <20170919145636.9389-36-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 35/38] s390x/ccw: create s390 phb for compat
 reasons as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

d32bd032d8 ("s390x/ccw: create s390 phb conditionally") made
registering the s390 pci host bridge conditional on presense
of the zpci facility bit. Sadly, that breaks migration from
machines that did not use the cpu model (2.7 and previous).

Create the s390 phb for pre-cpu model machines as well: We can
tweak s390_has_feat() to always indicate the zpci facility bit
when no cpu model is available (on 2.7 and previous compat machines).

Fixes: d32bd032d8 ("s390x/ccw: create s390 phb conditionally")
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c295e641e6..5169379db5 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -196,6 +196,9 @@ bool s390_has_feat(S390Feat feat)
             }
         }
 #endif
+        if (feat == S390_FEAT_ZPCI) {
+            return true;
+        }
         return 0;
     }
     return test_bit(feat, cpu->model->features);
-- 
2.13.5
