Received: from eggs.gnu.org ([2001:4830:134:3::10]:57217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6b-0005jI-PS
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6Y-0002NH-FI
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:26 +0100
Message-Id: <20171222151846.28110-16-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 15/35] block: Remove the deprecated -hdachs
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

It's been marked as deprecated since QEMU v2.10.0, and so far nobody
complained that we should keep it, so let's remove this legacy option
now to simplify the code quite a bit.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 vl.c            | 86 ++-------------------------------------------------------
 qemu-doc.texi   |  8 ------
 qemu-options.hx | 19 ++-----------
 3 files changed, 4 insertions(+), 109 deletions(-)

diff --git a/vl.c b/vl.c
index d3a5c5d021..444b7507da 100644
--- a/vl.c
+++ b/vl.c
@@ -3052,9 +3052,8 @@ int main(int argc, char **argv, char **envp)
     const char *boot_order = NULL;
     const char *boot_once = NULL;
     DisplayState *ds;
-    int cyls, heads, secs, translation;
     QemuOpts *opts, *machine_opts;
-    QemuOpts *hda_opts = NULL, *icount_opts = NULL, *accel_opts = NULL;
+    QemuOpts *icount_opts = NULL, *accel_opts = NULL;
     QemuOptsList *olist;
     int optind;
     const char *optarg;
@@ -3146,8 +3145,6 @@ int main(int argc, char **argv, char **envp)
 
     cpu_model = NULL;
     snapshot = 0;
-    cyls = heads = secs = 0;
-    translation = BIOS_ATA_TRANSLATION_AUTO;
 
     nb_nics = 0;
 
@@ -3186,7 +3183,7 @@ int main(int argc, char **argv, char **envp)
         if (optind >= argc)
             break;
         if (argv[optind][0] != '-') {
-            hda_opts = drive_add(IF_DEFAULT, 0, argv[optind++], HD_OPTS);
+            drive_add(IF_DEFAULT, 0, argv[optind++], HD_OPTS);
         } else {
             const QEMUOption *popt;
 
@@ -3206,21 +3203,6 @@ int main(int argc, char **argv, char **envp)
                 cpu_model = optarg;
                 break;
             case QEMU_OPTION_hda:
-                {
-                    char buf[256];
-                    if (cyls == 0)
-                        snprintf(buf, sizeof(buf), "%s", HD_OPTS);
-                    else
-                        snprintf(buf, sizeof(buf),
-                                 "%s,cyls=%d,heads=%d,secs=%d%s",
-                                 HD_OPTS , cyls, heads, secs,
-                                 translation == BIOS_ATA_TRANSLATION_LBA ?
-                                 ",trans=lba" :
-                                 translation == BIOS_ATA_TRANSLATION_NONE ?
-                                 ",trans=none" : "");
-                    drive_add(IF_DEFAULT, 0, optarg, buf);
-                    break;
-                }
             case QEMU_OPTION_hdb:
             case QEMU_OPTION_hdc:
             case QEMU_OPTION_hdd:
@@ -3271,70 +3253,6 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_snapshot:
                 snapshot = 1;
                 break;
-            case QEMU_OPTION_hdachs:
-                {
-                    const char *p;
-                    p = optarg;
-                    cyls = strtol(p, (char **)&p, 0);
-                    if (cyls < 1 || cyls > 16383)
-                        goto chs_fail;
-                    if (*p != ',')
-                        goto chs_fail;
-                    p++;
-                    heads = strtol(p, (char **)&p, 0);
-                    if (heads < 1 || heads > 16)
-                        goto chs_fail;
-                    if (*p != ',')
-                        goto chs_fail;
-                    p++;
-                    secs = strtol(p, (char **)&p, 0);
-                    if (secs < 1 || secs > 63)
-                        goto chs_fail;
-                    if (*p == ',') {
-                        p++;
-                        if (!strcmp(p, "large")) {
-                            translation = BIOS_ATA_TRANSLATION_LARGE;
-                        } else if (!strcmp(p, "rechs")) {
-                            translation = BIOS_ATA_TRANSLATION_RECHS;
-                        } else if (!strcmp(p, "none")) {
-                            translation = BIOS_ATA_TRANSLATION_NONE;
-                        } else if (!strcmp(p, "lba")) {
-                            translation = BIOS_ATA_TRANSLATION_LBA;
-                        } else if (!strcmp(p, "auto")) {
-                            translation = BIOS_ATA_TRANSLATION_AUTO;
-                        } else {
-                            goto chs_fail;
-                        }
-                    } else if (*p != '\0') {
-                    chs_fail:
-                        error_report("invalid physical CHS format");
-                        exit(1);
-                    }
-                    if (hda_opts != NULL) {
-                        qemu_opt_set_number(hda_opts, "cyls", cyls,
-                                            &error_abort);
-                        qemu_opt_set_number(hda_opts, "heads", heads,
-                                            &error_abort);
-                        qemu_opt_set_number(hda_opts, "secs", secs,
-                                            &error_abort);
-                        if (translation == BIOS_ATA_TRANSLATION_LARGE) {
-                            qemu_opt_set(hda_opts, "trans", "large",
-                                         &error_abort);
-                        } else if (translation == BIOS_ATA_TRANSLATION_RECHS) {
-                            qemu_opt_set(hda_opts, "trans", "rechs",
-                                         &error_abort);
-                        } else if (translation == BIOS_ATA_TRANSLATION_LBA) {
-                            qemu_opt_set(hda_opts, "trans", "lba",
-                                         &error_abort);
-                        } else if (translation == BIOS_ATA_TRANSLATION_NONE) {
-                            qemu_opt_set(hda_opts, "trans", "none",
-                                         &error_abort);
-                        }
-                    }
-                }
-                error_report("'-hdachs' is deprecated, please use '-device"
-                             " ide-hd,cyls=c,heads=h,secs=s,...' instead");
-                break;
             case QEMU_OPTION_numa:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("numa"),
                                                optarg, true);
diff --git a/qemu-doc.texi b/qemu-doc.texi
index ed55bd477d..96fda9c56e 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2686,14 +2686,6 @@ The ``--net dump'' argument is now replaced with the
 ``-object filter-dump'' argument which works in combination
 with the modern ``-netdev`` backends instead.
 
-@subsection -hdachs (since 2.10.0)
-
-The ``-hdachs'' argument is now a synonym for setting
-the ``cyls'', ``heads'', ``secs'', and ``trans'' properties
-on the ``ide-hd'' device using the ``-device'' argument.
-The new syntax allows different settings to be provided
-per disk.
-
 @subsection -usbdevice (since 2.10.0)
 
 The ``-usbdevice DEV'' argument is now a synonym for setting
diff --git a/qemu-options.hx b/qemu-options.hx
index 94647e21e3..2d39ba0b6d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -846,8 +846,8 @@ of available connectors of a given interface type.
 @item media=@var{media}
 This option defines the type of the media: disk or cdrom.
 @item cyls=@var{c},heads=@var{h},secs=@var{s}[,trans=@var{t}]
-These options have the same definition as they have in @option{-hdachs}.
-These parameters are deprecated, use the corresponding parameters
+Force disk physical geometry and the optional BIOS translation (trans=none or
+lba). These parameters are deprecated, use the corresponding parameters
 of @code{-device} instead.
 @item snapshot=@var{snapshot}
 @var{snapshot} is "on" or "off" and controls snapshot mode for the given drive
@@ -1027,21 +1027,6 @@ the raw disk image you use is not written back. You can however force
 the write back by pressing @key{C-a s} (@pxref{disk_images}).
 ETEXI
 
-DEF("hdachs", HAS_ARG, QEMU_OPTION_hdachs, \
-    "-hdachs c,h,s[,t]\n" \
-    "                force hard disk 0 physical geometry and the optional BIOS\n" \
-    "                translation (t=none or lba) (usually QEMU can guess them)\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -hdachs @var{c},@var{h},@var{s},[,@var{t}]
-@findex -hdachs
-Force hard disk 0 physical geometry (1 <= @var{c} <= 16383, 1 <=
-@var{h} <= 16, 1 <= @var{s} <= 63) and optionally force the BIOS
-translation mode (@var{t}=none, lba or auto). Usually QEMU can guess
-all those parameters. This option is deprecated, please use
-@code{-device ide-hd,cyls=c,heads=h,secs=s,...} instead.
-ETEXI
-
 DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
     "-fsdev fsdriver,id=id[,path=path,][security_model={mapped-xattr|mapped-file|passthrough|none}]\n"
     " [,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]\n"
-- 
2.13.6
