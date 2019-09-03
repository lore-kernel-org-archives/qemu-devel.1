Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32069C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0739230F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N7VkuJNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0739230F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GLt-0001WD-E5
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5Faa-0008JH-6B
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaW-0000wW-Jp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaW-0000u5-8Z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KdQ1P070881;
 Tue, 3 Sep 2019 20:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=QjNGkiktIFNQTlzT1Gx4wwJ8fVaMJjNVq/WelnMLhyw=;
 b=N7VkuJNLA+1UKoquHON7wtTkSUWVnpMxIsPCpZWxO36lYz9dLTGQW9lkMpR285oMGAGz
 ApTmAMXBqI/RSqsRuRhwZ5i84KdEyKNw9PpeBF1lm9C5lNCh25FC61KT0THMhB7NgV4s
 iUXkgWJuBTLdf+N3NqUrR4ulFQ697XneWK4S4TF13ildutAEWWf/5XP4iDxlvI0bGOcS
 HusFxkBOTPHfiXkAYLNmDxCiUAnxJu3qFf2Z4MRog1xgqWmnHqxmN1yiM7G+DTdV3/Ni
 W4jDK+vrg1J7m6CTAbKf24TGp6OstdH1aDNznVCQSGmg/aLtRLogelOyJJnLT9h7pjHN Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2usy4u8345-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83Kc9qR025296;
 Tue, 3 Sep 2019 20:39:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2us5pha0wk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KdTw2017860;
 Tue, 3 Sep 2019 20:39:29 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:28 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:38:07 -0400
Message-Id: <a90fb2dd9a528ef13962e9a80e5be08c036c37e9.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030207
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC v3 PATCH 41/45] multi-process/mon: trim HMP
 command set for remote storage processes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trim down the list of HMP commands available for storage class of
remote processes.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v3

 Makefile.objs              |   2 +
 Makefile.target            |  14 +-
 hmp-scsi-commands-info.hx  | 167 ++++++++++++++++++++
 hmp-scsi-commands.hx       | 384 +++++++++++++++++++++++++++++++++++++++++++++
 monitor/misc.c             |  84 +++++-----
 monitor/monitor-internal.h |  38 +++++
 qom/Makefile.objs          |   2 +-
 7 files changed, 651 insertions(+), 40 deletions(-)
 create mode 100644 hmp-scsi-commands-info.hx
 create mode 100644 hmp-scsi-commands.hx

diff --git a/Makefile.objs b/Makefile.objs
index 04af900..11cd7be 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -45,6 +45,8 @@ remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o
 remote-lsi-obj-$(CONFIG_MPQEMU) += hw/
 remote-lsi-obj-$(CONFIG_MPQEMU) += ui/
 
+remote-lsi-obj-$(CONFIG_MPQEMU) += device-hotplug.o
+
 #######################################################################
 # crypto-obj-y is code used by both qemu system emulation and qemu-img
 
diff --git a/Makefile.target b/Makefile.target
index 0ca832f..00a4b85 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -210,6 +210,10 @@ endif
 generated-files-y += hmp-commands.h hmp-commands-info.h
 generated-files-y += config-devices.h
 
+ifdef CONFIG_MPQEMU
+generated-files-y += hmp-scsi-commands.h hmp-scsi-commands-info.h
+endif
+
 endif # CONFIG_SOFTMMU
 
 dummy := $(call unnest-vars,,obj-y)
@@ -294,10 +298,18 @@ hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
 hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
 
+ifdef CONFIG_MPQEMU
+hmp-scsi-commands.h: $(SRC_PATH)/hmp-scsi-commands.hx $(SRC_PATH)/scripts/hxtool
+	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
+
+hmp-scsi-commands-info.h: $(SRC_PATH)/hmp-scsi-commands-info.hx $(SRC_PATH)/scripts/hxtool
+	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
+endif
+
 clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
-	rm -f hmp-commands.h gdbstub-xml.c
+	rm -f hmp-commands.h gdbstub-xml.c hmp-scsi-commands.h hmp-scsi-commands-info.h
 	rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
 ifdef CONFIG_TRACE_SYSTEMTAP
 	rm -f *.stp
diff --git a/hmp-scsi-commands-info.hx b/hmp-scsi-commands-info.hx
new file mode 100644
index 0000000..315a445
--- /dev/null
+++ b/hmp-scsi-commands-info.hx
@@ -0,0 +1,167 @@
+HXCOMM Use DEFHEADING() to define headings in both help text and texi
+HXCOMM Text between STEXI and ETEXI are copied to texi version and
+HXCOMM discarded from C version
+HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
+HXCOMM monitor info commands
+HXCOMM HXCOMM can be used for comments, discarded from both texi and C
+
+STEXI
+@table @option
+@item info @var{subcommand}
+@findex info
+Show various information about the system state.
+@table @option
+ETEXI
+
+    {
+        .name       = "version",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show the version of QEMU",
+        .cmd        = hmp_info_version,
+        .flags      = "p",
+    },
+
+STEXI
+@item info version
+@findex info version
+Show the version of QEMU.
+ETEXI
+
+    {
+        .name       = "chardev",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show the character devices",
+        .cmd        = hmp_info_chardev,
+        .flags      = "p",
+    },
+
+STEXI
+@item info chardev
+@findex info chardev
+Show the character devices.
+ETEXI
+
+    {
+        .name       = "block",
+        .args_type  = "nodes:-n,verbose:-v,device:B?",
+        .params     = "[-n] [-v] [device]",
+        .help       = "show info of one block device or all block devices "
+                      "(-n: show named nodes; -v: show details)",
+        .cmd        = hmp_info_block,
+    },
+
+STEXI
+@item info block
+@findex info block
+Show info of one block device or all block devices.
+ETEXI
+
+    {
+        .name       = "blockstats",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show block device statistics",
+        .cmd        = hmp_info_blockstats,
+    },
+
+STEXI
+@item info blockstats
+@findex info blockstats
+Show block device statistics.
+ETEXI
+
+    {
+        .name       = "block-jobs",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show progress of ongoing block device operations",
+        .cmd        = hmp_info_block_jobs,
+    },
+
+STEXI
+@item info block-jobs
+@findex info block-jobs
+Show progress of ongoing block device operations.
+ETEXI
+
+    {
+        .name       = "history",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show the command line history",
+        .cmd        = hmp_info_history,
+        .flags      = "p",
+    },
+
+STEXI
+@item info history
+@findex info history
+Show the command line history.
+ETEXI
+
+    {
+        .name       = "pci",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show PCI info",
+        .cmd        = hmp_info_pci,
+    },
+
+STEXI
+@item info pci
+@findex info pci
+Show PCI information.
+ETEXI
+
+    {
+        .name       = "qtree",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show device tree",
+        .cmd        = hmp_info_qtree,
+    },
+
+STEXI
+@item info qtree
+@findex info qtree
+Show device tree.
+ETEXI
+
+    {
+        .name       = "qdm",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show qdev device model list",
+        .cmd        = hmp_info_qdm,
+    },
+
+STEXI
+@item info qdm
+@findex info qdm
+Show qdev device model list.
+ETEXI
+
+    {
+        .name       = "qom-tree",
+        .args_type  = "path:s?",
+        .params     = "[path]",
+        .help       = "show QOM composition tree",
+        .cmd        = hmp_info_qom_tree,
+        .flags      = "p",
+    },
+
+STEXI
+@item info qom-tree
+@findex info qom-tree
+Show QOM composition tree.
+ETEXI
+
+STEXI
+@end table
+ETEXI
+
+STEXI
+@end table
+ETEXI
diff --git a/hmp-scsi-commands.hx b/hmp-scsi-commands.hx
new file mode 100644
index 0000000..d3438f3
--- /dev/null
+++ b/hmp-scsi-commands.hx
@@ -0,0 +1,384 @@
+HXCOMM Use DEFHEADING() to define headings in both help text and texi
+HXCOMM Text between STEXI and ETEXI are copied to texi version and
+HXCOMM discarded from C version
+HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
+HXCOMM monitor commands
+HXCOMM HXCOMM can be used for comments, discarded from both texi and C
+
+STEXI
+@table @option
+ETEXI
+
+    {
+        .name       = "help|?",
+        .args_type  = "name:S?",
+        .params     = "[cmd]",
+        .help       = "show the help",
+        .cmd        = do_help_cmd,
+        .flags      = "p",
+    },
+
+STEXI
+@item help or ? [@var{cmd}]
+@findex help
+Show the help for all commands or just for command @var{cmd}.
+ETEXI
+
+    {
+        .name       = "q|quit",
+        .args_type  = "",
+        .params     = "",
+        .help       = "quit the emulator",
+        .cmd        = hmp_quit,
+    },
+
+STEXI
+@item q or quit
+@findex quit
+Quit the emulator.
+ETEXI
+
+    {
+        .name       = "block_resize",
+        .args_type  = "device:B,size:o",
+        .params     = "device size",
+        .help       = "resize a block image",
+        .cmd        = hmp_block_resize,
+    },
+
+STEXI
+@item block_resize
+@findex block_resize
+Resize a block image while a guest is running.  Usually requires guest
+action to see the updated size.  Resize to a lower size is supported,
+but should be used with extreme caution.  Note that this command only
+resizes image files, it can not resize block devices like LVM volumes.
+ETEXI
+
+    {
+        .name       = "block_stream",
+        .args_type  = "device:B,speed:o?,base:s?",
+        .params     = "device [speed [base]]",
+        .help       = "copy data from a backing file into a block device",
+        .cmd        = hmp_block_stream,
+    },
+
+STEXI
+@item block_stream
+@findex block_stream
+Copy data from a backing file into a block device.
+ETEXI
+
+    {
+        .name       = "block_job_set_speed",
+        .args_type  = "device:B,speed:o",
+        .params     = "device speed",
+        .help       = "set maximum speed for a background block operation",
+        .cmd        = hmp_block_job_set_speed,
+    },
+
+STEXI
+@item block_job_set_speed
+@findex block_job_set_speed
+Set maximum speed for a background block operation.
+ETEXI
+
+    {
+        .name       = "block_job_cancel",
+        .args_type  = "force:-f,device:B",
+        .params     = "[-f] device",
+        .help       = "stop an active background block operation (use -f"
+                      "\n\t\t\t if you want to abort the operation immediately"
+                      "\n\t\t\t instead of keep running until data is in sync)",
+        .cmd        = hmp_block_job_cancel,
+    },
+
+STEXI
+@item block_job_cancel
+@findex block_job_cancel
+Stop an active background block operation (streaming, mirroring).
+ETEXI
+
+    {
+        .name       = "block_job_complete",
+        .args_type  = "device:B",
+        .params     = "device",
+        .help       = "stop an active background block operation",
+        .cmd        = hmp_block_job_complete,
+    },
+
+STEXI
+@item block_job_complete
+@findex block_job_complete
+Manually trigger completion of an active background block operation.
+For mirroring, this will switch the device to the destination path.
+ETEXI
+
+    {
+        .name       = "block_job_pause",
+        .args_type  = "device:B",
+        .params     = "device",
+        .help       = "pause an active background block operation",
+        .cmd        = hmp_block_job_pause,
+    },
+
+STEXI
+@item block_job_pause
+@findex block_job_pause
+Pause an active block streaming operation.
+ETEXI
+
+    {
+        .name       = "block_job_resume",
+        .args_type  = "device:B",
+        .params     = "device",
+        .help       = "resume a paused background block operation",
+        .cmd        = hmp_block_job_resume,
+    },
+
+STEXI
+@item block_job_resume
+@findex block_job_resume
+Resume a paused block streaming operation.
+ETEXI
+
+    {
+        .name       = "eject",
+        .args_type  = "force:-f,device:B",
+        .params     = "[-f] device",
+        .help       = "eject a removable medium (use -f to force it)",
+        .cmd        = hmp_eject,
+    },
+
+STEXI
+@item eject [-f] @var{device}
+@findex eject
+Eject a removable medium (use -f to force it).
+ETEXI
+
+    {
+        .name       = "drive_del",
+        .args_type  = "id:B",
+        .params     = "device",
+        .help       = "remove host block device",
+        .cmd        = hmp_drive_del,
+    },
+
+STEXI
+@item drive_del @var{device}
+@findex drive_del
+Remove host block device.  The result is that guest generated IO is no longer
+submitted against the host device underlying the disk.  Once a drive has
+been deleted, the QEMU Block layer returns -EIO which results in IO
+errors in the guest for applications that are reading/writing to the device.
+These errors are always reported to the guest, regardless of the drive's error
+actions (drive options rerror, werror).
+ETEXI
+
+    {
+        .name       = "change",
+        .args_type  = "device:B,target:F,arg:s?,read-only-mode:s?",
+        .params     = "device filename [format [read-only-mode]]",
+        .help       = "change a removable medium, optional format",
+        .cmd        = hmp_change,
+    },
+
+STEXI
+@item change @var{device} @var{setting}
+@findex change
+Change the configuration of a device.
+
+@table @option
+@item change @var{diskdevice} @var{filename} [@var{format} [@var{read-only-mode}]]
+Change the medium for a removable disk device to point to @var{filename}. eg
+
+@example
+(qemu) change ide1-cd0 /path/to/some.iso
+@end example
+
+@var{format} is optional.
+
+@var{read-only-mode} may be used to change the read-only status of the device.
+It accepts the following values:
+
+@table @var
+@item retain
+Retains the current status; this is the default.
+
+@item read-only
+Makes the device read-only.
+
+@item read-write
+Makes the device writable.
+@end table
+
+@item change vnc @var{display},@var{options}
+Change the configuration of the VNC server. The valid syntax for @var{display}
+and @var{options} are described at @ref{sec_invocation}. eg
+
+@example
+(qemu) change vnc localhost:1
+@end example
+
+@item change vnc password [@var{password}]
+
+Change the password associated with the VNC server. If the new password is not
+supplied, the monitor will prompt for it to be entered. VNC passwords are only
+significant up to 8 letters. eg
+
+@example
+(qemu) change vnc password
+Password: ********
+@end example
+
+@end table
+ETEXI
+
+    {
+        .name       = "device_add",
+        .args_type  = "device:O",
+        .params     = "driver[,prop=value][,...]",
+        .help       = "add device, like -device on the command line",
+        .cmd        = hmp_device_add,
+        .command_completion = device_add_completion,
+    },
+
+STEXI
+@item device_add @var{config}
+@findex device_add
+Add device.
+ETEXI
+
+    {
+        .name       = "device_del",
+        .args_type  = "id:s",
+        .params     = "device",
+        .help       = "remove device",
+        .cmd        = hmp_device_del,
+        .command_completion = device_del_completion,
+    },
+
+STEXI
+@item device_del @var{id}
+@findex device_del
+Remove device @var{id}. @var{id} may be a short ID
+or a QOM object path.
+ETEXI
+
+    {
+        .name       = "drive_backup",
+        .args_type  = "reuse:-n,full:-f,compress:-c,device:B,target:s,format:s?",
+        .params     = "[-n] [-f] [-c] device target [format]",
+        .help       = "initiates a point-in-time\n\t\t\t"
+                      "copy for a device. The device's contents are\n\t\t\t"
+                      "copied to the new image file, excluding data that\n\t\t\t"
+                      "is written after the command is started.\n\t\t\t"
+                      "The -n flag requests QEMU to reuse the image found\n\t\t\t"
+                      "in new-image-file, instead of recreating it from scratch.\n\t\t\t"
+                      "The -f flag requests QEMU to copy the whole disk,\n\t\t\t"
+                      "so that the result does not need a backing file.\n\t\t\t"
+                      "The -c flag requests QEMU to compress backup data\n\t\t\t"
+                      "(if the target format supports it).\n\t\t\t",
+        .cmd        = hmp_drive_backup,
+    },
+STEXI
+@item drive_backup
+@findex drive_backup
+Start a point-in-time copy of a block device to a specificed target.
+ETEXI
+
+    {
+        .name       = "drive_add",
+        .args_type  = "node:-n,pci_addr:s,opts:s",
+        .params     = "[-n] [[<domain>:]<bus>:]<slot>\n"
+                      "[file=file][,if=type][,bus=n]\n"
+                      "[,unit=m][,media=d][,index=i]\n"
+                      "[,snapshot=on|off][,cache=on|off]\n"
+                      "[,readonly=on|off][,copy-on-read=on|off]",
+        .help       = "add drive to PCI storage controller",
+        .cmd        = hmp_drive_add,
+    },
+
+STEXI
+@item drive_add
+@findex drive_add
+Add drive to PCI storage controller.
+ETEXI
+
+    {
+        .name       = "chardev-add",
+        .args_type  = "args:s",
+        .params     = "args",
+        .help       = "add chardev",
+        .cmd        = hmp_chardev_add,
+        .command_completion = chardev_add_completion,
+    },
+
+STEXI
+@item chardev-add args
+@findex chardev-add
+chardev-add accepts the same parameters as the -chardev command line switch.
+
+ETEXI
+
+    {
+        .name       = "chardev-change",
+        .args_type  = "id:s,args:s",
+        .params     = "id args",
+        .help       = "change chardev",
+        .cmd        = hmp_chardev_change,
+    },
+
+STEXI
+@item chardev-change args
+@findex chardev-change
+chardev-change accepts existing chardev @var{id} and then the same arguments
+as the -chardev command line switch (except for "id").
+
+ETEXI
+
+    {
+        .name       = "chardev-remove",
+        .args_type  = "id:s",
+        .params     = "id",
+        .help       = "remove chardev",
+        .cmd        = hmp_chardev_remove,
+        .command_completion = chardev_remove_completion,
+    },
+
+STEXI
+@item chardev-remove id
+@findex chardev-remove
+Removes the chardev @var{id}.
+
+ETEXI
+
+    {
+        .name       = "chardev-send-break",
+        .args_type  = "id:s",
+        .params     = "id",
+        .help       = "send a break on chardev",
+        .cmd        = hmp_chardev_send_break,
+        .command_completion = chardev_remove_completion,
+    },
+
+STEXI
+@item chardev-send-break id
+@findex chardev-send-break
+Send a break on the chardev @var{id}.
+
+ETEXI
+
+    {
+        .name       = "info",
+        .args_type  = "item:s?",
+        .params     = "[subcommand]",
+        .help       = "show various information about the system state",
+        .cmd        = hmp_info_help,
+        .sub_table  = hmp_info_cmds,
+        .flags      = "p",
+    },
+
+STEXI
+@end table
+ETEXI
diff --git a/monitor/misc.c b/monitor/misc.c
index 00338c0..4914f46 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -176,12 +176,12 @@ int hmp_compare_cmd(const char *name, const char *list)
     return 0;
 }
 
-static void do_help_cmd(Monitor *mon, const QDict *qdict)
+void do_help_cmd(Monitor *mon, const QDict *qdict)
 {
     help_cmd(mon, qdict_get_try_str(qdict, "name"));
 }
 
-static void hmp_trace_event(Monitor *mon, const QDict *qdict)
+void hmp_trace_event(Monitor *mon, const QDict *qdict)
 {
     const char *tp_name = qdict_get_str(qdict, "name");
     bool new_state = qdict_get_bool(qdict, "option");
@@ -225,7 +225,7 @@ static void hmp_trace_file(Monitor *mon, const QDict *qdict)
 }
 #endif
 
-static void hmp_info_help(Monitor *mon, const QDict *qdict)
+void hmp_info_help(Monitor *mon, const QDict *qdict)
 {
     help_cmd(mon, "info");
 }
@@ -436,7 +436,7 @@ int monitor_get_cpu_index(void)
     return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
 }
 
-static void hmp_info_registers(Monitor *mon, const QDict *qdict)
+void hmp_info_registers(Monitor *mon, const QDict *qdict)
 {
     bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
     CPUState *cs;
@@ -459,7 +459,7 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
 }
 
 #ifdef CONFIG_TCG
-static void hmp_info_jit(Monitor *mon, const QDict *qdict)
+void hmp_info_jit(Monitor *mon, const QDict *qdict)
 {
     if (!tcg_enabled()) {
         error_report("JIT information is only available with accel=tcg");
@@ -470,13 +470,13 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
     dump_drift_info();
 }
 
-static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
+void hmp_info_opcount(Monitor *mon, const QDict *qdict)
 {
     dump_opcount_info();
 }
 #endif
 
-static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
+void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
 {
     int64_t max = qdict_get_try_int(qdict, "max", 10);
     bool mean = qdict_get_try_bool(qdict, "mean", false);
@@ -487,7 +487,7 @@ static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
     qsp_report(max, sort_by, coalesce);
 }
 
-static void hmp_info_history(Monitor *mon, const QDict *qdict)
+void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
     MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
     int i;
@@ -507,7 +507,7 @@ static void hmp_info_history(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
+void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
 {
     CPUState *cs = mon_get_cpu();
 
@@ -518,7 +518,7 @@ static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
     cpu_dump_statistics(cs, 0);
 }
 
-static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
+void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
 {
     const char *name = qdict_get_try_str(qdict, "name");
     bool has_vcpu = qdict_haskey(qdict, "vcpu");
@@ -578,7 +578,7 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
     error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "protocol", "spice");
 }
 
-static void hmp_logfile(Monitor *mon, const QDict *qdict)
+void hmp_logfile(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
@@ -588,7 +588,7 @@ static void hmp_logfile(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_log(Monitor *mon, const QDict *qdict)
+void hmp_log(Monitor *mon, const QDict *qdict)
 {
     int mask;
     const char *items = qdict_get_str(qdict, "items");
@@ -605,7 +605,7 @@ static void hmp_log(Monitor *mon, const QDict *qdict)
     qemu_set_log(mask);
 }
 
-static void hmp_singlestep(Monitor *mon, const QDict *qdict)
+void hmp_singlestep(Monitor *mon, const QDict *qdict)
 {
     const char *option = qdict_get_try_str(qdict, "option");
     if (!option || !strcmp(option, "on")) {
@@ -617,7 +617,7 @@ static void hmp_singlestep(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_gdbserver(Monitor *mon, const QDict *qdict)
+void hmp_gdbserver(Monitor *mon, const QDict *qdict)
 {
     const char *device = qdict_get_try_str(qdict, "device");
     if (!device)
@@ -633,7 +633,7 @@ static void hmp_gdbserver(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
+void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
 {
     const char *action = qdict_get_str(qdict, "action");
     if (select_watchdog_action(action) == -1) {
@@ -775,7 +775,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
 }
 
-static void hmp_memory_dump(Monitor *mon, const QDict *qdict)
+void hmp_memory_dump(Monitor *mon, const QDict *qdict)
 {
     int count = qdict_get_int(qdict, "count");
     int format = qdict_get_int(qdict, "format");
@@ -785,7 +785,7 @@ static void hmp_memory_dump(Monitor *mon, const QDict *qdict)
     memory_dump(mon, count, format, size, addr, 0);
 }
 
-static void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
+void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
 {
     int count = qdict_get_int(qdict, "count");
     int format = qdict_get_int(qdict, "format");
@@ -815,7 +815,7 @@ static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
     return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
 }
 
-static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
+void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
 {
     hwaddr addr = qdict_get_int(qdict, "addr");
     Error *local_err = NULL;
@@ -835,7 +835,7 @@ static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
     memory_region_unref(mr);
 }
 
-static void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
+void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
 {
     target_ulong addr = qdict_get_int(qdict, "addr");
     MemTxAttrs attrs;
@@ -890,7 +890,7 @@ out:
     return ret;
 }
 
-static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
+void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
 {
     hwaddr addr = qdict_get_int(qdict, "addr");
     Error *local_err = NULL;
@@ -917,7 +917,7 @@ static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
 }
 #endif
 
-static void do_print(Monitor *mon, const QDict *qdict)
+void do_print(Monitor *mon, const QDict *qdict)
 {
     int format = qdict_get_int(qdict, "format");
     hwaddr val = qdict_get_int(qdict, "val");
@@ -943,7 +943,7 @@ static void do_print(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "\n");
 }
 
-static void hmp_sum(Monitor *mon, const QDict *qdict)
+void hmp_sum(Monitor *mon, const QDict *qdict)
 {
     uint32_t addr;
     uint16_t sum;
@@ -963,7 +963,7 @@ static void hmp_sum(Monitor *mon, const QDict *qdict)
 
 static int mouse_button_state;
 
-static void hmp_mouse_move(Monitor *mon, const QDict *qdict)
+void hmp_mouse_move(Monitor *mon, const QDict *qdict)
 {
     int dx, dy, dz, button;
     const char *dx_str = qdict_get_str(qdict, "dx_str");
@@ -987,7 +987,7 @@ static void hmp_mouse_move(Monitor *mon, const QDict *qdict)
     qemu_input_event_sync();
 }
 
-static void hmp_mouse_button(Monitor *mon, const QDict *qdict)
+void hmp_mouse_button(Monitor *mon, const QDict *qdict)
 {
     static uint32_t bmap[INPUT_BUTTON__MAX] = {
         [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
@@ -1004,7 +1004,7 @@ static void hmp_mouse_button(Monitor *mon, const QDict *qdict)
     mouse_button_state = button_state;
 }
 
-static void hmp_ioport_read(Monitor *mon, const QDict *qdict)
+void hmp_ioport_read(Monitor *mon, const QDict *qdict)
 {
     int size = qdict_get_int(qdict, "size");
     int addr = qdict_get_int(qdict, "addr");
@@ -1038,7 +1038,7 @@ static void hmp_ioport_read(Monitor *mon, const QDict *qdict)
                    suffix, addr, size * 2, val);
 }
 
-static void hmp_ioport_write(Monitor *mon, const QDict *qdict)
+void hmp_ioport_write(Monitor *mon, const QDict *qdict)
 {
     int size = qdict_get_int(qdict, "size");
     int addr = qdict_get_int(qdict, "addr");
@@ -1060,7 +1060,7 @@ static void hmp_ioport_write(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_boot_set(Monitor *mon, const QDict *qdict)
+void hmp_boot_set(Monitor *mon, const QDict *qdict)
 {
     Error *local_err = NULL;
     const char *bootdevice = qdict_get_str(qdict, "bootdevice");
@@ -1073,7 +1073,7 @@ static void hmp_boot_set(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
+void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 {
     bool flatview = qdict_get_try_bool(qdict, "flatview", false);
     bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
@@ -1086,7 +1086,7 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 
 int64_t dev_time;
 
-static void hmp_info_profile(Monitor *mon, const QDict *qdict)
+void hmp_info_profile(Monitor *mon, const QDict *qdict)
 {
     static int64_t last_cpu_exec_time;
     int64_t cpu_exec_time;
@@ -1103,7 +1103,7 @@ static void hmp_info_profile(Monitor *mon, const QDict *qdict)
     dev_time = 0;
 }
 #else
-static void hmp_info_profile(Monitor *mon, const QDict *qdict)
+void hmp_info_profile(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "Internal profiler not compiled\n");
 }
@@ -1112,7 +1112,7 @@ static void hmp_info_profile(Monitor *mon, const QDict *qdict)
 /* Capture support */
 static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
 
-static void hmp_info_capture(Monitor *mon, const QDict *qdict)
+void hmp_info_capture(Monitor *mon, const QDict *qdict)
 {
     int i;
     CaptureState *s;
@@ -1123,7 +1123,7 @@ static void hmp_info_capture(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_stopcapture(Monitor *mon, const QDict *qdict)
+void hmp_stopcapture(Monitor *mon, const QDict *qdict)
 {
     int i;
     int n = qdict_get_int(qdict, "n");
@@ -1139,7 +1139,7 @@ static void hmp_stopcapture(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
+void hmp_wavcapture(Monitor *mon, const QDict *qdict)
 {
     const char *path = qdict_get_str(qdict, "path");
     int has_freq = qdict_haskey(qdict, "freq");
@@ -1192,7 +1192,7 @@ static void hmp_warn_acl(void)
     warn_acl = true;
 }
 
-static void hmp_acl_show(Monitor *mon, const QDict *qdict)
+void hmp_acl_show(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     QAuthZList *auth = find_auth(mon, aclname);
@@ -1219,7 +1219,7 @@ static void hmp_acl_show(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_acl_reset(Monitor *mon, const QDict *qdict)
+void hmp_acl_reset(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     QAuthZList *auth = find_auth(mon, aclname);
@@ -1236,7 +1236,7 @@ static void hmp_acl_reset(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "acl: removed all rules\n");
 }
 
-static void hmp_acl_policy(Monitor *mon, const QDict *qdict)
+void hmp_acl_policy(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     const char *policy = qdict_get_str(qdict, "policy");
@@ -1277,7 +1277,7 @@ static QAuthZListFormat hmp_acl_get_format(const char *match)
     }
 }
 
-static void hmp_acl_add(Monitor *mon, const QDict *qdict)
+void hmp_acl_add(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     const char *match = qdict_get_str(qdict, "match");
@@ -1330,7 +1330,7 @@ static void hmp_acl_add(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_acl_remove(Monitor *mon, const QDict *qdict)
+void hmp_acl_remove(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     const char *match = qdict_get_str(qdict, "match");
@@ -1799,13 +1799,21 @@ int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
 
 /* Please update hmp-commands.hx when adding or changing commands */
 static HMPCommand hmp_info_cmds[] = {
+#if defined(SCSI_PROCESS)
+#include "hmp-scsi-commands-info.h"
+#else
 #include "hmp-commands-info.h"
+#endif
     { NULL, NULL, },
 };
 
 /* hmp_cmds and hmp_info_cmds would be sorted at runtime */
 HMPCommand hmp_cmds[] = {
+#if defined(SCSI_PROCESS)
+#include "hmp-scsi-commands.h"
+#else
 #include "hmp-commands.h"
+#endif
     { NULL, NULL, },
 };
 
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 7760b22..5e8abd6 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -180,4 +180,42 @@ void help_cmd(Monitor *mon, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
+void do_help_cmd(Monitor *mon, const QDict *qdict);
+void hmp_trace_event(Monitor *mon, const QDict *qdict);
+void hmp_info_help(Monitor *mon, const QDict *qdict);
+void hmp_info_registers(Monitor *mon, const QDict *qdict);
+void hmp_info_jit(Monitor *mon, const QDict *qdict);
+void hmp_info_opcount(Monitor *mon, const QDict *qdict);
+void hmp_info_sync_profile(Monitor *mon, const QDict *qdict);
+void hmp_info_history(Monitor *mon, const QDict *qdict);
+void hmp_info_cpustats(Monitor *mon, const QDict *qdict);
+void hmp_info_trace_events(Monitor *mon, const QDict *qdict);
+void hmp_logfile(Monitor *mon, const QDict *qdict);
+void hmp_log(Monitor *mon, const QDict *qdict);
+void hmp_singlestep(Monitor *mon, const QDict *qdict);
+void hmp_gdbserver(Monitor *mon, const QDict *qdict);
+void hmp_watchdog_action(Monitor *mon, const QDict *qdict);
+void hmp_memory_dump(Monitor *mon, const QDict *qdict);
+void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
+void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
+void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
+void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
+void do_print(Monitor *mon, const QDict *qdict);
+void hmp_sum(Monitor *mon, const QDict *qdict);
+void hmp_mouse_move(Monitor *mon, const QDict *qdict);
+void hmp_mouse_button(Monitor *mon, const QDict *qdict);
+void hmp_ioport_read(Monitor *mon, const QDict *qdict);
+void hmp_ioport_write(Monitor *mon, const QDict *qdict);
+void hmp_boot_set(Monitor *mon, const QDict *qdict);
+void hmp_info_mtree(Monitor *mon, const QDict *qdict);
+void hmp_info_profile(Monitor *mon, const QDict *qdict);
+void hmp_info_capture(Monitor *mon, const QDict *qdict);
+void hmp_stopcapture(Monitor *mon, const QDict *qdict);
+void hmp_wavcapture(Monitor *mon, const QDict *qdict);
+void hmp_acl_show(Monitor *mon, const QDict *qdict);
+void hmp_acl_reset(Monitor *mon, const QDict *qdict);
+void hmp_acl_policy(Monitor *mon, const QDict *qdict);
+void hmp_acl_add(Monitor *mon, const QDict *qdict);
+void hmp_acl_remove(Monitor *mon, const QDict *qdict);
+
 #endif
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index e42ea7a..4410d71 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -7,4 +7,4 @@ common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
 remote-pci-obj-$(CONFIG_MPQEMU) += object.o qom-qobject.o container.o
 remote-pci-obj-$(CONFIG_MPQEMU) += object_interfaces.o
 remote-pci-obj-$(CONFIG_MPQEMU) += cpu.o
-remote-pci-obj-$(CONFIG_MPQEMU) += qom-qmp-cmds.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qom-qmp-cmds.o qom-hmp-cmds.o
-- 
1.8.3.1


