Received: from eggs.gnu.org ([2001:4830:134:3::10]:49238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gaOWq-0001QW-FX
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 12:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gaOWj-0003Rv-Ji
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 12:24:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gaOWj-0003QW-DM
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 12:23:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85D4A19D011
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 17:23:56 +0000 (UTC)
Date: Fri, 21 Dec 2018 18:23:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181221182351.7edab300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] possible leak in bios-tables-test.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

When running test under valgrind it spits out a bunch of still reachable
allocations. most of them are glib g_test related but there is one that
belong to the test itself. I've found why it happens so reporting in hope
that someone else would be able to track it down.

reproducer:

make && make tests/bios-tables-test && QTEST_QEMU_BINARY=./x86_64-softmmu/qemu-system-x86_64 \
valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all tests/bios-tables-test

==52347== 5 bytes in 1 blocks are still reachable in loss record 4 of 27
==52347==    at 0x4C29BC3: malloc (vg_replace_malloc.c:299)
==52347==    by 0x529F68D: g_malloc (in /usr/lib64/libglib-2.0.so.0.5600.1)
==52347==    by 0x52B869E: g_strdup (in /usr/lib64/libglib-2.0.so.0.5600.1)
==52347==    by 0x52CD151: g_get_tmp_dir (in /usr/lib64/libglib-2.0.so.0.5600.1)
==52347==    by 0x528664D: ??? (in /usr/lib64/libglib-2.0.so.0.5600.1)
==52347==    by 0x528733E: g_file_open_tmp (in /usr/lib64/libglib-2.0.so.0.5600.1)
==52347==    by 0x112484: dump_aml_files (bios-tables-test.c:272)
==52347==    by 0x112E68: test_acpi_asl (bios-tables-test.c:432)
==52347==    by 0x113BE3: test_acpi_one (bios-tables-test.c:649)
==52347==    by 0x113CB1: test_acpi_piix4_tcg (bios-tables-test.c:676)
==52347==    by 0x52C0290: ??? (in /usr/lib64/libglib-2.0.so.0.5600.1)
==52347==    by 0x52C014A: ??? (in /usr/lib64/libglib-2.0.so.0.5600.1)
