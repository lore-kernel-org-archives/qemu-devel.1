Received: from eggs.gnu.org ([2001:4830:134:3::10]:38907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dnkXs-0005mH-Sn
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dnkXo-0007wN-8e
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dnkXo-0007wC-2p
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:55:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18D101F570
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 11:55:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  1 Sep 2017 13:55:00 +0200
Message-Id: <20170901115500.12654-3-quintela@redhat.com>
In-Reply-To: <20170901115500.12654-1-quintela@redhat.com>
References: <20170901115500.12654-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 2/2] tests: Make vmgenid test compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Just make sure that nr_tables is size_t not int.
Once there, do the assert in the right place and be sure that we don't
have a division by zero.

Suggested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--

Drop the s/g_new0/g_malloc0/ change.
Avoid division by zero with assert (danp)
---
 tests/vmgenid-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 3d5c1c3615..918c82c82a 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(void)
     AcpiRsdpDescriptor rsdp_table;
     uint32_t rsdt;
     AcpiRsdtDescriptorRev1 rsdt_table;
-    int tables_nr;
+    size_t tables_nr;
     uint32_t *tables;
     AcpiTableHeader ssdt_table;
     VgidTable vgid_table;
@@ -62,9 +62,9 @@ static uint32_t acpi_find_vgia(void)
     ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");
=20
     /* compute the table entries in rsdt */
+    g_assert_cmpint(rsdt_table.length, >, sizeof(AcpiRsdtDescriptorRev1)=
);
     tables_nr =3D (rsdt_table.length - sizeof(AcpiRsdtDescriptorRev1)) /
                 sizeof(uint32_t);
-    g_assert_cmpint(tables_nr, >, 0);
=20
     /* get the addresses of the tables pointed by rsdt */
     tables =3D g_new0(uint32_t, tables_nr);
--=20
2.13.5
