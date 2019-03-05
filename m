Received: from eggs.gnu.org ([209.51.188.92]:40869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1Fng-0007qT-2F
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1Fnd-0007yq-UL
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:32:27 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:34102 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1Fnb-0007hL-DQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:32:25 -0500
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
	by postfix.smtp2.imsva2 (Postfix) with ESMTPS id 2E2B8660E
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:32:19 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E09275A051
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:32:18 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBB6E5A045
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:32:18 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
	by imsva2.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:32:18 +0100 (CET)
Received: from mail-it1-f178.google.com (mail-it1-f178.google.com
	[209.85.166.178]) by smtp2 (Postfix) with ESMTPSA id 758F568FB
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 20:32:18 +0100 (CET)
Received: by mail-it1-f178.google.com with SMTP id e24so5838003itl.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 11:32:18 -0800 (PST)
MIME-Version: 1.0
References: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
	<0ac05885-96d6-9355-0333-31a909fd943b@redhat.com>
	<CAGZZdDEp7vxzxbWoHn5AF3g28FKSwka1WQB=U5MTv6X=XLeL7A@mail.gmail.com>
In-Reply-To: <CAGZZdDEp7vxzxbWoHn5AF3g28FKSwka1WQB=U5MTv6X=XLeL7A@mail.gmail.com>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Tue, 5 Mar 2019 20:32:07 +0100
Message-ID: <CAGZZdDHJ2+TFZ1ZvVtR-xfUOJj=gxEKvwHXH0Trn6ra=2Xd9og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel]  [PATCH v2] qemu-binfmt-conf.sh: add CPUS, add --reset,
 make -p and -c boolean (no arg)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, riku.voipio@iki.fi, laurent@vivier.eu

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
---
 scripts/qemu-binfmt-conf.sh | 190 +++++++++++++++++++++++-------------
 1 file changed, 121 insertions(+), 69 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a1..b1aa4a312a 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -6,6 +6,35 @@ mips mipsel mipsn32 mipsn32el mips64 mips64el \
 sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
 microblaze microblazeel or1k x86_64"

+# check if given target CPUS is/are in the supported target list
+qemu_check_target_list() {
+    all="$qemu_target_list"
+    if [ "x$1" = "xALL" ]; then
+      checked_target_list="$all"
+      return
+    fi
+    list=""
+    bIFS="$IFS"
+    IFS=" ,"
+    for target in $@; do
+        unknown_target="true"
+        for cpu in $all ; do
+            if [ "x$cpu" = "x$target" ] ; then
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
+    IFS="$bIFS"
+    checked_target_list="$list"
+}
+
 i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
 i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
 i386_family=i386
@@ -167,45 +196,48 @@ qemu_get_family() {

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
-        sudo update-binfmts --importdir ${EXPORTDIR:-$DEBIANDIR}
--import qemu-CPU
-
-    To remove interpreter, use :
-
-        sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH
-
-    With systemd, binfmt files are loaded by systemd-binfmt.service
-
-    The environment variable HOST_ARCH allows to override 'uname' to generate
-    configuration files for a different architecture than the current one.
-
-    where CPU is one of:
-
-        $qemu_target_list
+Usage: qemu-binfmt-conf.sh [--help][--qemu-path PATH][--qemu-suffix SUFFIX]
+                           [--persistent][--credential][--exportdir PATH]
+                           [--reset ARCHS][--systemd][--debian][CPUS]
+
+    Configure binfmt_misc to use qemu interpreter for the given target CPUS.
+    Supported formats for CPUS are: single arch or comma/space separated list.
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
+                   separated list). If ARCHS is 'ALL', remove all registered
+                   'qemu-*' interpreters.
+    --systemd:     don't write into /proc,
+                   instead generate file(s) for systemd-binfmt.service;
+                   environment variable HOST_ARCH allows to override 'uname'
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
@@ -255,10 +287,10 @@ qemu_check_systemd() {

 qemu_generate_register() {
     flags=""
-    if [ "$CREDENTIAL" = "yes" ] ; then
+    if [ "x$CREDENTIAL" = "xyes" ] ; then
         flags="OC"
     fi
-    if [ "$PERSISTENT" = "yes" ] ; then
+    if [ "x$PERSISTENT" = "xyes" ] ; then
         flags="${flags}F"
     fi

@@ -286,35 +318,65 @@ EOF
 }

 qemu_set_binfmts() {
+    if [ "x$1" = "xNONE" ]; then
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
+    qemu_check_target_list $targets

-    for cpu in ${qemu_target_list} ; do
+    # register the interpreter for each target except for the native one
+    for cpu in $checked_target_list; do
         magic=$(eval echo \$${cpu}_magic)
         mask=$(eval echo \$${cpu}_mask)
         family=$(eval echo \$${cpu}_family)

-        if [ "$magic" = "" ] || [ "$mask" = "" ] || [ "$family" = "" ] ; then
+        if [ "x$magic" = "x" ] || [ "x$mask" = "x" ] || [ "x$family"
= "x" ] ; then
             echo "INTERNAL ERROR: unknown cpu $cpu" 1>&2
             continue
         fi

         qemu="$QEMU_PATH/qemu-$cpu"
-        if [ "$cpu" = "i486" ] ; then
+        if [ "x$cpu" = "xi486" ] ; then
             qemu="$QEMU_PATH/qemu-i386"
         fi

         qemu="$qemu$QEMU_SUFFIX"
-        if [ "$host_family" != "$family" ] ; then
+        if [ "x$host_family" != "x$family" ] ; then
             $BINFMT_SET
         fi
     done
 }

+qemu_remove_notimplemented() {
+    echo "ERROR: option reset not implemented for this mode yet" 1>&2
+    usage
+    exit 1
+}
+
+qemu_remove_interpreter() {
+    names='qemu-*'
+    if [ "x$1" != "xALL" ]; then
+        qemu_check_target_list $1
+        unset names pre
+        for t in $checked_target_list; do
+            names="${names}${pre}qemu-$t"
+            pre=' -o -name '
+        done
+    fi
+    find /proc/sys/fs/binfmt_misc/ -type f -name $names -exec sh -c
'printf %s -1 > {}' \;
+}
+
 CHECK=qemu_check_bintfmt_misc
 BINFMT_SET=qemu_register_interpreter
+BINFMT_REMOVE=qemu_remove_interpreter

 SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"
@@ -324,37 +386,27 @@ CREDENTIAL=no
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
+        $CHECK
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
@@ -373,12 +425,10 @@ while true ; do
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
@@ -387,5 +437,7 @@ while true ; do
     shift
 done

+shift
+
 $CHECK
-qemu_set_binfmts
+qemu_set_binfmts $@
-- 
2.20.1
