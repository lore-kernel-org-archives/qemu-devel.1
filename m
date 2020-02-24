Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC57C38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AD020CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uykGE8go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AD020CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L3v-00048J-SB
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmf-0007VN-Tn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kme-0003jn-1Z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kmd-0003ih-OW
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrXG6032136;
 Mon, 24 Feb 2020 20:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=vpe0/c5G0MXd4JAhsy6/u+S1fhUP7KtMyY9f4+3J9y0=;
 b=uykGE8go7EUwEw0hPoulYcC8MArfUGyM7lglFb7LD0RmG/br2pOVg+YuNJxKoZbKSPvJ
 BxWcdiD7LkL0E1mA1Ed/ZkC623UJlHGbS19T6vz3uW4DtD4naD3+yejUVDBOCv7EHSrr
 /S8SKPcYUR6gCaVG8rBJyQoZKD+ZVKHgNQ5v3cNStnMt25fIYCl82bYJEZrwI3Ivbk2N
 7ElRFkPzgSebxb7IQfWfV+ya3P5dwU9fyVF3Zh4lZJkQPV/dGTdHki/JtW68L66079yF
 oBJIjmQK+jUkl94GCLReh/WbLh5UxzVyGaDbvMHd+RMk9VVcDiQSKYiTa+VVVdyKXDAl Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2yauqua0pk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq5u5171230;
 Mon, 24 Feb 2020 20:56:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2ybdshksbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:50 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKunv2028718;
 Mon, 24 Feb 2020 20:56:49 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:49 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 34/50] multi-process/mon: choose HMP commands based on
 target
Date: Mon, 24 Feb 2020 15:55:25 -0500
Message-Id: <bf5c4efc14dc27a778509ff31190c82862af9fa1.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=964 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Add "targets" field to HMP command definition to select the targets
which would be supported by each command

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hmp-commands-info.hx | 10 ++++++++++
 hmp-commands.hx      | 20 ++++++++++++++++++++
 scripts/hxtool       | 44 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 scripts/hxtool

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 257ee7d..631cc76 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -19,6 +19,7 @@ ETEXI
         .params     = "",
         .help       = "show the version of QEMU",
         .cmd        = hmp_info_version,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
@@ -48,6 +49,7 @@ ETEXI
         .params     = "",
         .help       = "show the character devices",
         .cmd        = hmp_info_chardev,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
@@ -64,6 +66,7 @@ ETEXI
         .help       = "show info of one block device or all block devices "
                       "(-n: show named nodes; -v: show details)",
         .cmd        = hmp_info_block,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -78,6 +81,7 @@ ETEXI
         .params     = "",
         .help       = "show block device statistics",
         .cmd        = hmp_info_blockstats,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -92,6 +96,7 @@ ETEXI
         .params     = "",
         .help       = "show progress of ongoing block device operations",
         .cmd        = hmp_info_block_jobs,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -167,6 +172,7 @@ ETEXI
         .params     = "",
         .help       = "show the command line history",
         .cmd        = hmp_info_history,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
@@ -224,6 +230,7 @@ ETEXI
         .params     = "",
         .help       = "show PCI info",
         .cmd        = hmp_info_pci,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -630,6 +637,7 @@ ETEXI
         .params     = "",
         .help       = "show device tree",
         .cmd        = hmp_info_qtree,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -644,6 +652,7 @@ ETEXI
         .params     = "",
         .help       = "show qdev device model list",
         .cmd        = hmp_info_qdm,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -658,6 +667,7 @@ ETEXI
         .params     = "[path]",
         .help       = "show QOM composition tree",
         .cmd        = hmp_info_qom_tree,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index dc23185..ecc6169 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -49,6 +49,7 @@ ETEXI
         .params     = "",
         .help       = "quit the emulator",
         .cmd        = hmp_quit,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -82,6 +83,7 @@ ETEXI
         .params     = "device size",
         .help       = "resize a block image",
         .cmd        = hmp_block_resize,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -99,6 +101,7 @@ ETEXI
         .params     = "device [speed [base]]",
         .help       = "copy data from a backing file into a block device",
         .cmd        = hmp_block_stream,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -113,6 +116,7 @@ ETEXI
         .params     = "device speed",
         .help       = "set maximum speed for a background block operation",
         .cmd        = hmp_block_job_set_speed,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -129,6 +133,7 @@ ETEXI
                       "\n\t\t\t if you want to abort the operation immediately"
                       "\n\t\t\t instead of keep running until data is in sync)",
         .cmd        = hmp_block_job_cancel,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -143,6 +148,7 @@ ETEXI
         .params     = "device",
         .help       = "stop an active background block operation",
         .cmd        = hmp_block_job_complete,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -158,6 +164,7 @@ ETEXI
         .params     = "device",
         .help       = "pause an active background block operation",
         .cmd        = hmp_block_job_pause,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -172,6 +179,7 @@ ETEXI
         .params     = "device",
         .help       = "resume a paused background block operation",
         .cmd        = hmp_block_job_resume,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -186,6 +194,7 @@ ETEXI
         .params     = "[-f] device",
         .help       = "eject a removable medium (use -f to force it)",
         .cmd        = hmp_eject,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -200,6 +209,7 @@ ETEXI
         .params     = "device",
         .help       = "remove host block device",
         .cmd        = hmp_drive_del,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -219,6 +229,7 @@ ETEXI
         .params     = "device filename [format [read-only-mode]]",
         .help       = "change a removable medium, optional format",
         .cmd        = hmp_change,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -732,6 +743,7 @@ ETEXI
         .help       = "add device, like -device on the command line",
         .cmd        = hmp_device_add,
         .command_completion = device_add_completion,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -747,6 +759,7 @@ ETEXI
         .help       = "remove device",
         .cmd        = hmp_device_del,
         .command_completion = device_del_completion,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1351,6 +1364,7 @@ ETEXI
                       "The -c flag requests QEMU to compress backup data\n\t\t\t"
                       "(if the target format supports it).\n\t\t\t",
         .cmd        = hmp_drive_backup,
+        .targets    = "scsi",
     },
 STEXI
 @item drive_backup
@@ -1368,6 +1382,7 @@ ETEXI
                       "[,readonly=on|off][,copy-on-read=on|off]",
         .help       = "add drive to PCI storage controller",
         .cmd        = hmp_drive_add,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1816,6 +1831,7 @@ ETEXI
         .help       = "add chardev",
         .cmd        = hmp_chardev_add,
         .command_completion = chardev_add_completion,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1831,6 +1847,7 @@ ETEXI
         .params     = "id args",
         .help       = "change chardev",
         .cmd        = hmp_chardev_change,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1848,6 +1865,7 @@ ETEXI
         .help       = "remove chardev",
         .cmd        = hmp_chardev_remove,
         .command_completion = chardev_remove_completion,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1864,6 +1882,7 @@ ETEXI
         .help       = "send a break on chardev",
         .cmd        = hmp_chardev_send_break,
         .command_completion = chardev_remove_completion,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1940,6 +1959,7 @@ ETEXI
         .params     = "[subcommand]",
         .help       = "show various information about the system state",
         .cmd        = hmp_info_help,
+        .targets    = "scsi",
         .sub_table  = hmp_info_cmds,
         .flags      = "p",
     },
diff --git a/scripts/hxtool b/scripts/hxtool
old mode 100644
new mode 100755
index 0003e7b..802cbd4
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -10,7 +10,14 @@ hxtoh()
             STEXI*|ETEXI*|SRST*|ERST*) flag=$(($flag^1))
             ;;
             *)
-            test $flag -eq 1 && printf "%s\n" "$str"
+            # Skip line that has ".targets" as it is for multi-process targets based hmp
+            # commands generation.
+            echo $str | grep -q '.targets'
+            if [ $? -eq 0 ]; then
+                continue
+            else
+                test $flag -eq 1 && printf "%s\n" "$str"
+            fi
             ;;
         esac
     done
@@ -84,16 +91,49 @@ hxtotexi()
             print_texi_heading "$(expr "$str" : "ARCHHEADING(\(.*\),.*)")"
             ;;
             *)
-            test $flag -eq 1 && printf '%s\n' "$str"
+            # Skip line that has ".targets" as it is for multi-process targets based hmp
+            # commands generation.
+            echo $str | grep -q '.targetss'
+            if [ $? -eq 0 ]; then
+                continue
+            else
+                test $flag -eq 1 && printf '%s\n' "$str"
+            fi
             ;;
         esac
         line=$((line+1))
     done
 }
 
+hxtoh_tgt()
+{
+    section=""
+    flag=1
+    use_section=0
+    while read -r str; do
+        # Print section if it has ".targets" and the second argument passed to the
+        # script, such as "scsi".
+        echo "$str" | grep -q -E ".targets.*$1"
+        if [ $? -eq 0 ]; then
+            use_section=1
+            continue
+        fi
+        case $str in
+            HXCOMM*)
+            ;;
+            STEXI*|ETEXI*) flag=$(($flag^1)); test $use_section -eq 1 && printf '%s' "$section"; section=""; use_section=0
+            ;;
+            *)
+            test $flag -eq 1 && section="${section} ${str} ${IFS}"
+            ;;
+        esac
+    done
+}
+
 case "$1" in
 "-h") hxtoh ;;
 "-t") hxtotexi ;;
+"-tgt") hxtoh_tgt $2 ;;
 *) exit 1 ;;
 esac
 
-- 
1.8.3.1


