Received: from eggs.gnu.org ([2001:4830:134:3::10]:39612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvf3l-0001A2-ND
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvexR-0007Ho-E9
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvexR-0007H4-77
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:09 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 31 Aug 2018 10:38:50 +0200
Message-Id: <1535704738-8986-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1535704738-8986-1-git-send-email-thuth@redhat.com>
References: <1535704738-8986-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] Remove the deprecated -balloon option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The "-balloon" option has been replaced by "-device virtio-balloon".
It's been marked as deprecated since two releases, and nobody
complained, so let's remove it now.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Peter Krempa <pkrempa@redhat.com>
Acked-by: J=C3=A1n Tomko <jtomko@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/virtio-balloon-stats.txt |  6 +++---
 qemu-deprecated.texi          |  5 -----
 qemu-options.hx               | 10 ----------
 vl.c                          | 36 ------------------------------------
 4 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/docs/virtio-balloon-stats.txt b/docs/virtio-balloon-stats.tx=
t
index 9985e1d..1732cc8 100644
--- a/docs/virtio-balloon-stats.txt
+++ b/docs/virtio-balloon-stats.txt
@@ -61,9 +61,9 @@ It's also important to note the following:
    respond to the request the timer will never be re-armed, which has
    the same effect as disabling polling
=20
-Here are a few examples. QEMU is started with '-balloon virtio', which
-generates '/machine/peripheral-anon/device[1]' as the QOM path for the
-balloon device.
+Here are a few examples. QEMU is started with '-device virtio-balloon',
+which generates '/machine/peripheral-anon/device[1]' as the QOM path for
+the balloon device.
=20
 Enable polling with 2 seconds interval:
=20
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 1b9c007..98f5062 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -86,11 +86,6 @@ enabled via the ``-machine usb=3Don'' argument.
=20
 The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
=20
-@subsection -balloon (since 2.12.0)
-
-The @option{--balloon virtio} argument has been superseded by
-@option{--device virtio-balloon}.
-
 @subsection -fsdev handle (since 2.12.0)
=20
 The ``handle'' fsdev backend does not support symlinks and causes the 9p
diff --git a/qemu-options.hx b/qemu-options.hx
index 654ef48..ccf7155 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -454,16 +454,6 @@ modprobe i810_audio clocking=3D48000
 @end example
 ETEXI
=20
-DEF("balloon", HAS_ARG, QEMU_OPTION_balloon,
-    "-balloon virtio[,addr=3Dstr]\n"
-    "                enable virtio balloon device (deprecated)\n", QEMU_=
ARCH_ALL)
-STEXI
-@item -balloon virtio[,addr=3D@var{addr}]
-@findex -balloon
-Enable virtio balloon device, optionally with PCI address @var{addr}. Th=
is
-option is deprecated, use @option{-device virtio-balloon} instead.
-ETEXI
-
 DEF("device", HAS_ARG, QEMU_OPTION_device,
     "-device driver[,prop[=3Dvalue][,...]]\n"
     "                add device (based on driver)\n"
diff --git a/vl.c b/vl.c
index 5ba06ad..674c42f 100644
--- a/vl.c
+++ b/vl.c
@@ -2127,36 +2127,6 @@ static void parse_display(const char *p)
     }
 }
=20
-static int balloon_parse(const char *arg)
-{
-    QemuOpts *opts;
-
-    warn_report("This option is deprecated. "
-                "Use '--device virtio-balloon' to enable the balloon dev=
ice.");
-
-    if (strcmp(arg, "none") =3D=3D 0) {
-        return 0;
-    }
-
-    if (!strncmp(arg, "virtio", 6)) {
-        if (arg[6] =3D=3D ',') {
-            /* have params -> parse them */
-            opts =3D qemu_opts_parse_noisily(qemu_find_opts("device"), a=
rg + 7,
-                                           false);
-            if (!opts)
-                return  -1;
-        } else {
-            /* create empty opts */
-            opts =3D qemu_opts_create(qemu_find_opts("device"), NULL, 0,
-                                    &error_abort);
-        }
-        qemu_opt_set(opts, "driver", "virtio-balloon", &error_abort);
-        return 0;
-    }
-
-    return -1;
-}
-
 char *qemu_find_file(int type, const char *name)
 {
     int i;
@@ -3660,12 +3630,6 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_no_hpet:
                 no_hpet =3D 1;
                 break;
-            case QEMU_OPTION_balloon:
-                if (balloon_parse(optarg) < 0) {
-                    error_report("unknown -balloon argument %s", optarg)=
;
-                    exit(1);
-                }
-                break;
             case QEMU_OPTION_no_reboot:
                 no_reboot =3D 1;
                 break;
--=20
1.8.3.1
