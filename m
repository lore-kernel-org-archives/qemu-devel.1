Received: from eggs.gnu.org ([2001:4830:134:3::10]:52543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYbjL-0006RD-I9
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYbjG-0001Zr-HK
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:28:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dYbjG-0001Yk-Af
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:28:42 -0400
Date: Fri, 21 Jul 2017 18:28:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170721172832.GI2133@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] dirty page count problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: haozhong.zhang@intel.com
Cc: qemu-devel@nongnu.org, alex.benee@linaro.org, peterx@redhat.com, lvivier@redhat.com, quintela@redhat.com

Hi,
  Git bisect is pointing to your patch 084140bd49:
  exec: fix access to ram_list.dirty_memory when sync dirty bitmap

trying to diagnose a bug I'm seeing; it looks like the dirty page count
is wrong for some reason.

Alex Benn=E9e spotted a problem where the postcopy test would occasionall=
y
fail under very heavy load;    attaching a debugger and it looks like
the problem is we have a migration_dirty_page count stuck at 2;
in the normal migration tests we don't spot this, because 2 pages is
smaller than the threshold to end migration and so an extra 2 pages
doesn't block it finishing.   However, with a very
small downtime setting (like we use in the postcopy test) and with
very low bandwidth (as when Alex ran the test on a very heavily loaded
machine) we end up never calling the bitmap sync again and never
completing the iteration.

I'm using the following addition to spot the problem:

diff --git a/migration/ram.c b/migration/ram.c
index e75f1050e4..3ddf884952 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1350,6 +1350,13 @@ static int ram_find_and_save_block(RAMState *rs, b=
ool last_stage)
         }
     } while (!pages && again);

+    if (!pages && !again && pss.complete_round && rs->migration_dirty_pa=
ges)
+    {
+        /* Should make this fail migration ? */
+        fprintf(stderr, "%s: no page found, yet dirty_pages=3D%"PRIu64"\=
n",
+                __func__, rs->migration_dirty_pages);
+    }
+
     rs->last_seen_block =3D pss.block;
     rs->last_page =3D pss.page;

(which I might add as a test to fail a migration)

That test fails easily even on an unloaded machine:
tests/postcopy-test
/x86_64/postcopy: ram_find_and_save_block: no page found, yet dirty_pages=
=3D2
ram_find_and_save_block: no page found, yet dirty_pages=3D2
ram_find_and_save_block: no page found, yet dirty_pages=3D2
OK


I'll try and debug where our extra two pages are coming from.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
