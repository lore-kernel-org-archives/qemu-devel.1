Received: from eggs.gnu.org ([2001:4830:134:3::10]:34972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPUaI-0001jk-9S
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPUaH-0003el-5H
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:01:46 -0400
Date: Mon, 26 Jun 2017 17:00:54 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170626140054.7aeo7m3ofhes5sst@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="or4ojdmw3nonecez"
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 3/8] block: add
 throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--or4ojdmw3nonecez
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 03:46:55PM +0300, Manos Pitsidianakis wrote:
>+static QemuOptsList throttle_opts =3D {
>+    .name =3D "throttle",
>+    .head =3D QTAILQ_HEAD_INITIALIZER(throttle_opts.head),
>+    .desc =3D {
>+        {
>+            .name =3D QEMU_OPT_IOPS_TOTAL,

throttle_opts should use THROTTLE_OPTS from throttle-options.h (how many=20
times can you say throttle opts in a sentence?), this will be corrected.

>+
>+static int throttle_configure_tgm(BlockDriverState *bs, ThrottleGroupMemb=
er *tgm,
>+                                                    QDict *options, Error=
 **errp)
>+{
> ....
>+    /* Copy previous configuration */
>+    throttle_get_config(ts, &cfg);
> ....
>+    /* Update group configuration */
>+    throttle_config(ts, tt, &cfg);

These should be throttle_group_get_config() and throttle_group_config()=20
respectively, to use the throttle group locks.

>+
>+block_init(bdrv_throttle_init);
>diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-optio=
ns.h
>index 3133d1ca40..508ee72625 100644
>--- a/include/qemu/throttle-options.h
>+++ b/include/qemu/throttle-options.h
>@@ -10,81 +10,103 @@
> #ifndef THROTTLE_OPTIONS_H
> #define THROTTLE_OPTIONS_H
>
>+#define QEMU_OPT_IOPS_TOTAL "iops-total"
>+#define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
>+#define QEMU_OPT_IOPS_TOTAL_MAX_LENGTH "iops-total-max-length"
>+#define QEMU_OPT_IOPS_READ "iops-read"
>+#define QEMU_OPT_IOPS_READ_MAX "iops-read-max"
>+#define QEMU_OPT_IOPS_READ_MAX_LENGTH "iops-read-max-length"
>+#define QEMU_OPT_IOPS_WRITE "iops-write"
>+#define QEMU_OPT_IOPS_WRITE_MAX "iops-write-max"
>+#define QEMU_OPT_IOPS_WRITE_MAX_LENGTH "iops-write-max-length"
>+#define QEMU_OPT_BPS_TOTAL "bps-total"
>+#define QEMU_OPT_BPS_TOTAL_MAX "bps-total-max"
>+#define QEMU_OPT_BPS_TOTAL_MAX_LENGTH "bps-total-max-length"
>+#define QEMU_OPT_BPS_READ "bps-read"
>+#define QEMU_OPT_BPS_READ_MAX "bps-read-max"
>+#define QEMU_OPT_BPS_READ_MAX_LENGTH "bps-read-max-length"
>+#define QEMU_OPT_BPS_WRITE "bps-write"
>+#define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
>+#define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
>+#define QEMU_OPT_IOPS_SIZE "iops-size"
>+#define QEMU_OPT_THROTTLE_GROUP_NAME "throttling-group"
>+
>+#define THROTTLE_OPT_PREFIX "throttling."
> #define THROTTLE_OPTS \
>           { \
>-            .name =3D "throttling.iops-total",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "limit total I/O operations per second",\
>         },{ \
>-            .name =3D "throttling.iops-read",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "limit read operations per second",\
>         },{ \
>-            .name =3D "throttling.iops-write",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "limit write operations per second",\
>         },{ \
>-            .name =3D "throttling.bps-total",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "limit total bytes per second",\
>         },{ \
>-            .name =3D "throttling.bps-read",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "limit read bytes per second",\
>         },{ \
>-            .name =3D "throttling.bps-write",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "limit write bytes per second",\
>         },{ \
>-            .name =3D "throttling.iops-total-max",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "I/O operations burst",\
>         },{ \
>-            .name =3D "throttling.iops-read-max",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "I/O operations read burst",\
>         },{ \
>-            .name =3D "throttling.iops-write-max",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "I/O operations write burst",\
>         },{ \
>-            .name =3D "throttling.bps-total-max",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "total bytes burst",\
>         },{ \
>-            .name =3D "throttling.bps-read-max",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "total bytes read burst",\
>         },{ \
>-            .name =3D "throttling.bps-write-max",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "total bytes write burst",\
>         },{ \
>-            .name =3D "throttling.iops-total-max-length",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX_LENGTH,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "length of the iops-total-max burst period, in seco=
nds",\
>         },{ \
>-            .name =3D "throttling.iops-read-max-length",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX_LENGTH,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "length of the iops-read-max burst period, in secon=
ds",\
>         },{ \
>-            .name =3D "throttling.iops-write-max-length",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX_LENGTH,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "length of the iops-write-max burst period, in seco=
nds",\
>         },{ \
>-            .name =3D "throttling.bps-total-max-length",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX_LENGTH,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "length of the bps-total-max burst period, in secon=
ds",\
>         },{ \
>-            .name =3D "throttling.bps-read-max-length",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_LENGTH,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "length of the bps-read-max burst period, in second=
s",\
>         },{ \
>-            .name =3D "throttling.bps-write-max-length",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX_LENGTH,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "length of the bps-write-max burst period, in secon=
ds",\
>         },{ \
>-            .name =3D "throttling.iops-size",\
>+            .name =3D THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE,\
>             .type =3D QEMU_OPT_NUMBER,\
>             .help =3D "when limiting by iops max size of an I/O in bytes"=
,\
>         }
>--=20
>2.11.0
>
>
>

--or4ojdmw3nonecez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllRE5YACgkQc2J8L2kN
9xCJ5w/+MNUmjDaf2LKr5gmUdxroHYa7sYCMfvr+wzqzZmoVOnke9V/a0lKSF9CX
57hiGVlUf5Ax4HpEeIAFyKaX3RvtliX91s5p61/R1IF+lAr3HIf2pICQAQatO4K2
kkLFuehYap5GTaaDrmooBlBF8om6jpau/1b/BKm0f5Z4T3P2/haUwYPfHLlA9CfA
dzGKe+Z4Q+1tkcIrEDFjksMEciHl7kJgeTnKeVWxg2+Eb1NVguTzjgdZ6BPOH3TN
TG4ZhDoPqpnsWwX4sXIyJ8bYDj0ZDSE6IxK+lghS0lXnZ+YVGJLvEO+Xka+qUbxJ
m89GLVeVAQErSGw2KvldXr1ZZ5o/+ZfVb+PkMZbx2xOpw6x/JbI86Q56eBAjQYVm
soF2bdimu0wbZu+BGPDERJC53z5spl9Wz8IJXXvwYqWt1H0Bn4VM1wBWWogAWhbZ
gVeB+FxflA9P0VzO0sheSE5abC1WQ8WF9bpw6lX+E4lw/i3xtzf3JDoKBnwSQB47
RGeB+lsl79Dt2CBHZAIsTe/VP1BFJnhzcYgo1uW+NfYFUuXANRuCRoixIwVrGFAC
0DmRTcRY89iNWycSrunYPj6PyFUi2rsyWTcmrK6vBF4/2ReID8NmyRBU6UHdvyRo
2fw4YgAyaINk3++88UEVrhwl+ZAZGc69UvqAPao9CuwABtv/sQg=
=r+9N
-----END PGP SIGNATURE-----

--or4ojdmw3nonecez--
