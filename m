Received: from eggs.gnu.org ([2001:4830:134:3::10]:40015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5j-000891-7n
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5i-0000Hk-Ay
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih5i-0000HU-5X
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:18 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:38 +0000
Message-Id: <20170228124056.5074-10-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/27] migration: fix id leak regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This leak was introduced in commit
581f08bac22bdd5e081ae07f68071a0fc3c5c2c7.

(it stands out quickly with ASAN once the rest of the leaks are also
removed from make check with this series)

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170221141451.28305-31-marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 5ecd264..87c7a00 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -688,6 +688,7 @@ int vmstate_register_with_alias_id(DeviceState *dev, =
int instance_id,
=20
                 return -1;
             }
+            g_free(id);
=20
             se->compat =3D g_new0(CompatEntry, 1);
             pstrcpy(se->compat->idstr, sizeof(se->compat->idstr), vmsd->=
name);
--=20
2.9.3
