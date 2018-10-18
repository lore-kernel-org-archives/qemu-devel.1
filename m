Received: from eggs.gnu.org ([2001:4830:134:3::10]:40500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9Xk-0000oV-LN
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9Xh-0005Ok-E6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:44:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD9Xh-0005NE-6U
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:44:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so33989261wrt.2
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:44:52 -0700 (PDT)
References: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
	<1d963c3e013dfedafa1f6edb9fb219b7e49e39da.1539846575.git.artem.k.pisarenko@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0bc338a1-70e8-8f38-86e0-f2e5a59d2403@redhat.com>
Date: Thu, 18 Oct 2018 16:44:49 +0200
MIME-Version: 1.0
In-Reply-To: <1d963c3e013dfedafa1f6edb9fb219b7e49e39da.1539846575.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] Fixes RTC bug with base datetime
 shifts in clock=vm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org

On 18/10/2018 09:12, Artem Pisarenko wrote:
> +    rtc_host_datetime_offset = rtc_ref_start_datetime - rtc_start_datetime;
> +    rtc_ref_start_datetime = rtc_start_datetime;

Because of this, multiple rtc options have funny effects.

Can squash this instead:

diff --git a/vl.c b/vl.c
index 1b349b78bd..4c332a5469 100644
--- a/vl.c
+++ b/vl.c
@@ -249,6 +249,7 @@ static struct {
 static QemuOptsList qemu_rtc_opts = {
     .name = "rtc",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_rtc_opts.head),
+    .merge_lists = true,
     .desc = {
         {
             .name = "base",
@@ -886,6 +887,11 @@ static void configure_rtc(QemuOpts *opts)
 {
     const char *value;

+    /* Set defaults */
+    rtc_clock = QEMU_CLOCK_HOST;
+    rtc_ref_start_datetime = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
+    rtc_realtime_clock_offset = qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
/ 1000;
+
     value = qemu_opt_get(opts, "base");
     if (value) {
         if (!strcmp(value, "utc")) {
@@ -3048,9 +3054,6 @@ int main(int argc, char **argv, char **envp)
         error_reportf_err(err, "cannot initialize crypto: ");
         exit(1);
     }
-    rtc_clock = QEMU_CLOCK_HOST;
-    rtc_ref_start_datetime = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
-    rtc_realtime_clock_offset = qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
/ 1000;

     QLIST_INIT (&vm_change_state_head);
     os_setup_early_signal_handling();
@@ -3770,7 +3771,6 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
-                configure_rtc(opts);
                 break;
             case QEMU_OPTION_tb_size:
 #ifndef CONFIG_TCG
@@ -3988,6 +3988,8 @@ int main(int argc, char **argv, char **envp)
         exit(EXIT_FAILURE);
     }

+    configure_rtc(qemu_find_opts_singleton("rtc"));
+
     machine_class = select_machine();

     set_memory_options(&ram_slots, &maxram_size, machine_class);
