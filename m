Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EB9C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D0B2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cp3TE4yC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D0B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTLX-0000KR-Di
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGv-0001NU-Tj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGu-0008Iy-Uu
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTGu-0008EC-Cm
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CcU6131607;
 Thu, 23 Apr 2020 04:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ErnlVmUky9MlIpNpwlwVvahKl4XDiFrMn9QLMadETbs=;
 b=Cp3TE4yCTTnVjH5pdDF4x/TzkcdTQd91C9S8QFRGN6hT5tYGTz3oKrENPHFln1hUa8ZN
 O/854Z+j4OhppjVhvkOJNS1htVU8l4K+W1r3Mq8hNU6D1LXiicjB+T06J7p7V1gB6+E1
 XPKH5gNf0W8S9zDvVsMx1uqES6dyROSZOQKWvrNkyl0gk+KWynME/072gcEn/jYbWHMl
 UQbpxlqFhcbfXArWyD90/zvbM1Up4+KAB13Ko/9u+SgAn4zqQKH5a67KsGJuvU+RdqVv
 pD/zNi+6HnJ4YtweH7aPjr502aJhpr62j6WFVYdLcKDv2W17ihufNJ5xWSJiMR21J3/S 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 30jvq4s917-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4Bf2v093677;
 Thu, 23 Apr 2020 04:15:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 30gb3ux0yc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:25 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4FNDV020411;
 Thu, 23 Apr 2020 04:15:23 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:15:22 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 31/36] multi-process/mon: choose HMP commands based
 on target
Date: Wed, 22 Apr 2020 21:14:06 -0700
Message-Id: <063939aadc1e3da83f6c2772dbbfc5ff02ba7ccb.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=1 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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


