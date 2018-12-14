Received: from eggs.gnu.org ([2001:4830:134:3::10]:59347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm4-0005fZ-Ks
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm2-00024X-7y
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:16 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com
	([40.107.8.118]:22409
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gXqm1-0001B5-RY
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:14 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 14 Dec 2018 16:57:06 +0000
Message-ID: <20181214165657.749-2-rkagan@virtuozzo.com>
References: <20181214165657.749-1-rkagan@virtuozzo.com>
In-Reply-To: <20181214165657.749-1-rkagan@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC PATCH 1/5] qom: preserve get/set presence in
 aliased properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>

Usually in order to tell if a property is read-only, write-only, or
read-write, one has to look at whether it has .get or .set methods.

However, property aliases are always defined with both, and it's not
until the call to the getter or setter when the support for the
corresponding operation can be found out.

To make it easier to determine if an operation is supported for an alias
property, only assign it getter and setter if the target property has
the corresponding method.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 qom/object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 17921c0a71..b362ebab19 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2382,8 +2382,8 @@ void object_property_add_alias(Object *obj, const cha=
r *name,
     prop->target_name =3D g_strdup(target_name);
=20
     op =3D object_property_add(obj, name, prop_type,
-                             property_get_alias,
-                             property_set_alias,
+                             target_prop->get ? property_get_alias : NULL,
+                             target_prop->set ? property_set_alias : NULL,
                              property_release_alias,
                              prop, &local_err);
     if (local_err) {
--=20
2.19.2
