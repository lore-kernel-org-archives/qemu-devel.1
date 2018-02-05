Received: from eggs.gnu.org ([2001:4830:134:3::10]:59299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipt1-0001fa-Td
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipt0-00072e-8g
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eipt0-000710-0Q
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:18 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:47 -0200
Message-Id: <20180205230900.11344-9-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/21] qapi: force a UTF-8 locale for running
 Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Python2 did not validate locale correctness when reading input data, so
would happily read UTF-8 data in non-UTF-8 locales. Python3 is strict so
if you try to read UTF-8 data in the C locale, it will raise an error
for any UTF-8 bytes that aren't representable in 7-bit ascii encoding.
e.g.

UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 54: ordinal not in range(128)
Traceback (most recent call last):
  File "/tmp/qemu-test/src/scripts/qapi-commands.py", line 317, in <module>
    schema = QAPISchema(input_file)
  File "/tmp/qemu-test/src/scripts/qapi.py", line 1468, in __init__
    parser = QAPISchemaParser(open(fname, 'r'))
  File "/tmp/qemu-test/src/scripts/qapi.py", line 301, in __init__
    previously_included)
  File "/tmp/qemu-test/src/scripts/qapi.py", line 348, in _include
    exprs_include = QAPISchemaParser(fobj, previously_included, info)
  File "/tmp/qemu-test/src/scripts/qapi.py", line 271, in __init__
    self.src = fp.read()
  File "/usr/lib64/python3.5/encodings/ascii.py", line 26, in decode
    return codecs.ascii_decode(input, self.errors)[0]

More background on this can be seen in

  https://www.python.org/dev/peps/pep-0538/

Many distros support a new C.UTF-8 locale that is like the C locale,
but with UTF-8 instead of 7-bit ASCII. That is not entirely portable
though. This patch thus sets the LANG to "C", but overrides LC_CTYPE
to be en_US.UTF-8 locale. This gets us pretty close to C.UTF-8, but
in a way that should be portable to everywhere QEMU builds.

This patch only forces UTF-8 for QAPI scripts, since that is the one
showing the immediate error under Python3 with C locale, but potentially
we ought to force this for all python scripts used in the build process.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20180116134217.8725-9-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 Makefile | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 7d35ea1a06..4ec7a3cb82 100644
--- a/Makefile
+++ b/Makefile
@@ -20,6 +20,8 @@ ifneq ($(wildcard config-host.mak),)
 all:
 include config-host.mak
 
+PYTHON_UTF8 = LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8 $(PYTHON)
+
 git-submodule-update:
 
 .PHONY: git-submodule-update
@@ -487,17 +489,17 @@ qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py
 
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h :\
 $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-types.py \
 		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$@")
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h :\
 $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-visit.py \
 		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$@")
 qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal.c :\
 $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-commands.py \
 		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$@")
 
@@ -518,27 +520,27 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
 
 qapi-types.c qapi-types.h :\
 $(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-types.py \
 		$(gen-out-type) -o "." -b $<, \
 		"GEN","$@")
 qapi-visit.c qapi-visit.h :\
 $(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-visit.py \
 		$(gen-out-type) -o "." -b $<, \
 		"GEN","$@")
 qapi-event.c qapi-event.h :\
 $(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-event.py \
 		$(gen-out-type) -o "." $<, \
 		"GEN","$@")
 qmp-commands.h qmp-marshal.c :\
 $(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-commands.py \
 		$(gen-out-type) -o "." $<, \
 		"GEN","$@")
 qmp-introspect.h qmp-introspect.c :\
 $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspect.py \
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-introspect.py \
 		$(gen-out-type) -o "." $<, \
 		"GEN","$@")
 
@@ -811,10 +813,10 @@ qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 docs/interop/qemu-qmp-qapi.texi docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
 
 docs/interop/qemu-qmp-qapi.texi: $(qapi-modules)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
 
 docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
+	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
 
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
-- 
2.14.3
