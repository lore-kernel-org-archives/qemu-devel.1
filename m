Received: from eggs.gnu.org ([2001:4830:134:3::10]:37925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZ9fc-0005eW-JV
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZ9fZ-0007Nr-Ct
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:20:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZ9fZ-0007NP-2f
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:19:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181217204046.14861-1-marcandre.lureau@redhat.com>
Date: Tue, 18 Dec 2018 08:19:51 +0100
In-Reply-To: <20181217204046.14861-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 18 Dec 2018 00:40:46 +0400")
Message-ID: <87woo7i9ns.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: fix flat union on uncovered branches
 conditionals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Default branches variant should use the member conditional.
>
> This fixes compilation with --disable-replication.
>
> Fixes: 335d10cd8e2c3bb6067804b095aaf6371fc1983e
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 8c2d97369e..d385a08270 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1460,7 +1460,7 @@ class QAPISchemaObjectTypeVariants(object):
>              cases =3D set([v.name for v in self.variants])
>              for m in self.tag_member.type.members:
>                  if m.name not in cases:
> -                    v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty')
> +                    v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty',=
 m.ifcond)
>                      v.set_owner(self.tag_member.owner)
>                      self.variants.append(v)
>          for v in self.variants:

Long line, happy to wrap it when I apply.

I append the diff of generated code.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


diff -rup qapi-gen-fb06411210/qapi-introspect.c qapi-gen-ce1a1aec47/qapi-in=
trospect.c
--- qapi-gen-fb06411210/qapi-introspect.c	2018-12-18 08:15:43.929724950 +01=
00
+++ qapi-gen-ce1a1aec47/qapi-introspect.c	2018-12-18 08:11:30.927263620 +01=
00
@@ -10068,11 +10068,13 @@ const QLitObject qmp_schema_qlit =3D QLIT_
                 { "type", QLIT_QSTR("0"), },
                 {}
             })),
+#if defined(CONFIG_REPLICATION)
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "case", QLIT_QSTR("replication"), },
                 { "type", QLIT_QSTR("0"), },
                 {}
             })),
+#endif /* defined(CONFIG_REPLICATION) */
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "case", QLIT_QSTR("throttle"), },
                 { "type", QLIT_QSTR("0"), },
diff -rup qapi-gen-fb06411210/qapi-visit-block-core.c qapi-gen-ce1a1aec47/q=
api-visit-block-core.c
--- qapi-gen-fb06411210/qapi-visit-block-core.c	2018-12-18 08:15:43.8337262=
92 +0100
+++ qapi-gen-ce1a1aec47/qapi-visit-block-core.c	2018-12-18 08:11:30.8332649=
35 +0100
@@ -7175,8 +7175,10 @@ void visit_type_BlockdevCreateOptions_me
         break;
     case BLOCKDEV_DRIVER_RAW:
         break;
+#if defined(CONFIG_REPLICATION)
     case BLOCKDEV_DRIVER_REPLICATION:
         break;
+#endif /* defined(CONFIG_REPLICATION) */
     case BLOCKDEV_DRIVER_THROTTLE:
         break;
     case BLOCKDEV_DRIVER_VMDK:
