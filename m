Received: from eggs.gnu.org ([2001:4830:134:3::10]:34327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEaq-0002VJ-Rp
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEaq-00036p-2x
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:32:04 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44330)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gAEap-00036T-Ou
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:32:03 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 10 Oct 2018 16:35:16 +0300
Message-ID: <20181010133516.24538.63822.stgit@pasha-VirtualBox>
In-Reply-To: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 18/19] replay: init rtc after enabling the
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
Cc: peter.maydell@linaro.org, war2jordan@live.com, pavel.dovgaluk@ispras.ru, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.comdovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, kwolf@redhat.com, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

This patch postpones the call of 'configure_rtc' function. This call
uses host clock to configure the rtc, but host clock access should be
recorded when using icount record/replay mode. Therefore now rtc
is configured after switching record/replay mode on.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 vl.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/vl.c b/vl.c
index a3e2e47..f910072 100644
--- a/vl.c
+++ b/vl.c
@@ -2932,6 +2932,7 @@ int main(int argc, char **argv, char **envp)
     DisplayState *ds;
     QemuOpts *opts, *machine_opts;
     QemuOpts *icount_opts = NULL, *accel_opts = NULL;
+    QemuOpts *rtc_opts = NULL;
     QemuOptsList *olist;
     int optind;
     const char *optarg;
@@ -3738,12 +3739,11 @@ int main(int argc, char **argv, char **envp)
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
-                configure_rtc(opts);
                 break;
             case QEMU_OPTION_tb_size:
 #ifndef CONFIG_TCG
@@ -3954,6 +3954,9 @@ int main(int argc, char **argv, char **envp)
     loc_set_none();
 
     replay_configure(icount_opts);
+    if (rtc_opts) {
+        configure_rtc(rtc_opts);
+    }
 
     if (incoming && !preconfig_exit_requested) {
         error_report("'preconfig' and 'incoming' options are "
