Received: from eggs.gnu.org ([2001:4830:134:3::10]:33584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1gEt2S-0001Pp-Fi
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1gEt2O-0007LC-4m
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:31:48 -0400
Received: from mail-eopbgr690088.outbound.protection.outlook.com
	([40.107.69.88]:17488
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Manish.Jaggi@cavium.com>)
	id 1gEt2N-000724-Pv
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:31:43 -0400
From: <mjaggi@caviumnetworks.com>
Date: Tue, 23 Oct 2018 09:31:18 +0000
Message-ID: <1db52b5ec7066f2fbc286288f97cc4946f94145e.1536948621.git.manish.jaggi@cavium.com>
References: <cover.1536948621.git.manish.jaggi@cavium.com>
In-Reply-To: <cover.1536948621.git.manish.jaggi@cavium.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 1/2] [RFC] arm: Introduce hostinvariant
 command line option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, "Nowicki,
	Tomasz" <Tomasz.Nowicki@cavium.com>

From: Manish Jaggi <manish.jaggi@cavium.com>

This option is user opt-in. hostinvariant will replace guest's invariant
registers with hosts.

Signed-off-by: Manish Jaggi <manish.jaggi@cavium.com>

diff --git a/qemu-options.hx b/qemu-options.hx
index 654ef48..d8c0da7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3896,6 +3896,19 @@ STEXI
 prepend a timestamp to each log message.(default:on)
 ETEXI
=20
+DEF("hostinvariant", HAS_ARG, QEMU_OPTION_hostinvariant,
+    "-hostinvariant enable[=3Don|off]\n"
+    "                migrated guest should use invariant register values o=
f host\n"
+    "                on|off controls migration between arch64 systems usin=
g -cpu host but with different MIDR values (default:off)\n",
+    QEMU_ARCH_ARM)
+STEXI
+@item -hostinvariant enable[=3Don|off]
+@findex -hostinvariant
+controls migration between arch64 systems using -cpu host but with differe=
nt MIDR values.(default:off)
+ETEXI
+
+
+
 DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
     "-dump-vmstate <file>\n"
     "                Output vmstate information in JSON format to file.\n"
diff --git a/vl.c b/vl.c
index 5ba06ad..b6df5f0 100644
--- a/vl.c
+++ b/vl.c
@@ -144,6 +144,7 @@ const char *mem_path =3D NULL;
 int mem_prealloc =3D 0; /* force preallocation of physical target memory *=
/
 bool enable_mlock =3D false;
 bool enable_cpu_pm =3D false;
+bool enable_hostinvariant =3D false;
 int nb_nics;
 NICInfo nd_table[MAX_NICS];
 int autostart;
@@ -420,6 +421,19 @@ static QemuOptsList qemu_msg_opts =3D {
     },
 };
=20
+static QemuOptsList qemu_hostinvariant_opts =3D {
+    .name =3D "hostinvariant",
+    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_hostinvariant_opts.head),
+    .desc =3D {
+        {
+            .name =3D "enable",
+            .type =3D QEMU_OPT_BOOL,
+        },
+        { /* end of list */ }
+    },
+};
+
+
 static QemuOptsList qemu_name_opts =3D {
     .name =3D "name",
     .implied_opt_name =3D "guest",
@@ -2989,6 +3003,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_realtime_opts);
     qemu_add_opts(&qemu_overcommit_opts);
     qemu_add_opts(&qemu_msg_opts);
+    qemu_add_opts(&qemu_hostinvariant_opts);
     qemu_add_opts(&qemu_name_opts);
     qemu_add_opts(&qemu_numa_opts);
     qemu_add_opts(&qemu_icount_opts);
@@ -3948,6 +3963,15 @@ int main(int argc, char **argv, char **envp)
                 }
                 configure_msg(opts);
                 break;
+            case QEMU_OPTION_hostinvariant:
+                opts =3D qemu_opts_parse_noisily(qemu_find_opts("hostinvar=
iant"), optarg,
+                                               false);
+                if (!opts) {
+                    exit(1);
+                }
+                enable_hostinvariant =3D qemu_opt_get_bool(opts, "hostinva=
riant", true);
+                error_report("Host Invariant=3D%d", enable_hostinvariant);
+                break;
             case QEMU_OPTION_dump_vmstate:
                 if (vmstate_dump_file) {
                     error_report("only one '-dump-vmstate' "
--=20
1.8.3.1
