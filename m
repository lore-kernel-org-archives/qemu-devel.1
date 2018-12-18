Received: from eggs.gnu.org ([2001:4830:134:3::10]:47107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDSY-0003Y9-12
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDSW-0006bm-A8
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:45 -0500
Received: from mail.ispras.ru ([83.149.199.45]:55788)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDSV-0006b9-Sg
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:44 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 18 Dec 2018 14:22:44 +0300
Message-ID: <20181218112244.11727.56050.stgit@pasha-VirtualBox>
In-Reply-To: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 19/20] replay: init rtc after enabling the
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
index 605ad89..c6aafc1 100644
--- a/vl.c
+++ b/vl.c
@@ -2979,6 +2979,7 @@ int main(int argc, char **argv, char **envp)
     DisplayState *ds;
     QemuOpts *opts, *machine_opts;
     QemuOpts *icount_opts = NULL, *accel_opts = NULL;
+    QemuOpts *rtc_opts = NULL;
     QemuOptsList *olist;
     int optind;
     const char *optarg;
@@ -3788,9 +3789,9 @@ int main(int argc, char **argv, char **envp)
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
@@ -4003,6 +4004,9 @@ int main(int argc, char **argv, char **envp)
     loc_set_none();
 
     replay_configure(icount_opts);
+    if (rtc_opts) {
+        configure_rtc(rtc_opts);
+    }
 
     if (incoming && !preconfig_exit_requested) {
         error_report("'preconfig' and 'incoming' options are "
