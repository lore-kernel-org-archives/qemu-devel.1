Received: from eggs.gnu.org ([209.51.188.92]:53386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1DBd-0007uM-E8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h1DBb-00030D-H1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:45:01 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:50786 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h1DBY-0002wp-Om
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:44:57 -0500
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
	by postfix.smtp1.imsva1 (Postfix) with ESMTPS id A3EBE2E5C4
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 17:44:53 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 695BB11005C
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 17:44:53 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A9AA110052
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 17:44:53 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
	by imsva1.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 17:44:53 +0100 (CET)
Received: from mail-it1-f172.google.com (mail-it1-f172.google.com
	[209.85.166.172]) by smtp1 (Postfix) with ESMTPSA id BF676300A5
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 17:44:52 +0100 (CET)
Received: by mail-it1-f172.google.com with SMTP id z124so5512869itc.2
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:44:52 -0800 (PST)
MIME-Version: 1.0
References: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
In-Reply-To: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Tue, 5 Mar 2019 17:44:41 +0100
Message-ID: <CAGZZdDE95jXfmrSignj2cSgqo29veJzVoKvAto28oBFUUDp-Rw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008bc85305835b9790"
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

--0000000000008bc85305835b9790
Content-Type: text/plain; charset="UTF-8"

I'm so sorry for the inconvenience of sending this patch multiple
times. This is my first contribution through email, and I am having a
hard time preventing the client from mangling with it.
This time, I attached que body below too. I hope that this allows any
other to properly push it, in case it is still not picked by patchew.

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
both options are used, one after the other. However, if any of the other two is
provided first, a error is shown: 'option reset not implemented for
this mode yet'.

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
+ all="$qemu_target_list"
+ if [ "$1" = "ALL" ]; then
+ checked_target_list="$all"
+ return
+ fi
+ list=""
+ for target in $@; do
+ unknown_target="true"
+ for cpu in $all ; do
+ if [ "$cpu" = "$target" ] ; then
+ list="$list $target"
+ unknown_target="false"
+ break
+ fi
+ done
+ if [ "$unknown_target" = "true" ] ; then
+ echo "ERROR: unknown CPU \"$target\"" 1>&2
+ usage
+ exit 1
+ fi
+ done
+ checked_target_list="$list"
+}
+
i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
i386_family=i386
@@ -167,45 +193,48 @@ qemu_get_family() {

usage() {
cat <<EOF
-Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
- [--help][--credential yes|no][--exportdir PATH]
- [--persistent yes|no][--qemu-suffix SUFFIX]
-
- Configure binfmt_misc to use qemu interpreter
-
- --help: display this usage
- --qemu-path: set path to qemu interpreter ($QEMU_PATH)
- --qemu-suffix: add a suffix to the default interpreter name
- --debian: don't write into /proc,
- instead generate update-binfmts templates
- --systemd: don't write into /proc,
- instead generate file for systemd-binfmt.service
- for the given CPU. If CPU is "ALL", generate a
- file for all known cpus
- --exportdir: define where to write configuration files
- (default: $SYSTEMDDIR or $DEBIANDIR)
- --credential: if yes, credential and security tokens are
- calculated according to the binary to interpret
- --persistent: if yes, the interpreter is loaded when binfmt is
- configured and remains in memory. All future uses
- are cloned from the open file.
-
- To import templates with update-binfmts, use :
-
- sudo update-binfmts --importdir ${EXPORTDIR:-$DEBIANDIR} --import qemu-CPU
-
- To remove interpreter, use :
-
- sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH
-
- With systemd, binfmt files are loaded by systemd-binfmt.service
-
- The environment variable HOST_ARCH allows to override 'uname' to generate
- configuration files for a different architecture than the current one.
-
- where CPU is one of:
-
- $qemu_target_list
+Usage: qemu-binfmt-conf.sh [--help][--qemu-path PATH][--qemu-suffix SUFFIX]
+ [--persistent][--credential][--exportdir PATH]
+ [--reset ARCHS][--systemd][--debian][CPUS]
+
+ Configure binfmt_misc to use qemu interpreter for the given target CPUS.
+ Supported formats for CPUS are: single arch or comma/space separated list.
+ If CPUS is empty, configure all known cpus. See QEMU target list below.
+
+ --help: display this usage.
+ --qemu-path: set path to qemu interpreter ($QEMU_PATH).
+ --qemu-suffix: add a suffix to the default interpreter name.
+ --persistent: if present, the interpreter is loaded when binfmt is
+ configured and remains in memory. All future uses
+ are cloned from the open file.
+ --credential: if present, credential and security tokens are
+ calculated according to the binary to interpret.
+ --exportdir: define where to write configuration files
+ (default: $SYSTEMDDIR or $DEBIANDIR).
+ --reset: remove registered interpreter for target ARCHS (comma
+ separated list). If ARCHS is 'ALL', remove all registered
+ 'qemu-*' interpreters.
+ --systemd: don't write into /proc,
+ instead generate file(s) for systemd-binfmt.service;
+ environment variable HOST_ARCH allows to override 'uname'
+ to generate configuration files for a different
+ architecture than the current one.
+ --debian: don't write into /proc,
+ instead generate update-binfmts templates.
+
+ To import templates with update-binfmts, use :
+
+ sudo update-binfmts \\
+ --importdir ${EXPORTDIR:-$DEBIANDIR} \\
+ --import qemu-CPU
+
+ To remove interpreter, use :
+
+ sudo update-binfmts \\
+ --package qemu-CPU \\
+ --remove qemu-CPU $QEMU_PATH
+
+ QEMU target list: $qemu_target_list

EOF
}
@@ -286,12 +315,22 @@ EOF
}

qemu_set_binfmts() {
+ if [ "$1" = "NONE" ]; then
+ return
+ fi
+
# probe cpu type
host_family=$(qemu_get_family)

- # register the interpreter for each cpu except for the native one
+ # reduce the list of target interpreters to those given in the CLI
+ targets="$@"
+ if [ $# -eq 0 ]; then
+ targets="ALL"
+ fi
+ qemu_check_target_list $(echo "$targets" | tr ',' ' ')

- for cpu in ${qemu_target_list} ; do
+ # register the interpreter for each target except for the native one
+ for cpu in $checked_target_list; do
magic=$(eval echo \$${cpu}_magic)
mask=$(eval echo \$${cpu}_mask)
family=$(eval echo \$${cpu}_family)
@@ -313,8 +352,26 @@ qemu_set_binfmts() {
done
}

+qemu_remove_notimplemented() {
+ echo "ERROR: option reset not implemented for this mode yet" 1>&2
+ usage
+ exit 1
+}
+
+qemu_remove_interpreter() {
+ if [ "$1" = "ALL" ]; then
+ find /proc/sys/fs/binfmt_misc/ -type f -name 'qemu-*' -exec sh -c
'echo -1 > {}' \;
+ else
+ qemu_check_target_list $(echo "$1" | tr ',' ' ')
+ for t in $checked_target_list; do
+ find /proc/sys/fs/binfmt_misc/ -type f -name "qemu-$t" -exec sh -c
'echo -1 > {}' \;
+ done
+ fi
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
+ -r|--reset)
+ shift
+ qemu_remove_interpreter $1
+ ;;
-d|--debian)
CHECK=qemu_check_debian
BINFMT_SET=qemu_generate_debian
+ BINFMT_REMOVE=qemu_remove_notimplemented
EXPORTDIR=${EXPORTDIR:-$DEBIANDIR}
;;
-s|--systemd)
CHECK=qemu_check_systemd
BINFMT_SET=qemu_generate_systemd
+ BINFMT_REMOVE=qemu_remove_notimplemented
EXPORTDIR=${EXPORTDIR:-$SYSTEMDDIR}
- shift
- # check given cpu is in the supported CPU list
- if [ "$1" != "ALL" ] ; then
- for cpu in ${qemu_target_list} ; do
- if [ "$cpu" = "$1" ] ; then
- break
- fi
- done
-
- if [ "$cpu" = "$1" ] ; then
- qemu_target_list="$1"
- else
- echo "ERROR: unknown CPU \"$1\"" 1>&2
- usage
- exit 1
- fi
- fi
;;
-Q|--qemu-path)
shift
@@ -373,12 +419,10 @@ while true ; do
exit 1
;;
-c|--credential)
- shift
- CREDENTIAL="$1"
+ CREDENTIAL=yes
;;
-p|--persistent)
- shift
- PERSISTENT="$1"
+ PERSISTENT=yes
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

--0000000000008bc85305835b9790
Content-Type: application/x-patch; name="qemu.patch"
Content-Disposition: attachment; filename="qemu.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jsw04u7m0>
X-Attachment-Id: f_jsw04u7m0

UmVsYXRlZCB0byBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC9xZW11LytidWcvMTgxNzIzOQoK
LSBQb3NpdGlvbmFsIHBhcmFtZXRlcnMgYXJlIHN1cHBvcnRlZCBhcyBbQ1BVU10uIFRoaXMgY2Fu
IGJlIGEgc2luZ2xlCnRhcmdldCBhcmNoLCBhIGNvbW1hIHNlcGFyYXRlZCBsaXN0IG9yIGEgc3Bh
Y2Ugc2VwYXJhdGVkIGxpc3QuIFRoaXMKcGFyYW1ldGVyIHJlcGxhY2VzIHFlbXVfdGFyZ2V0X2xp
c3QgZm9yIGFueSBtb2RlIChkZWZhdWx0LCBzeXN0ZW1kCm9yIGRlYmlhbikuIElmIGl0IGlzIGxl
ZnQgZW1wdHkgb3IgQUxMIGlzIHByb3ZpZGVkLCBhbGwgdGhlIHRhcmdldHMgYXJlCnJlZ2lzdGVy
ZWQuIElmIE5PTkUgaXMgcHJvdmlkZWQsIG5vIHRhcmdldCBpcyByZWdpc3RlcmVkLgotIE9wdGlv
biBbLS1zeXN0ZW1kIENQVV0gaXMgbW9kaWZpZWQgdG8gWy0tc3lzdGVtZF0sIHNpbmNlIHRoZQpm
dW5jdGlvbmFsaXR5IGlzIHN1cHBvcnRlZCBieSBbQ1BVU10gbm93LgotIFstLWNyZWRlbnRpYWwg
eWVzfG5vXSBhbmQgWy0tcGVyc2lzdGVudCB5ZXN8bm9dIGFyZSBtb2RpZmllZCB0bwpbLS1jcmVk
ZW50aWFsXSBhbmQgWy0tcGVyc2lzdGVudF0sIHJlc3BlY3RpdmVseS4gVGhleSBhcmUgJ25vJyBi
eSBkZWZhdWx0LAphbmQgJ3llcycgaWYgdGhlIGNvcnJlc3BvbmRpbmcgZmxhZyBpcyBwcm92aWRl
ZC4KLSBbLS1yZXNldCBBUkNIU10gaXMgYWRkZWQuIFRoaXMgYWxsb3dzIHRvIHJlbW92ZSByZWdp
c3RlcmVkIGludGVycHJldGVycy4KU3VwcG9ydGVkIGZvcm1hdHMgYXJlIGEgc2luZ2xlIHRhcmdl
dCBuYW1lIG9yIGEgY29tbWEgc2VwYXJhdGVkIGxpc3Qgb2YKdGFyZ2V0cy4gSWYgQUxMIGlzIHBy
b3ZpZGVkLCBhbGwgdGhlIGV4aXN0aW5nICdxZW11LSonIGludGVycHJldGVycyBhcmUKcmVtb3Zl
ZC4KLSAndXNhZ2UnIGlzIHVwZGF0ZWQgYWNjb3JkaW5nIHRvIHRoZSBjaGFuZ2VzIGFib3ZlLgoK
Tm90ZSB0aGF0IEkgZG9uJ3Qga25vdyBob3cgdG8gcHJvY2VlZCB3aGVuIGAtLXJlc2V0YCBpcyB1
c2VkIHRvZ2V0aGVyIHdpdGgKYC0tc3lzdGVtZGAgb3IgYC0tZGViaWFuYC4gQXQgdGhlIG1vbWVu
dCwgaWYgYC0tcmVzZXRgIGlzIHByb3ZpZGVkIGZpcnN0LApib3RoIG9wdGlvbnMgYXJlIHVzZWQs
IG9uZSBhZnRlciB0aGUgb3RoZXIuIEhvd2V2ZXIsIGlmIGFueSBvZiB0aGUgb3RoZXIgdHdvIGlz
CnByb3ZpZGVkIGZpcnN0LCBhIGVycm9yIGlzIHNob3duOiAnb3B0aW9uIHJlc2V0IG5vdCBpbXBs
ZW1lbnRlZCBmb3IgdGhpcyBtb2RlIHlldCcuCgpTb21lIGV4YW1wbGUgdXNlIGNhc2VzIHRoYXQg
YXJlIHRvIGJlIHN1cHBvcnRlZCBieSB0aGlzIHBhdGNoOgoKcWVtdS1iaW5mbXQtY29uZi5zaCAt
cCBhYXJjaDY0CnFlbXUtYmluZm10LWNvbmYuc2ggLXAgYWFyY2g2NCByaXNjdjY0CnFlbXUtYmlu
Zm10LWNvbmYuc2ggLXAgYWFyY2g2NCxyaXNjdjY0CnFlbXUtYmluZm10LWNvbmYuc2ggLXIgQUxM
IC1wIGFhcmNoNjQKcWVtdS1iaW5mbXQtY29uZi5zaCAtciBhYXJjaDY0IC1wIGFhcmNoNjQKcWVt
dS1iaW5mbXQtY29uZi5zaCAtciBBTEwgLXAgYWFyY2g2NCByaXNjdjY0CnFlbXUtYmluZm10LWNv
bmYuc2ggLXIgQUxMIC1wIGFhcmNoNjQscmlzY3Y2NApxZW11LWJpbmZtdC1jb25mLnNoIC1yIGFh
cmNoNjQscmlzY3Y2NCAtcCBhYXJjaDY0IHJpc2N2NjQKcWVtdS1iaW5mbXQtY29uZi5zaCAtciBh
YXJjaDY0LHJpc2N2NjQgLXAgYWFyY2g2NCxyaXNjdjY0CnFlbXUtYmluZm10LWNvbmYuc2ggLXIg
QUxMIE5PTkUKClRoZSBtYWluIHB1cnBvc2Ugb2YgdGhlc2UgY2hhbmdlcyBpcyB0byBtYWtlIGl0
IGVhc2llciB0byB1c2UgcWVtdS11c2VyLXN0YXRpYyB0bwpidWlsZCBkb2NrZXIgaW1hZ2VzIGZv
ciBmb3JlaWduIGFyY2hpdGVjdHVyZXMuClNlZSBodHRwczovL2dpdGh1Yi5jb20vdW1hcmNvci9x
dXMvdHJlZS9xZW11LXVwZGF0ZQoKU2lnbmVkLW9mZi1ieTogVW5haSBNYXJ0aW5lei1Db3JyYWwg
PHVuYWkubWFydGluZXpjb3JyYWxAZWh1LmV1cz4KLS0tCiBzY3JpcHRzL3FlbXUtYmluZm10LWNv
bmYuc2ggfCAxNzQgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMTEwIGluc2VydGlvbnMoKyksIDY0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3NjcmlwdHMvcWVtdS1iaW5mbXQtY29uZi5zaCBiL3NjcmlwdHMvcWVtdS1iaW5mbXQtY29uZi5z
aAppbmRleCBiNWExNjc0MmExLi5mMDQ0NDQ2ZDVjIDEwMDc1NQotLS0gYS9zY3JpcHRzL3FlbXUt
YmluZm10LWNvbmYuc2gKKysrIGIvc2NyaXB0cy9xZW11LWJpbmZtdC1jb25mLnNoCkBAIC02LDYg
KzYsMzIgQEAgbWlwcyBtaXBzZWwgbWlwc24zMiBtaXBzbjMyZWwgbWlwczY0IG1pcHM2NGVsIFwK
IHNoNCBzaDRlYiBzMzkweCBhYXJjaDY0IGFhcmNoNjRfYmUgaHBwYSByaXNjdjMyIHJpc2N2NjQg
eHRlbnNhIHh0ZW5zYWViIFwKIG1pY3JvYmxhemUgbWljcm9ibGF6ZWVsIG9yMWsgeDg2XzY0IgoK
KyMgY2hlY2sgaWYgZ2l2ZW4gdGFyZ2V0IENQVVMgaXMvYXJlIGluIHRoZSBzdXBwb3J0ZWQgdGFy
Z2V0IGxpc3QKK3FlbXVfY2hlY2tfdGFyZ2V0X2xpc3QoKSB7CisgICAgYWxsPSIkcWVtdV90YXJn
ZXRfbGlzdCIKKyAgICBpZiBbICIkMSIgPSAiQUxMIiBdOyB0aGVuCisgICAgICBjaGVja2VkX3Rh
cmdldF9saXN0PSIkYWxsIgorICAgICAgcmV0dXJuCisgICAgZmkKKyAgICBsaXN0PSIiCisgICAg
Zm9yIHRhcmdldCBpbiAkQDsgZG8KKyAgICAgICAgdW5rbm93bl90YXJnZXQ9InRydWUiCisgICAg
ICAgIGZvciBjcHUgaW4gJGFsbCA7IGRvCisgICAgICAgICAgICBpZiBbICIkY3B1IiA9ICIkdGFy
Z2V0IiBdIDsgdGhlbgorICAgICAgICAgICAgICAgIGxpc3Q9IiRsaXN0ICR0YXJnZXQiCisgICAg
ICAgICAgICAgICAgdW5rbm93bl90YXJnZXQ9ImZhbHNlIgorICAgICAgICAgICAgICAgIGJyZWFr
CisgICAgICAgICAgICBmaQorICAgICAgICBkb25lCisgICAgICAgIGlmIFsgIiR1bmtub3duX3Rh
cmdldCIgPSAidHJ1ZSIgXSA7IHRoZW4KKyAgICAgICAgICAgIGVjaG8gIkVSUk9SOiB1bmtub3du
IENQVSBcIiR0YXJnZXRcIiIgMT4mMgorICAgICAgICAgICAgdXNhZ2UKKyAgICAgICAgICAgIGV4
aXQgMQorICAgICAgICBmaQorICAgIGRvbmUKKyAgICBjaGVja2VkX3RhcmdldF9saXN0PSIkbGlz
dCIKK30KKwogaTM4Nl9tYWdpYz0nXHg3ZkVMRlx4MDFceDAxXHgwMVx4MDBceDAwXHgwMFx4MDBc
eDAwXHgwMFx4MDBceDAwXHgwMFx4MDJceDAwXHgwM1x4MDAnCiBpMzg2X21hc2s9J1x4ZmZceGZm
XHhmZlx4ZmZceGZmXHhmZVx4ZmVceDAwXHhmZlx4ZmZceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmZc
eGZlXHhmZlx4ZmZceGZmJwogaTM4Nl9mYW1pbHk9aTM4NgpAQCAtMTY3LDQ1ICsxOTMsNDggQEAg
cWVtdV9nZXRfZmFtaWx5KCkgewoKIHVzYWdlKCkgewogICAgIGNhdCA8PEVPRgotVXNhZ2U6IHFl
bXUtYmluZm10LWNvbmYuc2ggWy0tcWVtdS1wYXRoIFBBVEhdWy0tZGViaWFuXVstLXN5c3RlbWQg
Q1BVXQotICAgICAgICAgICAgICAgICAgICAgICAgICAgWy0taGVscF1bLS1jcmVkZW50aWFsIHll
c3xub11bLS1leHBvcnRkaXIgUEFUSF0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgIFstLXBl
cnNpc3RlbnQgeWVzfG5vXVstLXFlbXUtc3VmZml4IFNVRkZJWF0KLQotICAgICAgIENvbmZpZ3Vy
ZSBiaW5mbXRfbWlzYyB0byB1c2UgcWVtdSBpbnRlcnByZXRlcgotCi0gICAgICAgLS1oZWxwOiAg
ICAgICAgZGlzcGxheSB0aGlzIHVzYWdlCi0gICAgICAgLS1xZW11LXBhdGg6ICAgc2V0IHBhdGgg
dG8gcWVtdSBpbnRlcnByZXRlciAoJFFFTVVfUEFUSCkKLSAgICAgICAtLXFlbXUtc3VmZml4OiBh
ZGQgYSBzdWZmaXggdG8gdGhlIGRlZmF1bHQgaW50ZXJwcmV0ZXIgbmFtZQotICAgICAgIC0tZGVi
aWFuOiAgICAgIGRvbid0IHdyaXRlIGludG8gL3Byb2MsCi0gICAgICAgICAgICAgICAgICAgICAg
aW5zdGVhZCBnZW5lcmF0ZSB1cGRhdGUtYmluZm10cyB0ZW1wbGF0ZXMKLSAgICAgICAtLXN5c3Rl
bWQ6ICAgICBkb24ndCB3cml0ZSBpbnRvIC9wcm9jLAotICAgICAgICAgICAgICAgICAgICAgIGlu
c3RlYWQgZ2VuZXJhdGUgZmlsZSBmb3Igc3lzdGVtZC1iaW5mbXQuc2VydmljZQotICAgICAgICAg
ICAgICAgICAgICAgIGZvciB0aGUgZ2l2ZW4gQ1BVLiBJZiBDUFUgaXMgIkFMTCIsIGdlbmVyYXRl
IGEKLSAgICAgICAgICAgICAgICAgICAgICBmaWxlIGZvciBhbGwga25vd24gY3B1cwotICAgICAg
IC0tZXhwb3J0ZGlyOiAgIGRlZmluZSB3aGVyZSB0byB3cml0ZSBjb25maWd1cmF0aW9uIGZpbGVz
Ci0gICAgICAgICAgICAgICAgICAgICAgKGRlZmF1bHQ6ICRTWVNURU1ERElSIG9yICRERUJJQU5E
SVIpCi0gICAgICAgLS1jcmVkZW50aWFsOiAgaWYgeWVzLCBjcmVkZW50aWFsIGFuZCBzZWN1cml0
eSB0b2tlbnMgYXJlCi0gICAgICAgICAgICAgICAgICAgICAgY2FsY3VsYXRlZCBhY2NvcmRpbmcg
dG8gdGhlIGJpbmFyeSB0byBpbnRlcnByZXQKLSAgICAgICAtLXBlcnNpc3RlbnQ6ICBpZiB5ZXMs
IHRoZSBpbnRlcnByZXRlciBpcyBsb2FkZWQgd2hlbiBiaW5mbXQgaXMKLSAgICAgICAgICAgICAg
ICAgICAgICBjb25maWd1cmVkIGFuZCByZW1haW5zIGluIG1lbW9yeS4gQWxsIGZ1dHVyZSB1c2Vz
Ci0gICAgICAgICAgICAgICAgICAgICAgYXJlIGNsb25lZCBmcm9tIHRoZSBvcGVuIGZpbGUuCi0K
LSAgICBUbyBpbXBvcnQgdGVtcGxhdGVzIHdpdGggdXBkYXRlLWJpbmZtdHMsIHVzZSA6Ci0KLSAg
ICAgICAgc3VkbyB1cGRhdGUtYmluZm10cyAtLWltcG9ydGRpciAke0VYUE9SVERJUjotJERFQklB
TkRJUn0gLS1pbXBvcnQgcWVtdS1DUFUKLQotICAgIFRvIHJlbW92ZSBpbnRlcnByZXRlciwgdXNl
IDoKLQotICAgICAgICBzdWRvIHVwZGF0ZS1iaW5mbXRzIC0tcGFja2FnZSBxZW11LUNQVSAtLXJl
bW92ZSBxZW11LUNQVSAkUUVNVV9QQVRICi0KLSAgICBXaXRoIHN5c3RlbWQsIGJpbmZtdCBmaWxl
cyBhcmUgbG9hZGVkIGJ5IHN5c3RlbWQtYmluZm10LnNlcnZpY2UKLQotICAgIFRoZSBlbnZpcm9u
bWVudCB2YXJpYWJsZSBIT1NUX0FSQ0ggYWxsb3dzIHRvIG92ZXJyaWRlICd1bmFtZScgdG8gZ2Vu
ZXJhdGUKLSAgICBjb25maWd1cmF0aW9uIGZpbGVzIGZvciBhIGRpZmZlcmVudCBhcmNoaXRlY3R1
cmUgdGhhbiB0aGUgY3VycmVudCBvbmUuCi0KLSAgICB3aGVyZSBDUFUgaXMgb25lIG9mOgotCi0g
ICAgICAgICRxZW11X3RhcmdldF9saXN0CitVc2FnZTogcWVtdS1iaW5mbXQtY29uZi5zaCBbLS1o
ZWxwXVstLXFlbXUtcGF0aCBQQVRIXVstLXFlbXUtc3VmZml4IFNVRkZJWF0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFstLXBlcnNpc3RlbnRdWy0tY3JlZGVudGlhbF1bLS1leHBvcnRkaXIg
UEFUSF0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgIFstLXJlc2V0IEFSQ0hTXVstLXN5c3Rl
bWRdWy0tZGViaWFuXVtDUFVTXQorCisgICAgQ29uZmlndXJlIGJpbmZtdF9taXNjIHRvIHVzZSBx
ZW11IGludGVycHJldGVyIGZvciB0aGUgZ2l2ZW4gdGFyZ2V0IENQVVMuCisgICAgU3VwcG9ydGVk
IGZvcm1hdHMgZm9yIENQVVMgYXJlOiBzaW5nbGUgYXJjaCBvciBjb21tYS9zcGFjZSBzZXBhcmF0
ZWQgbGlzdC4KKyAgICBJZiBDUFVTIGlzIGVtcHR5LCBjb25maWd1cmUgYWxsIGtub3duIGNwdXMu
IFNlZSBRRU1VIHRhcmdldCBsaXN0IGJlbG93LgorCisgICAgLS1oZWxwOiAgICAgICAgZGlzcGxh
eSB0aGlzIHVzYWdlLgorICAgIC0tcWVtdS1wYXRoOiAgIHNldCBwYXRoIHRvIHFlbXUgaW50ZXJw
cmV0ZXIgKCRRRU1VX1BBVEgpLgorICAgIC0tcWVtdS1zdWZmaXg6IGFkZCBhIHN1ZmZpeCB0byB0
aGUgZGVmYXVsdCBpbnRlcnByZXRlciBuYW1lLgorICAgIC0tcGVyc2lzdGVudDogIGlmIHByZXNl
bnQsIHRoZSBpbnRlcnByZXRlciBpcyBsb2FkZWQgd2hlbiBiaW5mbXQgaXMKKyAgICAgICAgICAg
ICAgICAgICBjb25maWd1cmVkIGFuZCByZW1haW5zIGluIG1lbW9yeS4gQWxsIGZ1dHVyZSB1c2Vz
CisgICAgICAgICAgICAgICAgICAgYXJlIGNsb25lZCBmcm9tIHRoZSBvcGVuIGZpbGUuCisgICAg
LS1jcmVkZW50aWFsOiAgaWYgcHJlc2VudCwgY3JlZGVudGlhbCBhbmQgc2VjdXJpdHkgdG9rZW5z
IGFyZQorICAgICAgICAgICAgICAgICAgIGNhbGN1bGF0ZWQgYWNjb3JkaW5nIHRvIHRoZSBiaW5h
cnkgdG8gaW50ZXJwcmV0LgorICAgIC0tZXhwb3J0ZGlyOiAgIGRlZmluZSB3aGVyZSB0byB3cml0
ZSBjb25maWd1cmF0aW9uIGZpbGVzCisgICAgICAgICAgICAgICAgICAgKGRlZmF1bHQ6ICRTWVNU
RU1ERElSIG9yICRERUJJQU5ESVIpLgorICAgIC0tcmVzZXQ6ICAgICAgIHJlbW92ZSByZWdpc3Rl
cmVkIGludGVycHJldGVyIGZvciB0YXJnZXQgQVJDSFMgKGNvbW1hCisgICAgICAgICAgICAgICAg
ICAgc2VwYXJhdGVkIGxpc3QpLiBJZiBBUkNIUyBpcyAnQUxMJywgcmVtb3ZlIGFsbCByZWdpc3Rl
cmVkCisgICAgICAgICAgICAgICAgICAgJ3FlbXUtKicgaW50ZXJwcmV0ZXJzLgorICAgIC0tc3lz
dGVtZDogICAgIGRvbid0IHdyaXRlIGludG8gL3Byb2MsCisgICAgICAgICAgICAgICAgICAgaW5z
dGVhZCBnZW5lcmF0ZSBmaWxlKHMpIGZvciBzeXN0ZW1kLWJpbmZtdC5zZXJ2aWNlOworICAgICAg
ICAgICAgICAgICAgIGVudmlyb25tZW50IHZhcmlhYmxlIEhPU1RfQVJDSCBhbGxvd3MgdG8gb3Zl
cnJpZGUgJ3VuYW1lJworICAgICAgICAgICAgICAgICAgIHRvIGdlbmVyYXRlIGNvbmZpZ3VyYXRp
b24gZmlsZXMgZm9yIGEgZGlmZmVyZW50CisgICAgICAgICAgICAgICAgICAgYXJjaGl0ZWN0dXJl
IHRoYW4gdGhlIGN1cnJlbnQgb25lLgorICAgIC0tZGViaWFuOiAgICAgIGRvbid0IHdyaXRlIGlu
dG8gL3Byb2MsCisgICAgICAgICAgICAgICAgICAgaW5zdGVhZCBnZW5lcmF0ZSB1cGRhdGUtYmlu
Zm10cyB0ZW1wbGF0ZXMuCisKKyAgICAgIFRvIGltcG9ydCB0ZW1wbGF0ZXMgd2l0aCB1cGRhdGUt
YmluZm10cywgdXNlIDoKKworICAgICAgICBzdWRvIHVwZGF0ZS1iaW5mbXRzIFxcCisgICAgICAg
ICAgICAgLS1pbXBvcnRkaXIgJHtFWFBPUlRESVI6LSRERUJJQU5ESVJ9IFxcCisgICAgICAgICAg
ICAgLS1pbXBvcnQgcWVtdS1DUFUKKworICAgICAgVG8gcmVtb3ZlIGludGVycHJldGVyLCB1c2Ug
OgorCisgICAgICAgIHN1ZG8gdXBkYXRlLWJpbmZtdHMgXFwKKyAgICAgICAgICAgICAtLXBhY2th
Z2UgcWVtdS1DUFUgXFwKKyAgICAgICAgICAgICAtLXJlbW92ZSBxZW11LUNQVSAkUUVNVV9QQVRI
CisKKyAgICBRRU1VIHRhcmdldCBsaXN0OiAkcWVtdV90YXJnZXRfbGlzdAoKIEVPRgogfQpAQCAt
Mjg2LDEyICszMTUsMjIgQEAgRU9GCiB9CgogcWVtdV9zZXRfYmluZm10cygpIHsKKyAgICBpZiBb
ICIkMSIgPSAiTk9ORSIgXTsgdGhlbgorICAgICAgcmV0dXJuCisgICAgZmkKKwogICAgICMgcHJv
YmUgY3B1IHR5cGUKICAgICBob3N0X2ZhbWlseT0kKHFlbXVfZ2V0X2ZhbWlseSkKCi0gICAgIyBy
ZWdpc3RlciB0aGUgaW50ZXJwcmV0ZXIgZm9yIGVhY2ggY3B1IGV4Y2VwdCBmb3IgdGhlIG5hdGl2
ZSBvbmUKKyAgICAjIHJlZHVjZSB0aGUgbGlzdCBvZiB0YXJnZXQgaW50ZXJwcmV0ZXJzIHRvIHRo
b3NlIGdpdmVuIGluIHRoZSBDTEkKKyAgICB0YXJnZXRzPSIkQCIKKyAgICBpZiBbICQjIC1lcSAw
IF07IHRoZW4KKyAgICAgIHRhcmdldHM9IkFMTCIKKyAgICBmaQorICAgIHFlbXVfY2hlY2tfdGFy
Z2V0X2xpc3QgJChlY2hvICIkdGFyZ2V0cyIgfCB0ciAnLCcgJyAnKQoKLSAgICBmb3IgY3B1IGlu
ICR7cWVtdV90YXJnZXRfbGlzdH0gOyBkbworICAgICMgcmVnaXN0ZXIgdGhlIGludGVycHJldGVy
IGZvciBlYWNoIHRhcmdldCBleGNlcHQgZm9yIHRoZSBuYXRpdmUgb25lCisgICAgZm9yIGNwdSBp
biAkY2hlY2tlZF90YXJnZXRfbGlzdDsgZG8KICAgICAgICAgbWFnaWM9JChldmFsIGVjaG8gXCQk
e2NwdX1fbWFnaWMpCiAgICAgICAgIG1hc2s9JChldmFsIGVjaG8gXCQke2NwdX1fbWFzaykKICAg
ICAgICAgZmFtaWx5PSQoZXZhbCBlY2hvIFwkJHtjcHV9X2ZhbWlseSkKQEAgLTMxMyw4ICszNTIs
MjYgQEAgcWVtdV9zZXRfYmluZm10cygpIHsKICAgICBkb25lCiB9CgorcWVtdV9yZW1vdmVfbm90
aW1wbGVtZW50ZWQoKSB7CisgICAgZWNobyAiRVJST1I6IG9wdGlvbiByZXNldCBub3QgaW1wbGVt
ZW50ZWQgZm9yIHRoaXMgbW9kZSB5ZXQiIDE+JjIKKyAgICB1c2FnZQorICAgIGV4aXQgMQorfQor
CitxZW11X3JlbW92ZV9pbnRlcnByZXRlcigpIHsKKyAgICBpZiBbICIkMSIgPSAiQUxMIiBdOyB0
aGVuCisgICAgICBmaW5kIC9wcm9jL3N5cy9mcy9iaW5mbXRfbWlzYy8gLXR5cGUgZiAtbmFtZSAn
cWVtdS0qJyAtZXhlYyBzaCAtYyAnZWNobyAtMSA+IHt9JyBcOworICAgIGVsc2UKKyAgICAgICAg
cWVtdV9jaGVja190YXJnZXRfbGlzdCAkKGVjaG8gIiQxIiB8IHRyICcsJyAnICcpCisgICAgICAg
IGZvciB0IGluICRjaGVja2VkX3RhcmdldF9saXN0OyBkbworICAgICAgICAgICAgZmluZCAvcHJv
Yy9zeXMvZnMvYmluZm10X21pc2MvIC10eXBlIGYgLW5hbWUgInFlbXUtJHQiIC1leGVjIHNoIC1j
ICdlY2hvIC0xID4ge30nIFw7CisgICAgICAgIGRvbmUKKyAgICBmaQorfQorCiBDSEVDSz1xZW11
X2NoZWNrX2JpbnRmbXRfbWlzYwogQklORk1UX1NFVD1xZW11X3JlZ2lzdGVyX2ludGVycHJldGVy
CitCSU5GTVRfUkVNT1ZFPXFlbXVfcmVtb3ZlX2ludGVycHJldGVyCgogU1lTVEVNRERJUj0iL2V0
Yy9iaW5mbXQuZCIKIERFQklBTkRJUj0iL3Vzci9zaGFyZS9iaW5mbXRzIgpAQCAtMzI0LDM3ICsz
ODEsMjYgQEAgQ1JFREVOVElBTD1ubwogUEVSU0lTVEVOVD1ubwogUUVNVV9TVUZGSVg9IiIKCi1v
cHRpb25zPSQoZ2V0b3B0IC1vIGRzOlE6UzplOmhjOnA6IC1sIGRlYmlhbixzeXN0ZW1kOixxZW11
LXBhdGg6LHFlbXUtc3VmZml4OixleHBvcnRkaXI6LGhlbHAsY3JlZGVudGlhbDoscGVyc2lzdGVu
dDogLS0gIiRAIikKK29wdGlvbnM9JChnZXRvcHQgLW8gcjpkc1E6UzplOmhjcCAtbCByZXNldDos
ZGViaWFuLHN5c3RlbWQscWVtdS1wYXRoOixxZW11LXN1ZmZpeDosZXhwb3J0ZGlyOixoZWxwLGNy
ZWRlbnRpYWwscGVyc2lzdGVudCAtLSAiJEAiKQogZXZhbCBzZXQgLS0gIiRvcHRpb25zIgoKIHdo
aWxlIHRydWUgOyBkbwogICAgIGNhc2UgIiQxIiBpbgorICAgIC1yfC0tcmVzZXQpCisgICAgICAg
IHNoaWZ0CisgICAgICAgIHFlbXVfcmVtb3ZlX2ludGVycHJldGVyICQxCisgICAgICAgIDs7CiAg
ICAgLWR8LS1kZWJpYW4pCiAgICAgICAgIENIRUNLPXFlbXVfY2hlY2tfZGViaWFuCiAgICAgICAg
IEJJTkZNVF9TRVQ9cWVtdV9nZW5lcmF0ZV9kZWJpYW4KKyAgICAgICAgQklORk1UX1JFTU9WRT1x
ZW11X3JlbW92ZV9ub3RpbXBsZW1lbnRlZAogICAgICAgICBFWFBPUlRESVI9JHtFWFBPUlRESVI6
LSRERUJJQU5ESVJ9CiAgICAgICAgIDs7CiAgICAgLXN8LS1zeXN0ZW1kKQogICAgICAgICBDSEVD
Sz1xZW11X2NoZWNrX3N5c3RlbWQKICAgICAgICAgQklORk1UX1NFVD1xZW11X2dlbmVyYXRlX3N5
c3RlbWQKKyAgICAgICAgQklORk1UX1JFTU9WRT1xZW11X3JlbW92ZV9ub3RpbXBsZW1lbnRlZAog
ICAgICAgICBFWFBPUlRESVI9JHtFWFBPUlRESVI6LSRTWVNURU1ERElSfQotICAgICAgICBzaGlm
dAotICAgICAgICAjIGNoZWNrIGdpdmVuIGNwdSBpcyBpbiB0aGUgc3VwcG9ydGVkIENQVSBsaXN0
Ci0gICAgICAgIGlmIFsgIiQxIiAhPSAiQUxMIiBdIDsgdGhlbgotICAgICAgICAgICAgZm9yIGNw
dSBpbiAke3FlbXVfdGFyZ2V0X2xpc3R9IDsgZG8KLSAgICAgICAgICAgICAgICBpZiBbICIkY3B1
IiA9ICIkMSIgXSA7IHRoZW4KLSAgICAgICAgICAgICAgICAgICAgYnJlYWsKLSAgICAgICAgICAg
ICAgICBmaQotICAgICAgICAgICAgZG9uZQotCi0gICAgICAgICAgICBpZiBbICIkY3B1IiA9ICIk
MSIgXSA7IHRoZW4KLSAgICAgICAgICAgICAgICBxZW11X3RhcmdldF9saXN0PSIkMSIKLSAgICAg
ICAgICAgIGVsc2UKLSAgICAgICAgICAgICAgICBlY2hvICJFUlJPUjogdW5rbm93biBDUFUgXCIk
MVwiIiAxPiYyCi0gICAgICAgICAgICAgICAgdXNhZ2UKLSAgICAgICAgICAgICAgICBleGl0IDEK
LSAgICAgICAgICAgIGZpCi0gICAgICAgIGZpCiAgICAgICAgIDs7CiAgICAgLVF8LS1xZW11LXBh
dGgpCiAgICAgICAgIHNoaWZ0CkBAIC0zNzMsMTIgKzQxOSwxMCBAQCB3aGlsZSB0cnVlIDsgZG8K
ICAgICAgICAgZXhpdCAxCiAgICAgICAgIDs7CiAgICAgLWN8LS1jcmVkZW50aWFsKQotICAgICAg
ICBzaGlmdAotICAgICAgICBDUkVERU5USUFMPSIkMSIKKyAgICAgICAgQ1JFREVOVElBTD15ZXMK
ICAgICAgICAgOzsKICAgICAtcHwtLXBlcnNpc3RlbnQpCi0gICAgICAgIHNoaWZ0Ci0gICAgICAg
IFBFUlNJU1RFTlQ9IiQxIgorICAgICAgICBQRVJTSVNURU5UPXllcwogICAgICAgICA7OwogICAg
ICopCiAgICAgICAgIGJyZWFrCkBAIC0zODcsNSArNDMxLDcgQEAgd2hpbGUgdHJ1ZSA7IGRvCiAg
ICAgc2hpZnQKIGRvbmUKCitzaGlmdAorCiAkQ0hFQ0sKLXFlbXVfc2V0X2JpbmZtdHMKK3FlbXVf
c2V0X2JpbmZtdHMgJEAKLS0KMi4yMC4x
--0000000000008bc85305835b9790--
