Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9CFC10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F7D2072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IH7NMMu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F7D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35243 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAB8Q-0001Ox-Ct
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsN-0004Ad-H7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsF-0005Yi-W9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAsF-0005VI-Gn
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:35 -0500
Received: by mail-wr1-x42b.google.com with SMTP id v4so1858691wrs.8
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZcCc7BYPhgeIF2SyGgKfpXNaDBnDdBOwqseAs2hlen0=;
 b=IH7NMMu6Z6DkN7Ijv05DP9WU3LSOtPxH3btXnDQxH4BBuhEu41PSbyDUyuxWI7i62u
 QmzUjQ1Dt6KiZ3Iw/lwKY68Py7d8FQ1la9HBVy/ads8cPCXsAhLOPVZuIOZc+oGf+xX9
 VymGSwkHsuI61VVshtPRcI0KLO3VjX0a1dqLeojv56BbhSDBLjDwckoUEbxl+YYFSwkH
 AcksjY975N8yds2jh9804mf4KJoX1NK9lkLmIvPE46+oChelX5iKmZ+fqc/7XZ9jniOa
 v8Ey4xwUomapr5a+Nrfyy3MH7AsJJjGz6iEqUx1OyzpkJRKQsmt+W/RN+5fUWhfGuEd7
 DXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZcCc7BYPhgeIF2SyGgKfpXNaDBnDdBOwqseAs2hlen0=;
 b=LBf2htG28VADiwjm4Dg7wM7AhS9SVVlmhxTHL3YqH/LJWt5YqN/yjtZlAtKgqBl0KX
 qpPSU9u9cBtQr1hGBvQHjhSFu6jQK/nepmUUWknUojbRElGmqRk4aOyQnCqVOXbE3gJz
 DNIOyqAD3ozAk30UYkNQyjw8LisPz9ZUvw4nj/6HEzwX2f2+obRaJh2ml7DMuSHzAtdp
 K4gsw6sfyEk5yzBv45mmzaI0VlAb5JL4dXdTMTqqE1+AUUu0cyRcq3ewsSZ90JQF+k8r
 iO5gjtEUG0WNNPQ6uzKgj+iPB6ZJJ1ZWlaaELol3FMUZanmZS1zUm9pTaAN4mPqoDP4k
 WIWA==
X-Gm-Message-State: ANhLgQ0dBDRlTK2GlkErcenfCE4LDg68wio4wfR9W9p9DY4vDFav9+Bi
 hwhuS4+sbP3lM5y5gvj1T+Z5o8jJDW56SQ==
X-Google-Smtp-Source: ADFU+vvHWmtbBeUiTgqfyNn3MLZjgv2SQNWKSd2VGYkLS797AQ7mvLhRn3VvmRmiqUw7dlkJsEl9VQ==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr3706630wrs.166.1583493031747; 
 Fri, 06 Mar 2020 03:10:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/33] hmp-commands.hx: Add rST documentation fragments
Date: Fri,  6 Mar 2020 11:09:46 +0000
Message-Id: <20200306110959.29461-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the rST versions of the documentation fragments.  Once we've
converted fully from Texinfo to rST we can remove the ETEXI
fragments; for the moment we need both.

Since the only consumer of the hmp-commands hxtool documentation
is the HTML manual, all we need to do for the monitor command
documentation to appear in the Sphinx system manual is add the
one line that invokes the hxtool extension on the .hx file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200228153619.9906-21-peter.maydell@linaro.org
---
 Makefile                |   2 +-
 docs/system/monitor.rst |  10 +-
 hmp-commands.hx         | 688 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 698 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f8642cd28a1..22427376b48 100644
--- a/Makefile
+++ b/Makefile
@@ -1071,7 +1071,7 @@ $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 	$(call build-manual,specs,html)
 
-$(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
+$(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system) $(SRC_PATH)/hmp-commands.hx
 	$(call build-manual,system,html)
 
 $(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools) $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
diff --git a/docs/system/monitor.rst b/docs/system/monitor.rst
index 482f391f327..52b0f18cfec 100644
--- a/docs/system/monitor.rst
+++ b/docs/system/monitor.rst
@@ -14,8 +14,16 @@ You can use it to:
 
 -  Inspect the VM state without an external debugger.
 
+Commands
+~~~~~~~~
+
+The following commands are available:
+
+.. hxtool-doc:: hmp-commands.hx
+
 ..
-  The commands section goes here once it's converted from Texinfo to RST.
+  TODO: convert and reference hmp-commands-info.hx
+
 
 Integer expressions
 ~~~~~~~~~~~~~~~~~~~
diff --git a/hmp-commands.hx b/hmp-commands.hx
index dc23185de43..9aa59f52312 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -23,6 +23,10 @@ STEXI
 @findex help
 Show the help for all commands or just for command @var{cmd}.
 ETEXI
+SRST
+``help`` or ``?`` [*cmd*]
+  Show the help for all commands or just for command *cmd*.
+ERST
 
     {
         .name       = "commit",
@@ -42,6 +46,16 @@ the backing file, the backing file will not be truncated.  If you want the
 backing file to match the size of the smaller snapshot, you can safely truncate
 it yourself once the commit operation successfully completes.
 ETEXI
+SRST
+``commit``
+  Commit changes to the disk images (if -snapshot is used) or backing files.
+  If the backing file is smaller than the snapshot, then the backing file
+  will be resized to be the same size as the snapshot.  If the snapshot is
+  smaller than the backing file, the backing file will not be truncated.
+  If you want the backing file to match the size of the smaller snapshot,
+  you can safely truncate it yourself once the commit operation successfully
+  completes.
+ERST
 
     {
         .name       = "q|quit",
@@ -56,6 +70,10 @@ STEXI
 @findex quit
 Quit the emulator.
 ETEXI
+SRST
+``q`` or ``quit``
+  Quit the emulator.
+ERST
 
     {
         .name       = "exit_preconfig",
@@ -75,6 +93,14 @@ and via the QMP monitor during the preconfig state. The command is only
 available during the preconfig state (i.e. when the --preconfig command
 line option was in use).
 ETEXI
+SRST
+``exit_preconfig``
+  This command makes QEMU exit the preconfig state and proceed with
+  VM initialization using configuration data provided on the command line
+  and via the QMP monitor during the preconfig state. The command is only
+  available during the preconfig state (i.e. when the --preconfig command
+  line option was in use).
+ERST
 
     {
         .name       = "block_resize",
@@ -92,6 +118,13 @@ action to see the updated size.  Resize to a lower size is supported,
 but should be used with extreme caution.  Note that this command only
 resizes image files, it can not resize block devices like LVM volumes.
 ETEXI
+SRST
+``block_resize``
+  Resize a block image while a guest is running.  Usually requires guest
+  action to see the updated size.  Resize to a lower size is supported,
+  but should be used with extreme caution.  Note that this command only
+  resizes image files, it can not resize block devices like LVM volumes.
+ERST
 
     {
         .name       = "block_stream",
@@ -106,6 +139,10 @@ STEXI
 @findex block_stream
 Copy data from a backing file into a block device.
 ETEXI
+SRST
+``block_stream``
+  Copy data from a backing file into a block device.
+ERST
 
     {
         .name       = "block_job_set_speed",
@@ -120,6 +157,10 @@ STEXI
 @findex block_job_set_speed
 Set maximum speed for a background block operation.
 ETEXI
+SRST
+``block_job_set_speed``
+  Set maximum speed for a background block operation.
+ERST
 
     {
         .name       = "block_job_cancel",
@@ -136,6 +177,10 @@ STEXI
 @findex block_job_cancel
 Stop an active background block operation (streaming, mirroring).
 ETEXI
+SRST
+``block_job_cancel``
+  Stop an active background block operation (streaming, mirroring).
+ERST
 
     {
         .name       = "block_job_complete",
@@ -151,6 +196,11 @@ STEXI
 Manually trigger completion of an active background block operation.
 For mirroring, this will switch the device to the destination path.
 ETEXI
+SRST
+``block_job_complete``
+  Manually trigger completion of an active background block operation.
+  For mirroring, this will switch the device to the destination path.
+ERST
 
     {
         .name       = "block_job_pause",
@@ -165,6 +215,10 @@ STEXI
 @findex block_job_pause
 Pause an active block streaming operation.
 ETEXI
+SRST
+``block_job_pause``
+  Pause an active block streaming operation.
+ERST
 
     {
         .name       = "block_job_resume",
@@ -179,6 +233,10 @@ STEXI
 @findex block_job_resume
 Resume a paused block streaming operation.
 ETEXI
+SRST
+``block_job_resume``
+  Resume a paused block streaming operation.
+ERST
 
     {
         .name       = "eject",
@@ -193,6 +251,10 @@ STEXI
 @findex eject
 Eject a removable medium (use -f to force it).
 ETEXI
+SRST
+``eject [-f]`` *device*
+  Eject a removable medium (use -f to force it).
+ERST
 
     {
         .name       = "drive_del",
@@ -212,6 +274,15 @@ errors in the guest for applications that are reading/writing to the device.
 These errors are always reported to the guest, regardless of the drive's error
 actions (drive options rerror, werror).
 ETEXI
+SRST
+``drive_del`` *device*
+  Remove host block device.  The result is that guest generated IO is no longer
+  submitted against the host device underlying the disk.  Once a drive has
+  been deleted, the QEMU Block layer returns -EIO which results in IO
+  errors in the guest for applications that are reading/writing to the device.
+  These errors are always reported to the guest, regardless of the drive's error
+  actions (drive options rerror, werror).
+ERST
 
     {
         .name       = "change",
@@ -271,6 +342,45 @@ Password: ********
 
 @end table
 ETEXI
+SRST
+``change`` *device* *setting*
+  Change the configuration of a device.
+
+  ``change`` *diskdevice* *filename* [*format* [*read-only-mode*]]
+    Change the medium for a removable disk device to point to *filename*. eg::
+
+      (qemu) change ide1-cd0 /path/to/some.iso
+
+    *format* is optional.
+
+    *read-only-mode* may be used to change the read-only status of the device.
+    It accepts the following values:
+
+    retain
+      Retains the current status; this is the default.
+
+    read-only
+      Makes the device read-only.
+
+    read-write
+      Makes the device writable.
+
+  ``change vnc`` *display*,\ *options*
+    Change the configuration of the VNC server. The valid syntax for *display*
+    and *options* are described at :ref:`sec_005finvocation`. eg::
+
+      (qemu) change vnc localhost:1
+
+  ``change vnc password`` [*password*]
+
+    Change the password associated with the VNC server. If the new password
+    is not supplied, the monitor will prompt for it to be entered. VNC
+    passwords are only significant up to 8 letters. eg::
+
+      (qemu) change vnc password
+      Password: ********
+
+ERST
 
     {
         .name       = "screendump",
@@ -286,6 +396,10 @@ STEXI
 @findex screendump
 Save screen into PPM image @var{filename}.
 ETEXI
+SRST
+``screendump`` *filename*
+  Save screen into PPM image *filename*.
+ERST
 
     {
         .name       = "logfile",
@@ -300,6 +414,10 @@ STEXI
 @findex logfile
 Output logs to @var{filename}.
 ETEXI
+SRST
+``logfile`` *filename*
+  Output logs to *filename*.
+ERST
 
     {
         .name       = "trace-event",
@@ -316,6 +434,10 @@ STEXI
 @findex trace-event
 changes status of a trace event
 ETEXI
+SRST
+``trace-event``
+  changes status of a trace event
+ERST
 
 #if defined(CONFIG_TRACE_SIMPLE)
     {
@@ -331,6 +453,11 @@ STEXI
 @findex trace-file
 Open, close, or flush the trace file.  If no argument is given, the status of the trace file is displayed.
 ETEXI
+SRST
+``trace-file on|off|flush``
+  Open, close, or flush the trace file.  If no argument is given, the
+  status of the trace file is displayed.
+ERST
 #endif
 
     {
@@ -346,6 +473,10 @@ STEXI
 @findex log
 Activate logging of the specified items.
 ETEXI
+SRST
+``log`` *item1*\ [,...]
+  Activate logging of the specified items.
+ERST
 
     {
         .name       = "savevm",
@@ -366,6 +497,16 @@ a snapshot with the same tag, it is replaced. More info at
 Since 4.0, savevm stopped allowing the snapshot id to be set, accepting
 only @var{tag} as parameter.
 ETEXI
+SRST
+``savevm`` *tag*
+  Create a snapshot of the whole virtual machine. If *tag* is
+  provided, it is used as human readable identifier. If there is already
+  a snapshot with the same tag, it is replaced. More info at
+  :ref:`vm_005fsnapshots`.
+
+  Since 4.0, savevm stopped allowing the snapshot id to be set, accepting
+  only *tag* as parameter.
+ERST
 
     {
         .name       = "loadvm",
@@ -384,6 +525,13 @@ Set the whole virtual machine to the snapshot identified by the tag
 
 Since 4.0, loadvm stopped accepting snapshot id as parameter.
 ETEXI
+SRST
+``loadvm`` *tag*
+  Set the whole virtual machine to the snapshot identified by the tag
+  *tag*.
+
+  Since 4.0, loadvm stopped accepting snapshot id as parameter.
+ERST
 
     {
         .name       = "delvm",
@@ -402,6 +550,13 @@ Delete the snapshot identified by @var{tag}.
 Since 4.0, delvm stopped deleting snapshots by snapshot id, accepting
 only @var{tag} as parameter.
 ETEXI
+SRST
+``delvm`` *tag*
+  Delete the snapshot identified by *tag*.
+
+  Since 4.0, delvm stopped deleting snapshots by snapshot id, accepting
+  only *tag* as parameter.
+ERST
 
     {
         .name       = "singlestep",
@@ -417,6 +572,11 @@ STEXI
 Run the emulation in single step mode.
 If called with option off, the emulation returns to normal mode.
 ETEXI
+SRST
+``singlestep [off]``
+  Run the emulation in single step mode.
+  If called with option off, the emulation returns to normal mode.
+ERST
 
     {
         .name       = "stop",
@@ -431,6 +591,10 @@ STEXI
 @findex stop
 Stop emulation.
 ETEXI
+SRST
+``stop``
+  Stop emulation.
+ERST
 
     {
         .name       = "c|cont",
@@ -445,6 +609,10 @@ STEXI
 @findex cont
 Resume emulation.
 ETEXI
+SRST
+``c`` or ``cont``
+  Resume emulation.
+ERST
 
     {
         .name       = "system_wakeup",
@@ -459,6 +627,10 @@ STEXI
 @findex system_wakeup
 Wakeup guest from suspend.
 ETEXI
+SRST
+``system_wakeup``
+  Wakeup guest from suspend.
+ERST
 
     {
         .name       = "gdbserver",
@@ -473,6 +645,10 @@ STEXI
 @findex gdbserver
 Start gdbserver session (default @var{port}=1234)
 ETEXI
+SRST
+``gdbserver`` [*port*]
+  Start gdbserver session (default *port*\=1234)
+ERST
 
     {
         .name       = "x",
@@ -487,6 +663,10 @@ STEXI
 @findex x
 Virtual memory dump starting at @var{addr}.
 ETEXI
+SRST
+``x/``\ *fmt* *addr*
+  Virtual memory dump starting at *addr*.
+ERST
 
     {
         .name       = "xp",
@@ -554,6 +734,54 @@ Dump 80 16 bit values at the start of the video memory.
 @end smallexample
 @end itemize
 ETEXI
+SRST
+``xp /``\ *fmt* *addr*
+  Physical memory dump starting at *addr*.
+
+  *fmt* is a format which tells the command how to format the
+  data. Its syntax is: ``/{count}{format}{size}``
+
+  *count*
+    is the number of items to be dumped.
+  *format*
+    can be x (hex), d (signed decimal), u (unsigned decimal), o (octal),
+    c (char) or i (asm instruction).
+  *size*
+    can be b (8 bits), h (16 bits), w (32 bits) or g (64 bits). On x86,
+    ``h`` or ``w`` can be specified with the ``i`` format to
+    respectively select 16 or 32 bit code instruction size.
+
+  Examples:
+
+  Dump 10 instructions at the current instruction pointer::
+
+    (qemu) x/10i $eip
+    0x90107063:  ret
+    0x90107064:  sti
+    0x90107065:  lea    0x0(%esi,1),%esi
+    0x90107069:  lea    0x0(%edi,1),%edi
+    0x90107070:  ret
+    0x90107071:  jmp    0x90107080
+    0x90107073:  nop
+    0x90107074:  nop
+    0x90107075:  nop
+    0x90107076:  nop
+
+  Dump 80 16 bit values at the start of the video memory::
+
+    (qemu) xp/80hx 0xb8000
+    0x000b8000: 0x0b50 0x0b6c 0x0b65 0x0b78 0x0b38 0x0b36 0x0b2f 0x0b42
+    0x000b8010: 0x0b6f 0x0b63 0x0b68 0x0b73 0x0b20 0x0b56 0x0b47 0x0b41
+    0x000b8020: 0x0b42 0x0b69 0x0b6f 0x0b73 0x0b20 0x0b63 0x0b75 0x0b72
+    0x000b8030: 0x0b72 0x0b65 0x0b6e 0x0b74 0x0b2d 0x0b63 0x0b76 0x0b73
+    0x000b8040: 0x0b20 0x0b30 0x0b35 0x0b20 0x0b4e 0x0b6f 0x0b76 0x0b20
+    0x000b8050: 0x0b32 0x0b30 0x0b30 0x0b33 0x0720 0x0720 0x0720 0x0720
+    0x000b8060: 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720
+    0x000b8070: 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720
+    0x000b8080: 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720
+    0x000b8090: 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720
+
+ERST
 
     {
         .name       = "gpa2hva",
@@ -569,6 +797,11 @@ STEXI
 Print the host virtual address at which the guest's physical address @var{addr}
 is mapped.
 ETEXI
+SRST
+``gpa2hva`` *addr*
+  Print the host virtual address at which the guest's physical address *addr*
+  is mapped.
+ERST
 
 #ifdef CONFIG_LINUX
     {
@@ -586,6 +819,11 @@ STEXI
 Print the host physical address at which the guest's physical address @var{addr}
 is mapped.
 ETEXI
+SRST
+``gpa2hpa`` *addr*
+  Print the host physical address at which the guest's physical address *addr*
+  is mapped.
+ERST
 
     {
         .name       = "gva2gpa",
@@ -601,6 +839,11 @@ STEXI
 Print the guest physical address at which the guest's virtual address @var{addr}
 is mapped based on the mapping for the current CPU.
 ETEXI
+SRST
+``gva2gpa`` *addr*
+  Print the guest physical address at which the guest's virtual address *addr*
+  is mapped based on the mapping for the current CPU.
+ERST
 
     {
         .name       = "p|print",
@@ -616,6 +859,11 @@ STEXI
 Print expression value. Only the @var{format} part of @var{fmt} is
 used.
 ETEXI
+SRST
+``p`` or ``print/``\ *fmt* *expr*
+  Print expression value. Only the *format* part of *fmt* is
+  used.
+ERST
 
     {
         .name       = "i",
@@ -630,6 +878,10 @@ STEXI
 @findex i
 Read I/O port.
 ETEXI
+SRST
+``i/``\ *fmt* *addr* [.\ *index*\ ]
+  Read I/O port.
+ERST
 
     {
         .name       = "o",
@@ -644,6 +896,10 @@ STEXI
 @findex o
 Write to I/O port.
 ETEXI
+SRST
+``o/``\ *fmt* *addr* *val*
+  Write to I/O port.
+ERST
 
     {
         .name       = "sendkey",
@@ -667,6 +923,17 @@ sendkey ctrl-alt-f1
 This command is useful to send keys that your graphical user interface
 intercepts at low level, such as @code{ctrl-alt-f1} in X Window.
 ETEXI
+SRST
+``sendkey`` *keys*
+  Send *keys* to the guest. *keys* could be the name of the
+  key or the raw value in hexadecimal format. Use ``-`` to press
+  several keys simultaneously. Example::
+
+    sendkey ctrl-alt-f1
+
+  This command is useful to send keys that your graphical user interface
+  intercepts at low level, such as ``ctrl-alt-f1`` in X Window.
+ERST
     {
         .name       = "sync-profile",
         .args_type  = "op:s?",
@@ -682,6 +949,11 @@ STEXI
 Enable, disable or reset synchronization profiling. With no arguments, prints
 whether profiling is on or off.
 ETEXI
+SRST
+``sync-profile [on|off|reset]``
+  Enable, disable or reset synchronization profiling. With no arguments, prints
+  whether profiling is on or off.
+ERST
 
     {
         .name       = "system_reset",
@@ -696,6 +968,10 @@ STEXI
 @findex system_reset
 Reset the system.
 ETEXI
+SRST
+``system_reset``
+  Reset the system.
+ERST
 
     {
         .name       = "system_powerdown",
@@ -710,6 +986,10 @@ STEXI
 @findex system_powerdown
 Power down the system (if supported).
 ETEXI
+SRST
+``system_powerdown``
+  Power down the system (if supported).
+ERST
 
     {
         .name       = "sum",
@@ -724,6 +1004,10 @@ STEXI
 @findex sum
 Compute the checksum of a memory region.
 ETEXI
+SRST
+``sum`` *addr* *size*
+  Compute the checksum of a memory region.
+ERST
 
     {
         .name       = "device_add",
@@ -739,6 +1023,10 @@ STEXI
 @findex device_add
 Add device.
 ETEXI
+SRST
+``device_add`` *config*
+  Add device.
+ERST
 
     {
         .name       = "device_del",
@@ -755,6 +1043,11 @@ STEXI
 Remove device @var{id}. @var{id} may be a short ID
 or a QOM object path.
 ETEXI
+SRST
+``device_del`` *id*
+  Remove device *id*. *id* may be a short ID
+  or a QOM object path.
+ERST
 
     {
         .name       = "cpu",
@@ -769,6 +1062,10 @@ STEXI
 @findex cpu
 Set the default CPU.
 ETEXI
+SRST
+``cpu`` *index*
+  Set the default CPU.
+ERST
 
     {
         .name       = "mouse_move",
@@ -784,6 +1081,11 @@ STEXI
 Move the active mouse to the specified coordinates @var{dx} @var{dy}
 with optional scroll axis @var{dz}.
 ETEXI
+SRST
+``mouse_move`` *dx* *dy* [*dz*]
+  Move the active mouse to the specified coordinates *dx* *dy*
+  with optional scroll axis *dz*.
+ERST
 
     {
         .name       = "mouse_button",
@@ -798,6 +1100,10 @@ STEXI
 @findex mouse_button
 Change the active mouse button state @var{val} (1=L, 2=M, 4=R).
 ETEXI
+SRST
+``mouse_button`` *val*
+  Change the active mouse button state *val* (1=L, 2=M, 4=R).
+ERST
 
     {
         .name       = "mouse_set",
@@ -816,6 +1122,14 @@ can be obtained with
 info mice
 @end example
 ETEXI
+SRST
+``mouse_set`` *index*
+  Set which mouse device receives events at given *index*, index
+  can be obtained with::
+
+    info mice
+
+ERST
 
     {
         .name       = "wavcapture",
@@ -838,6 +1152,18 @@ Defaults:
 @item Number of channels = 2 - Stereo
 @end itemize
 ETEXI
+SRST
+``wavcapture`` *filename* *audiodev* [*frequency* [*bits* [*channels*]]]
+  Capture audio into *filename* from *audiodev*, using sample rate
+  *frequency* bits per sample *bits* and number of channels
+  *channels*.
+
+  Defaults:
+
+  - Sample rate = 44100 Hz - CD quality
+  - Bits = 16
+  - Number of channels = 2 - Stereo
+ERST
 
     {
         .name       = "stopcapture",
@@ -854,6 +1180,13 @@ Stop capture with a given @var{index}, index can be obtained with
 info capture
 @end example
 ETEXI
+SRST
+``stopcapture`` *index*
+  Stop capture with a given *index*, index can be obtained with::
+
+    info capture
+
+ERST
 
     {
         .name       = "memsave",
@@ -868,6 +1201,10 @@ STEXI
 @findex memsave
 save to disk virtual memory dump starting at @var{addr} of size @var{size}.
 ETEXI
+SRST
+``memsave`` *addr* *size* *file*
+  save to disk virtual memory dump starting at *addr* of size *size*.
+ERST
 
     {
         .name       = "pmemsave",
@@ -882,6 +1219,10 @@ STEXI
 @findex pmemsave
 save to disk physical memory dump starting at @var{addr} of size @var{size}.
 ETEXI
+SRST
+``pmemsave`` *addr* *size* *file*
+  save to disk physical memory dump starting at *addr* of size *size*.
+ERST
 
     {
         .name       = "boot_set",
@@ -900,6 +1241,14 @@ the values specified on the command line through the @code{-boot} option.
 The values that can be specified here depend on the machine type, but are
 the same that can be specified in the @code{-boot} command line option.
 ETEXI
+SRST
+``boot_set`` *bootdevicelist*
+  Define new values for the boot device list. Those values will override
+  the values specified on the command line through the ``-boot`` option.
+
+  The values that can be specified here depend on the machine type, but are
+  the same that can be specified in the ``-boot`` command line option.
+ERST
 
     {
         .name       = "nmi",
@@ -914,6 +1263,10 @@ STEXI
 Inject an NMI on the default CPU (x86/s390) or all CPUs (ppc64).
 
 ETEXI
+SRST
+``nmi`` *cpu*
+  Inject an NMI on the default CPU (x86/s390) or all CPUs (ppc64).
+ERST
 
     {
         .name       = "ringbuf_write",
@@ -931,6 +1284,11 @@ Write @var{data} to ring buffer character device @var{device}.
 @var{data} must be a UTF-8 string.
 
 ETEXI
+SRST
+``ringbuf_write`` *device* *data*
+  Write *data* to ring buffer character device *device*.
+  *data* must be a UTF-8 string.
+ERST
 
     {
         .name       = "ringbuf_read",
@@ -953,6 +1311,16 @@ NUL characters, after the ring buffer lost data, and when reading
 stops because the size limit is reached.
 
 ETEXI
+SRST
+``ringbuf_read`` *device*
+  Read and print up to *size* bytes from ring buffer character
+  device *device*.
+  Certain non-printable characters are printed ``\uXXXX``, where ``XXXX`` is the
+  character code in hexadecimal.  Character ``\`` is printed ``\\``.
+  Bug: can screw up when the buffer contains invalid UTF-8 sequences,
+  NUL characters, after the ring buffer lost data, and when reading
+  stops because the size limit is reached.
+ERST
 
     {
         .name       = "announce_self",
@@ -972,6 +1340,15 @@ An optional comma separated @var{interfaces} list restricts the announce to the
 named set of interfaces. An optional @var{id} can be used to start a separate announce
 timer and to change the parameters of it later.
 ETEXI
+SRST
+``announce_self``
+  Trigger a round of GARP/RARP broadcasts; this is useful for explicitly
+  updating the network infrastructure after a reconfiguration or some forms
+  of migration. The timings of the round are set by the migration announce
+  parameters. An optional comma separated *interfaces* list restricts the
+  announce to the named set of interfaces. An optional *id* can be used to
+  start a separate announce timer and to change the parameters of it later.
+ERST
 
     {
         .name       = "migrate",
@@ -994,6 +1371,15 @@ Migrate to @var{uri} (using -d to not wait for completion).
 	-b for migration with full copy of disk
 	-i for migration with incremental copy of disk (base image is shared)
 ETEXI
+SRST
+``migrate [-d] [-b] [-i]`` *uri*
+  Migrate to *uri* (using -d to not wait for completion).
+
+  ``-b``
+    for migration with full copy of disk
+  ``-i``
+    for migration with incremental copy of disk (base image is shared)
+ERST
 
     {
         .name       = "migrate_cancel",
@@ -1008,6 +1394,10 @@ STEXI
 @findex migrate_cancel
 Cancel the current VM migration.
 ETEXI
+SRST
+``migrate_cancel``
+  Cancel the current VM migration.
+ERST
 
     {
         .name       = "migrate_continue",
@@ -1021,6 +1411,10 @@ STEXI
 @findex migrate_continue
 Continue migration from the paused state @var{state}
 ETEXI
+SRST
+``migrate_continue`` *state*
+  Continue migration from the paused state *state*
+ERST
 
     {
         .name       = "migrate_incoming",
@@ -1036,6 +1430,11 @@ STEXI
 Continue an incoming migration using the @var{uri} (that has the same syntax
 as the -incoming option).
 ETEXI
+SRST
+``migrate_incoming`` *uri*
+  Continue an incoming migration using the *uri* (that has the same syntax
+  as the ``-incoming`` option).
+ERST
 
     {
         .name       = "migrate_recover",
@@ -1050,6 +1449,10 @@ STEXI
 @findex migrate_recover
 Continue a paused incoming postcopy migration using the @var{uri}.
 ETEXI
+SRST
+``migrate_recover`` *uri*
+  Continue a paused incoming postcopy migration using the *uri*.
+ERST
 
     {
         .name       = "migrate_pause",
@@ -1064,6 +1467,10 @@ STEXI
 @findex migrate_pause
 Pause an ongoing migration.  Currently it only supports postcopy.
 ETEXI
+SRST
+``migrate_pause``
+  Pause an ongoing migration.  Currently it only supports postcopy.
+ERST
 
     {
         .name       = "migrate_set_cache_size",
@@ -1083,6 +1490,10 @@ STEXI
 @findex migrate_set_cache_size
 Set cache size to @var{value} (in bytes) for xbzrle migrations.
 ETEXI
+SRST
+``migrate_set_cache_size`` *value*
+  Set cache size to *value* (in bytes) for xbzrle migrations.
+ERST
 
     {
         .name       = "migrate_set_speed",
@@ -1098,6 +1509,10 @@ STEXI
 @findex migrate_set_speed
 Set maximum speed to @var{value} (in bytes) for migrations.
 ETEXI
+SRST
+``migrate_set_speed`` *value*
+  Set maximum speed to *value* (in bytes) for migrations.
+ERST
 
     {
         .name       = "migrate_set_downtime",
@@ -1112,6 +1527,10 @@ STEXI
 @findex migrate_set_downtime
 Set maximum tolerated downtime (in seconds) for migration.
 ETEXI
+SRST
+``migrate_set_downtime`` *second*
+  Set maximum tolerated downtime (in seconds) for migration.
+ERST
 
     {
         .name       = "migrate_set_capability",
@@ -1127,6 +1546,10 @@ STEXI
 @findex migrate_set_capability
 Enable/Disable the usage of a capability @var{capability} for migration.
 ETEXI
+SRST
+``migrate_set_capability`` *capability* *state*
+  Enable/Disable the usage of a capability *capability* for migration.
+ERST
 
     {
         .name       = "migrate_set_parameter",
@@ -1142,6 +1565,10 @@ STEXI
 @findex migrate_set_parameter
 Set the parameter @var{parameter} for migration.
 ETEXI
+SRST
+``migrate_set_parameter`` *parameter* *value*
+  Set the parameter *parameter* for migration.
+ERST
 
     {
         .name       = "migrate_start_postcopy",
@@ -1160,6 +1587,11 @@ STEXI
 Switch in-progress migration to postcopy mode. Ignored after the end of
 migration (or once already in postcopy).
 ETEXI
+SRST
+``migrate_start_postcopy``
+  Switch in-progress migration to postcopy mode. Ignored after the end of
+  migration (or once already in postcopy).
+ERST
 
     {
         .name       = "x_colo_lost_heartbeat",
@@ -1175,6 +1607,10 @@ STEXI
 @findex x_colo_lost_heartbeat
 Tell COLO that heartbeat is lost, a failover or takeover is needed.
 ETEXI
+SRST
+``x_colo_lost_heartbeat``
+  Tell COLO that heartbeat is lost, a failover or takeover is needed.
+ERST
 
     {
         .name       = "client_migrate_info",
@@ -1191,6 +1627,12 @@ Set migration information for remote display.  This makes the server
 ask the client to automatically reconnect using the new parameters
 once migration finished successfully.  Only implemented for SPICE.
 ETEXI
+SRST
+``client_migrate_info`` *protocol* *hostname* *port* *tls-port* *cert-subject*
+  Set migration information for remote display.  This makes the server
+  ask the client to automatically reconnect using the new parameters
+  once migration finished successfully.  Only implemented for SPICE.
+ERST
 
     {
         .name       = "dump-guest-memory",
@@ -1227,6 +1669,34 @@ gdb. Without -z|-l|-s|-w, the dump format is ELF.
     length: the memory size, in bytes. It's optional, and should be specified
             together with begin.
 ETEXI
+SRST
+``dump-guest-memory [-p]`` *filename* *begin* *length*
+  \ 
+``dump-guest-memory [-z|-l|-s|-w]`` *filename*
+  Dump guest memory to *protocol*. The file can be processed with crash or
+  gdb. Without ``-z|-l|-s|-w``, the dump format is ELF.
+
+  ``-p``
+    do paging to get guest's memory mapping.
+  ``-z``
+    dump in kdump-compressed format, with zlib compression.
+  ``-l``
+    dump in kdump-compressed format, with lzo compression.
+  ``-s``
+    dump in kdump-compressed format, with snappy compression.
+  ``-w``
+    dump in Windows crashdump format (can be used instead of ELF-dump converting),
+    for Windows x64 guests with vmcoreinfo driver only
+  *filename*
+    dump file name.
+  *begin*
+    the starting physical address. It's optional, and should be
+    specified together with *length*.
+  *length*
+    the memory size, in bytes. It's optional, and should be specified
+    together with *begin*.
+
+ERST
 
 #if defined(TARGET_S390X)
     {
@@ -1243,6 +1713,10 @@ STEXI
 @findex dump-skeys
 Save guest storage keys to a file.
 ETEXI
+SRST
+``dump-skeys`` *filename*
+  Save guest storage keys to a file.
+ERST
 
 #if defined(TARGET_S390X)
     {
@@ -1259,6 +1733,10 @@ STEXI
 @findex migration_mode
 Enables or disables migration mode.
 ETEXI
+SRST
+``migration_mode`` *mode*
+  Enables or disables migration mode.
+ERST
 
     {
         .name       = "snapshot_blkdev",
@@ -1280,6 +1758,10 @@ STEXI
 @findex snapshot_blkdev
 Snapshot device, using snapshot file as target if provided
 ETEXI
+SRST
+``snapshot_blkdev``
+  Snapshot device, using snapshot file as target if provided
+ERST
 
     {
         .name       = "snapshot_blkdev_internal",
@@ -1296,6 +1778,10 @@ STEXI
 @findex snapshot_blkdev_internal
 Take an internal snapshot on device if it support
 ETEXI
+SRST
+``snapshot_blkdev_internal``
+  Take an internal snapshot on device if it support
+ERST
 
     {
         .name       = "snapshot_delete_blkdev_internal",
@@ -1314,6 +1800,10 @@ STEXI
 @findex snapshot_delete_blkdev_internal
 Delete an internal snapshot on device if it support
 ETEXI
+SRST
+``snapshot_delete_blkdev_internal``
+  Delete an internal snapshot on device if it support
+ERST
 
     {
         .name       = "drive_mirror",
@@ -1335,6 +1825,11 @@ STEXI
 Start mirroring a block device's writes to a new destination,
 using the specified target.
 ETEXI
+SRST
+``drive_mirror``
+  Start mirroring a block device's writes to a new destination,
+  using the specified target.
+ERST
 
     {
         .name       = "drive_backup",
@@ -1357,6 +1852,10 @@ STEXI
 @findex drive_backup
 Start a point-in-time copy of a block device to a specificed target.
 ETEXI
+SRST
+``drive_backup``
+  Start a point-in-time copy of a block device to a specificed target.
+ERST
 
     {
         .name       = "drive_add",
@@ -1375,6 +1874,10 @@ STEXI
 @findex drive_add
 Add drive to PCI storage controller.
 ETEXI
+SRST
+``drive_add``
+  Add drive to PCI storage controller.
+ERST
 
     {
         .name       = "pcie_aer_inject_error",
@@ -1399,6 +1902,10 @@ STEXI
 @findex pcie_aer_inject_error
 Inject PCIe AER error
 ETEXI
+SRST
+``pcie_aer_inject_error``
+  Inject PCIe AER error
+ERST
 
     {
         .name       = "netdev_add",
@@ -1414,6 +1921,10 @@ STEXI
 @findex netdev_add
 Add host network device.
 ETEXI
+SRST
+``netdev_add``
+  Add host network device.
+ERST
 
     {
         .name       = "netdev_del",
@@ -1429,6 +1940,10 @@ STEXI
 @findex netdev_del
 Remove host network device.
 ETEXI
+SRST
+``netdev_del``
+  Remove host network device.
+ERST
 
     {
         .name       = "object_add",
@@ -1444,6 +1959,10 @@ STEXI
 @findex object_add
 Create QOM object.
 ETEXI
+SRST
+``object_add``
+  Create QOM object.
+ERST
 
     {
         .name       = "object_del",
@@ -1459,6 +1978,10 @@ STEXI
 @findex object_del
 Destroy QOM object.
 ETEXI
+SRST
+``object_del``
+  Destroy QOM object.
+ERST
 
 #ifdef CONFIG_SLIRP
     {
@@ -1474,6 +1997,10 @@ STEXI
 @findex hostfwd_add
 Redirect TCP or UDP connections from host to guest (requires -net user).
 ETEXI
+SRST
+``hostfwd_add``
+  Redirect TCP or UDP connections from host to guest (requires -net user).
+ERST
 
 #ifdef CONFIG_SLIRP
     {
@@ -1490,6 +2017,10 @@ STEXI
 @findex hostfwd_remove
 Remove host-to-guest TCP or UDP redirection.
 ETEXI
+SRST
+``hostfwd_remove``
+  Remove host-to-guest TCP or UDP redirection.
+ERST
 
     {
         .name       = "balloon",
@@ -1504,6 +2035,10 @@ STEXI
 @findex balloon
 Request VM to change its memory allocation to @var{value} (in MB).
 ETEXI
+SRST
+``balloon`` *value*
+  Request VM to change its memory allocation to *value* (in MB).
+ERST
 
     {
         .name       = "set_link",
@@ -1519,6 +2054,10 @@ STEXI
 @findex set_link
 Switch link @var{name} on (i.e. up) or off (i.e. down).
 ETEXI
+SRST
+``set_link`` *name* ``[on|off]``
+  Switch link *name* on (i.e. up) or off (i.e. down).
+ERST
 
     {
         .name       = "watchdog_action",
@@ -1534,6 +2073,10 @@ STEXI
 @findex watchdog_action
 Change watchdog action.
 ETEXI
+SRST
+``watchdog_action``
+  Change watchdog action.
+ERST
 
     {
         .name       = "acl_show",
@@ -1551,6 +2094,13 @@ policy. There are currently two named access control lists,
 @var{vnc.x509dname} and @var{vnc.username} matching on the x509 client
 certificate distinguished name, and SASL username respectively.
 ETEXI
+SRST
+``acl_show`` *aclname*
+  List all the matching rules in the access control list, and the default
+  policy. There are currently two named access control lists,
+  *vnc.x509dname* and *vnc.username* matching on the x509 client
+  certificate distinguished name, and SASL username respectively.
+ERST
 
     {
         .name       = "acl_policy",
@@ -1567,6 +2117,12 @@ Set the default access control list policy, used in the event that
 none of the explicit rules match. The default policy at startup is
 always @code{deny}.
 ETEXI
+SRST
+``acl_policy`` *aclname* ``allow|deny``
+  Set the default access control list policy, used in the event that
+  none of the explicit rules match. The default policy at startup is
+  always ``deny``.
+ERST
 
     {
         .name       = "acl_add",
@@ -1586,6 +2142,15 @@ allow all users in the @code{EXAMPLE.COM} kerberos realm. The match will
 normally be appended to the end of the ACL, but can be inserted
 earlier in the list if the optional @var{index} parameter is supplied.
 ETEXI
+SRST
+``acl_add`` *aclname* *match* ``allow|deny`` [*index*]
+  Add a match rule to the access control list, allowing or denying access.
+  The match will normally be an exact username or x509 distinguished name,
+  but can optionally include wildcard globs. eg ``*@EXAMPLE.COM`` to
+  allow all users in the ``EXAMPLE.COM`` kerberos realm. The match will
+  normally be appended to the end of the ACL, but can be inserted
+  earlier in the list if the optional *index* parameter is supplied.
+ERST
 
     {
         .name       = "acl_remove",
@@ -1600,6 +2165,10 @@ STEXI
 @findex acl_remove
 Remove the specified match rule from the access control list.
 ETEXI
+SRST
+``acl_remove`` *aclname* *match*
+  Remove the specified match rule from the access control list.
+ERST
 
     {
         .name       = "acl_reset",
@@ -1615,6 +2184,11 @@ STEXI
 Remove all matches from the access control list, and set the default
 policy back to @code{deny}.
 ETEXI
+SRST
+``acl_reset`` *aclname*
+  Remove all matches from the access control list, and set the default
+  policy back to ``deny``.
+ERST
 
     {
         .name       = "nbd_server_start",
@@ -1631,6 +2205,13 @@ option is included, all of the virtual machine's block devices that
 have an inserted media on them are automatically exported; in this case,
 the @option{-w} option makes the devices writable too.
 ETEXI
+SRST
+``nbd_server_start`` *host*:*port*
+  Start an NBD server on the given host and/or port.  If the ``-a``
+  option is included, all of the virtual machine's block devices that
+  have an inserted media on them are automatically exported; in this case,
+  the ``-w`` option makes the devices writable too.
+ERST
 
     {
         .name       = "nbd_server_add",
@@ -1647,6 +2228,13 @@ beforehand with @command{nbd_server_start}.  The @option{-w} option makes the
 exported device writable too.  The export name is controlled by @var{name},
 defaulting to @var{device}.
 ETEXI
+SRST
+``nbd_server_add`` *device* [ *name* ]
+  Export a block device through QEMU's NBD server, which must be started
+  beforehand with ``nbd_server_start``.  The ``-w`` option makes the
+  exported device writable too.  The export name is controlled by *name*,
+  defaulting to *device*.
+ERST
 
     {
         .name       = "nbd_server_remove",
@@ -1664,6 +2252,14 @@ option forces the server to drop the export immediately even if
 clients are connected; otherwise the command fails unless there are no
 clients.
 ETEXI
+SRST
+``nbd_server_remove [-f]`` *name*
+  Stop exporting a block device through QEMU's NBD server, which was
+  previously started with ``nbd_server_add``.  The ``-f``
+  option forces the server to drop the export immediately even if
+  clients are connected; otherwise the command fails unless there are no
+  clients.
+ERST
 
     {
         .name       = "nbd_server_stop",
@@ -1677,6 +2273,10 @@ STEXI
 @findex nbd_server_stop
 Stop the QEMU embedded NBD server.
 ETEXI
+SRST
+``nbd_server_stop``
+  Stop the QEMU embedded NBD server.
+ERST
 
 
 #if defined(TARGET_I386)
@@ -1695,6 +2295,10 @@ STEXI
 @findex mce (x86)
 Inject an MCE on the given CPU (x86 only).
 ETEXI
+SRST
+``mce`` *cpu* *bank* *status* *mcgstatus* *addr* *misc*
+  Inject an MCE on the given CPU (x86 only).
+ERST
 
     {
         .name       = "getfd",
@@ -1711,6 +2315,12 @@ If a file descriptor is passed alongside this command using the SCM_RIGHTS
 mechanism on unix sockets, it is stored using the name @var{fdname} for
 later use by other monitor commands.
 ETEXI
+SRST
+``getfd`` *fdname*
+  If a file descriptor is passed alongside this command using the SCM_RIGHTS
+  mechanism on unix sockets, it is stored using the name *fdname* for
+  later use by other monitor commands.
+ERST
 
     {
         .name       = "closefd",
@@ -1727,6 +2337,12 @@ Close the file descriptor previously assigned to @var{fdname} using the
 @code{getfd} command. This is only needed if the file descriptor was never
 used by another monitor command.
 ETEXI
+SRST
+``closefd`` *fdname*
+  Close the file descriptor previously assigned to *fdname* using the
+  ``getfd`` command. This is only needed if the file descriptor was never
+  used by another monitor command.
+ERST
 
     {
         .name       = "block_passwd",
@@ -1743,6 +2359,12 @@ Set the encrypted device @var{device} password to @var{password}
 
 This command is now obsolete and will always return an error since 2.10
 ETEXI
+SRST
+``block_passwd`` *device* *password*
+  Set the encrypted device *device* password to *password*
+
+  This command is now obsolete and will always return an error since 2.10
+ERST
 
     {
         .name       = "block_set_io_throttle",
@@ -1758,6 +2380,12 @@ STEXI
 Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}.
 @var{device} can be a block device name, a qdev ID or a QOM path.
 ETEXI
+SRST
+``block_set_io_throttle`` *device* *bps* *bps_rd* *bps_wr* *iops* *iops_rd* *iops_wr*
+  Change I/O throttle limits for a block drive to
+  *bps* *bps_rd* *bps_wr* *iops* *iops_rd* *iops_wr*.
+  *device* can be a block device name, a qdev ID or a QOM path.
+ERST
 
     {
         .name       = "set_password",
@@ -1777,6 +2405,15 @@ fail.  @var{disconnect} changes the password and disconnects the
 client.  @var{keep} changes the password and keeps the connection up.
 @var{keep} is the default.
 ETEXI
+SRST
+``set_password [ vnc | spice ] password [ action-if-connected ]``
+  Change spice/vnc password.  Use zero to make the password stay valid
+  forever.  *action-if-connected* specifies what should happen in
+  case a connection is established: *fail* makes the password change
+  fail.  *disconnect* changes the password and disconnects the
+  client.  *keep* changes the password and keeps the connection up.
+  *keep* is the default.
+ERST
 
     {
         .name       = "expire_password",
@@ -1808,6 +2445,22 @@ passed since 1970, i.e. unix epoch.
 
 @end table
 ETEXI
+SRST
+``expire_password [ vnc | spice ]`` *expire-time*
+  Specify when a password for spice/vnc becomes
+  invalid. *expire-time* accepts:
+
+  ``now``
+    Invalidate password instantly.
+  ``never``
+    Password stays valid forever.
+  ``+``\ *nsec*
+    Password stays valid for *nsec* seconds starting now.
+  *nsec*
+    Password is invalidated at the given time.  *nsec* are the seconds
+    passed since 1970, i.e. unix epoch.
+
+ERST
 
     {
         .name       = "chardev-add",
@@ -1824,6 +2477,10 @@ STEXI
 chardev-add accepts the same parameters as the -chardev command line switch.
 
 ETEXI
+SRST
+``chardev-add`` *args*
+  chardev-add accepts the same parameters as the -chardev command line switch.
+ERST
 
     {
         .name       = "chardev-change",
@@ -1840,6 +2497,11 @@ chardev-change accepts existing chardev @var{id} and then the same arguments
 as the -chardev command line switch (except for "id").
 
 ETEXI
+SRST
+``chardev-change`` *args*
+  chardev-change accepts existing chardev *id* and then the same arguments
+  as the -chardev command line switch (except for "id").
+ERST
 
     {
         .name       = "chardev-remove",
@@ -1856,6 +2518,10 @@ STEXI
 Removes the chardev @var{id}.
 
 ETEXI
+SRST
+``chardev-remove`` *id*
+  Removes the chardev *id*.
+ERST
 
     {
         .name       = "chardev-send-break",
@@ -1872,6 +2538,10 @@ STEXI
 Send a break on the chardev @var{id}.
 
 ETEXI
+SRST
+``chardev-send-break`` *id*
+  Send a break on the chardev *id*.
+ERST
 
     {
         .name       = "qemu-io",
@@ -1889,6 +2559,10 @@ STEXI
 Executes a qemu-io command on the given block device.
 
 ETEXI
+SRST
+``qemu-io`` *device* *command*
+  Executes a qemu-io command on the given block device.
+ERST
 
     {
         .name       = "cpu-add",
@@ -1905,6 +2579,12 @@ Add CPU with id @var{id}.  This command is deprecated, please
 +use @code{device_add} instead. For details, refer to
 'docs/cpu-hotplug.rst'.
 ETEXI
+SRST
+``cpu-add`` *id*
+  Add CPU with id *id*.  This command is deprecated, please
+  +use ``device_add`` instead. For details, refer to
+  'docs/cpu-hotplug.rst'.
+ERST
 
     {
         .name       = "qom-list",
@@ -1919,6 +2599,10 @@ STEXI
 @item qom-list [@var{path}]
 Print QOM properties of object at location @var{path}
 ETEXI
+SRST
+``qom-list`` [*path*]
+  Print QOM properties of object at location *path*
+ERST
 
     {
         .name       = "qom-set",
@@ -1933,6 +2617,10 @@ STEXI
 @item qom-set @var{path} @var{property} @var{value}
 Set QOM property @var{property} of object at location @var{path} to value @var{value}
 ETEXI
+SRST
+``qom-set`` *path* *property* *value*
+  Set QOM property *property* of object at location *path* to value *value*
+ERST
 
     {
         .name       = "info",
-- 
2.20.1


