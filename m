Received: from eggs.gnu.org ([209.51.188.92]:50193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDR-0005ZE-Rk
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDR-0002zf-5I
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:13 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52374)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDQ-0002zL-U7
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:13 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 31 Jan 2019 16:17:15 +0300
Message-ID: <20190131131715.23264.78194.stgit@pasha-VirtualBox>
In-Reply-To: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
References: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v11 20/25] replay: init rtc after enabling the
 replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch postpones the call of 'configure_rtc' function. This call
uses host clock to configure the rtc, but host clock access should be
recorded when using icount record/replay mode. Therefore now rtc
is configured after switching record/replay mode on.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 vl.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 5992d8e..d5a3fca 100644
--- a/vl.c
+++ b/vl.c
@@ -3008,6 +3008,7 @@ int main(int argc, char **argv, char **envp)
     DisplayState *ds;
     QemuOpts *opts, *machine_opts;
     QemuOpts *icount_opts = NULL, *accel_opts = NULL;
+    QemuOpts *rtc_opts = NULL;
     QemuOptsList *olist;
     int optind;
     const char *optarg;
@@ -3814,9 +3815,9 @@ int main(int argc, char **argv, char **envp)
                 warn_report("This option is ignored and will be removed soon");
                 break;
             case QEMU_OPTION_rtc:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("rtc"), optarg,
-                                               false);
-                if (!opts) {
+                rtc_opts = qemu_opts_parse_noisily(qemu_find_opts("rtc"),
+                                                   optarg, false);
+                if (!rtc_opts) {
                     exit(1);
                 }
                 break;
@@ -4022,6 +4023,9 @@ int main(int argc, char **argv, char **envp)
     loc_set_none();
 
     replay_configure(icount_opts);
+    if (rtc_opts) {
+        configure_rtc(rtc_opts);
+    }
 
     if (incoming && !preconfig_exit_requested) {
         error_report("'preconfig' and 'incoming' options are "
