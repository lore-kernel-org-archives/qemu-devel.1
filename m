Received: from eggs.gnu.org ([2001:4830:134:3::10]:37493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQF1h-0000XU-9E
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQF1f-0000u6-CF
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:37:09 -0400
Date: Wed, 28 Jun 2017 17:36:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628153654.GI5378@noname.redhat.com>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
	<20170628144012.GH5378@noname.redhat.com>
	<20170628152209.hf6iqosa24b3nocc@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
In-Reply-To: <20170628152209.hf6iqosa24b3nocc@postretch>
Subject: Re: [Qemu-devel] [PATCH RFC v3 3/8] block: add throttle block
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.06.2017 um 17:22 hat Manos Pitsidianakis geschrieben:
> On Wed, Jun 28, 2017 at 04:40:12PM +0200, Kevin Wolf wrote:
> >Am 23.06.2017 um 14:46 hat Manos Pitsidianakis geschrieben:
> >>block/throttle.c uses existing I/O throttle infrastructure inside a
> >>block filter driver. I/O operations are intercepted in the filter's
> >>read/write coroutines, and referred to block/throttle-groups.c
> >>
> >>The driver can be used with the command
> >>-drive driver=3Dthrottle,file.filename=3Dfoo.qcow2,iops-total=3D...
> >>The configuration flags and semantics are identical to the hardcoded
> >>throttling ones.
> >>
> >>Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> >>---
> >> block/Makefile.objs             |   1 +
> >> block/throttle.c                | 427 ++++++++++++++++++++++++++++++++=
++++++++
> >> include/qemu/throttle-options.h |  60 ++++--
> >> 3 files changed, 469 insertions(+), 19 deletions(-)
> >> create mode 100644 block/throttle.c
> >>
> >>diff --git a/block/Makefile.objs b/block/Makefile.objs
> >>index ea955302c8..bb811a4d01 100644
> >>--- a/block/Makefile.objs
> >>+++ b/block/Makefile.objs
> >>@@ -25,6 +25,7 @@ block-obj-y +=3D accounting.o dirty-bitmap.o
> >> block-obj-y +=3D write-threshold.o
> >> block-obj-y +=3D backup.o
> >> block-obj-$(CONFIG_REPLICATION) +=3D replication.o
> >>+block-obj-y +=3D throttle.o
> >>
> >> block-obj-y +=3D crypto.o
> >>
> >>diff --git a/block/throttle.c b/block/throttle.c
> >>new file mode 100644
> >>index 0000000000..0c17051161
> >>--- /dev/null
> >>+++ b/block/throttle.c
> >>@@ -0,0 +1,427 @@
> >>+/*
> >>+ * QEMU block throttling filter driver infrastructure
> >>+ *
> >>+ * Copyright (c) 2017 Manos Pitsidianakis
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or
> >>+ * modify it under the terms of the GNU General Public License as
> >>+ * published by the Free Software Foundation; either version 2 or
> >>+ * (at your option) version 3 of the License.
> >>+ *
> >>+ * This program is distributed in the hope that it will be useful,
> >>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>+ * GNU General Public License for more details.
> >>+ *
> >>+ * You should have received a copy of the GNU General Public License
> >>+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
> >>+ */
> >
> >Please consider using the LGPL. We're still hoping to turn the block
> >layer into a library one day, and almost all code in it is licensed
> >liberally (MIT or LGPL).
> >
> >>+#include "qemu/osdep.h"
> >>+#include "block/throttle-groups.h"
> >>+#include "qemu/throttle-options.h"
> >>+#include "qapi/error.h"
> >>+
> >>+
> >>+static QemuOptsList throttle_opts =3D {
> >>+    .name =3D "throttle",
> >>+    .head =3D QTAILQ_HEAD_INITIALIZER(throttle_opts.head),
> >>+    .desc =3D {
> >>+        {
> >>+            .name =3D QEMU_OPT_IOPS_TOTAL,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "limit total I/O operations per second",
> >>+        },{
> >>+            .name =3D QEMU_OPT_IOPS_READ,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "limit read operations per second",
> >>+        },{
> >>+            .name =3D QEMU_OPT_IOPS_WRITE,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "limit write operations per second",
> >>+        },{
> >>+            .name =3D QEMU_OPT_BPS_TOTAL,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "limit total bytes per second",
> >>+        },{
> >>+            .name =3D QEMU_OPT_BPS_READ,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "limit read bytes per second",
> >>+        },{
> >>+            .name =3D QEMU_OPT_BPS_WRITE,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "limit write bytes per second",
> >>+        },{
> >>+            .name =3D QEMU_OPT_IOPS_TOTAL_MAX,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "I/O operations burst",
> >>+        },{
> >>+            .name =3D QEMU_OPT_IOPS_READ_MAX,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "I/O operations read burst",
> >>+        },{
> >>+            .name =3D QEMU_OPT_IOPS_WRITE_MAX,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "I/O operations write burst",
> >>+        },{
> >>+            .name =3D QEMU_OPT_BPS_TOTAL_MAX,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "total bytes burst",
> >>+        },{
> >>+            .name =3D QEMU_OPT_BPS_READ_MAX,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "total bytes read burst",
> >>+        },{
> >>+            .name =3D QEMU_OPT_BPS_WRITE_MAX,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "total bytes write burst",
> >>+        },{
> >>+            .name =3D QEMU_OPT_IOPS_TOTAL_MAX_LENGTH,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "length of the iopstotalmax burst period, in sec=
onds",
> >>+        },{
> >>+            .name =3D QEMU_OPT_IOPS_READ_MAX_LENGTH,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "length of the iopsreadmax burst period, in seco=
nds",
> >>+        },{
> >>+            .name =3D QEMU_OPT_IOPS_WRITE_MAX_LENGTH,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "length of the iopswritemax burst period, in sec=
onds",
> >>+        },{
> >>+            .name =3D QEMU_OPT_BPS_TOTAL_MAX_LENGTH,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "length of the bpstotalmax burst period, in seco=
nds",
> >>+        },{
> >>+            .name =3D QEMU_OPT_BPS_READ_MAX_LENGTH,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "length of the bpsreadmax burst period, in secon=
ds",
> >>+        },{
> >>+            .name =3D QEMU_OPT_BPS_WRITE_MAX_LENGTH,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "length of the bpswritemax burst period, in seco=
nds",
> >>+        },{
> >>+            .name =3D QEMU_OPT_IOPS_SIZE,
> >>+            .type =3D QEMU_OPT_NUMBER,
> >>+            .help =3D "when limiting by iops max size of an I/O in byt=
es",
> >>+        },
> >>+        {
> >>+            .name =3D QEMU_OPT_THROTTLE_GROUP_NAME,
> >>+            .type =3D QEMU_OPT_STRING,
> >>+            .help =3D "throttle group name",
> >>+        },
> >>+        { /* end of list */ }
> >>+    },
> >>+};
> >>+
> >>+/* Extract ThrottleConfig options. Assumes cfg is initialized and will=
 be
> >>+ * checked for validity.
> >>+ */
> >>+
> >>+static void throttle_extract_options(QemuOpts *opts, ThrottleConfig *c=
fg)
> >>+{
> >>+    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL)) {
> >>+        cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ)) {
> >>+        cfg->buckets[THROTTLE_BPS_READ].avg  =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE)) {
> >>+        cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL)) {
> >>+        cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ)) {
> >>+        cfg->buckets[THROTTLE_OPS_READ].avg =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE)) {
> >>+        cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL_MAX)) {
> >>+        cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ_MAX)) {
> >>+        cfg->buckets[THROTTLE_BPS_READ].max  =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE_MAX)) {
> >>+        cfg->buckets[THROTTLE_BPS_WRITE].max =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL_MAX)) {
> >>+        cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ_MAX)) {
> >>+        cfg->buckets[THROTTLE_OPS_READ].max =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE_MAX)) {
> >>+        cfg->buckets[THROTTLE_OPS_WRITE].max =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX, 0);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH)) {
> >>+        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1=
);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ_MAX_LENGTH)) {
> >>+        cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH)) {
> >>+        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1=
);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH)) {
> >>+        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, =
1);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH)) {
> >>+        cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH, 1=
);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH)) {
> >>+        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH, =
1);
> >>+    }
> >>+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_SIZE)) {
> >>+        cfg->op_size =3D
> >>+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_SIZE, 0);
> >>+    }
> >>+}
> >>+
> >>+static int throttle_configure_tgm(BlockDriverState *bs, ThrottleGroupM=
ember *tgm,
> >>+                                                    QDict *options, Er=
ror **errp)
> >
> >Both lines exceed 80 characters. The indentation is off, too: QDict on
> >the second line should be aligned with BlockDriverState on the first
> >one.
> >
> >>+{
> >>+    int ret =3D 0;
> >>+    ThrottleState *ts;
> >>+    ThrottleTimers *tt;
> >>+    ThrottleConfig cfg;
> >>+    QemuOpts *opts =3D NULL;
> >>+    const char *group_name =3D NULL;
> >>+    Error *local_err =3D NULL;
> >>+
> >>+    opts =3D qemu_opts_create(&throttle_opts, NULL, 0, &local_err);
> >>+    if (local_err) {
> >>+        error_propagate(errp, local_err);
> >>+        return -EINVAL;
> >>+    }
> >>+    qemu_opts_absorb_qdict(opts, options, &local_err);
> >>+    if (local_err) {
> >>+        goto err;
> >>+    }
> >>+
> >>+    group_name =3D qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
> >>+    if (!group_name) {
> >>+        group_name =3D bdrv_get_device_or_node_name(bs);
> >
> >This is a legacy function, we should avoid adding new callers.
> >
> >Worse yet, if the group isn't specified, we want to create a new
> >group internally just for this throttle node. But nothing stops the user
> >from creating a group that is named like the device or node name of
> >another throttle node, so we might end up attaching to an existing
> >throttle group instead!
> >
> >I think throttle groups should be anonymous rather than having a default
> >name if they are created implicitly.
>=20
> Since we're moving groups to QOM we will need ids for each group.
> Can objects be anonymous?

Hm, that's a good question. But object_new() doesn't take an ID, so I
think they can be anonymous.

Looking a bit closer, strcut Object doesn't even have a field for the
ID. It seems that what the ID really is is the name of a property in a
parent object that points to the new object. So as long as you don't
want to have another QOM object point to it, there is no such thing as
an ID.

Anyway, I followed the call chain from throttle_group_register_tgm() and
it ends in throttle_group_incref() where we simply have this:

    tg =3D g_new0(ThrottleGroup, 1);
    tg->name =3D g_strdup(name);

Shouldn't this be using something a little more QOMy now?

Kevin

--3Pql8miugIZX0722
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZU80WAAoJEH8JsnLIjy/WNkAQAKs8MMI3LPAr7j2s4mFlDEcl
qdvfmzrjUztWNtLfStQ0Xg7Z4LWr9c0vR+lMW2vdI7UYLTDTZ0XZc09fM4Lln1ix
zhzpAWeMeQzazXUsI2R7E/uNMht0zXl6/NUUG0XtXMOAyrOfwItSzmF3mkUtvqWj
oqKcspmhWis22pTLdOlBpEO/y3OWjU5ZeotEQmZZSwF9TqFkBgifDOLxgMjpqFIP
Xs/kMPTBQXmSRz7rkJxy0UqnVQAJnKfJ8kSfT4a76o8EASXP/ZEp9ylBWJTFmHXP
6maT4m7kB6/6FT0CunA2NUdQ/icpKr1lBkSkhAEcMMBxscH47oaPwzHPqA12tqh1
cjnbayqa1iNRvxiA9vwFTOcNyo0iYEDzqH9XB0HheycrUiUSmA+TRnGF0l2ObKJV
UmcpIdAUy5eSAhwLKXdM/KoMyC/3F11bgpMIs8+7E9OshqGQaNel+CnhU6G6GG9j
FOK2K8nyFlYBB3a+lM0F/ADka/nXq6rzBmCulAZpyBn+26jD4objwCcZsGiODUeb
IAFPFo4xpk1wNfidCDIzKO6ngXkJs6X6kbXkywG73elO4nJqK2NAmK+oJ5sN1SKC
wQ7N0w66AdUzZe9kUngH+teFgITso7fzywKNFqgnUm7KkCkxbn1nRnjASoFubjHf
NA6S6fxlKGAhB6aP95Pz
=Mz96
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
