Received: from eggs.gnu.org ([2001:4830:134:3::10]:47051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFB-0002F4-Dm
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFA-0006ca-Ex
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFA-0006cH-87
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:48 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 492A461971
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 10:13:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:22 +0200
Message-Id: <20170505101337.4650-7-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/21] vl: deprecate the "-hdachs" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

If the user needs to specify the disk geometry, the corresponding
parameters of the "-device ide-hd" option should be used instead.
"-hdachs" is considered as deprecated and might be removed soon.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1493270454-1448-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 4 ++--
 vl.c            | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 787b9c38da..f68829f3b0 100644
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
index f46e070e0d..42d4bce439 100644
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
2.12.2
