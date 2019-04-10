Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69762C10F0E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A4F20874
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A4F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51669 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE21o-0000xp-G2
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 21:27:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hE1yY-0007Wd-9T
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hE1yT-0002Cm-3D
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:24:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hE1yO-0001pH-9F; Tue, 09 Apr 2019 21:24:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8720181104;
	Wed, 10 Apr 2019 01:24:19 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-206.bos.redhat.com [10.18.17.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 813AA1001E92;
	Wed, 10 Apr 2019 01:24:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  9 Apr 2019 21:24:12 -0400
Message-Id: <20190410012413.31569-3-jsnow@redhat.com>
In-Reply-To: <20190410012413.31569-1-jsnow@redhat.com>
References: <20190410012413.31569-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 10 Apr 2019 01:24:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC 2/3] pxtool: Add new qemu-img command info
 generation tool
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	John Snow <jsnow@redhat.com>, armbru@redhat.com,
	Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410012412.fSrD_roJbTgkjH1au0Svd-_A8kl9oi8F4Jh8YlEEhlo@z>

Presently we use hxtool and a .hx format to generate a few things like
the qemu_img subcommand dispatch table, the qemu_img help() display output,
and a help output in qemu-img.texi.

Unfortunately, this means that this information is duplicated in at least
three places:

(1) in qemu-img-cmds.hx as a human readable string
(2) in qemu-img-cmds.hx as a texi string
(3) in qemu-img.texi again, as a texi string

We can do a little better, though: all of these sources can be generated
from a single json file. Add a new small tool ("pxtool") that can do this.

This tool can at least handle generating (1) and (2) from the same source
without needing to reduplicate that information. Deduplicating (3) happens
in the next patch.

Notes:
 - The json format was chosen to be very "stupid", and the command line
   documentation is being kept one-per-line to make future diffs easier
   to read.
 - It's easy enough to generate the human-readable output from the texi
   output by removing '@var{foo}' with 'foo'.
 - The qemu-img command dispatch always calls img_cmdname, so we don't
   need to store this information separately, either.
 - The need for DEF() macros could be removed as well, but I left it in
   to create a minimally disruptive patch.
Signed-off-by: John Snow <jsnow@redhat.com>
---
 Makefile           |   8 +--
 qemu-img-cmds.json | 165 +++++++++++++++++++++++++++++++++++++++++++++
 qemu-img-cmds.hx   | 102 ----------------------------
 scripts/pxtool.py  |  49 ++++++++++++++
 4 files changed, 218 insertions(+), 106 deletions(-)
 create mode 100644 qemu-img-cmds.json
 delete mode 100644 qemu-img-cmds.hx
 create mode 100755 scripts/pxtool.py

diff --git a/Makefile b/Makefile
index 04a0d45050..d203bb90dc 100644
--- a/Makefile
+++ b/Makefile
@@ -524,8 +524,8 @@ ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
 endif
 
-qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
+qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.json $(SRC_PATH)/scripts/pxtool.py
+	$(call quiet-command,$(PYTOHN) $(SRC_PATH)/scripts/pxtool.py --macros $< > $@,"GEN","$@")
 
 qemu-ga$(EXESUF): LIBS = $(LIBS_QGA)
 qemu-ga$(EXESUF): QEMU_CFLAGS += -I qga/qapi-generated
@@ -918,8 +918,8 @@ qemu-monitor.texi: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
 qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
 
-qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
+qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.json $(SRC_PATH)/scripts/pxtool.py
+	$(call quiet-command,$(PYTON) $(SRC_PATH)/scripts/pxtool.py --texi $< > $@,"GEN","$@")
 
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
diff --git a/qemu-img-cmds.json b/qemu-img-cmds.json
new file mode 100644
index 0000000000..35d96f92a3
--- /dev/null
+++ b/qemu-img-cmds.json
@@ -0,0 +1,165 @@
+{
+    "amend": [
+        "[--object @var{objectdef}]",
+        "[--image-opts]",
+        "[-p]",
+        "[-q]",
+        "[-f @var{fmt}]",
+        "[-t @var{cache}]",
+        "-o @var{options}",
+        "@var{filename}"
+    ],
+    "bench": [
+        "[-c @var{count}]",
+        "[-d @var{depth}]",
+        "[-f @var{fmt}]",
+        "[--flush-interval=@var{flush_interval}]",
+        "[-n]",
+        "[--no-drain]",
+        "[-o @var{offset}]",
+        "[--pattern=@var{pattern}]",
+        "[-q]",
+        "[-s @var{buffer_size}]",
+        "[-S @var{step_size}]",
+        "[-t @var{cache}]",
+        "[-w]",
+        "[-U]",
+        "@var{filename}"
+    ],
+    "check": [
+        "[--object @var{objectdef}]",
+        "[--image-opts]",
+        "[-q]",
+        "[-f @var{fmt}]",
+        "[--output=@var{ofmt}]",
+        "[-r [leaks | all]]",
+        "[-T @var{src_cache}]",
+        "[-U]",
+        "@var{filename}"
+    ],
+    "commit": [
+        "[--object @var{objectdef}]",
+        "[--image-opts]",
+        "[-q]",
+        "[-f @var{fmt}]",
+        "[-t @var{cache}]",
+        "[-b @var{base}]",
+        "[-d]",
+        "[-p]",
+        "@var{filename}"
+    ],
+    "compare": [
+        "[--object @var{objectdef}]",
+        "[--image-opts]",
+        "[-f @var{fmt}]",
+        "[-F @var{fmt}]",
+        "[-T @var{src_cache}]",
+        "[-p]",
+        "[-q]",
+        "[-s]",
+        "[-U]",
+        "@var{filename1}",
+        "@var{filename2}"
+    ],
+    "convert": [
+        "[--object @var{objectdef}]",
+        "[--image-opts]",
+        "[--target-image-opts]",
+        "[-U]",
+        "[-C]",
+        "[-c]",
+        "[-p]",
+        "[-q]",
+        "[-n]",
+        "[-f @var{fmt}]",
+        "[-t @var{cache}]",
+        "[-T @var{src_cache}]",
+        "[-O @var{output_fmt}]",
+        "[-B @var{backing_file}]",
+        "[-o @var{options}]",
+        "[-l @var{snapshot_param}]",
+        "[-S @var{sparse_size}]",
+        "[-m @var{num_coroutines}]",
+        "[-W]",
+        "@var{filename}",
+        "[@var{filename2} [...]]",
+        "@var{output_filename}"
+    ],
+    "create": [
+        "[--object @var{objectdef}]",
+        "[-q]",
+        "[-f @var{fmt}]",
+        "[-b @var{backing_file}]",
+        "[-F @var{backing_fmt}]",
+        "[-u]",
+        "[-o @var{options}]",
+        "@var{filename}",
+        "[@var{size}]"
+    ],
+    "dd": [
+        "[--image-opts]",
+        "[-U]",
+        "[-f @var{fmt}]",
+        "[-O @var{output_fmt}]",
+        "[bs=@var{block_size}]",
+        "[count=@var{blocks}]",
+        "[skip=@var{blocks}]",
+        "if=@var{input}",
+        "of=@var{output}"
+    ],
+    "info": [
+        "[--object @var{objectdef}]",
+        "[--image-opts]",
+        "[-f @var{fmt}]",
+        "[--output=@var{ofmt}]",
+        "[--backing-chain]",
+        "[-U]",
+        "@var{filename}"
+    ],
+    "map": [
+        "[--object @var{objectdef}]",
+        "[--image-opts]",
+        "[-f @var{fmt}]",
+        "[--output=@var{ofmt}]",
+        "[-U]",
+        "@var{filename}"
+    ],
+    "measure": [
+        "[--output=@var{ofmt}]",
+        "[-O @var{output_fmt}]",
+        "[-o @var{options}]",
+        "[--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-l @var{snapshot_param}] @var{filename}]"
+    ],
+    "snapshot": [
+        "[--object @var{objectdef}]",
+        "[--image-opts]",
+        "[-U]",
+        "[-q]",
+        "[-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot}]",
+        "@var{filename}"
+    ],
+    "rebase": [
+        "[--object @var{objectdef}]",
+        "[--image-opts]",
+        "[-U]",
+        "[-q]",
+        "[-f @var{fmt}]",
+        "[-t @var{cache}]",
+        "[-T @var{src_cache}]",
+        "[-p]",
+        "[-u]",
+        "-b @var{backing_file}",
+        "[-F @var{backing_fmt}]",
+        "@var{filename}"
+    ],
+    "resize": [
+        "[--object @var{objectdef}]",
+        "[--image-opts]",
+        "[-f @var{fmt}]",
+        "[--preallocation=@var{prealloc}]",
+        "[-q]",
+        "[--shrink]",
+        "@var{filename}",
+        "[+ | -]@var{size}"
+    ]
+}
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
deleted file mode 100644
index 4b47f7495d..0000000000
--- a/qemu-img-cmds.hx
+++ /dev/null
@@ -1,102 +0,0 @@
-HXCOMM Keep the list of subcommands sorted by name.
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
-HXCOMM Text between STEXI and ETEXI are copied to texi version and
-HXCOMM discarded from C version
-HXCOMM DEF(command, callback, arg_string) is used to construct
-HXCOMM command structures and help message.
-HXCOMM HXCOMM can be used for comments, discarded from both texi and C
-
-HXCOMM When amending the TEXI sections, please remember to copy the usage
-HXCOMM over to the per-command sections in qemu-img.texi.
-
-STEXI
-@table @option
-ETEXI
-
-DEF("amend", img_amend,
-    "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cache] -o options filename")
-STEXI
-@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
-ETEXI
-
-DEF("bench", img_bench,
-    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename")
-STEXI
-@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var{cache}] [-w] [-U] @var{filename}
-ETEXI
-
-DEF("check", img_check,
-    "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
-STEXI
-@item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [--output=@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var{filename}
-ETEXI
-
-DEF("commit", img_commit,
-    "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-d] [-p] filename")
-STEXI
-@item commit [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] [-t @var{cache}] [-b @var{base}] [-d] [-p] @var{filename}
-ETEXI
-
-DEF("compare", img_compare,
-    "compare [--object objectdef] [--image-opts] [-f fmt] [-F fmt] [-T src_cache] [-p] [-q] [-s] [-U] filename1 filename2")
-STEXI
-@item compare [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-q] [-s] [-U] @var{filename1} @var{filename2}
-ETEXI
-
-DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
-STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
-ETEXI
-
-DEF("create", img_create,
-    "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]")
-STEXI
-@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{backing_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [@var{size}]
-ETEXI
-
-DEF("dd", img_dd,
-    "dd [--image-opts] [-U] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output")
-STEXI
-@item dd [--image-opts] [-U] [-f @var{fmt}] [-O @var{output_fmt}] [bs=@var{block_size}] [count=@var{blocks}] [skip=@var{blocks}] if=@var{input} of=@var{output}
-ETEXI
-
-DEF("info", img_info,
-    "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] [-U] filename")
-STEXI
-@item info [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [--backing-chain] [-U] @var{filename}
-ETEXI
-
-DEF("map", img_map,
-    "map [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] filename")
-STEXI
-@item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--output=@var{ofmt}] [-U] @var{filename}
-ETEXI
-
-DEF("measure", img_measure,
-"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
-STEXI
-@item measure [--output=@var{ofmt}] [-O @var{output_fmt}] [-o @var{options}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-l @var{snapshot_param}] @var{filename}]
-ETEXI
-
-DEF("snapshot", img_snapshot,
-    "snapshot [--object objectdef] [--image-opts] [-U] [-q] [-l | -a snapshot | -c snapshot | -d snapshot] filename")
-STEXI
-@item snapshot [--object @var{objectdef}] [--image-opts] [-U] [-q] [-l | -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot}] @var{filename}
-ETEXI
-
-DEF("rebase", img_rebase,
-    "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b backing_file [-F backing_fmt] filename")
-STEXI
-@item rebase [--object @var{objectdef}] [--image-opts] [-U] [-q] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-p] [-u] -b @var{backing_file} [-F @var{backing_fmt}] @var{filename}
-ETEXI
-
-DEF("resize", img_resize,
-    "resize [--object objectdef] [--image-opts] [-f fmt] [--preallocation=prealloc] [-q] [--shrink] filename [+ | -]size")
-STEXI
-@item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--preallocation=@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var{size}
-ETEXI
-
-STEXI
-@end table
-ETEXI
diff --git a/scripts/pxtool.py b/scripts/pxtool.py
new file mode 100755
index 0000000000..008fea839e
--- /dev/null
+++ b/scripts/pxtool.py
@@ -0,0 +1,49 @@
+#!/usr/bin/env python
+
+import argparse
+from collections import OrderedDict
+import json
+import re
+
+# Helpers:
+def scrub_texi_string(tstring):
+    return re.sub(r"@var{([^{}]*?)}", r"\1", tstring)
+
+def human_readable_usage(usage_list):
+    return scrub_texi_string(" ".join(usage_list))
+
+def callback_name(command):
+    return "img_{:s}".format(command)
+
+# Output modes:
+def generate_def_header(conf):
+    """Print DEF() macros to be used by qemu-img.c"""
+    for command, usage_strs in conf.items():
+        print("DEF(\"{}\", {}, \"{} {}\")".format(
+            command,
+            callback_name(command),
+            command,
+            human_readable_usage(usage_strs)))
+
+def generate_texi(conf):
+    """Generate texi command summary table"""
+    print("@table @option")
+    for command, usage_strs in conf.items():
+        usage = " ".join(usage_strs)
+        print("@item {} {}".format(command, usage))
+    print("@end table")
+
+if __name__ == '__main__':
+    parser = argparse.ArgumentParser(description="Generate qemu-img command information")
+    parser.add_argument("--macros", action="store_true", dest="macros")
+    parser.add_argument("--texi", action="store_true")
+    parser.add_argument("commands_json")
+    args = parser.parse_args()
+
+    with open(args.commands_json, "r") as f:
+        conf = json.load(f, object_pairs_hook=OrderedDict)
+
+    if args.macros:
+        generate_def_header(conf)
+    if args.texi:
+        generate_texi(conf)
-- 
2.17.2


