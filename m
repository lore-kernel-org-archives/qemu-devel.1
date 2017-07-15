Received: from eggs.gnu.org ([2001:4830:134:3::10]:57472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dWLTD-0000dC-Is
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 07:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dWLTA-0005Nc-EE
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 07:42:47 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:45072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dWLT8-0005Ih-OG
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 07:42:44 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Sat, 15 Jul 2017 17:12:05 +0530
Message-Id: <1500118925-10569-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: [Qemu-devel] [PATCH v5] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jsnow@redhat.com, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

qemu-backup will be a command-line tool for performing full and
incremental disk backups on running VMs. It is intended as a
reference implementation for management stack and backup developers
to see QEMU's backup features in action. The following commit is an
initial implementation of manpage listing the commands which the
backup tool will support. The manpage wil be build along with other
docs when configure is provided with --enable-docs flag in the
location contrib/backup in build directory.

Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
---
 Makefile                        |  15 +++--
 contrib/backup/qemu-backup.texi | 135 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+), 4 deletions(-)
 create mode 100644 contrib/backup/qemu-backup.texi

diff --git a/Makefile b/Makefile
index 16a0430..1826a74 100644
--- a/Makefile
+++ b/Makefile
@@ -209,6 +209,8 @@ ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
+DOCS+=contrib/backup/qemu-backup.html contrib/backup/qemu-backup.txt
+DOCS+=contrib/backup/qemu-backup.pdf contrib/backup/qemu-backup.info
 ifdef CONFIG_VIRTFS
 DOCS+=fsdev/virtfs-proxy-helper.1
 endif
@@ -508,6 +510,8 @@ VERSION ?= $(shell cat VERSION)
 
 dist: qemu-$(VERSION).tar.bz2
 
+qemu-backup.8: contrib/backup/qemu-backup.texi
+
 qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
 
@@ -719,16 +723,19 @@ fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
 qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
 qemu-ga.8: qemu-ga.texi
 
-html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
-info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info
-pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
-txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
+html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html contrib/backup/qemu-backup.html
+info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-ref.info contrib/backup/qemu-backup.info
+pdf: qemu-doc.pdf docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf contrib/backup/qemu-backup.pdf
+txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt contrib/backup/qemu-backup.txt
 
 qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
 	qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.texi \
 	qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
 	qemu-monitor-info.texi
 
+contrib/backup/qemu-backup.html contrib/backup/qemu-backup.pdf contrib/backup/qemu-backup.txt contrib/backup/qemu-backup.info: \
+	contrib/backup/qemu-backup.texi
+
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
     docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7: \
diff --git a/contrib/backup/qemu-backup.texi b/contrib/backup/qemu-backup.texi
new file mode 100644
index 0000000..ba9f9ec
--- /dev/null
+++ b/contrib/backup/qemu-backup.texi
@@ -0,0 +1,135 @@
+\input texinfo
+@setfilename qemu-backup
+
+@documentlanguage en
+@documentencoding UTF-8
+
+@settitle QEMU Backup Tool
+@copying
+
+Copyright @copyright{} 2017 The QEMU Project developers
+@end copying
+@ifinfo
+@direntry
+* QEMU: (QEMU-backup).    Man page for QEMU Backup Tool.
+@end direntry
+@end ifinfo
+@iftex
+@titlepage
+@sp 7
+@center @titlefont{QEMU Backup Tool}
+@sp 1
+@sp 3
+@end titlepage
+@end iftex
+@ifnottex
+@node Top
+@top Short Sample
+
+@menu
+* Name::
+* Synopsis::
+* List of Commands::
+* Command Parameters::
+* Command Descriptions::
+* License::
+@end menu
+
+@end ifnottex
+
+@node Name
+@chapter Name
+
+QEMU disk backup tool.
+
+@node Synopsis
+@chapter Synopsis
+
+qemu-backup command [command options].
+
+@node  List of Commands
+@chapter  List of Commands
+@itemize
+@item qemu-backup guest add --guest guestname --qmp socketpath [--tcp]
+@item qemu-backup guest list
+@item qemu-backup drive add --id driveid --guest guestname --target target
+@item qemu-backup drive add --all --guest guestname --target target
+@item qemu-backup drive list --guest guestname
+@item qemu-backup backup [--inc] --guest guestname
+@item qemu-backup restore --guest guestname
+@item qemu-backup guest remove --guest guestname
+@item qemu-backup drive remove --guest guestname --id driveid
+@end itemize
+@node  Command Parameters
+@chapter  Command Parameters
+@itemize
+@item --all: Add all the drives present in a guest which are suitable for backup.
+@item --guest: Name of the guest.
+@item --id: id of guest or drive.
+@item --inc: (Optional) For incremental backup.
+@item --qmp: Path of qmp socket.
+@item --target: Destination path on which you want your backup to be made.
+@item --tcp: (Optional) Specifies TCP socket.
+@end itemize
+
+@node  Command Descriptions
+@chapter  Command Descriptions
+@itemize
+@item qemu-backup guest add --guest guestname --qmp socketpath [--tcp]
+This command adds a guest to the configuration file given its path to qmp socket.
+
+example:
+qemu-backup guest add --id=fedora --qmp=/var/run/qemu/fedora.sock
+
+qemu-backup guest add --id=fedora --qmp=localhost:4444 --tcp
+
+@item qemu-backup guest list
+This commands lists the names of guests which are added to configuration file.
+
+@item qemu-backup drive add --guest guestname --id driveid --target target
+This command adds different drives for backup in a particular guest by giving the name of drive to be backed up and target imagefile in which we want to store the drive backup.
+
+example: qemu-backup drive add --guest=fedora --id=root --target=/backup/root.img
+
+@item qemu-backup drive add --all --guest guestname --destination destination
+This command adds all the drives of the guest for backup other than CDROM drive and read-only drives. Here all the backup drives will have the same names as original drives and target will be the destination folder.
+
+example: qemu-backup drive add --all --guest fedora --destination =/backup/fedora/
+
+@item qemu-backup drive list --guest guestname
+This commands gives the names of the drive present in a guest which are added for backup.
+
+example: qemu-backup drive list --guest=fedora
+
+@item qemu-backup backup --guest guestname
+
+This command makes the backup of the drives, in their respective given destinations. The ids of drive and their destinations are taken from the configuration file.
+
+example: qemu-backup backup --guest=fedora
+
+@item qemu-backup restore --guest guestname
+This command is needed if we want to restore the backup. It will list the commands to be run for performing the same but will not perform any action.
+
+example: qemu-backup restore --guest=fedora
+
+@item qemu-backup guest remove --guest guestname
+This command removes the guest from the configuration file.
+
+example: qemu-backup guest remove --guest=fedora
+
+@item qemu-backup drive remove --guest guestname --id driveid
+This command helps remove a drive which is set for backup in configuration of given host.
+
+example: drive remove --guest=fedora --id=root
+
+
+@end itemize
+
+@node License
+@appendix License
+QEMU is a trademark of Fabrice Bellard.
+QEMU is released under the
+@url{https://www.gnu.org/licenses/gpl-2.0.txt,GNU General Public License},
+version 2. Parts of QEMU have specific licenses, see file
+@url{http://git.qemu.org/?p=qemu.git;a=blob_plain;f=LICENSE,LICENSE}.
+@bye
-- 
2.7.4
