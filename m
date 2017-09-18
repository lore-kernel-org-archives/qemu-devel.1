Received: from eggs.gnu.org ([2001:4830:134:3::10]:45917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dtynm-00005O-Ui
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dtyni-0007iX-Ou
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:21:42 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:45009)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dtyni-0007fm-7p
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:21:38 -0400
Date: Mon, 18 Sep 2017 19:20:33 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170918162033.ee7fuarojpkwp5wr@postretch>
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-2-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhsjxyjhaxfjd4nl"
Content-Disposition: inline
In-Reply-To: <1505385610-35529-2-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v11 1/6] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, qemu-devel@nongnu.org, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>


--jhsjxyjhaxfjd4nl
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 06:40:05AM -0400, Pradeep Jagadeesh wrote:
>This patch factors out the duplicate throttle code that was still
>present in block and fsdev devices.
>
>Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>Reviewed-by: Alberto Garcia <berto@igalia.com>
>Reviewed-by: Greg Kurz <groug@kaod.org>
>Reviewed-by: Eric Blake <eblake@redhat.com>
>---
> blockdev.c                      | 44 +---------------------------------
> fsdev/qemu-fsdev-throttle.c     | 44 ++--------------------------------
> include/qemu/throttle-options.h |  3 +++
> include/qemu/throttle.h         |  4 ++--
> include/qemu/typedefs.h         |  1 +
> util/throttle.c                 | 52 ++++++++++++++++++++++++++++++++++++=
+++++
> 6 files changed, 61 insertions(+), 87 deletions(-)
>
>diff --git a/blockdev.c b/blockdev.c
>index 56a6b24..9d33c25 100644
>--- a/blockdev.c
>+++ b/blockdev.c
>@@ -387,49 +387,7 @@ static void extract_common_blockdev_options(QemuOpts =
*opts, int *bdrv_flags,
>     }
>
>     if (throttle_cfg) {
>-        throttle_config_init(throttle_cfg);
>-        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
>-            qemu_opt_get_number(opts, "throttling.bps-total", 0);
>-        throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =3D
>-            qemu_opt_get_number(opts, "throttling.bps-read", 0);
>-        throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
>-            qemu_opt_get_number(opts, "throttling.bps-write", 0);
>-        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
>-            qemu_opt_get_number(opts, "throttling.iops-total", 0);
>-        throttle_cfg->buckets[THROTTLE_OPS_READ].avg =3D
>-            qemu_opt_get_number(opts, "throttling.iops-read", 0);
>-        throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
>-            qemu_opt_get_number(opts, "throttling.iops-write", 0);
>-
>-        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
>-            qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
>-        throttle_cfg->buckets[THROTTLE_BPS_READ].max  =3D
>-            qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
>-        throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =3D
>-            qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
>-        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
>-            qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
>-        throttle_cfg->buckets[THROTTLE_OPS_READ].max =3D
>-            qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
>-        throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =3D
>-            qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
>-
>-        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
>-            qemu_opt_get_number(opts, "throttling.bps-total-max-length", =
1);
>-        throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
>-            qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1=
);
>-        throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
>-            qemu_opt_get_number(opts, "throttling.bps-write-max-length", =
1);
>-        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
>-            qemu_opt_get_number(opts, "throttling.iops-total-max-length",=
 1);
>-        throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
>-            qemu_opt_get_number(opts, "throttling.iops-read-max-length", =
1);
>-        throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
>-            qemu_opt_get_number(opts, "throttling.iops-write-max-length",=
 1);
>-
>-        throttle_cfg->op_size =3D
>-            qemu_opt_get_number(opts, "throttling.iops-size", 0);
>-
>+        throttle_parse_options(throttle_cfg, opts);
>         if (!throttle_is_valid(throttle_cfg, errp)) {
>             return;
>         }
>diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
>index 49eebb5..0e6fb86 100644
>--- a/fsdev/qemu-fsdev-throttle.c
>+++ b/fsdev/qemu-fsdev-throttle.c
>@@ -16,6 +16,7 @@
> #include "qemu/error-report.h"
> #include "qemu-fsdev-throttle.h"
> #include "qemu/iov.h"
>+#include "qemu/throttle-options.h"
>
> static void fsdev_throttle_read_timer_cb(void *opaque)
> {
>@@ -31,48 +32,7 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
>
> void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **e=
rrp)
> {
>-    throttle_config_init(&fst->cfg);
>-    fst->cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D
>-        qemu_opt_get_number(opts, "throttling.bps-total", 0);
>-    fst->cfg.buckets[THROTTLE_BPS_READ].avg  =3D
>-        qemu_opt_get_number(opts, "throttling.bps-read", 0);
>-    fst->cfg.buckets[THROTTLE_BPS_WRITE].avg =3D
>-        qemu_opt_get_number(opts, "throttling.bps-write", 0);
>-    fst->cfg.buckets[THROTTLE_OPS_TOTAL].avg =3D
>-        qemu_opt_get_number(opts, "throttling.iops-total", 0);
>-    fst->cfg.buckets[THROTTLE_OPS_READ].avg =3D
>-        qemu_opt_get_number(opts, "throttling.iops-read", 0);
>-    fst->cfg.buckets[THROTTLE_OPS_WRITE].avg =3D
>-        qemu_opt_get_number(opts, "throttling.iops-write", 0);
>-
>-    fst->cfg.buckets[THROTTLE_BPS_TOTAL].max =3D
>-        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
>-    fst->cfg.buckets[THROTTLE_BPS_READ].max  =3D
>-        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
>-    fst->cfg.buckets[THROTTLE_BPS_WRITE].max =3D
>-        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
>-    fst->cfg.buckets[THROTTLE_OPS_TOTAL].max =3D
>-        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
>-    fst->cfg.buckets[THROTTLE_OPS_READ].max =3D
>-        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
>-    fst->cfg.buckets[THROTTLE_OPS_WRITE].max =3D
>-        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
>-
>-    fst->cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =3D
>-        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
>-    fst->cfg.buckets[THROTTLE_BPS_READ].burst_length  =3D
>-        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
>-    fst->cfg.buckets[THROTTLE_BPS_WRITE].burst_length =3D
>-        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
>-    fst->cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =3D
>-        qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
>-    fst->cfg.buckets[THROTTLE_OPS_READ].burst_length =3D
>-        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
>-    fst->cfg.buckets[THROTTLE_OPS_WRITE].burst_length =3D
>-        qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
>-    fst->cfg.op_size =3D
>-        qemu_opt_get_number(opts, "throttling.iops-size", 0);
>-
>+    throttle_parse_options(&fst->cfg, opts);
>     throttle_is_valid(&fst->cfg, errp);
> }
>
>diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-optio=
ns.h
>index 3528a8f..9709dcd 100644
>--- a/include/qemu/throttle-options.h
>+++ b/include/qemu/throttle-options.h
>@@ -9,6 +9,7 @@
>  */
> #ifndef THROTTLE_OPTIONS_H
> #define THROTTLE_OPTIONS_H
>+#include "typedefs.h"
>
> #define QEMU_OPT_IOPS_TOTAL "iops-total"
> #define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
>@@ -111,4 +112,6 @@
>             .help =3D "when limiting by iops max size of an I/O in bytes"=
,\
>         }
>
>+void throttle_parse_options(ThrottleConfig *, QemuOpts *);
>+
> #endif
>diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
>index 8c93237..b6ebc6d 100644
>--- a/include/qemu/throttle.h
>+++ b/include/qemu/throttle.h
>@@ -89,10 +89,10 @@ typedef struct LeakyBucket {
>  * However it allows to keep the code clean and the bucket field is reset=
 to
>  * zero at the right time.
>  */
>-typedef struct ThrottleConfig {
>+struct ThrottleConfig {
>     LeakyBucket buckets[BUCKETS_COUNT]; /* leaky buckets */
>     uint64_t op_size;         /* size of an operation in bytes */
>-} ThrottleConfig;
>+};
>
> typedef struct ThrottleState {
>     ThrottleConfig cfg;       /* configuration */
>diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>index 39bc835..90fe0f9 100644
>--- a/include/qemu/typedefs.h
>+++ b/include/qemu/typedefs.h
>@@ -100,6 +100,7 @@ typedef struct uWireSlave uWireSlave;
> typedef struct VirtIODevice VirtIODevice;
> typedef struct Visitor Visitor;
> typedef struct node_info NodeInfo;
>+typedef struct ThrottleConfig ThrottleConfig;

Is this really needed? Just include include/qemu/throttle.h wherever you=20
need.

> typedef void SaveStateHandler(QEMUFile *f, void *opaque);
> typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
>
>diff --git a/util/throttle.c b/util/throttle.c
>index 06bf916..9ef28c4 100644
>--- a/util/throttle.c
>+++ b/util/throttle.c
>@@ -27,6 +27,7 @@
> #include "qemu/throttle.h"
> #include "qemu/timer.h"
> #include "block/aio.h"
>+#include "qemu/throttle-options.h"
>
> /* This function make a bucket leak
>  *
>@@ -635,3 +636,54 @@ void throttle_config_to_limits(ThrottleConfig *cfg, T=
hrottleLimits *var)
>     var->has_iops_write_max_length =3D true;
>     var->has_iops_size =3D true;
> }
>+
>+/* parse the throttle options
>+ *
>+ * @opts: qemu options
>+ * @throttle_cfg: throttle configuration
>+ */
>+void throttle_parse_options(ThrottleConfig *throttle_cfg, QemuOpts *opts)
>+{
>+    throttle_config_init(throttle_cfg);
>+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
>+        qemu_opt_get_number(opts, "throttling.bps-total", 0);
>+    throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =3D
>+        qemu_opt_get_number(opts, "throttling.bps-read", 0);
>+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
>+        qemu_opt_get_number(opts, "throttling.bps-write", 0);
>+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
>+        qemu_opt_get_number(opts, "throttling.iops-total", 0);
>+    throttle_cfg->buckets[THROTTLE_OPS_READ].avg =3D
>+        qemu_opt_get_number(opts, "throttling.iops-read", 0);
>+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
>+        qemu_opt_get_number(opts, "throttling.iops-write", 0);
>+
>+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
>+        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
>+    throttle_cfg->buckets[THROTTLE_BPS_READ].max  =3D
>+        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
>+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =3D
>+        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
>+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
>+        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
>+    throttle_cfg->buckets[THROTTLE_OPS_READ].max =3D
>+        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
>+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =3D
>+        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
>+
>+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
>+        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
>+    throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
>+        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
>+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
>+        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
>+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
>+        qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
>+    throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
>+        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
>+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
>+        qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
>+
>+    throttle_cfg->op_size =3D
>+        qemu_opt_get_number(opts, "throttling.iops-size", 0);
>+}

You should reuse the #define's in include/qemu/throttle-options.h
See throttle_extract_options() in this patch:=20
http://patchwork.ozlabs.org/patch/803919/ Disregard the UINT_MAX checks,=20
unsigned ints in LeakyBucket were replaced by uint64_t.

Don't forget to drop the reviews when you change a patch! The original=20
reviews will probably not be valid anymore.

--jhsjxyjhaxfjd4nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlm/8lEACgkQc2J8L2kN
9xDR5w/+JXi1UMYGkApml4XepMI+9YBPXSh+/LlVTLKON1kGLJSDVA+U1p0lfgGP
IC7tVcy2LAWGw3Ld9uBsyDvbgcivavakUViKD+E0+EFnarx12xHCBB1p+ZM8VkjL
KOII6s6UKKu40wG1zJ/tmqwrIqSdqHsFZto2MMvC/JkvUZpzryuKhMghry8cRlIr
7iHQOZEjOrhG3yDaULNGr40ghJ5L5i3K4j9KhVLhdx7hbo1HE1V3vXerwxOJBi3Q
5E9hTp/gTlcHDYkp3kx2xKqcdTfcMj6epAVtYC8NqoJENgSYDBR3TAebGrmBlnoz
6dUURl/TiDXIswf7/JfXX3jQNCS1hY64ekL2O7rExylWXfcPdnadTY3GZyf/70dU
ifzTk3GJNQDj4iT4T+13r4txpLt7e59iGIZ19phWPJ3NcXutm5UCTWxLukSJSraU
4Xs77uZVGJbWOomfT55ta+qb9JV8RNZwXXcSxNtXqlFiBhS0Sg+K00nMob1tNW1M
lHP4v0GT4i24sZ7+h+Idtc4inbso20tUr03YcanTT6715+2OGuniuZ2TjLiqLHyh
ADQElgjpqV4+6oZMZe8fBY6MgYbcRV6lv4FnH399pue2FEnXgjM2JJKXsd/h3RT0
aKnG9rq+I4kI/wRurjBE8pwnfBc8XC6RoZAXDSG32WRhwgE5DcQ=
=YvRV
-----END PGP SIGNATURE-----

--jhsjxyjhaxfjd4nl--
