Received: from eggs.gnu.org ([2001:4830:134:3::10]:50830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4R-0004Lz-Jr
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4P-0000Qv-Le
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4P-0000Qn-BP
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:05 -0300
Message-Id: <20170613165313.20954-8-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 07/15] Manual changes to use IGNORE_ERRORS
 instead of NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

These cases were missed by the Coccinelle script for some, reason, so I
fixed them manually.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 block/crypto.c         |  4 ++--
 block/qcow2.c          |  2 +-
 block/snapshot.c       |  2 +-
 hw/acpi/cpu.c          |  2 +-
 hw/core/qdev.c         |  8 ++++----
 hw/isa/lpc_ich9.c      |  2 +-
 hw/ppc/spapr_drc.c     |  6 +++---
 hw/s390x/css.c         |  2 +-
 hw/vfio/ccw.c          |  2 +-
 hw/watchdog/watchdog.c |  2 +-
 hw/xen/xen_backend.c   |  4 ++--
 migration/colo.c       |  4 ++--
 migration/rdma.c       |  2 +-
 monitor.c              |  4 ++--
 nbd/server.c           |  2 +-
 net/net.c              |  2 +-
 qapi/opts-visitor.c    |  2 +-
 vl.c                   | 50 +++++++++++++++++++++++++-------------------------
 18 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index f317eda83f..5c2687d271 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -449,7 +449,7 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
         if (qcrypto_block_decrypt(crypto->block,
                                   sector_num,
                                   cipher_data, cur_nr_sectors * 512,
-                                  NULL) < 0) {
+                                  IGNORE_ERRORS) < 0) {
             ret = -EIO;
             goto cleanup;
         }
@@ -510,7 +510,7 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
         if (qcrypto_block_encrypt(crypto->block,
                                   sector_num,
                                   cipher_data, cur_nr_sectors * 512,
-                                  NULL) < 0) {
+                                  IGNORE_ERRORS) < 0) {
             ret = -EIO;
             goto cleanup;
         }
diff --git a/block/qcow2.c b/block/qcow2.c
index aa0dc46162..53920a83b5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2602,7 +2602,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         /* align end of file to a sector boundary to ease reading with
            sector based I/Os */
         cluster_offset = bdrv_getlength(bs->file->bs);
-        return bdrv_truncate(bs->file, cluster_offset, NULL);
+        return bdrv_truncate(bs->file, cluster_offset, IGNORE_ERRORS);
     }
 
     buf = qemu_blockalign(bs, s->cluster_size);
diff --git a/block/snapshot.c b/block/snapshot.c
index a46564e7b7..244fdc2bb6 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -207,7 +207,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         bs->file = NULL;
 
         ret = bdrv_snapshot_goto(file, snapshot_id);
-        open_ret = drv->bdrv_open(bs, options, bs->open_flags, NULL);
+        open_ret = drv->bdrv_open(bs, options, bs->open_flags, IGNORE_ERRORS);
         QDECREF(options);
         if (open_ret < 0) {
             bdrv_unref(file);
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index a233fe17cf..6dc138db89 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -125,7 +125,7 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
             trace_cpuhp_acpi_ejecting_cpu(cpu_st->selector);
             dev = DEVICE(cdev->cpu);
             hotplug_ctrl = qdev_get_hotplug_handler(dev);
-            hotplug_handler_unplug(hotplug_ctrl, dev, NULL);
+            hotplug_handler_unplug(hotplug_ctrl, dev, IGNORE_ERRORS);
         }
         break;
     case ACPI_CPU_CMD_OFFSET_WR:
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index faa4af0dc3..163e827e01 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -952,9 +952,9 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         }
         dev->pending_deleted_event = false;
     } else if (!value && dev->realized) {
-        Error **local_errp = NULL;
+        Error **local_errp = IGNORE_ERRORS;
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
-            local_errp = local_err ? NULL : &local_err;
+            local_errp = local_err ? IGNORE_ERRORS : &local_err;
             object_property_set_bool(OBJECT(bus), false, "realized",
                                      local_errp);
         }
@@ -962,7 +962,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
         }
         if (dc->unrealize) {
-            local_errp = local_err ? NULL : &local_err;
+            local_errp = local_err ? IGNORE_ERRORS : &local_err;
             dc->unrealize(dev, local_errp);
         }
         dev->pending_deleted_event = true;
@@ -988,7 +988,7 @@ child_realize_fail:
 
 post_realize_fail:
     if (dc->unrealize) {
-        dc->unrealize(dev, NULL);
+        dc->unrealize(dev, IGNORE_ERRORS);
     }
 
 fail:
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 99a136d05a..ffa8f3ba03 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -659,7 +659,7 @@ static void ich9_lpc_add_properties(ICH9LPCState *lpc)
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
                                   &acpi_disable_cmd, IGNORE_ERRORS);
 
-    ich9_pm_add_properties(OBJECT(lpc), &lpc->pm, NULL);
+    ich9_pm_add_properties(OBJECT(lpc), &lpc->pm, IGNORE_ERRORS);
 }
 
 static void ich9_lpc_initfn(Object *obj)
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index d7d0c0ee8e..1b0a7546fb 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -105,7 +105,7 @@ static uint32_t set_isolation_state(sPAPRDRConnector *drc,
             uint32_t drc_index = spapr_drc_index(drc);
             if (drc->configured) {
                 trace_spapr_drc_set_isolation_state_finalizing(drc_index);
-                drck->detach(drc, DEVICE(drc->dev), NULL);
+                drck->detach(drc, DEVICE(drc->dev), IGNORE_ERRORS);
             } else {
                 trace_spapr_drc_set_isolation_state_deferring(drc_index);
             }
@@ -159,7 +159,7 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
             drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
             uint32_t drc_index = spapr_drc_index(drc);
             trace_spapr_drc_set_allocation_state_finalizing(drc_index);
-            drck->detach(drc, DEVICE(drc->dev), NULL);
+            drck->detach(drc, DEVICE(drc->dev), IGNORE_ERRORS);
         } else if (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
             drc->awaiting_allocation = false;
         }
@@ -467,7 +467,7 @@ static void reset(DeviceState *d)
          * force removal if we are
          */
         if (drc->awaiting_release) {
-            drck->detach(drc, DEVICE(drc->dev), NULL);
+            drck->detach(drc, DEVICE(drc->dev), IGNORE_ERRORS);
         }
 
         /* non-PCI devices may be awaiting a transition to UNUSABLE */
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1e2f26b65a..c39e65f206 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2070,7 +2070,7 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
 
             if   (css_find_free_subch_and_devno(bus_id.cssid, &bus_id.ssid,
                                                 &bus_id.devid, &schid,
-                                                NULL)) {
+                                                IGNORE_ERRORS)) {
                 break;
             }
             if (bus_id.cssid == MAX_CSSID) {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 12d0262336..d8dfbe321a 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -370,7 +370,7 @@ out_device_err:
     vfio_put_group(group);
 out_group_err:
     if (cdc->unrealize) {
-        cdc->unrealize(cdev, NULL);
+        cdc->unrealize(cdev, IGNORE_ERRORS);
     }
 out_err_propagate:
     error_propagate(errp, err);
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 2c3b2bb418..60ad3fe113 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -144,7 +144,7 @@ void watchdog_perform_action(void)
     case WDT_NMI:
         qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_INJECT_NMI,
                                  &error_abort);
-        nmi_monitor_handle(0, NULL);
+        nmi_monitor_handle(0, IGNORE_ERRORS);
         break;
     }
 }
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index c46cbb0759..b3450e01e0 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -143,7 +143,7 @@ static struct XenDevice *xen_be_get_xendev(const char *type, int dom, int dev,
     xendev->evtchndev = xenevtchn_open(NULL, 0);
     if (xendev->evtchndev == NULL) {
         xen_pv_printf(NULL, 0, "can't open evtchn device\n");
-        qdev_unplug(DEVICE(xendev), NULL);
+        qdev_unplug(DEVICE(xendev), IGNORE_ERRORS);
         return NULL;
     }
     qemu_set_cloexec(xenevtchn_fd(xendev->evtchndev));
@@ -153,7 +153,7 @@ static struct XenDevice *xen_be_get_xendev(const char *type, int dom, int dev,
         if (xendev->gnttabdev == NULL) {
             xen_pv_printf(NULL, 0, "can't open gnttab device\n");
             xenevtchn_close(xendev->evtchndev);
-            qdev_unplug(DEVICE(xendev), NULL);
+            qdev_unplug(DEVICE(xendev), IGNORE_ERRORS);
             return NULL;
         }
     } else {
diff --git a/migration/colo.c b/migration/colo.c
index d623d801e7..a68e6e9cdf 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -175,7 +175,7 @@ void qmp_xen_set_replication(bool enable, bool primary,
         if (!has_failover) {
             failover = NULL;
         }
-        replication_stop_all(failover, failover ? NULL : errp);
+        replication_stop_all(failover, failover ? IGNORE_ERRORS : errp);
     }
 #else
     abort();
@@ -641,7 +641,7 @@ void *colo_process_incoming_thread(void *opaque)
         if (failover_get_state() == FAILOVER_STATUS_RELAUNCH) {
             failover_set_state(FAILOVER_STATUS_RELAUNCH,
                             FAILOVER_STATUS_NONE);
-            failover_request_active(NULL);
+            failover_request_active(IGNORE_ERRORS);
             goto out;
         }
 
diff --git a/migration/rdma.c b/migration/rdma.c
index e446c6fd6a..a33edbf29b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2509,7 +2509,7 @@ static void *qemu_rdma_data_init(const char *host_port, Error **errp)
         rdma->current_chunk = -1;
 
         addr = g_new(InetSocketAddress, 1);
-        if (!inet_parse(addr, host_port, NULL)) {
+        if (!inet_parse(addr, host_port, IGNORE_ERRORS)) {
             rdma->port = atoi(addr->port);
             rdma->host = g_strdup(addr->host);
         } else {
diff --git a/monitor.c b/monitor.c
index c262311fdd..7c4327a175 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3467,7 +3467,7 @@ void netdev_del_completion(ReadLineState *rs, int nb_args, const char *str)
         if (strncmp(str, name, len)) {
             continue;
         }
-        opts = qemu_opts_find(qemu_find_opts_err("netdev", NULL), name);
+        opts = qemu_opts_find(qemu_find_opts_err("netdev", IGNORE_ERRORS), name);
         if (opts) {
             readline_add_completion(rs, name);
         }
@@ -3642,7 +3642,7 @@ static void vm_completion(ReadLineState *rs, const char *str)
 
         aio_context_acquire(ctx);
         if (bdrv_can_snapshot(bs)) {
-            ok = bdrv_query_snapshot_info_list(bs, &snapshots, NULL) == 0;
+            ok = bdrv_query_snapshot_info_list(bs, &snapshots, IGNORE_ERRORS) == 0;
         }
         aio_context_release(ctx);
         if (!ok) {
diff --git a/nbd/server.c b/nbd/server.c
index 8631fa55a3..b617ad5a4b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -388,7 +388,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     tioc = qio_channel_tls_new_server(ioc,
                                       client->tlscreds,
                                       client->tlsaclname,
-                                      NULL);
+                                      IGNORE_ERRORS);
     if (!tioc) {
         return NULL;
     }
diff --git a/net/net.c b/net/net.c
index 9d0f1119cc..b7f5459b33 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1248,7 +1248,7 @@ void qmp_netdev_del(const char *id, Error **errp)
         return;
     }
 
-    opts = qemu_opts_find(qemu_find_opts_err("netdev", NULL), id);
+    opts = qemu_opts_find(qemu_find_opts_err("netdev", IGNORE_ERRORS), id);
     if (!opts) {
         error_setg(errp, "Device '%s' is not a netdev", id);
         return;
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 324b197495..3e408e4bf0 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -516,7 +516,7 @@ opts_optional(Visitor *v, const char *name, bool *present)
 
     /* we only support a single mandatory scalar field in a list node */
     assert(ov->list_mode == LM_NONE);
-    *present = (lookup_distinct(ov, name, NULL) != NULL);
+    *present = (lookup_distinct(ov, name, IGNORE_ERRORS) != NULL);
 }
 
 
diff --git a/vl.c b/vl.c
index a7ad0cbd0c..32068db274 100644
--- a/vl.c
+++ b/vl.c
@@ -1176,7 +1176,7 @@ static void default_drive(int enable, int snapshot, BlockInterfaceType type,
 
     opts = drive_add(type, index, NULL, optstr);
     if (snapshot) {
-        drive_enable_snapshot(NULL, opts, NULL);
+        drive_enable_snapshot(NULL, opts, IGNORE_ERRORS);
     }
 
     dinfo = drive_new(opts, type);
@@ -1352,12 +1352,12 @@ static inline void semihosting_arg_fallback(const char *file, const char *cmd)
     char *cmd_token;
 
     /* argv[0] */
-    add_semihosting_arg(&semihosting, "arg", file, NULL);
+    add_semihosting_arg(&semihosting, "arg", file, IGNORE_ERRORS);
 
     /* split -append and initialize argv[1..n] */
     cmd_token = strtok(g_strdup(cmd), " ");
     while (cmd_token) {
-        add_semihosting_arg(&semihosting, "arg", cmd_token, NULL);
+        add_semihosting_arg(&semihosting, "arg", cmd_token, IGNORE_ERRORS);
         cmd_token = strtok(NULL, " ");
     }
 }
@@ -3556,7 +3556,7 @@ int main(int argc, char **argv, char **envp)
                 fsdev = qemu_opts_create(qemu_find_opts("fsdev"),
                                          qemu_opts_id(opts) ?:
                                          qemu_opt_get(opts, "mount_tag"),
-                                         1, NULL);
+                                         1, IGNORE_ERRORS);
                 if (!fsdev) {
                     error_report("duplicate or invalid fsdev id: %s",
                                  qemu_opt_get(opts, "mount_tag"));
@@ -3606,7 +3606,7 @@ int main(int argc, char **argv, char **envp)
                 QemuOpts *device;
 
                 fsdev = qemu_opts_create(qemu_find_opts("fsdev"), "v_synth",
-                                         1, NULL);
+                                         1, IGNORE_ERRORS);
                 if (!fsdev) {
                     error_report("duplicate option: %s", "virtfs_synth");
                     exit(1);
@@ -3875,7 +3875,7 @@ int main(int argc, char **argv, char **envp)
                     }
                     /* Set semihosting argument count and vector */
                     qemu_opt_foreach(opts, add_semihosting_arg,
-                                     &semihosting, NULL);
+                                     &semihosting, IGNORE_ERRORS);
                 } else {
                     error_report("unsupported semihosting-config %s", optarg);
                     exit(1);
@@ -4107,23 +4107,23 @@ int main(int argc, char **argv, char **envp)
     }
 
     if (qemu_opts_foreach(qemu_find_opts("sandbox"),
-                          parse_sandbox, NULL, NULL)) {
+                          parse_sandbox, NULL, IGNORE_ERRORS)) {
         exit(1);
     }
 
     if (qemu_opts_foreach(qemu_find_opts("name"),
-                          parse_name, NULL, NULL)) {
+                          parse_name, NULL, IGNORE_ERRORS)) {
         exit(1);
     }
 
 #ifndef _WIN32
     if (qemu_opts_foreach(qemu_find_opts("add-fd"),
-                          parse_add_fd, NULL, NULL)) {
+                          parse_add_fd, NULL, IGNORE_ERRORS)) {
         exit(1);
     }
 
     if (qemu_opts_foreach(qemu_find_opts("add-fd"),
-                          cleanup_add_fd, NULL, NULL)) {
+                          cleanup_add_fd, NULL, IGNORE_ERRORS)) {
         exit(1);
     }
 #endif
@@ -4220,9 +4220,9 @@ int main(int argc, char **argv, char **envp)
     }
 
     qemu_opts_foreach(qemu_find_opts("device"),
-                      default_driver_check, NULL, NULL);
+                      default_driver_check, NULL, IGNORE_ERRORS);
     qemu_opts_foreach(qemu_find_opts("global"),
-                      default_driver_check, NULL, NULL);
+                      default_driver_check, NULL, IGNORE_ERRORS);
 
     if (!vga_model && !default_vga) {
         vga_interface_type = VGA_DEVICE;
@@ -4364,30 +4364,30 @@ int main(int argc, char **argv, char **envp)
 
     if (qemu_opts_foreach(qemu_find_opts("object"),
                           user_creatable_add_opts_foreach,
-                          object_create_initial, NULL)) {
+                          object_create_initial, IGNORE_ERRORS)) {
         exit(1);
     }
 
     if (qemu_opts_foreach(qemu_find_opts("chardev"),
-                          chardev_init_func, NULL, NULL)) {
+                          chardev_init_func, NULL, IGNORE_ERRORS)) {
         exit(1);
     }
 
 #ifdef CONFIG_VIRTFS
     if (qemu_opts_foreach(qemu_find_opts("fsdev"),
-                          fsdev_init_func, NULL, NULL)) {
+                          fsdev_init_func, NULL, IGNORE_ERRORS)) {
         exit(1);
     }
 #endif
 
     if (qemu_opts_foreach(qemu_find_opts("device"),
-                          device_help_func, NULL, NULL)) {
+                          device_help_func, NULL, IGNORE_ERRORS)) {
         exit(0);
     }
 
     machine_opts = qemu_get_machine_opts();
     if (qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
-                         NULL)) {
+                         IGNORE_ERRORS)) {
         object_unref(OBJECT(current_machine));
         exit(1);
     }
@@ -4479,7 +4479,7 @@ int main(int argc, char **argv, char **envp)
 
     if (qemu_opts_foreach(qemu_find_opts("object"),
                           user_creatable_add_opts_foreach,
-                          object_create_delayed, NULL)) {
+                          object_create_delayed, IGNORE_ERRORS)) {
         exit(1);
     }
 
@@ -4524,10 +4524,10 @@ int main(int argc, char **argv, char **envp)
     }
     if (snapshot || replay_mode != REPLAY_MODE_NONE) {
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
-                          NULL, NULL);
+                          NULL, IGNORE_ERRORS);
     }
     if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
-                          &machine_class->block_default_type, NULL)) {
+                          &machine_class->block_default_type, IGNORE_ERRORS)) {
         exit(1);
     }
 
@@ -4539,7 +4539,7 @@ int main(int argc, char **argv, char **envp)
     parse_numa_opts(current_machine);
 
     if (qemu_opts_foreach(qemu_find_opts("mon"),
-                          mon_init_func, NULL, NULL)) {
+                          mon_init_func, NULL, IGNORE_ERRORS)) {
         exit(1);
     }
 
@@ -4578,7 +4578,7 @@ int main(int argc, char **argv, char **envp)
     machine_register_compat_props(current_machine);
 
     qemu_opts_foreach(qemu_find_opts("global"),
-                      global_init_func, NULL, NULL);
+                      global_init_func, NULL, IGNORE_ERRORS);
 
     /* This checkpoint is required by replay to separate prior clock
        reading from the other reads, because timer polling functions query
@@ -4603,7 +4603,7 @@ int main(int argc, char **argv, char **envp)
     }
 
     if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
-                          parse_fw_cfg, fw_cfg_find(), NULL) != 0) {
+                          parse_fw_cfg, fw_cfg_find(), IGNORE_ERRORS) != 0) {
         exit(1);
     }
 
@@ -4619,7 +4619,7 @@ int main(int argc, char **argv, char **envp)
     /* init generic devices */
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     if (qemu_opts_foreach(qemu_find_opts("device"),
-                          device_init_func, NULL, NULL)) {
+                          device_init_func, NULL, IGNORE_ERRORS)) {
         exit(1);
     }
 
@@ -4683,7 +4683,7 @@ int main(int argc, char **argv, char **envp)
     /* init remote displays */
 #ifdef CONFIG_VNC
     qemu_opts_foreach(qemu_find_opts("vnc"),
-                      vnc_init_func, NULL, NULL);
+                      vnc_init_func, NULL, IGNORE_ERRORS);
 #endif
 
     if (using_spice) {
-- 
2.11.0.259.g40922b1
