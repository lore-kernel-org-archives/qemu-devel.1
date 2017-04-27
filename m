Received: from eggs.gnu.org ([2001:4830:134:3::10]:56940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d3brV-00023U-1I
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d3brU-00033H-2j
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:21:05 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 27 Apr 2017 07:20:54 +0200
Message-Id: <1493270454-1448-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3] Issue a deprecation warning if the user
 specifies the "-hdachs" option.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

If the user needs to specify the disk geometry, the corresponding
parameters of the "-device ide-hd" option should be used instead.
"-hdachs" is considered as deprecated and might be removed soon.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3:
 - Recommend to use the parameters of -device ide-hd instead
 - Also add the deprecation warning to the documentation

 qemu-options.hx | 4 ++--
 vl.c            | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 787b9c3..f68829f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -803,8 +803,8 @@ STEXI
 Force hard disk 0 physical geometry (1 <= @var{c} <= 16383, 1 <=
 @var{h} <= 16, 1 <= @var{s} <= 63) and optionally force the BIOS
 translation mode (@var{t}=none, lba or auto). Usually QEMU can guess
-all those parameters. This option is useful for old MS-DOS disk
-images.
+all those parameters. This option is deprecated, please use
+@code{-device ide-hd,cyls=c,heads=h,secs=s,...} instead.
 ETEXI
 
 DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
diff --git a/vl.c b/vl.c
index f46e070..42d4bce 100644
--- a/vl.c
+++ b/vl.c
@@ -3231,6 +3231,8 @@ int main(int argc, char **argv, char **envp)
                         }
                     }
                 }
+                error_report("'-hdachs' is deprecated, please use '-device"
+                             " ide-hd,cyls=c,heads=h,secs=s,...' instead");
                 break;
             case QEMU_OPTION_numa:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("numa"),
-- 
1.8.3.1
