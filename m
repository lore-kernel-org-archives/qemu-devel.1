Received: from eggs.gnu.org ([2001:4830:134:3::10]:35609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benyux.xu@intel.com>) id 1dRJtT-0003s0-Bz
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benyux.xu@intel.com>) id 1dRJtO-0003oq-UX
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:57356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benyux.xu@intel.com>) id 1dRJtO-0003hL-Mq
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:02 -0400
From: Benyu Xu <benyux.xu@intel.com>
Date: Sat,  1 Jul 2017 22:57:09 +0800
Message-Id: <1498921030-23255-3-git-send-email-benyux.xu@intel.com>
In-Reply-To: <1498921030-23255-1-git-send-email-benyux.xu@intel.com>
References: <1498921030-23255-1-git-send-email-benyux.xu@intel.com>
Subject: [Qemu-devel] [PATCH 2/3] vcpu pin: parameters parse and execution.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, gordon.jin@intel.com, eddie.dong@intel.com, kevin.tian@intel.com, haozhong.zhang@intel.com, hongbo.wang@intel.com, hao.l.li@intel.com, xudong.hao@intel.com, tianyu.lan@intel.com, binx.wu@intel.com, benyux.xu@intel.com, benjamin_xby@163.com

Signed-off-by: Benyu Xu <benyux.xu@intel.com>
---
 vl.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/vl.c b/vl.c
index 36ff3f4..8c5dd25 100644
--- a/vl.c
+++ b/vl.c
@@ -167,6 +167,7 @@ int smp_cpus = 1;
 int max_cpus = 1;
 int smp_cores = 1;
 int smp_threads = 1;
+int pcpu_id_array[131072 + 2] = {0}; /* 131072 = 1024 * 128 */
 int acpi_enabled = 1;
 int no_hpet = 0;
 int fd_bootchk = 1;
@@ -1270,6 +1271,106 @@ static void smp_parse(QemuOpts *opts)
     }
 }
 
+static void vcpupin_parse(const char *pcpu_id_list, const int smp_cpus_num)
+{
+    long pcpu_id;
+    int pcpu_num = 0;
+    bool pin_auto = false;
+    bool id_is_range = false;
+    long id_range_left;
+    long id_range_right;
+    int host_cpu_num;
+    const char *tmp_id_list = pcpu_id_list;
+    int ret = 0;
+
+    if (!pcpu_id_list) {
+        return;
+    }
+
+    if (strcmp(pcpu_id_list, "auto") == 0) {
+        pin_auto = true;
+    }
+
+    host_cpu_num = get_pcpu_num(pin_auto, pcpu_id_array);
+    if (host_cpu_num <= 0) {
+        error_report("cannot determine host cpu number");
+        exit(1);
+    }
+
+    if (smp_cpus_num > host_cpu_num) {
+        error_report("host can serve only %d cpus, less than smp_cpus_num %d",
+                      host_cpu_num, smp_cpus_num);
+        exit(1);
+    }
+
+    if (pin_auto == true) {
+        return;
+    }
+
+    if (isdigit(tmp_id_list[0]) == 0) {
+        error_report("invalid pcpu id list %s", pcpu_id_list);
+        error_report("pcpu id list should be \"auto\" or begin by digit");
+        exit(1);
+    }
+
+    while (tmp_id_list[0] != '\0') {
+        if (isdigit(tmp_id_list[0]) == 0 && tmp_id_list[0] != ',' &&
+            tmp_id_list[0] != '-') {
+            error_report("invalid pcpu id list %s", pcpu_id_list);
+            error_report("pcpu id list only accept digit or ',' or '-'");
+            exit(1);
+        }
+        tmp_id_list++;
+    }
+    tmp_id_list = pcpu_id_list;
+
+    while (tmp_id_list) {
+        ret = qemu_strtol(tmp_id_list, &tmp_id_list, 10, &pcpu_id);
+        if (ret == ERANGE || pcpu_id < 0 || pcpu_id >= host_cpu_num) {
+            error_report("pcpu id %ld is out of range", pcpu_id);
+            exit(1);
+        }
+
+        if (id_is_range == true) {
+            id_range_right = pcpu_id;
+            if (id_range_right <= id_range_left) {
+                error_report("invalid pcpu id list [%ld-%ld]",
+                              id_range_left, id_range_right);
+                exit(1);
+            }
+            for (; id_range_left <= id_range_right; id_range_left++) {
+                pcpu_id_array[0] = pcpu_num;
+                pcpu_id_array[pcpu_num] = id_range_left;
+                pcpu_num++;
+            }
+            pcpu_num--;
+        } else {
+            pcpu_num++;
+            pcpu_id_array[0] = pcpu_num;
+            pcpu_id_array[pcpu_num] = pcpu_id;
+        }
+
+        if (tmp_id_list[0] == '\0') {
+            break;
+        } else if (tmp_id_list[0] == '-') {
+            id_is_range = true;
+            id_range_left = pcpu_id;
+        } else {
+            id_is_range = false;
+        }
+        tmp_id_list++;
+
+        if (tmp_id_list[0] == '\0') {
+            error_report("invalid pcpu id list %s", pcpu_id_list);
+            error_report("pcpu id list should be end by digit");
+            exit(1);
+        } else if (isdigit(tmp_id_list[0]) == 0) {
+            error_report("invalid pcpu id list %s", pcpu_id_list);
+            exit(1);
+        }
+    }
+}
+
 static void realtime_init(void)
 {
     if (enable_mlock) {
@@ -3024,6 +3125,9 @@ int main(int argc, char **argv, char **envp)
     Error *main_loop_err = NULL;
     Error *err = NULL;
     bool list_data_dirs = false;
+
+    const char *pcpu_id_list = NULL;
+
     typedef struct BlockdevOptions_queue {
         BlockdevOptions *bdo;
         Location loc;
@@ -3810,6 +3914,9 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_vcpupin:
+                pcpu_id_list = optarg;
+                break;
             case QEMU_OPTION_vnc:
                 vnc_parse(optarg, &error_fatal);
                 break;
@@ -4222,6 +4329,8 @@ int main(int argc, char **argv, char **envp)
 
     smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
 
+    vcpupin_parse(pcpu_id_list, smp_cpus);
+
     machine_class->max_cpus = machine_class->max_cpus ?: 1; /* Default to UP */
     if (max_cpus > machine_class->max_cpus) {
         error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
@@ -4621,6 +4730,12 @@ int main(int argc, char **argv, char **envp)
 
     machine_run_board_init(current_machine);
 
+    pin_all_vcpus(smp_cpus, pcpu_id_array, &err);
+    if (err) {
+        error_report_err(err);
+        exit(1);
+    }
+
     realtime_init();
 
     soundhw_init();
-- 
1.8.3.1
