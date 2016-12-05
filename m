Received: from eggs.gnu.org ([2001:4830:134:3::10]:35413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE177-0006yq-8V
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE176-0002Mu-IQ
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:47:57 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Dec 2016 22:46:43 +0100
Message-Id: <1480974406-29345-13-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
References: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests RFC 12/15] arm/arm64: ITS: create
 collection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, drjones@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org
Cc: andre.przywara@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com

Helper function to create a collection, characterized by its
collection id and the target address. Currently the number of
collections cannot exceed the number of redistributors.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 lib/arm/asm/gic-v3-its.h |  1 +
 lib/arm/gic-v3-its.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
index 31589d6..af82b32 100644
--- a/lib/arm/asm/gic-v3-its.h
+++ b/lib/arm/asm/gic-v3-its.h
@@ -190,6 +190,7 @@ extern void its_setup_baser(int i, struct its_baser *baser);
 extern void enable_lpi(u32 redist);
 extern void its_enable_defaults(void);
 extern struct its_device *its_create_device(u32 dev_id, int nvecs);
+extern struct its_collection *its_create_collection(u32 col_id, u32 target);
 
 
 #endif /* !__ASSEMBLY__ */
diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
index c230959..1b50fc5 100644
--- a/lib/arm/gic-v3-its.c
+++ b/lib/arm/gic-v3-its.c
@@ -286,3 +286,20 @@ struct its_device *its_create_device(u32 device_id, int nvecs)
 	its_data.nb_devices++;
 	return new;
 }
+
+struct its_collection *its_create_collection(u32 col_id, u32 pe)
+{
+	if (col_id >= gicv3_data.cpu_count)
+		report_abort("%s coll_id=%d >= cpu_count %d\n",
+			      __func__, col_id, gicv3_data.cpu_count);
+
+	if (its_data.typer.pta)
+		its_data.collections[col_id].target_address =
+			(u64)gicv3_data.redist_base[pe];
+	else
+		its_data.collections[col_id].target_address = pe << 16;
+
+	its_data.collections[col_id].col_id = col_id;
+
+	return &its_data.collections[col_id];
+}
-- 
2.5.5
