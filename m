Received: from eggs.gnu.org ([2001:4830:134:3::10]:60552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqE-0001k0-17
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqD-0000EB-2o
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQqC-0000E4-Te
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:33 -0300
Message-Id: <20180611174243.31070-4-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/13] python: futurize -f
 libfuturize.fixes.fix_next_call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Change obj.next() calls to next(obj).

This is necessary for Python 3 compatibility.

Done using:

  $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f libfuturize.fixes.fix_next_call $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608122952.2009-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/ordereddict.py            | 4 ++--
 scripts/vmstate-static-checker.py | 4 ++--
 tests/image-fuzzer/runner.py      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/ordereddict.py b/scripts/ordereddict.py
index 2d1d81370b..68ed340b33 100644
--- a/scripts/ordereddict.py
+++ b/scripts/ordereddict.py
@@ -71,9 +71,9 @@ class OrderedDict(dict, DictMixin):
         if not self:
             raise KeyError('dictionary is empty')
         if last:
-            key = reversed(self).next()
+            key = next(reversed(self))
         else:
-            key = iter(self).next()
+            key = next(iter(self))
         value = self.pop(key)
         return key, value
 
diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
index 60d1bf4cda..d3467288dc 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -158,7 +158,7 @@ def check_fields(src_fields, dest_fields, desc, sec):
     while True:
         if advance_src:
             try:
-                s_item = s_iter.next()
+                s_item = next(s_iter)
             except StopIteration:
                 if s_iter_list == []:
                     break
@@ -173,7 +173,7 @@ def check_fields(src_fields, dest_fields, desc, sec):
 
         if advance_dest:
             try:
-                d_item = d_iter.next()
+                d_item = next(d_iter)
             except StopIteration:
                 if d_iter_list == []:
                     # We were not in a substruct
diff --git a/tests/image-fuzzer/runner.py b/tests/image-fuzzer/runner.py
index 8de656933e..45e8fca63f 100755
--- a/tests/image-fuzzer/runner.py
+++ b/tests/image-fuzzer/runner.py
@@ -422,7 +422,7 @@ if __name__ == '__main__':
     test_id = count(1)
     while should_continue(duration, start_time):
         try:
-            run_test(str(test_id.next()), seed, work_dir, run_log, cleanup,
+            run_test(str(next(test_id)), seed, work_dir, run_log, cleanup,
                      log_all, command, config)
         except (KeyboardInterrupt, SystemExit):
             sys.exit(1)
-- 
2.18.0.rc1.1.g3f1ff2140
