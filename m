Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC80C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818B3206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OoO09WPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818B3206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOW0-0005Ew-Kw
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOH2-0002nd-J8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOH0-0002W4-Ry
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOH0-0002V0-JW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369eCZN089766;
 Mon, 6 Apr 2020 09:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ErnlVmUky9MlIpNpwlwVvahKl4XDiFrMn9QLMadETbs=;
 b=OoO09WPdq9+YDwNXcg9gRhD/iA5VoIB4O5nOdIp+0DCXI+tz+Aa0x1U0UHRRjALSNP1q
 KXZz1lX0RW0H/j6VIc6j9bNexUnVT7C49z/kEdqGKpT2E5IkV7s6lLsVc4W5SYvl+UeA
 CBOgaLB7CMAnscJIQ6q9Ls8deb7DhOeDmvshRQP1AukB1PcMmd/o028KmCkVY8QKnn35
 X6LvAVzSE2/5ALT3QR2fmnaCFnMlRdpVOBwT/t6P4TBNPpgUwS/iA7N3nGYiBlwpA4iy
 MoPGUPZJkA37k3S3PgpC5Dv0/yPJj2BH0Xbdg3wBnOWRJC7vwj/sBArabvdyrvY6ZxTV jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 306hnqwtyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369fN8t066116;
 Mon, 6 Apr 2020 09:42:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 307419xhu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:24 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369gNjb032122;
 Mon, 6 Apr 2020 09:42:23 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:23 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 31/36] multi-process/mon: choose HMP commands based on
 target
Date: Mon,  6 Apr 2020 02:41:21 -0700
Message-Id: <5baeb9209242fc32e43f25513fab9ab082a52c0a.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=1
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
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
 scripts/hxtool       | 35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 64 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 scripts/hxtool

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ca5198438d..1fbca7a18d 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -23,6 +23,7 @@ ERST
         .params     = "",
         .help       = "show the version of QEMU",
         .cmd        = hmp_info_version,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
@@ -50,6 +51,7 @@ ERST
         .params     = "",
         .help       = "show the character devices",
         .cmd        = hmp_info_chardev,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
@@ -65,6 +67,7 @@ ERST
         .help       = "show info of one block device or all block devices "
                       "(-n: show named nodes; -v: show details)",
         .cmd        = hmp_info_block,
+        .targets    = "scsi",
     },
 
 SRST
@@ -78,6 +81,7 @@ ERST
         .params     = "",
         .help       = "show block device statistics",
         .cmd        = hmp_info_blockstats,
+        .targets    = "scsi",
     },
 
 SRST
@@ -91,6 +95,7 @@ ERST
         .params     = "",
         .help       = "show progress of ongoing block device operations",
         .cmd        = hmp_info_block_jobs,
+        .targets    = "scsi",
     },
 
 SRST
@@ -161,6 +166,7 @@ ERST
         .params     = "",
         .help       = "show the command line history",
         .cmd        = hmp_info_history,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
@@ -214,6 +220,7 @@ ERST
         .params     = "",
         .help       = "show PCI info",
         .cmd        = hmp_info_pci,
+        .targets    = "scsi",
     },
 
 SRST
@@ -598,6 +605,7 @@ ERST
         .params     = "",
         .help       = "show device tree",
         .cmd        = hmp_info_qtree,
+        .targets    = "scsi",
     },
 
 SRST
@@ -611,6 +619,7 @@ ERST
         .params     = "",
         .help       = "show qdev device model list",
         .cmd        = hmp_info_qdm,
+        .targets    = "scsi",
     },
 
 SRST
@@ -624,6 +633,7 @@ ERST
         .params     = "[path]",
         .help       = "show QOM composition tree",
         .cmd        = hmp_info_qom_tree,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 02cae25c24..1b60676d7c 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -45,6 +45,7 @@ ERST
         .params     = "",
         .help       = "quit the emulator",
         .cmd        = hmp_quit,
+        .targets    = "scsi",
     },
 
 SRST
@@ -76,6 +77,7 @@ ERST
         .params     = "device size",
         .help       = "resize a block image",
         .cmd        = hmp_block_resize,
+        .targets    = "scsi",
     },
 
 SRST
@@ -92,6 +94,7 @@ ERST
         .params     = "device [speed [base]]",
         .help       = "copy data from a backing file into a block device",
         .cmd        = hmp_block_stream,
+        .targets    = "scsi",
     },
 
 SRST
@@ -105,6 +108,7 @@ ERST
         .params     = "device speed",
         .help       = "set maximum speed for a background block operation",
         .cmd        = hmp_block_job_set_speed,
+        .targets    = "scsi",
     },
 
 SRST
@@ -120,6 +124,7 @@ ERST
                       "\n\t\t\t if you want to abort the operation immediately"
                       "\n\t\t\t instead of keep running until data is in sync)",
         .cmd        = hmp_block_job_cancel,
+        .targets    = "scsi",
     },
 
 SRST
@@ -133,6 +138,7 @@ ERST
         .params     = "device",
         .help       = "stop an active background block operation",
         .cmd        = hmp_block_job_complete,
+        .targets    = "scsi",
     },
 
 SRST
@@ -147,6 +153,7 @@ ERST
         .params     = "device",
         .help       = "pause an active background block operation",
         .cmd        = hmp_block_job_pause,
+        .targets    = "scsi",
     },
 
 SRST
@@ -160,6 +167,7 @@ ERST
         .params     = "device",
         .help       = "resume a paused background block operation",
         .cmd        = hmp_block_job_resume,
+        .targets    = "scsi",
     },
 
 SRST
@@ -173,6 +181,7 @@ ERST
         .params     = "[-f] device",
         .help       = "eject a removable medium (use -f to force it)",
         .cmd        = hmp_eject,
+        .targets    = "scsi",
     },
 
 SRST
@@ -186,6 +195,7 @@ ERST
         .params     = "device",
         .help       = "remove host block device",
         .cmd        = hmp_drive_del,
+        .targets    = "scsi",
     },
 
 SRST
@@ -204,6 +214,7 @@ ERST
         .params     = "device filename [format [read-only-mode]]",
         .help       = "change a removable medium, optional format",
         .cmd        = hmp_change,
+        .targets    = "scsi",
     },
 
 SRST
@@ -671,6 +682,7 @@ ERST
         .help       = "add device, like -device on the command line",
         .cmd        = hmp_device_add,
         .command_completion = device_add_completion,
+        .targets    = "scsi",
     },
 
 SRST
@@ -685,6 +697,7 @@ ERST
         .help       = "remove device",
         .cmd        = hmp_device_del,
         .command_completion = device_del_completion,
+        .targets    = "scsi",
     },
 
 SRST
@@ -1264,6 +1277,7 @@ ERST
                       "The -c flag requests QEMU to compress backup data\n\t\t\t"
                       "(if the target format supports it).\n\t\t\t",
         .cmd        = hmp_drive_backup,
+        .targets    = "scsi",
     },
 SRST
 ``drive_backup``
@@ -1280,6 +1294,7 @@ ERST
                       "[,readonly=on|off][,copy-on-read=on|off]",
         .help       = "add drive to PCI storage controller",
         .cmd        = hmp_drive_add,
+        .targets    = "scsi",
     },
 
 SRST
@@ -1697,6 +1712,7 @@ ERST
         .help       = "add chardev",
         .cmd        = hmp_chardev_add,
         .command_completion = chardev_add_completion,
+        .targets    = "scsi",
     },
 
 SRST
@@ -1710,6 +1726,7 @@ ERST
         .params     = "id args",
         .help       = "change chardev",
         .cmd        = hmp_chardev_change,
+        .targets    = "scsi",
     },
 
 SRST
@@ -1725,6 +1742,7 @@ ERST
         .help       = "remove chardev",
         .cmd        = hmp_chardev_remove,
         .command_completion = chardev_remove_completion,
+        .targets    = "scsi",
     },
 
 SRST
@@ -1739,6 +1757,7 @@ ERST
         .help       = "send a break on chardev",
         .cmd        = hmp_chardev_send_break,
         .command_completion = chardev_remove_completion,
+        .targets    = "scsi",
     },
 
 SRST
@@ -1810,6 +1829,7 @@ ERST
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
index 7b1452f3cf..80c6845db1
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -10,7 +10,39 @@ hxtoh()
             SRST*|ERST*) flag=$(($flag^1))
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
+            ;;
+        esac
+    done
+}
+
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
+            SRST*|ERST*) flag=$(($flag^1)); test $use_section -eq 1 && printf '%s' "$section"; section=""; use_section=0
+            ;;
+            *)
+            test $flag -eq 1 && section="${section} ${str} ${IFS}"
             ;;
         esac
     done
@@ -18,6 +50,7 @@ hxtoh()
 
 case "$1" in
 "-h") hxtoh ;;
+"-tgt") hxtoh_tgt $2 ;;
 *) exit 1 ;;
 esac
 
-- 
2.25.GIT


