Received: from eggs.gnu.org ([209.51.188.92]:35729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1C6m-000345-VC
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1C6e-0007zE-9j
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:53 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:17071 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1C6d-0007V3-Mx
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:48 -0500
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
	by postfix.smtp1.imsva1 (Postfix) with ESMTPS id 6433F30842
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 16:35:44 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11BCA110056
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 16:35:44 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E66B2110053
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 16:35:43 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
	by imsva1.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 16:35:43 +0100 (CET)
Received: from mail-it1-f169.google.com (mail-it1-f169.google.com
	[209.85.166.169]) by smtp1 (Postfix) with ESMTPSA id 6854930842
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 16:35:43 +0100 (CET)
Received: by mail-it1-f169.google.com with SMTP id l15so5089118iti.4
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 07:35:43 -0800 (PST)
MIME-Version: 1.0
References: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
In-Reply-To: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Tue, 5 Mar 2019 16:35:32 +0100
Message-ID: <CAGZZdDGct2XqP8FHBhnH0ujCRtcTLPBX=68OLwhhigSJpn3diw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset,
 make -p and -c boolean (no arg)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Unai_Mart=C3=ADnez_Corral?= <unai.martinezcorral@ehu.eus>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, riku.voipio@iki.fi

Related to https://bugs.launchpad.net/qemu/+bug/1817239

- Positional parameters are supported as [CPUS]. This can be a single
target arch, a comma separated list or a space separated list. This
parameter replaces qemu_target_list for any mode (default, systemd
or debian). If it is left empty or ALL is provided, all the targets are
registered. If NONE is provided, no target is registered.
- Option [--systemd CPU] is modified to [--systemd], since the
functionality is supported by [CPUS] now.
- [--credential yes|no] and [--persistent yes|no] are modified to
[--credential] and [--persistent], respectively. They are 'no' by default,
and 'yes' if the corresponding flag is provided.
- [--reset ARCHS] is added. This allows to remove registered interpreters.
Supported formats are a single target name or a comma separated list of
targets. If ALL is provided, all the existing 'qemu-*' interpreters are
removed.
- 'usage' is updated according to the changes above.

Note that I don't know how to proceed when `--reset` is used together with
`--systemd` or `--debian`. At the moment, if `--reset` is provided first,
both options are used, one after the other. However, if any of the other
two is
provided first, a error is shown: 'option reset not implemented for this
mode yet'.

Some example use cases that are to be supported by this patch:

qemu-binfmt-conf.sh -p aarch64
qemu-binfmt-conf.sh -p aarch64 riscv64
qemu-binfmt-conf.sh -p aarch64,riscv64
qemu-binfmt-conf.sh -r ALL -p aarch64
qemu-binfmt-conf.sh -r aarch64 -p aarch64
qemu-binfmt-conf.sh -r ALL -p aarch64 riscv64
qemu-binfmt-conf.sh -r ALL -p aarch64,riscv64
qemu-binfmt-conf.sh -r aarch64,riscv64 -p aarch64 riscv64
qemu-binfmt-conf.sh -r aarch64,riscv64 -p aarch64,riscv64
qemu-binfmt-conf.sh -r ALL NONE

The main purpose of these changes is to make it easier to use
qemu-user-static to
build docker images for foreign architectures.
See https://github.com/umarcor/qus/tree/qemu-update

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
---
 scripts/qemu-binfmt-conf.sh | 174 +++++++++++++++++++++++-------------
 1 file changed, 110 insertions(+), 64 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a1..f044446d5c 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -6,6 +6,32 @@ mips mipsel mipsn32 mipsn32el mips64 mips64el \
 sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
 microblaze microblazeel or1k x86_64"

+# check if given target CPUS is/are in the supported target list
+qemu_check_target_list() {
+    all="$qemu_target_list"
+    if [ "$1" = "ALL" ]; then
+      checked_target_list="$all"
+      return
+    fi
+    list=""
+    for target in $@; do
+        unknown_target="true"
+        for cpu in $all ; do
+            if [ "$cpu" = "$target" ] ; then
+                list="$list $target"
+                unknown_target="false"
+                break
+            fi
+        done
+        if [ "$unknown_target" = "true" ] ; then
+            echo "ERROR: unknown CPU \"$target\"" 1>&2
+            usage
+            exit 1
+        fi
+    done
+    checked_target_list="$list"
+}
+
 i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
 i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
 i386_family=i386
@@ -167,45 +193,48 @@ qemu_get_family() {

 usage() {
     cat <<EOF
-Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
-                           [--help][--credential yes|no][--exportdir PATH]
-                           [--persistent yes|no][--qemu-suffix SUFFIX]
-
-       Configure binfmt_misc to use qemu interpreter
-
-       --help:        display this usage
-       --qemu-path:   set path to qemu interpreter ($QEMU_PATH)
-       --qemu-suffix: add a suffix to the default interpreter name
-       --debian:      don't write into /proc,
-                      instead generate update-binfmts templates
-       --systemd:     don't write into /proc,
-                      instead generate file for systemd-binfmt.service
-                      for the given CPU. If CPU is "ALL", generate a
-                      file for all known cpus
-       --exportdir:   define where to write configuration files
-                      (default: $SYSTEMDDIR or $DEBIANDIR)
-       --credential:  if yes, credential and security tokens are
-                      calculated according to the binary to interpret
-       --persistent:  if yes, the interpreter is loaded when binfmt is
-                      configured and remains in memory. All future uses
-                      are cloned from the open file.
-
-    To import templates with update-binfmts, use :
-
-        sudo update-binfmts --importdir ${EXPORTDIR:-$DEBIANDIR} --import
qemu-CPU
-
-    To remove interpreter, use :
-
-        sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH
-
-    With systemd, binfmt files are loaded by systemd-binfmt.service
-
-    The environment variable HOST_ARCH allows to override 'uname' to
generate
-    configuration files for a different architecture than the current one.
-
-    where CPU is one of:
-
-        $qemu_target_list
+Usage: qemu-binfmt-conf.sh [--help][--qemu-path PATH][--qemu-suffix SUFFIX]
+                           [--persistent][--credential][--exportdir PATH]
+                           [--reset ARCHS][--systemd][--debian][CPUS]
+
+    Configure binfmt_misc to use qemu interpreter for the given target
CPUS.
+    Supported formats for CPUS are: single arch or comma/space separated
list.
+    If CPUS is empty, configure all known cpus. See QEMU target list below.
+
+    --help:        display this usage.
+    --qemu-path:   set path to qemu interpreter ($QEMU_PATH).
+    --qemu-suffix: add a suffix to the default interpreter name.
+    --persistent:  if present, the interpreter is loaded when binfmt is
+                   configured and remains in memory. All future uses
+                   are cloned from the open file.
+    --credential:  if present, credential and security tokens are
+                   calculated according to the binary to interpret.
+    --exportdir:   define where to write configuration files
+                   (default: $SYSTEMDDIR or $DEBIANDIR).
+    --reset:       remove registered interpreter for target ARCHS (comma
+                   separated list). If ARCHS is 'ALL', remove all
registered
+                   'qemu-*' interpreters.
+    --systemd:     don't write into /proc,
+                   instead generate file(s) for systemd-binfmt.service;
+                   environment variable HOST_ARCH allows to override
'uname'
+                   to generate configuration files for a different
+                   architecture than the current one.
+    --debian:      don't write into /proc,
+                   instead generate update-binfmts templates.
+
+      To import templates with update-binfmts, use :
+
+        sudo update-binfmts \\
+             --importdir ${EXPORTDIR:-$DEBIANDIR} \\
+             --import qemu-CPU
+
+      To remove interpreter, use :
+
+        sudo update-binfmts \\
+             --package qemu-CPU \\
+             --remove qemu-CPU $QEMU_PATH
+
+    QEMU target list: $qemu_target_list

 EOF
 }
@@ -286,12 +315,22 @@ EOF
 }

 qemu_set_binfmts() {
+    if [ "$1" = "NONE" ]; then
+      return
+    fi
+
     # probe cpu type
     host_family=$(qemu_get_family)

-    # register the interpreter for each cpu except for the native one
+    # reduce the list of target interpreters to those given in the CLI
+    targets="$@"
+    if [ $# -eq 0 ]; then
+      targets="ALL"
+    fi
+    qemu_check_target_list $(echo "$targets" | tr ',' ' ')

-    for cpu in ${qemu_target_list} ; do
+    # register the interpreter for each target except for the native one
+    for cpu in $checked_target_list; do
         magic=$(eval echo \$${cpu}_magic)
         mask=$(eval echo \$${cpu}_mask)
         family=$(eval echo \$${cpu}_family)
@@ -313,8 +352,26 @@ qemu_set_binfmts() {
     done
 }

+qemu_remove_notimplemented() {
+    echo "ERROR: option reset not implemented for this mode yet" 1>&2
+    usage
+    exit 1
+}
+
+qemu_remove_interpreter() {
+    if [ "$1" = "ALL" ]; then
+      find /proc/sys/fs/binfmt_misc/ -type f -name 'qemu-*' -exec sh -c
'echo -1 > {}' \;
+    else
+        qemu_check_target_list $(echo "$1" | tr ',' ' ')
+        for t in $checked_target_list; do
+            find /proc/sys/fs/binfmt_misc/ -type f -name "qemu-$t" -exec
sh -c 'echo -1 > {}' \;
+        done
+    fi
+}
+
 CHECK=qemu_check_bintfmt_misc
 BINFMT_SET=qemu_register_interpreter
+BINFMT_REMOVE=qemu_remove_interpreter

 SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"
@@ -324,37 +381,26 @@ CREDENTIAL=no
 PERSISTENT=no
 QEMU_SUFFIX=""

-options=$(getopt -o ds:Q:S:e:hc:p: -l
debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent:
-- "$@")
+options=$(getopt -o r:dsQ:S:e:hcp -l
reset:,debian,systemd,qemu-path:,qemu-suffix:,exportdir:,help,credential,persistent
-- "$@")
 eval set -- "$options"

 while true ; do
     case "$1" in
+    -r|--reset)
+        shift
+        qemu_remove_interpreter $1
+        ;;
     -d|--debian)
         CHECK=qemu_check_debian
         BINFMT_SET=qemu_generate_debian
+        BINFMT_REMOVE=qemu_remove_notimplemented
         EXPORTDIR=${EXPORTDIR:-$DEBIANDIR}
         ;;
     -s|--systemd)
         CHECK=qemu_check_systemd
         BINFMT_SET=qemu_generate_systemd
+        BINFMT_REMOVE=qemu_remove_notimplemented
         EXPORTDIR=${EXPORTDIR:-$SYSTEMDDIR}
-        shift
-        # check given cpu is in the supported CPU list
-        if [ "$1" != "ALL" ] ; then
-            for cpu in ${qemu_target_list} ; do
-                if [ "$cpu" = "$1" ] ; then
-                    break
-                fi
-            done
-
-            if [ "$cpu" = "$1" ] ; then
-                qemu_target_list="$1"
-            else
-                echo "ERROR: unknown CPU \"$1\"" 1>&2
-                usage
-                exit 1
-            fi
-        fi
         ;;
     -Q|--qemu-path)
         shift
@@ -373,12 +419,10 @@ while true ; do
         exit 1
         ;;
     -c|--credential)
-        shift
-        CREDENTIAL="$1"
+        CREDENTIAL=yes
         ;;
     -p|--persistent)
-        shift
-        PERSISTENT="$1"
+        PERSISTENT=yes
         ;;
     *)
         break
@@ -387,5 +431,7 @@ while true ; do
     shift
 done

+shift
+
 $CHECK
-qemu_set_binfmts
+qemu_set_binfmts $@
--
2.20.1
