Received: from eggs.gnu.org ([2001:4830:134:3::10]:32788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6SD-0001Iy-Vl
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6SA-0006kX-1w
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1df6S9-0006im-Mw
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6AE178EC2
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 15:29:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  8 Aug 2017 17:29:41 +0200
Message-Id: <20170808152941.11247-10-pbonzini@redhat.com>
In-Reply-To: <20170808152941.11247-1-pbonzini@redhat.com>
References: <20170808152941.11247-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] maint: Include bug-reporting info in --help
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

These days, many programs are including a bug-reporting address,
or better yet, a link to the project web site, at the tail of
their --help output.  However, we were not very consistent at
doing so: only qemu-nbd and qemu-qa mentioned anything, with the
latter pointing to an individual person instead of the project.

Add a new #define that sets up a uniform string, mentioning both
bug reporting instructions and overall project details, and which
a downstream vendor could tweak if they want bugs to go to a
downstream database.  Then use it in all of our binaries which
have --help output.

The canned text intentionally references http:// instead of https://
because our https website currently causes certificate errors in
some browsers.  That can be tweaked later once we have resolved the
web site issued.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170803163353.19558-5-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/main.c       | 2 ++
 include/qemu-common.h | 5 +++++
 linux-user/main.c     | 4 +++-
 qemu-img.c            | 2 +-
 qemu-io.c             | 5 +++--
 qemu-nbd.c            | 2 +-
 qga/main.c            | 2 +-
 vl.c                  | 4 +++-
 8 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 501e16f675..8a6706a1c8 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -686,6 +686,8 @@ static void usage(void)
            "    -E var1=3Dval2 -E var2=3Dval2 -U LD_PRELOAD -U LD_DEBUG\=
n"
            "Note that if you provide several changes to single variable\=
n"
            "last change will stay in effect.\n"
+           "\n"
+           QEMU_HELP_BOTTOM "\n"
            ,
            TARGET_NAME,
            interp_prefix,
diff --git a/include/qemu-common.h b/include/qemu-common.h
index b5adbfa5e9..0456c79df4 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -22,6 +22,11 @@
 #define QEMU_COPYRIGHT "Copyright (c) 2003-2017 " \
     "Fabrice Bellard and the QEMU Project developers"
=20
+/* Bug reporting information for --help arguments, About dialogs, etc */
+#define QEMU_HELP_BOTTOM \
+    "See <http://qemu.org/contribute/report-a-bug> for how to report bug=
s.\n" \
+    "More information on the QEMU project at <http://qemu.org>."
+
 /* main function, renamed */
 #if defined(CONFIG_COCOA)
 int qemu_main(int argc, char **argv, char **envp);
diff --git a/linux-user/main.c b/linux-user/main.c
index 2b38d39d87..03666ef657 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4136,7 +4136,9 @@ static void usage(int exitcode)
            "    -E var1=3Dval2,var2=3Dval2 -U LD_PRELOAD,LD_DEBUG\n"
            "    QEMU_SET_ENV=3Dvar1=3Dval2,var2=3Dval2 QEMU_UNSET_ENV=3D=
LD_PRELOAD,LD_DEBUG\n"
            "Note that if you provide several changes to a single variabl=
e\n"
-           "the last change will stay in effect.\n");
+           "the last change will stay in effect.\n"
+           "\n"
+           QEMU_HELP_BOTTOM "\n");
=20
     exit(exitcode);
 }
diff --git a/qemu-img.c b/qemu-img.c
index f4d5f0d77d..56ef49e214 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -201,7 +201,7 @@ static void QEMU_NORETURN help(void)
=20
     printf("%s\nSupported formats:", help_msg);
     bdrv_iterate_format(format_print, NULL);
-    printf("\n");
+    printf("\n\n" QEMU_HELP_BOTTOM "\n");
     exit(EXIT_SUCCESS);
 }
=20
diff --git a/qemu-io.c b/qemu-io.c
index ec175630a6..265445ad89 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -262,8 +262,9 @@ static void usage(const char *name)
 "  -h, --help           display this help and exit\n"
 "  -V, --version        output version information and exit\n"
 "\n"
-"See '%s -c help' for information on available commands."
-"\n",
+"See '%s -c help' for information on available commands.\n"
+"\n"
+QEMU_HELP_BOTTOM "\n",
     name, name);
 }
=20
diff --git a/qemu-nbd.c b/qemu-nbd.c
index b8666bb575..27164b8205 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -123,7 +123,7 @@ static void usage(const char *name)
 "      --detect-zeroes=3DMODE  set detect-zeroes mode (off, on, unmap)\n=
"
 "      --image-opts          treat FILE as a full set of image options\n=
"
 "\n"
-"Report bugs to <qemu-devel@nongnu.org>\n"
+QEMU_HELP_BOTTOM "\n"
     , name, NBD_DEFAULT_PORT, "DEVICE");
 }
=20
diff --git a/qga/main.c b/qga/main.c
index b64c7ac2a2..62a62755bd 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -249,7 +249,7 @@ QEMU_COPYRIGHT "\n"
 "                    options / command-line parameters to stdout\n"
 "  -h, --help        display this help and exit\n"
 "\n"
-"Report bugs to <mdroth@linux.vnet.ibm.com>\n"
+QEMU_HELP_BOTTOM "\n"
     , cmd, QGA_VIRTIO_PATH_DEFAULT, QGA_SERIAL_PATH_DEFAULT,
     dfl_pathnames.pidfile,
 #ifdef CONFIG_FSFREEZE
diff --git a/vl.c b/vl.c
index 8967115514..8e247cc2a2 100644
--- a/vl.c
+++ b/vl.c
@@ -1942,7 +1942,9 @@ static void help(int exitcode)
            "ctrl-alt-n      switch to virtual console 'n'\n"
            "ctrl-alt        toggle mouse and keyboard grab\n"
            "\n"
-           "When using -nographic, press 'ctrl-a h' to get some help.\n"=
);
+           "When using -nographic, press 'ctrl-a h' to get some help.\n"
+           "\n"
+           QEMU_HELP_BOTTOM "\n");
=20
     exit(exitcode);
 }
--=20
2.13.3
