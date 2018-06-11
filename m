Received: from eggs.gnu.org ([2001:4830:134:3::10]:60563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQqF-0001kg-5I
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQq8-0000Cj-Uc
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQq8-0000CR-FU
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:42:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:42:31 -0300
Message-Id: <20180611174243.31070-2-ehabkost@redhat.com>
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/13] python: futurize -f
 libfuturize.fixes.fix_print_with_import
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

Change all Python code to use print as a function.

This is necessary for Python 3 compatibility.

Done using:

  $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
    sort -u | grep -v README.sh4)
  $ futurize -w -f libfuturize.fixes.fix_print_with_import $py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608122952.2009-2-ehabkost@redhat.com>
[ehabkost: fixup tests/docker/docker.py]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/analyse-9p-simpletrace.py        | 89 ++++++++++++------------
 scripts/analyse-locks-simpletrace.py     |  1 +
 scripts/analyze-migration.py             | 11 +--
 scripts/dump-guest-memory.py             |  1 +
 scripts/replay-dump.py                   | 21 +++---
 scripts/signrom.py                       |  1 +
 scripts/simpletrace.py                   |  3 +-
 scripts/vmstate-static-checker.py        | 85 +++++++++++-----------
 scripts/device-crash-test                |  3 +-
 scripts/kvm/kvm_flightrecorder           | 21 +++---
 scripts/kvm/vmxcap                       |  1 +
 scripts/qmp/qemu-ga-client               |  1 +
 scripts/qmp/qmp                          | 17 ++---
 scripts/qmp/qmp-shell                    | 35 +++++-----
 scripts/qmp/qom-get                      |  7 +-
 scripts/qmp/qom-list                     | 11 +--
 scripts/qmp/qom-set                      |  5 +-
 scripts/qmp/qom-tree                     | 11 +--
 tests/docker/docker.py                   | 17 ++---
 tests/docker/travis.py                   | 15 ++--
 tests/guest-debug/test-gdbstub.py        |  1 +
 tests/image-fuzzer/runner.py             | 38 +++++-----
 tests/migration/guestperf/engine.py      | 29 ++++----
 tests/migration/guestperf/plot.py        | 17 ++---
 tests/migration/guestperf/shell.py       | 19 ++---
 tests/qemu-iotests/149                   |  3 +-
 tests/qemu-iotests/165                   |  3 +-
 tests/qemu-iotests/iotests.py            |  5 +-
 tests/qemu-iotests/nbd-fault-injector.py |  7 +-
 tests/qemu-iotests/qcow2.py              | 39 ++++++-----
 tests/qemu-iotests/qed.py                | 17 ++---
 tests/vm/basevm.py                       |  3 +-
 32 files changed, 281 insertions(+), 256 deletions(-)

diff --git a/scripts/analyse-9p-simpletrace.py b/scripts/analyse-9p-simpl=
etrace.py
index 3c3dee4337..710e01adba 100755
--- a/scripts/analyse-9p-simpletrace.py
+++ b/scripts/analyse-9p-simpletrace.py
@@ -3,6 +3,7 @@
 # Usage: ./analyse-9p-simpletrace <trace-events> <trace-pid>
 #
 # Author: Harsh Prateek Bora
+from __future__ import print_function
 import os
 import simpletrace
=20
@@ -79,135 +80,135 @@ symbol_9p =3D {
=20
 class VirtFSRequestTracker(simpletrace.Analyzer):
         def begin(self):
-                print "Pretty printing 9p simpletrace log ..."
+                print("Pretty printing 9p simpletrace log ...")
=20
         def v9fs_rerror(self, tag, id, err):
-                print "RERROR (tag =3D", tag, ", id =3D", symbol_9p[id],=
 ", err =3D \"", os.strerror(err), "\")"
+                print("RERROR (tag =3D", tag, ", id =3D", symbol_9p[id],=
 ", err =3D \"", os.strerror(err), "\")")
=20
         def v9fs_version(self, tag, id, msize, version):
-                print "TVERSION (tag =3D", tag, ", msize =3D", msize, ",=
 version =3D", version, ")"
+                print("TVERSION (tag =3D", tag, ", msize =3D", msize, ",=
 version =3D", version, ")")
=20
         def v9fs_version_return(self, tag, id, msize, version):
-                print "RVERSION (tag =3D", tag, ", msize =3D", msize, ",=
 version =3D", version, ")"
+                print("RVERSION (tag =3D", tag, ", msize =3D", msize, ",=
 version =3D", version, ")")
=20
         def v9fs_attach(self, tag, id, fid, afid, uname, aname):
-                print "TATTACH (tag =3D", tag, ", fid =3D", fid, ", afid=
 =3D", afid, ", uname =3D", uname, ", aname =3D", aname, ")"
+                print("TATTACH (tag =3D", tag, ", fid =3D", fid, ", afid=
 =3D", afid, ", uname =3D", uname, ", aname =3D", aname, ")")
=20
         def v9fs_attach_return(self, tag, id, type, version, path):
-                print "RATTACH (tag =3D", tag, ", qid=3D{type =3D", type=
, ", version =3D", version, ", path =3D", path, "})"
+                print("RATTACH (tag =3D", tag, ", qid=3D{type =3D", type=
, ", version =3D", version, ", path =3D", path, "})")
=20
         def v9fs_stat(self, tag, id, fid):
-                print "TSTAT (tag =3D", tag, ", fid =3D", fid, ")"
+                print("TSTAT (tag =3D", tag, ", fid =3D", fid, ")")
=20
         def v9fs_stat_return(self, tag, id, mode, atime, mtime, length):
-                print "RSTAT (tag =3D", tag, ", mode =3D", mode, ", atim=
e =3D", atime, ", mtime =3D", mtime, ", length =3D", length, ")"
+                print("RSTAT (tag =3D", tag, ", mode =3D", mode, ", atim=
e =3D", atime, ", mtime =3D", mtime, ", length =3D", length, ")")
=20
         def v9fs_getattr(self, tag, id, fid, request_mask):
-                print "TGETATTR (tag =3D", tag, ", fid =3D", fid, ", req=
uest_mask =3D", hex(request_mask), ")"
+                print("TGETATTR (tag =3D", tag, ", fid =3D", fid, ", req=
uest_mask =3D", hex(request_mask), ")")
=20
         def v9fs_getattr_return(self, tag, id, result_mask, mode, uid, g=
id):
-                print "RGETATTR (tag =3D", tag, ", result_mask =3D", hex=
(result_mask), ", mode =3D", oct(mode), ", uid =3D", uid, ", gid =3D", gi=
d, ")"
+                print("RGETATTR (tag =3D", tag, ", result_mask =3D", hex=
(result_mask), ", mode =3D", oct(mode), ", uid =3D", uid, ", gid =3D", gi=
d, ")")
=20
         def v9fs_walk(self, tag, id, fid, newfid, nwnames):
-                print "TWALK (tag =3D", tag, ", fid =3D", fid, ", newfid=
 =3D", newfid, ", nwnames =3D", nwnames, ")"
+                print("TWALK (tag =3D", tag, ", fid =3D", fid, ", newfid=
 =3D", newfid, ", nwnames =3D", nwnames, ")")
=20
         def v9fs_walk_return(self, tag, id, nwnames, qids):
-                print "RWALK (tag =3D", tag, ", nwnames =3D", nwnames, "=
, qids =3D", hex(qids), ")"
+                print("RWALK (tag =3D", tag, ", nwnames =3D", nwnames, "=
, qids =3D", hex(qids), ")")
=20
         def v9fs_open(self, tag, id, fid, mode):
-                print "TOPEN (tag =3D", tag, ", fid =3D", fid, ", mode =3D=
", oct(mode), ")"
+                print("TOPEN (tag =3D", tag, ", fid =3D", fid, ", mode =3D=
", oct(mode), ")")
=20
         def v9fs_open_return(self, tag, id, type, version, path, iounit)=
:
-                print "ROPEN (tag =3D", tag,  ", qid=3D{type =3D", type,=
 ", version =3D", version, ", path =3D", path, "}, iounit =3D", iounit, "=
)"
+                print("ROPEN (tag =3D", tag,  ", qid=3D{type =3D", type,=
 ", version =3D", version, ", path =3D", path, "}, iounit =3D", iounit, "=
)")
=20
         def v9fs_lcreate(self, tag, id, dfid, flags, mode, gid):
-                print "TLCREATE (tag =3D", tag, ", dfid =3D", dfid, ", f=
lags =3D", oct(flags), ", mode =3D", oct(mode), ", gid =3D", gid, ")"
+                print("TLCREATE (tag =3D", tag, ", dfid =3D", dfid, ", f=
lags =3D", oct(flags), ", mode =3D", oct(mode), ", gid =3D", gid, ")")
=20
         def v9fs_lcreate_return(self, tag, id, type, version, path, ioun=
it):
-                print "RLCREATE (tag =3D", tag,  ", qid=3D{type =3D", ty=
pe, ", version =3D", version, ", path =3D", path, "}, iounit =3D", iounit=
, ")"
+                print("RLCREATE (tag =3D", tag,  ", qid=3D{type =3D", ty=
pe, ", version =3D", version, ", path =3D", path, "}, iounit =3D", iounit=
, ")")
=20
         def v9fs_fsync(self, tag, id, fid, datasync):
-                print "TFSYNC (tag =3D", tag, ", fid =3D", fid, ", datas=
ync =3D", datasync, ")"
+                print("TFSYNC (tag =3D", tag, ", fid =3D", fid, ", datas=
ync =3D", datasync, ")")
=20
         def v9fs_clunk(self, tag, id, fid):
-                print "TCLUNK (tag =3D", tag, ", fid =3D", fid, ")"
+                print("TCLUNK (tag =3D", tag, ", fid =3D", fid, ")")
=20
         def v9fs_read(self, tag, id, fid, off, max_count):
-                print "TREAD (tag =3D", tag, ", fid =3D", fid, ", off =3D=
", off, ", max_count =3D", max_count, ")"
+                print("TREAD (tag =3D", tag, ", fid =3D", fid, ", off =3D=
", off, ", max_count =3D", max_count, ")")
=20
         def v9fs_read_return(self, tag, id, count, err):
-                print "RREAD (tag =3D", tag, ", count =3D", count, ", er=
r =3D", err, ")"
+                print("RREAD (tag =3D", tag, ", count =3D", count, ", er=
r =3D", err, ")")
=20
         def v9fs_readdir(self, tag, id, fid, offset, max_count):
-                print "TREADDIR (tag =3D", tag, ", fid =3D", fid, ", off=
set =3D", offset, ", max_count =3D", max_count, ")"
+                print("TREADDIR (tag =3D", tag, ", fid =3D", fid, ", off=
set =3D", offset, ", max_count =3D", max_count, ")")
=20
         def v9fs_readdir_return(self, tag, id, count, retval):
-                print "RREADDIR (tag =3D", tag, ", count =3D", count, ",=
 retval =3D", retval, ")"
+                print("RREADDIR (tag =3D", tag, ", count =3D", count, ",=
 retval =3D", retval, ")")
=20
         def v9fs_write(self, tag, id, fid, off, count, cnt):
-                print "TWRITE (tag =3D", tag, ", fid =3D", fid, ", off =3D=
", off, ", count =3D", count, ", cnt =3D", cnt, ")"
+                print("TWRITE (tag =3D", tag, ", fid =3D", fid, ", off =3D=
", off, ", count =3D", count, ", cnt =3D", cnt, ")")
=20
         def v9fs_write_return(self, tag, id, total, err):
-                print "RWRITE (tag =3D", tag, ", total =3D", total, ", e=
rr =3D", err, ")"
+                print("RWRITE (tag =3D", tag, ", total =3D", total, ", e=
rr =3D", err, ")")
=20
         def v9fs_create(self, tag, id, fid, name, perm, mode):
-                print "TCREATE (tag =3D", tag, ", fid =3D", fid, ", perm=
 =3D", oct(perm), ", name =3D", name, ", mode =3D", oct(mode), ")"
+                print("TCREATE (tag =3D", tag, ", fid =3D", fid, ", perm=
 =3D", oct(perm), ", name =3D", name, ", mode =3D", oct(mode), ")")
=20
         def v9fs_create_return(self, tag, id, type, version, path, iouni=
t):
-                print "RCREATE (tag =3D", tag,  ", qid=3D{type =3D", typ=
e, ", version =3D", version, ", path =3D", path, "}, iounit =3D", iounit,=
 ")"
+                print("RCREATE (tag =3D", tag,  ", qid=3D{type =3D", typ=
e, ", version =3D", version, ", path =3D", path, "}, iounit =3D", iounit,=
 ")")
=20
         def v9fs_symlink(self, tag, id, fid, name, symname, gid):
-                print "TSYMLINK (tag =3D", tag, ", fid =3D", fid, ", nam=
e =3D", name, ", symname =3D", symname, ", gid =3D", gid, ")"
+                print("TSYMLINK (tag =3D", tag, ", fid =3D", fid, ", nam=
e =3D", name, ", symname =3D", symname, ", gid =3D", gid, ")")
=20
         def v9fs_symlink_return(self, tag, id, type, version, path):
-                print "RSYMLINK (tag =3D", tag,  ", qid=3D{type =3D", ty=
pe, ", version =3D", version, ", path =3D", path, "})"
+                print("RSYMLINK (tag =3D", tag,  ", qid=3D{type =3D", ty=
pe, ", version =3D", version, ", path =3D", path, "})")
=20
         def v9fs_flush(self, tag, id, flush_tag):
-                print "TFLUSH (tag =3D", tag, ", flush_tag =3D", flush_t=
ag, ")"
+                print("TFLUSH (tag =3D", tag, ", flush_tag =3D", flush_t=
ag, ")")
=20
         def v9fs_link(self, tag, id, dfid, oldfid, name):
-                print "TLINK (tag =3D", tag, ", dfid =3D", dfid, ", oldf=
id =3D", oldfid, ", name =3D", name, ")"
+                print("TLINK (tag =3D", tag, ", dfid =3D", dfid, ", oldf=
id =3D", oldfid, ", name =3D", name, ")")
=20
         def v9fs_remove(self, tag, id, fid):
-                print "TREMOVE (tag =3D", tag, ", fid =3D", fid, ")"
+                print("TREMOVE (tag =3D", tag, ", fid =3D", fid, ")")
=20
         def v9fs_wstat(self, tag, id, fid, mode, atime, mtime):
-                print "TWSTAT (tag =3D", tag, ", fid =3D", fid, ", mode =
=3D", oct(mode), ", atime =3D", atime, "mtime =3D", mtime, ")"
+                print("TWSTAT (tag =3D", tag, ", fid =3D", fid, ", mode =
=3D", oct(mode), ", atime =3D", atime, "mtime =3D", mtime, ")")
=20
         def v9fs_mknod(self, tag, id, fid, mode, major, minor):
-                print "TMKNOD (tag =3D", tag, ", fid =3D", fid, ", mode =
=3D", oct(mode), ", major =3D", major, ", minor =3D", minor, ")"
+                print("TMKNOD (tag =3D", tag, ", fid =3D", fid, ", mode =
=3D", oct(mode), ", major =3D", major, ", minor =3D", minor, ")")
=20
         def v9fs_lock(self, tag, id, fid, type, start, length):
-                print "TLOCK (tag =3D", tag, ", fid =3D", fid, "type =3D=
", type, ", start =3D", start, ", length =3D", length, ")"
+                print("TLOCK (tag =3D", tag, ", fid =3D", fid, "type =3D=
", type, ", start =3D", start, ", length =3D", length, ")")
=20
         def v9fs_lock_return(self, tag, id, status):
-                print "RLOCK (tag =3D", tag, ", status =3D", status, ")"
+                print("RLOCK (tag =3D", tag, ", status =3D", status, ")"=
)
=20
         def v9fs_getlock(self, tag, id, fid, type, start, length):
-                print "TGETLOCK (tag =3D", tag, ", fid =3D", fid, "type =
=3D", type, ", start =3D", start, ", length =3D", length, ")"
+                print("TGETLOCK (tag =3D", tag, ", fid =3D", fid, "type =
=3D", type, ", start =3D", start, ", length =3D", length, ")")
=20
         def v9fs_getlock_return(self, tag, id, type, start, length, proc=
_id):
-                print "RGETLOCK (tag =3D", tag, "type =3D", type, ", sta=
rt =3D", start, ", length =3D", length, ", proc_id =3D", proc_id,  ")"
+                print("RGETLOCK (tag =3D", tag, "type =3D", type, ", sta=
rt =3D", start, ", length =3D", length, ", proc_id =3D", proc_id,  ")")
=20
         def v9fs_mkdir(self, tag, id, fid, name, mode, gid):
-                print "TMKDIR (tag =3D", tag, ", fid =3D", fid, ", name =
=3D", name, ", mode =3D", mode, ", gid =3D", gid, ")"
+                print("TMKDIR (tag =3D", tag, ", fid =3D", fid, ", name =
=3D", name, ", mode =3D", mode, ", gid =3D", gid, ")")
=20
         def v9fs_mkdir_return(self, tag, id, type, version, path, err):
-                print "RMKDIR (tag =3D", tag,  ", qid=3D{type =3D", type=
, ", version =3D", version, ", path =3D", path, "}, err =3D", err, ")"
+                print("RMKDIR (tag =3D", tag,  ", qid=3D{type =3D", type=
, ", version =3D", version, ", path =3D", path, "}, err =3D", err, ")")
=20
         def v9fs_xattrwalk(self, tag, id, fid, newfid, name):
-                print "TXATTRWALK (tag =3D", tag, ", fid =3D", fid, ", n=
ewfid =3D", newfid, ", xattr name =3D", name, ")"
+                print("TXATTRWALK (tag =3D", tag, ", fid =3D", fid, ", n=
ewfid =3D", newfid, ", xattr name =3D", name, ")")
=20
         def v9fs_xattrwalk_return(self, tag, id, size):
-                print "RXATTRWALK (tag =3D", tag, ", xattrsize  =3D", si=
ze, ")"
+                print("RXATTRWALK (tag =3D", tag, ", xattrsize  =3D", si=
ze, ")")
=20
         def v9fs_xattrcreate(self, tag, id, fid, name, size, flags):
-                print "TXATTRCREATE (tag =3D", tag, ", fid =3D", fid, ",=
 name =3D", name, ", xattrsize =3D", size, ", flags =3D", flags, ")"
+                print("TXATTRCREATE (tag =3D", tag, ", fid =3D", fid, ",=
 name =3D", name, ", xattrsize =3D", size, ", flags =3D", flags, ")")
=20
         def v9fs_readlink(self, tag, id, fid):
-                print "TREADLINK (tag =3D", tag, ", fid =3D", fid, ")"
+                print("TREADLINK (tag =3D", tag, ", fid =3D", fid, ")")
=20
         def v9fs_readlink_return(self, tag, id, target):
-                print "RREADLINK (tag =3D", tag, ", target =3D", target,=
 ")"
+                print("RREADLINK (tag =3D", tag, ", target =3D", target,=
 ")")
=20
 simpletrace.run(VirtFSRequestTracker())
diff --git a/scripts/analyse-locks-simpletrace.py b/scripts/analyse-locks=
-simpletrace.py
index 101e84dea5..352bc9c22d 100755
--- a/scripts/analyse-locks-simpletrace.py
+++ b/scripts/analyse-locks-simpletrace.py
@@ -6,6 +6,7 @@
 # Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
 #
=20
+from __future__ import print_function
 import os
 import simpletrace
 import argparse
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 88ff4adb30..5c2010c917 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -17,6 +17,7 @@
 # You should have received a copy of the GNU Lesser General Public
 # License along with this library; if not, see <http://www.gnu.org/licen=
ses/>.
=20
+from __future__ import print_function
 import numpy as np
 import json
 import os
@@ -162,7 +163,7 @@ class RamSection(object):
                     len =3D self.file.read64()
                     self.sizeinfo[self.name] =3D '0x%016x' % len
                     if self.write_memory:
-                        print self.name
+                        print(self.name)
                         mkdir_p('./' + os.path.dirname(self.name))
                         f =3D open('./' + self.name, "wb")
                         f.truncate(0)
@@ -588,7 +589,7 @@ if args.extract:
     dump =3D MigrationDump(args.file)
=20
     dump.read(desc_only =3D True)
-    print "desc.json"
+    print("desc.json")
     f =3D open("desc.json", "wb")
     f.truncate()
     f.write(jsonenc.encode(dump.vmsd_desc))
@@ -596,7 +597,7 @@ if args.extract:
=20
     dump.read(write_memory =3D True)
     dict =3D dump.getDict()
-    print "state.json"
+    print("state.json")
     f =3D open("state.json", "wb")
     f.truncate()
     f.write(jsonenc.encode(dict))
@@ -605,10 +606,10 @@ elif args.dump =3D=3D "state":
     dump =3D MigrationDump(args.file)
     dump.read(dump_memory =3D args.memory)
     dict =3D dump.getDict()
-    print jsonenc.encode(dict)
+    print(jsonenc.encode(dict))
 elif args.dump =3D=3D "desc":
     dump =3D MigrationDump(args.file)
     dump.read(desc_only =3D True)
-    print jsonenc.encode(dump.vmsd_desc)
+    print(jsonenc.encode(dump.vmsd_desc))
 else:
     raise Exception("Please specify either -x, -d state or -d dump")
diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 276eebf0c2..5a857cebcf 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -12,6 +12,7 @@ Authors:
 This work is licensed under the terms of the GNU GPL, version 2 or later=
. See
 the COPYING file in the top-level directory.
 """
+from __future__ import print_function
=20
 import ctypes
 import struct
diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index e274086277..5ae77c8a92 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -18,6 +18,7 @@
 # You should have received a copy of the GNU Lesser General Public
 # License along with this library; if not, see <http://www.gnu.org/licen=
ses/>.
=20
+from __future__ import print_function
 import argparse
 import struct
 from collections import namedtuple
@@ -89,9 +90,9 @@ def call_decode(table, index, dumpfile):
     "Search decode table for next step"
     decoder =3D next((d for d in table if d.eid =3D=3D index), None)
     if not decoder:
-        print "Could not decode index: %d" % (index)
-        print "Entry is: %s" % (decoder)
-        print "Decode Table is:\n%s" % (table)
+        print("Could not decode index: %d" % (index))
+        print("Entry is: %s" % (decoder))
+        print("Decode Table is:\n%s" % (table))
         return False
     else:
         return decoder.fn(decoder.eid, decoder.name, dumpfile)
@@ -103,23 +104,23 @@ def print_event(eid, name, string=3DNone, event_cou=
nt=3DNone):
         event_count =3D replay_state.event_count
=20
     if string:
-        print "%d:%s(%d) %s" % (event_count, name, eid, string)
+        print("%d:%s(%d) %s" % (event_count, name, eid, string))
     else:
-        print "%d:%s(%d)" % (event_count, name, eid)
+        print("%d:%s(%d)" % (event_count, name, eid))
=20
=20
 # Decoders for each event type
=20
 def decode_unimp(eid, name, _unused_dumpfile):
     "Unimplimented decoder, will trigger exit"
-    print "%s not handled - will now stop" % (name)
+    print("%s not handled - will now stop" % (name))
     return False
=20
 # Checkpoint decoder
 def swallow_async_qword(eid, name, dumpfile):
     "Swallow a qword of data without looking at it"
     step_id =3D read_qword(dumpfile)
-    print "  %s(%d) @ %d" % (name, eid, step_id)
+    print("  %s(%d) @ %d" % (name, eid, step_id))
     return True
=20
 async_decode_table =3D [ Decoder(0, "REPLAY_ASYNC_EVENT_BH", swallow_asy=
nc_qword),
@@ -139,8 +140,8 @@ def decode_async(eid, name, dumpfile):
     async_event_checkpoint =3D read_byte(dumpfile)
=20
     if async_event_checkpoint !=3D replay_state.current_checkpoint:
-        print "  mismatch between checkpoint %d and async data %d" % (
-            replay_state.current_checkpoint, async_event_checkpoint)
+        print("  mismatch between checkpoint %d and async data %d" % (
+            replay_state.current_checkpoint, async_event_checkpoint))
         return True
=20
     return call_decode(async_decode_table, async_event_kind, dumpfile)
@@ -283,7 +284,7 @@ def decode_file(filename):
     version =3D read_dword(dumpfile)
     junk =3D read_qword(dumpfile)
=20
-    print "HEADER: version 0x%x" % (version)
+    print("HEADER: version 0x%x" % (version))
=20
     if version =3D=3D 0xe02007:
         event_decode_table =3D v7_event_table
diff --git a/scripts/signrom.py b/scripts/signrom.py
index 0497a1c32e..313ee28a17 100644
--- a/scripts/signrom.py
+++ b/scripts/signrom.py
@@ -1,3 +1,4 @@
+from __future__ import print_function
 #
 # Option ROM signing utility
 #
diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 9d45c6ba4e..2658b5cc7c 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -9,6 +9,7 @@
 #
 # For help see docs/devel/tracing.txt
=20
+from __future__ import print_function
 import struct
 import re
 import inspect
@@ -257,6 +258,6 @@ if __name__ =3D=3D '__main__':
                 else:
                     fields.append('%s=3D0x%x' % (name, rec[i]))
                 i +=3D 1
-            print ' '.join(fields)
+            print(' '.join(fields))
=20
     run(Formatter())
diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-c=
hecker.py
index bcef7ee28e..60d1bf4cda 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -19,6 +19,7 @@
 # You should have received a copy of the GNU General Public License alon=
g
 # with this program; if not, see <http://www.gnu.org/licenses/>.
=20
+from __future__ import print_function
 import argparse
 import json
 import sys
@@ -176,10 +177,10 @@ def check_fields(src_fields, dest_fields, desc, sec=
):
             except StopIteration:
                 if d_iter_list =3D=3D []:
                     # We were not in a substruct
-                    print "Section \"" + sec + "\",",
-                    print "Description " + "\"" + desc + "\":",
-                    print "expected field \"" + s_item["field"] + "\",",
-                    print "while dest has no further fields"
+                    print("Section \"" + sec + "\",", end=3D' ')
+                    print("Description " + "\"" + desc + "\":", end=3D' =
')
+                    print("expected field \"" + s_item["field"] + "\",",=
 end=3D' ')
+                    print("while dest has no further fields")
                     bump_taint()
                     break
=20
@@ -197,10 +198,10 @@ def check_fields(src_fields, dest_fields, desc, sec=
):
                     advance_dest =3D True
                     continue
                 if unused_count < 0:
-                    print "Section \"" + sec + "\",",
-                    print "Description \"" + desc + "\":",
-                    print "unused size mismatch near \"",
-                    print s_item["field"] + "\""
+                    print("Section \"" + sec + "\",", end=3D' ')
+                    print("Description \"" + desc + "\":", end=3D' ')
+                    print("unused size mismatch near \"", end=3D' ')
+                    print(s_item["field"] + "\"")
                     bump_taint()
                     break
                 continue
@@ -211,10 +212,10 @@ def check_fields(src_fields, dest_fields, desc, sec=
):
                     advance_src =3D True
                     continue
                 if unused_count < 0:
-                    print "Section \"" + sec + "\",",
-                    print "Description \"" + desc + "\":",
-                    print "unused size mismatch near \"",
-                    print d_item["field"] + "\""
+                    print("Section \"" + sec + "\",", end=3D' ')
+                    print("Description \"" + desc + "\":", end=3D' ')
+                    print("unused size mismatch near \"", end=3D' ')
+                    print(d_item["field"] + "\"")
                     bump_taint()
                     break
                 continue
@@ -262,10 +263,10 @@ def check_fields(src_fields, dest_fields, desc, sec=
):
                     unused_count =3D s_item["size"] - d_item["size"]
                     continue
=20
-            print "Section \"" + sec + "\",",
-            print "Description \"" + desc + "\":",
-            print "expected field \"" + s_item["field"] + "\",",
-            print "got \"" + d_item["field"] + "\"; skipping rest"
+            print("Section \"" + sec + "\",", end=3D' ')
+            print("Description \"" + desc + "\":", end=3D' ')
+            print("expected field \"" + s_item["field"] + "\",", end=3D'=
 ')
+            print("got \"" + d_item["field"] + "\"; skipping rest")
             bump_taint()
             break
=20
@@ -289,8 +290,8 @@ def check_subsections(src_sub, dest_sub, desc, sec):
             check_descriptions(s_item, d_item, sec)
=20
         if not found:
-            print "Section \"" + sec + "\", Description \"" + desc + "\"=
:",
-            print "Subsection \"" + s_item["name"] + "\" not found"
+            print("Section \"" + sec + "\", Description \"" + desc + "\"=
:", end=3D' ')
+            print("Subsection \"" + s_item["name"] + "\" not found")
             bump_taint()
=20
=20
@@ -299,8 +300,8 @@ def check_description_in_list(s_item, d_item, sec, de=
sc):
         return
=20
     if not "Description" in d_item:
-        print "Section \"" + sec + "\", Description \"" + desc + "\",",
-        print "Field \"" + s_item["field"] + "\": missing description"
+        print("Section \"" + sec + "\", Description \"" + desc + "\",", =
end=3D' ')
+        print("Field \"" + s_item["field"] + "\": missing description")
         bump_taint()
         return
=20
@@ -311,17 +312,17 @@ def check_descriptions(src_desc, dest_desc, sec):
     check_version(src_desc, dest_desc, sec, src_desc["name"])
=20
     if not check_fields_match(sec, src_desc["name"], dest_desc["name"]):
-        print "Section \"" + sec + "\":",
-        print "Description \"" + src_desc["name"] + "\"",
-        print "missing, got \"" + dest_desc["name"] + "\" instead; skipp=
ing"
+        print("Section \"" + sec + "\":", end=3D' ')
+        print("Description \"" + src_desc["name"] + "\"", end=3D' ')
+        print("missing, got \"" + dest_desc["name"] + "\" instead; skipp=
ing")
         bump_taint()
         return
=20
     for f in src_desc:
         if not f in dest_desc:
-            print "Section \"" + sec + "\"",
-            print "Description \"" + src_desc["name"] + "\":",
-            print "Entry \"" + f + "\" missing"
+            print("Section \"" + sec + "\"", end=3D' ')
+            print("Description \"" + src_desc["name"] + "\":", end=3D' '=
)
+            print("Entry \"" + f + "\" missing")
             bump_taint()
             continue
=20
@@ -334,39 +335,39 @@ def check_descriptions(src_desc, dest_desc, sec):
=20
 def check_version(s, d, sec, desc=3DNone):
     if s["version_id"] > d["version_id"]:
-        print "Section \"" + sec + "\"",
+        print("Section \"" + sec + "\"", end=3D' ')
         if desc:
-            print "Description \"" + desc + "\":",
-        print "version error:", s["version_id"], ">", d["version_id"]
+            print("Description \"" + desc + "\":", end=3D' ')
+        print("version error:", s["version_id"], ">", d["version_id"])
         bump_taint()
=20
     if not "minimum_version_id" in d:
         return
=20
     if s["version_id"] < d["minimum_version_id"]:
-        print "Section \"" + sec + "\"",
+        print("Section \"" + sec + "\"", end=3D' ')
         if desc:
-            print "Description \"" + desc + "\":",
-            print "minimum version error:", s["version_id"], "<",
-            print d["minimum_version_id"]
+            print("Description \"" + desc + "\":", end=3D' ')
+            print("minimum version error:", s["version_id"], "<", end=3D=
' ')
+            print(d["minimum_version_id"])
             bump_taint()
=20
=20
 def check_size(s, d, sec, desc=3DNone, field=3DNone):
     if s["size"] !=3D d["size"]:
-        print "Section \"" + sec + "\"",
+        print("Section \"" + sec + "\"", end=3D' ')
         if desc:
-            print "Description \"" + desc + "\"",
+            print("Description \"" + desc + "\"", end=3D' ')
         if field:
-            print "Field \"" + field + "\"",
-        print "size mismatch:", s["size"], ",", d["size"]
+            print("Field \"" + field + "\"", end=3D' ')
+        print("size mismatch:", s["size"], ",", d["size"])
         bump_taint()
=20
=20
 def check_machine_type(s, d):
     if s["Name"] !=3D d["Name"]:
-        print "Warning: checking incompatible machine types:",
-        print "\"" + s["Name"] + "\", \"" + d["Name"] + "\""
+        print("Warning: checking incompatible machine types:", end=3D' '=
)
+        print("\"" + s["Name"] + "\", \"" + d["Name"] + "\"")
     return
=20
=20
@@ -400,7 +401,7 @@ def main():
             # doesn't exist in dest.
             dest_sec =3D get_changed_sec_name(sec)
             if not dest_sec in dest_data:
-                print "Section \"" + sec + "\" does not exist in dest"
+                print("Section \"" + sec + "\" does not exist in dest")
                 bump_taint()
                 continue
=20
@@ -415,8 +416,8 @@ def main():
=20
         for entry in s:
             if not entry in d:
-                print "Section \"" + sec + "\": Entry \"" + entry + "\""=
,
-                print "missing"
+                print("Section \"" + sec + "\": Entry \"" + entry + "\""=
, end=3D' ')
+                print("missing")
                 bump_taint()
                 continue
=20
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index b3ce72069f..e6c233e9bf 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -23,6 +23,7 @@
 Run QEMU with all combinations of -machine and -device types,
 check for crashes and unexpected errors.
 """
+from __future__ import print_function
=20
 import sys
 import os
@@ -554,7 +555,7 @@ def main():
                 tc[k] =3D v
=20
     if len(binariesToTest(args, tc)) =3D=3D 0:
-        print >>sys.stderr, "No QEMU binary found"
+        print("No QEMU binary found", file=3Dsys.stderr)
         parser.print_usage(sys.stderr)
         return 1
=20
diff --git a/scripts/kvm/kvm_flightrecorder b/scripts/kvm/kvm_flightrecor=
der
index 7fb1c2d1a7..54a56745e4 100755
--- a/scripts/kvm/kvm_flightrecorder
+++ b/scripts/kvm/kvm_flightrecorder
@@ -32,6 +32,7 @@
 # consuming CPU cycles.  No disk I/O is performed since the ring buffer =
holds a
 # fixed-size in-memory trace.
=20
+from __future__ import print_function
 import sys
 import os
=20
@@ -77,8 +78,8 @@ def tail_trace():
         pass
=20
 def usage():
-    print 'Usage: %s start [buffer_size_kb] | stop | dump | tail' % sys.=
argv[0]
-    print 'Control the KVM flight recorder tracing.'
+    print('Usage: %s start [buffer_size_kb] | stop | dump | tail' % sys.=
argv[0])
+    print('Control the KVM flight recorder tracing.')
     sys.exit(0)
=20
 def main():
@@ -87,15 +88,15 @@ def main():
=20
     cmd =3D sys.argv[1]
     if cmd =3D=3D '--version':
-        print 'kvm_flightrecorder version 1.0'
+        print('kvm_flightrecorder version 1.0')
         sys.exit(0)
=20
     if not os.path.isdir(tracing_dir):
-        print 'Unable to tracing debugfs directory, try:'
-        print 'mount -t debugfs none /sys/kernel/debug'
+        print('Unable to tracing debugfs directory, try:')
+        print('mount -t debugfs none /sys/kernel/debug')
         sys.exit(1)
     if not os.access(tracing_dir, os.W_OK):
-        print 'Unable to write to tracing debugfs directory, please run =
as root'
+        print('Unable to write to tracing debugfs directory, please run =
as root')
         sys.exit(1)
=20
     if cmd =3D=3D 'start':
@@ -105,16 +106,16 @@ def main():
             try:
                 buffer_size_kb =3D int(sys.argv[2])
             except ValueError:
-                print 'Invalid per-cpu trace buffer size in KB'
+                print('Invalid per-cpu trace buffer size in KB')
                 sys.exit(1)
             write_file(trace_path('buffer_size_kb'), str(buffer_size_kb)=
)
-            print 'Per-CPU ring buffer size set to %d KB' % buffer_size_=
kb
+            print('Per-CPU ring buffer size set to %d KB' % buffer_size_=
kb)
=20
         start_tracing()
-        print 'KVM flight recorder enabled'
+        print('KVM flight recorder enabled')
     elif cmd =3D=3D 'stop':
         stop_tracing()
-        print 'KVM flight recorder disabled'
+        print('KVM flight recorder disabled')
     elif cmd =3D=3D 'dump':
         dump_trace()
     elif cmd =3D=3D 'tail':
diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index d9a6db0bb7..99a8146aaa 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -10,6 +10,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
=20
+from __future__ import print_function
 MSR_IA32_VMX_BASIC =3D 0x480
 MSR_IA32_VMX_PINBASED_CTLS =3D 0x481
 MSR_IA32_VMX_PROCBASED_CTLS =3D 0x482
diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index 7d2a472094..8510814683 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -36,6 +36,7 @@
 # See also: https://wiki.qemu.org/Features/QAPI/GuestAgent
 #
=20
+from __future__ import print_function
 import base64
 import random
=20
diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
index 514b539a6b..16d3bdb6fe 100755
--- a/scripts/qmp/qmp
+++ b/scripts/qmp/qmp
@@ -10,6 +10,7 @@
 # This work is licensed under the terms of the GNU GPLv2 or later.
 # See the COPYING file in the top-level directory.
=20
+from __future__ import print_function
 import sys, os
 from qmp import QEMUMonitorProtocol
=20
@@ -26,9 +27,9 @@ def print_response(rsp, prefix=3D[]):
             print_response(rsp[key], prefix + [key])
     else:
         if len(prefix):
-            print '%s: %s' % ('.'.join(prefix), rsp)
+            print('%s: %s' % ('.'.join(prefix), rsp))
         else:
-            print '%s' % (rsp)
+            print('%s' % (rsp))
=20
 def main(args):
     path =3D None
@@ -53,21 +54,21 @@ def main(args):
             elif arg in ['help']:
                 os.execlp('man', 'man', 'qmp')
             else:
-                print 'Unknown argument "%s"' % arg
+                print('Unknown argument "%s"' % arg)
=20
             args =3D args[1:]
         else:
             break
=20
     if not path:
-        print "QMP path isn't set, use --path=3Dqmp-monitor-address or s=
et QMP_PATH"
+        print("QMP path isn't set, use --path=3Dqmp-monitor-address or s=
et QMP_PATH")
         return 1
=20
     if len(args):
         command, args =3D args[0], args[1:]
     else:
-        print 'No command found'
-        print 'Usage: "qmp [--path=3Dqmp-monitor-address] qmp-cmd argume=
nts"'
+        print('No command found')
+        print('Usage: "qmp [--path=3Dqmp-monitor-address] qmp-cmd argume=
nts"')
         return 1
=20
     if command in ['help']:
@@ -93,7 +94,7 @@ def main(args):
             os.execvp(fullcmd, [fullcmd] + args)
         except OSError as exc:
             if exc.errno =3D=3D 2:
-                print 'Command "%s" not found.' % (fullcmd)
+                print('Command "%s" not found.' % (fullcmd))
                 return 1
             raise
         return 0
@@ -104,7 +105,7 @@ def main(args):
     arguments =3D {}
     for arg in args:
         if not arg.startswith('--'):
-            print 'Unknown argument "%s"' % arg
+            print('Unknown argument "%s"' % arg)
             return 1
=20
         arg =3D arg[2:]
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index be449de621..b1cc7e2271 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -65,6 +65,7 @@
 # which will echo back the properly formatted JSON-compliant QMP that is=
 being
 # sent to QEMU, which is useful for debugging and documentation generati=
on.
=20
+from __future__ import print_function
 import qmp
 import json
 import ast
@@ -153,14 +154,14 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                 # File not found. No problem.
                 pass
             else:
-                print "Failed to read history '%s'; %s" % (self._histfil=
e, e)
+                print("Failed to read history '%s'; %s" % (self._histfil=
e, e))
         atexit.register(self.__save_history)
=20
     def __save_history(self):
         try:
             readline.write_history_file(self._histfile)
         except Exception as e:
-            print "Failed to save history file '%s'; %s" % (self._histfi=
le, e)
+            print("Failed to save history file '%s'; %s" % (self._histfi=
le, e))
=20
     def __parse_value(self, val):
         try:
@@ -258,15 +259,15 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         if self._pretty:
             indent =3D 4
         jsobj =3D json.dumps(qmp, indent=3Dindent)
-        print str(jsobj)
+        print(str(jsobj))
=20
     def _execute_cmd(self, cmdline):
         try:
             qmpcmd =3D self.__build_cmd(cmdline)
         except Exception as e:
-            print 'Error while parsing command line: %s' % e
-            print 'command format: <command-name> ',
-            print '[arg-name1=3Darg1] ... [arg-nameN=3DargN]'
+            print('Error while parsing command line: %s' % e)
+            print('command format: <command-name> ', end=3D' ')
+            print('[arg-name1=3Darg1] ... [arg-nameN=3DargN]')
             return True
         # For transaction mode, we may have just cached the action:
         if qmpcmd is None:
@@ -275,7 +276,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             self._print(qmpcmd)
         resp =3D self.cmd_obj(qmpcmd)
         if resp is None:
-            print 'Disconnected'
+            print('Disconnected')
             return False
         self._print(resp)
         return True
@@ -285,12 +286,12 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         self.__completer_setup()
=20
     def show_banner(self, msg=3D'Welcome to the QMP low-level shell!'):
-        print msg
+        print(msg)
         if not self._greeting:
-            print 'Connected'
+            print('Connected')
             return
         version =3D self._greeting['QMP']['version']['qemu']
-        print 'Connected to QEMU %d.%d.%d\n' % (version['major'],version=
['minor'],version['micro'])
+        print('Connected to QEMU %d.%d.%d\n' % (version['major'],version=
['minor'],version['micro']))
=20
     def get_prompt(self):
         if self._transmode:
@@ -306,11 +307,11 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         try:
             cmdline =3D raw_input(prompt)
         except EOFError:
-            print
+            print()
             return False
         if cmdline =3D=3D '':
             for ev in self.get_events():
-                print ev
+                print(ev)
             self.clear_events()
             return True
         else:
@@ -366,24 +367,24 @@ class HMPShell(QMPShell):
             try:
                 idx =3D int(cmdline.split()[1])
                 if not 'return' in self.__cmd_passthrough('info version'=
, idx):
-                    print 'bad CPU index'
+                    print('bad CPU index')
                     return True
                 self.__cpu_index =3D idx
             except ValueError:
-                print 'cpu command takes an integer argument'
+                print('cpu command takes an integer argument')
                 return True
         resp =3D self.__cmd_passthrough(cmdline, self.__cpu_index)
         if resp is None:
-            print 'Disconnected'
+            print('Disconnected')
             return False
         assert 'return' in resp or 'error' in resp
         if 'return' in resp:
             # Success
             if len(resp['return']) > 0:
-                print resp['return'],
+                print(resp['return'], end=3D' ')
         else:
             # Error
-            print '%s: %s' % (resp['error']['class'], resp['error']['des=
c'])
+            print('%s: %s' % (resp['error']['class'], resp['error']['des=
c']))
         return True
=20
     def show_banner(self):
diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 0172c69441..291c8bfbc2 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -11,6 +11,7 @@
 # the COPYING file in the top-level directory.
 ##
=20
+from __future__ import print_function
 import sys
 import os
 from qmp import QEMUMonitorProtocol
@@ -33,7 +34,7 @@ def usage_error(error_msg =3D "unspecified error"):
=20
 if len(args) > 0:
     if args[0] =3D=3D "-h":
-        print usage()
+        print(usage())
         exit(0);
     elif args[0] =3D=3D "-s":
         try:
@@ -62,6 +63,6 @@ srv.connect()
 rsp =3D srv.command('qom-get', path=3Dpath, property=3Dprop)
 if type(rsp) =3D=3D dict:
     for i in rsp.keys():
-        print '%s: %s' % (i, rsp[i])
+        print('%s: %s' % (i, rsp[i]))
 else:
-    print rsp
+    print(rsp)
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 1e7cc6cb2d..cd907bb81f 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -11,6 +11,7 @@
 # the COPYING file in the top-level directory.
 ##
=20
+from __future__ import print_function
 import sys
 import os
 from qmp import QEMUMonitorProtocol
@@ -33,7 +34,7 @@ def usage_error(error_msg =3D "unspecified error"):
=20
 if len(args) > 0:
     if args[0] =3D=3D "-h":
-        print usage()
+        print(usage())
         exit(0);
     elif args[0] =3D=3D "-s":
         try:
@@ -52,13 +53,13 @@ srv =3D QEMUMonitorProtocol(socket_path)
 srv.connect()
=20
 if len(args) =3D=3D 0:
-    print '/'
+    print('/')
     sys.exit(0)
=20
 for item in srv.command('qom-list', path=3Dargs[0]):
     if item['type'].startswith('child<'):
-        print '%s/' % item['name']
+        print('%s/' % item['name'])
     elif item['type'].startswith('link<'):
-        print '@%s/' % item['name']
+        print('@%s/' % item['name'])
     else:
-        print '%s' % item['name']
+        print('%s' % item['name'])
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 94e2778922..fbe4b3e471 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -11,6 +11,7 @@
 # the COPYING file in the top-level directory.
 ##
=20
+from __future__ import print_function
 import sys
 import os
 from qmp import QEMUMonitorProtocol
@@ -34,7 +35,7 @@ def usage_error(error_msg =3D "unspecified error"):
=20
 if len(args) > 0:
     if args[0] =3D=3D "-h":
-        print usage()
+        print(usage())
         exit(0);
     elif args[0] =3D=3D "-s":
         try:
@@ -61,4 +62,4 @@ else:
 srv =3D QEMUMonitorProtocol(socket_path)
 srv.connect()
=20
-print srv.command('qom-set', path=3Dpath, property=3Dprop, value=3Dvalue=
)
+print(srv.command('qom-set', path=3Dpath, property=3Dprop, value=3Dvalue=
))
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 906fcd2640..0ffd1ff1de 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -13,6 +13,7 @@
 # the COPYING file in the top-level directory.
 ##
=20
+from __future__ import print_function
 import sys
 import os
 from qmp import QEMUMonitorProtocol
@@ -35,7 +36,7 @@ def usage_error(error_msg =3D "unspecified error"):
=20
 if len(args) > 0:
     if args[0] =3D=3D "-h":
-        print usage()
+        print(usage())
         exit(0);
     elif args[0] =3D=3D "-s":
         try:
@@ -54,15 +55,15 @@ srv =3D QEMUMonitorProtocol(socket_path)
 srv.connect()
=20
 def list_node(path):
-    print '%s' % path
+    print('%s' % path)
     items =3D srv.command('qom-list', path=3Dpath)
     for item in items:
         if not item['type'].startswith('child<'):
             try:
-                print '  %s: %s (%s)' % (item['name'], srv.command('qom-=
get', path=3Dpath, property=3Ditem['name']), item['type'])
+                print('  %s: %s (%s)' % (item['name'], srv.command('qom-=
get', path=3Dpath, property=3Ditem['name']), item['type']))
             except:
-                print '  %s: <EXCEPTION> (%s)' % (item['name'], item['ty=
pe'])
-    print ''
+                print('  %s: <EXCEPTION> (%s)' % (item['name'], item['ty=
pe']))
+    print('')
     for item in items:
         if item['type'].startswith('child<'):
             list_node((path if (path !=3D '/') else '')  + '/' + item['n=
ame'])
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index f8267586eb..306e14cf69 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -11,6 +11,7 @@
 # or (at your option) any later version. See the COPYING file in
 # the top-level directory.
=20
+from __future__ import print_function
 import os
 import sys
 sys.path.append(os.path.join(os.path.dirname(__file__),
@@ -87,7 +88,7 @@ def _get_so_libs(executable):
                 so_lib =3D search.groups()[1]
                 libs.append("%s/%s" % (so_path, so_lib))
     except subprocess.CalledProcessError:
-        print "%s had no associated libraries (static build?)" % (execut=
able)
+        print("%s had no associated libraries (static build?)" % (execut=
able))
=20
     return libs
=20
@@ -161,7 +162,7 @@ class Docker(object):
                 continue
             if only_known and instance_uuid not in self._instances:
                 continue
-            print "Terminating", i
+            print("Terminating", i)
             if active:
                 self._do(["kill", i])
             self._do(["rm", i])
@@ -288,7 +289,7 @@ class BuildCommand(SubCommand):
         if "--no-cache" not in argv and \
            dkr.image_matches_dockerfile(tag, dockerfile):
             if not args.quiet:
-                print "Image is up to date."
+                print("Image is up to date.")
         else:
             # Create a docker context directory for the build
             docker_dir =3D tempfile.mkdtemp(prefix=3D"docker_build")
@@ -300,10 +301,10 @@ class BuildCommand(SubCommand):
                 rc =3D subprocess.call(os.path.realpath(docker_pre),
                                      cwd=3Ddocker_dir, stdout=3Dstdout)
                 if rc =3D=3D 3:
-                    print "Skip"
+                    print("Skip")
                     return 0
                 elif rc !=3D 0:
-                    print "%s exited with code %d" % (docker_pre, rc)
+                    print("%s exited with code %d" % (docker_pre, rc))
                     return 1
=20
             # Copy any extra files into the Docker context. These can be
@@ -399,11 +400,11 @@ class ProbeCommand(SubCommand):
         try:
             docker =3D Docker()
             if docker._command[0] =3D=3D "docker":
-                print "yes"
+                print("yes")
             elif docker._command[0] =3D=3D "sudo":
-                print "sudo"
+                print("sudo")
         except Exception:
-            print "no"
+            print("no")
=20
         return
=20
diff --git a/tests/docker/travis.py b/tests/docker/travis.py
index 703a7fde85..ea1ef169e6 100755
--- a/tests/docker/travis.py
+++ b/tests/docker/travis.py
@@ -11,6 +11,7 @@
 # or (at your option) any later version. See the COPYING file in
 # the top-level directory.
=20
+from __future__ import print_function
 import sys
 import yaml
 import itertools
@@ -34,14 +35,14 @@ def main():
         sys.stderr.write("Usage: %s <travis-file>\n" % sys.argv[0])
         return 1
     conf =3D load_yaml(sys.argv[1])
-    print "\n".join((": ${%s}" % var for var in conf["env"]["global"]))
+    print("\n".join((": ${%s}" % var for var in conf["env"]["global"])))
     for config in conf_iter(conf):
-        print "("
-        print "\n".join(config["env"])
-        print "alias cc=3D" + config["compiler"]
-        print "\n".join(conf["before_script"])
-        print "\n".join(conf["script"])
-        print ")"
+        print("(")
+        print("\n".join(config["env"]))
+        print("alias cc=3D" + config["compiler"])
+        print("\n".join(conf["before_script"]))
+        print("\n".join(conf["script"]))
+        print(")")
     return 0
=20
 if __name__ =3D=3D "__main__":
diff --git a/tests/guest-debug/test-gdbstub.py b/tests/guest-debug/test-g=
dbstub.py
index 31ba6c943a..474d2c5c65 100644
--- a/tests/guest-debug/test-gdbstub.py
+++ b/tests/guest-debug/test-gdbstub.py
@@ -1,3 +1,4 @@
+from __future__ import print_function
 #
 # This script needs to be run on startup
 # qemu -kernel ${KERNEL} -s -S
diff --git a/tests/image-fuzzer/runner.py b/tests/image-fuzzer/runner.py
index 96a1c11b2f..8de656933e 100755
--- a/tests/image-fuzzer/runner.py
+++ b/tests/image-fuzzer/runner.py
@@ -18,6 +18,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
+from __future__ import print_function
 import sys
 import os
 import signal
@@ -36,9 +37,8 @@ except ImportError:
     try:
         import simplejson as json
     except ImportError:
-        print >>sys.stderr, \
-            "Warning: Module for JSON processing is not found.\n" \
-            "'--config' and '--command' options are not supported."
+        print("Warning: Module for JSON processing is not found.\n" \
+            "'--config' and '--command' options are not supported.", fil=
e=3Dsys.stderr)
=20
 # Backing file sizes in MB
 MAX_BACKING_FILE_SIZE =3D 10
@@ -158,9 +158,8 @@ class TestEnv(object):
         try:
             os.makedirs(self.current_dir)
         except OSError as e:
-            print >>sys.stderr, \
-                "Error: The working directory '%s' cannot be used. Reaso=
n: %s"\
-                % (self.work_dir, e[1])
+            print("Error: The working directory '%s' cannot be used. Rea=
son: %s"\
+                % (self.work_dir, e[1]), file=3Dsys.stderr)
             raise TestException
         self.log =3D open(os.path.join(self.current_dir, "test.log"), "w=
")
         self.parent_log =3D open(run_log, "a")
@@ -277,7 +276,7 @@ class TestEnv(object):
 if __name__ =3D=3D '__main__':
=20
     def usage():
-        print """
+        print("""
         Usage: runner.py [OPTION...] TEST_DIR IMG_GENERATOR
=20
         Set up test environment in TEST_DIR and run a test in it. A modu=
le for
@@ -326,7 +325,7 @@ if __name__ =3D=3D '__main__':
=20
         If '--config' argument is specified, fields not listed in
         the configuration array will not be fuzzed.
-        """
+        """)
=20
     def run_test(test_id, seed, work_dir, run_log, cleanup, log_all,
                  command, fuzz_config):
@@ -357,8 +356,7 @@ if __name__ =3D=3D '__main__':
                                        ['command=3D', 'help', 'seed=3D',=
 'config=3D',
                                         'keep_passed', 'verbose', 'durat=
ion=3D'])
     except getopt.error as e:
-        print >>sys.stderr, \
-            "Error: %s\n\nTry 'runner.py --help' for more information" %=
 e
+        print("Error: %s\n\nTry 'runner.py --help' for more information"=
 % e, file=3Dsys.stderr)
         sys.exit(1)
=20
     command =3D None
@@ -375,9 +373,8 @@ if __name__ =3D=3D '__main__':
             try:
                 command =3D json.loads(arg)
             except (TypeError, ValueError, NameError) as e:
-                print >>sys.stderr, \
-                    "Error: JSON array of test commands cannot be loaded=
.\n" \
-                    "Reason: %s" % e
+                print("Error: JSON array of test commands cannot be load=
ed.\n" \
+                    "Reason: %s" % e, file=3Dsys.stderr)
                 sys.exit(1)
         elif opt in ('-k', '--keep_passed'):
             cleanup =3D False
@@ -391,15 +388,13 @@ if __name__ =3D=3D '__main__':
             try:
                 config =3D json.loads(arg)
             except (TypeError, ValueError, NameError) as e:
-                print >>sys.stderr, \
-                    "Error: JSON array with the fuzzer configuration can=
not" \
-                    " be loaded\nReason: %s" % e
+                print("Error: JSON array with the fuzzer configuration c=
annot" \
+                    " be loaded\nReason: %s" % e, file=3Dsys.stderr)
                 sys.exit(1)
=20
     if not len(args) =3D=3D 2:
-        print >>sys.stderr, \
-            "Expected two parameters\nTry 'runner.py --help'" \
-            " for more information."
+        print("Expected two parameters\nTry 'runner.py --help'" \
+            " for more information.", file=3Dsys.stderr)
         sys.exit(1)
=20
     work_dir =3D os.path.realpath(args[0])
@@ -415,9 +410,8 @@ if __name__ =3D=3D '__main__':
     try:
         image_generator =3D __import__(generator_name)
     except ImportError as e:
-        print >>sys.stderr, \
-            "Error: The image generator '%s' cannot be imported.\n" \
-            "Reason: %s" % (generator_name, e)
+        print("Error: The image generator '%s' cannot be imported.\n" \
+            "Reason: %s" % (generator_name, e), file=3Dsys.stderr)
         sys.exit(1)
=20
     # Enable core dumps
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestp=
erf/engine.py
index e14d4320b2..398e3f2706 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -1,3 +1,4 @@
+from __future__ import print_function
 #
 # Migration test main engine
 #
@@ -117,7 +118,7 @@ class Engine(object):
         # XXX how to get dst timings on remote host ?
=20
         if self._verbose:
-            print "Sleeping %d seconds for initial guest workload run" %=
 self._sleep
+            print("Sleeping %d seconds for initial guest workload run" %=
 self._sleep)
         sleep_secs =3D self._sleep
         while sleep_secs > 1:
             src_qemu_time.append(self._cpu_timing(src_pid))
@@ -126,7 +127,7 @@ class Engine(object):
             sleep_secs -=3D 1
=20
         if self._verbose:
-            print "Starting migration"
+            print("Starting migration")
         if scenario._auto_converge:
             resp =3D src.command("migrate-set-capabilities",
                                capabilities =3D [
@@ -216,7 +217,7 @@ class Engine(object):
=20
                 if progress._status =3D=3D "completed":
                     if self._verbose:
-                        print "Sleeping %d seconds for final guest workl=
oad run" % self._sleep
+                        print("Sleeping %d seconds for final guest workl=
oad run" % self._sleep)
                     sleep_secs =3D self._sleep
                     while sleep_secs > 1:
                         time.sleep(1)
@@ -227,23 +228,23 @@ class Engine(object):
                 return [progress_history, src_qemu_time, src_vcpu_time]
=20
             if self._verbose and (loop % 20) =3D=3D 0:
-                print "Iter %d: remain %5dMB of %5dMB (total %5dMB @ %5d=
Mb/sec)" % (
+                print("Iter %d: remain %5dMB of %5dMB (total %5dMB @ %5d=
Mb/sec)" % (
                     progress._ram._iterations,
                     progress._ram._remaining_bytes / (1024 * 1024),
                     progress._ram._total_bytes / (1024 * 1024),
                     progress._ram._transferred_bytes / (1024 * 1024),
                     progress._ram._transfer_rate_mbs,
-                )
+                ))
=20
             if progress._ram._iterations > scenario._max_iters:
                 if self._verbose:
-                    print "No completion after %d iterations over RAM" %=
 scenario._max_iters
+                    print("No completion after %d iterations over RAM" %=
 scenario._max_iters)
                 src.command("migrate_cancel")
                 continue
=20
             if time.time() > (start + scenario._max_time):
                 if self._verbose:
-                    print "No completion after %d seconds" % scenario._m=
ax_time
+                    print("No completion after %d seconds" % scenario._m=
ax_time)
                 src.command("migrate_cancel")
                 continue
=20
@@ -251,7 +252,7 @@ class Engine(object):
                 progress._ram._iterations >=3D scenario._post_copy_iters=
 and
                 not post_copy):
                 if self._verbose:
-                    print "Switching to post-copy after %d iterations" %=
 scenario._post_copy_iters
+                    print("Switching to post-copy after %d iterations" %=
 scenario._post_copy_iters)
                 resp =3D src.command("migrate-start-postcopy")
                 post_copy =3D True
=20
@@ -259,7 +260,7 @@ class Engine(object):
                 progress._ram._iterations >=3D scenario._pause_iters and
                 not paused):
                 if self._verbose:
-                    print "Pausing VM after %d iterations" % scenario._p=
ause_iters
+                    print("Pausing VM after %d iterations" % scenario._p=
ause_iters)
                 resp =3D src.command("stop")
                 paused =3D True
=20
@@ -348,7 +349,7 @@ class Engine(object):
         if not log:
             return []
         if self._debug:
-            print log
+            print(log)
=20
         regex =3D r"[^\s]+\s\((\d+)\):\sINFO:\s(\d+)ms\scopied\s\d+\sGB\=
sin\s(\d+)ms"
         matcher =3D re.compile(regex)
@@ -407,7 +408,7 @@ class Engine(object):
             if uri[0:5] =3D=3D "unix:":
                 os.remove(uri[5:])
             if self._verbose:
-                print "Finished migration"
+                print("Finished migration")
=20
             src.shutdown()
             dst.shutdown()
@@ -420,7 +421,7 @@ class Engine(object):
                           self._initrd, self._transport, self._sleep)
         except Exception as e:
             if self._debug:
-                print "Failed: %s" % str(e)
+                print("Failed: %s" % str(e))
             try:
                 src.shutdown()
             except:
@@ -431,7 +432,7 @@ class Engine(object):
                 pass
=20
             if self._debug:
-                print src.get_log()
-                print dst.get_log()
+                print(src.get_log())
+                print(dst.get_log())
             raise
=20
diff --git a/tests/migration/guestperf/plot.py b/tests/migration/guestper=
f/plot.py
index bc42249e16..aa98912a82 100644
--- a/tests/migration/guestperf/plot.py
+++ b/tests/migration/guestperf/plot.py
@@ -1,3 +1,4 @@
+from __future__ import print_function
 #
 # Migration test graph plotting
 #
@@ -588,7 +589,7 @@ class Plot(object):
 """
=20
     def generate_html(self, fh):
-        print >>fh, """<html>
+        print("""<html>
   <head>
     <script type=3D"text/javascript" src=3D"plotly.min.js">
     </script>
@@ -601,19 +602,19 @@ class Plot(object):
     <h1>Migration report</h1>
     <h2>Chart summary</h2>
     <div id=3D"chart">
-""" % self._generate_style()
-        print >>fh, self._generate_chart()
-        print >>fh, """
+""" % self._generate_style(), file=3Dfh)
+        print(self._generate_chart(), file=3Dfh)
+        print("""
     </div>
     <h2>Report details</h2>
     <div id=3D"report">
-"""
-        print >>fh, self._generate_report()
-        print >>fh, """
+""", file=3Dfh)
+        print(self._generate_report(), file=3Dfh)
+        print("""
     </div>
   </body>
 </html>
-"""
+""", file=3Dfh)
=20
     def generate(self, filename):
         if filename is None:
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestpe=
rf/shell.py
index b272978f47..a6b8cec1e0 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -1,3 +1,4 @@
+from __future__ import print_function
 #
 # Migration test command line shell integration
 #
@@ -160,13 +161,13 @@ class Shell(BaseShell):
         try:
             report =3D engine.run(hardware, scenario)
             if args.output is None:
-                print report.to_json()
+                print(report.to_json())
             else:
                 with open(args.output, "w") as fh:
-                    print >>fh, report.to_json()
+                    print(report.to_json(), file=3Dfh)
             return 0
         except Exception as e:
-            print >>sys.stderr, "Error: %s" % str(e)
+            print("Error: %s" % str(e), file=3Dsys.stderr)
             if args.debug:
                 raise
             return 1
@@ -199,11 +200,11 @@ class BatchShell(BaseShell):
                     name =3D os.path.join(comparison._name, scenario._na=
me)
                     if not fnmatch.fnmatch(name, args.filter):
                         if args.verbose:
-                            print "Skipping %s" % name
+                            print("Skipping %s" % name)
                         continue
=20
                     if args.verbose:
-                        print "Running %s" % name
+                        print("Running %s" % name)
=20
                     dirname =3D os.path.join(args.output, comparison._na=
me)
                     filename =3D os.path.join(dirname, scenario._name + =
".json")
@@ -211,9 +212,9 @@ class BatchShell(BaseShell):
                         os.makedirs(dirname)
                     report =3D engine.run(hardware, scenario)
                     with open(filename, "w") as fh:
-                        print >>fh, report.to_json()
+                        print(report.to_json(), file=3Dfh)
         except Exception as e:
-            print >>sys.stderr, "Error: %s" % str(e)
+            print("Error: %s" % str(e), file=3Dsys.stderr)
             if args.debug:
                 raise
=20
@@ -246,14 +247,14 @@ class PlotShell(object):
=20
=20
         if len(args.reports) =3D=3D 0:
-            print >>sys.stderr, "At least one report required"
+            print("At least one report required", file=3Dsys.stderr)
             return 1
=20
         if not (args.qemu_cpu or
                 args.vcpu_cpu or
                 args.total_guest_cpu or
                 args.split_guest_cpu):
-            print >>sys.stderr, "At least one chart type is required"
+            print("At least one chart type is required", file=3Dsys.stde=
rr)
             return 1
=20
         reports =3D []
diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 223cd68ad5..d3ffa259db 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -20,6 +20,7 @@
 # Exercise the QEMU 'luks' block driver to validate interoperability
 # with the Linux dm-crypt + cryptsetup implementation
=20
+from __future__ import print_function
 import subprocess
 import os
 import os.path
@@ -376,7 +377,7 @@ def test_once(config, qemu_img=3DFalse):
     finally:
         iotests.log("# Delete image")
         delete_image(config)
-        print
+        print()
=20
=20
 # Obviously we only work with the luks image format
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index 2936929627..88f62d3c6d 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -18,6 +18,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
+from __future__ import print_function
 import os
 import re
 import iotests
@@ -85,7 +86,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         log =3D re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
         log =3D re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
         if log:
-            print log
+            print(log)
=20
         self.vm =3D self.mkVm()
         self.vm.launch()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index fdbdd8b300..fd8f79fef9 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1,3 +1,4 @@
+from __future__ import print_function
 # Common utilities and Python wrappers for qemu-iotests
 #
 # Copyright (C) 2012 IBM Corp.
@@ -239,7 +240,7 @@ def filter_img_info(output, filename):
 def log(msg, filters=3D[]):
     for flt in filters:
         msg =3D flt(msg)
-    print msg
+    print(msg)
=20
 class Timeout:
     def __init__(self, seconds, errmsg =3D "Timeout"):
@@ -599,7 +600,7 @@ def notrun(reason):
     seq =3D os.path.basename(sys.argv[0])
=20
     open('%s/%s.notrun' % (output_dir, seq), 'wb').write(reason + '\n')
-    print '%s not run: %s' % (seq, reason)
+    print('%s not run: %s' % (seq, reason))
     sys.exit(0)
=20
 def verify_image_format(supported_fmts=3D[], unsupported_fmts=3D[]):
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotest=
s/nbd-fault-injector.py
index 8a04d979aa..f9193c0fae 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -43,6 +43,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
 # See the COPYING file in the top-level directory.
=20
+from __future__ import print_function
 import sys
 import socket
 import struct
@@ -110,7 +111,7 @@ class FaultInjectionSocket(object):
         for rule in self.rules:
             if rule.match(event, io):
                 if rule.when =3D=3D 0 or bufsize is None:
-                    print 'Closing connection on rule match %s' % rule.n=
ame
+                    print('Closing connection on rule match %s' % rule.n=
ame)
                     sys.exit(0)
                 if rule.when !=3D -1:
                     return rule.when
@@ -182,7 +183,7 @@ def handle_connection(conn, use_export):
         elif req.type =3D=3D NBD_CMD_DISC:
             break
         else:
-            print 'unrecognized command type %#02x' % req.type
+            print('unrecognized command type %#02x' % req.type)
             break
     conn.close()
=20
@@ -242,7 +243,7 @@ def open_socket(path):
         sock =3D socket.socket(socket.AF_UNIX)
         sock.bind(path)
     sock.listen(0)
-    print 'Listening on %s' % path
+    print('Listening on %s' % path)
     sys.stdout.flush() # another process may be waiting, show message no=
w
     return sock
=20
diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 9cc4cf7d08..b95a837759 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -1,5 +1,6 @@
 #!/usr/bin/env python
=20
+from __future__ import print_function
 import sys
 import struct
 import string
@@ -129,8 +130,8 @@ class QcowHeader:
=20
     def dump(self):
         for f in QcowHeader.fields:
-            print "%-25s" % f[2], f[1] % self.__dict__[f[2]]
-        print ""
+            print("%-25s" % f[2], f[1] % self.__dict__[f[2]])
+        print("")
=20
     def dump_extensions(self):
         for ex in self.extensions:
@@ -141,11 +142,11 @@ class QcowHeader:
             else:
                 data =3D "<binary>"
=20
-            print "Header extension:"
-            print "%-25s %#x" % ("magic", ex.magic)
-            print "%-25s %d" % ("length", ex.length)
-            print "%-25s %s" % ("data", data)
-            print ""
+            print("Header extension:")
+            print("%-25s %#x" % ("magic", ex.magic))
+            print("%-25s %d" % ("length", ex.length))
+            print("%-25s %s" % ("data", data))
+            print("")
=20
=20
 def cmd_dump_header(fd):
@@ -157,12 +158,12 @@ def cmd_set_header(fd, name, value):
     try:
         value =3D int(value, 0)
     except:
-        print "'%s' is not a valid number" % value
+        print("'%s' is not a valid number" % value)
         sys.exit(1)
=20
     fields =3D (field[2] for field in QcowHeader.fields)
     if not name in fields:
-        print "'%s' is not a known header field" % name
+        print("'%s' is not a known header field" % name)
         sys.exit(1)
=20
     h =3D QcowHeader(fd)
@@ -173,7 +174,7 @@ def cmd_add_header_ext(fd, magic, data):
     try:
         magic =3D int(magic, 0)
     except:
-        print "'%s' is not a valid magic number" % magic
+        print("'%s' is not a valid magic number" % magic)
         sys.exit(1)
=20
     h =3D QcowHeader(fd)
@@ -188,7 +189,7 @@ def cmd_del_header_ext(fd, magic):
     try:
         magic =3D int(magic, 0)
     except:
-        print "'%s' is not a valid magic number" % magic
+        print("'%s' is not a valid magic number" % magic)
         sys.exit(1)
=20
     h =3D QcowHeader(fd)
@@ -200,7 +201,7 @@ def cmd_del_header_ext(fd, magic):
             h.extensions.remove(ex)
=20
     if not found:
-        print "No such header extension"
+        print("No such header extension")
         return
=20
     h.update(fd)
@@ -211,7 +212,7 @@ def cmd_set_feature_bit(fd, group, bit):
         if bit < 0 or bit >=3D 64:
             raise ValueError
     except:
-        print "'%s' is not a valid bit number in range [0, 64)" % bit
+        print("'%s' is not a valid bit number in range [0, 64)" % bit)
         sys.exit(1)
=20
     h =3D QcowHeader(fd)
@@ -222,7 +223,7 @@ def cmd_set_feature_bit(fd, group, bit):
     elif group =3D=3D 'autoclear':
         h.autoclear_features |=3D 1 << bit
     else:
-        print "'%s' is not a valid group, try 'incompatible', 'compatibl=
e', or 'autoclear'" % group
+        print("'%s' is not a valid group, try 'incompatible', 'compatibl=
e', or 'autoclear'" % group)
         sys.exit(1)
=20
     h.update(fd)
@@ -248,16 +249,16 @@ def main(filename, cmd, args):
             else:
                 handler(fd, *args)
                 return
-        print "Unknown command '%s'" % cmd
+        print("Unknown command '%s'" % cmd)
     finally:
         fd.close()
=20
 def usage():
-    print "Usage: %s <file> <cmd> [<arg>, ...]" % sys.argv[0]
-    print ""
-    print "Supported commands:"
+    print("Usage: %s <file> <cmd> [<arg>, ...]" % sys.argv[0])
+    print("")
+    print("Supported commands:")
     for name, handler, num_args, desc in cmds:
-        print "    %-20s - %s" % (name, desc)
+        print("    %-20s - %s" % (name, desc))
=20
 if __name__ =3D=3D '__main__':
     if len(sys.argv) < 3:
diff --git a/tests/qemu-iotests/qed.py b/tests/qemu-iotests/qed.py
index 748068d7fe..ea469b9c48 100755
--- a/tests/qemu-iotests/qed.py
+++ b/tests/qemu-iotests/qed.py
@@ -10,6 +10,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
 # See the COPYING file in the top-level directory.
=20
+from __future__ import print_function
 import sys
 import struct
 import random
@@ -108,12 +109,12 @@ def corrupt_table_invalidate(qed, table):
 def cmd_show(qed, *args):
     '''show [header|l1|l2 <offset>]- Show header or l1/l2 tables'''
     if not args or args[0] =3D=3D 'header':
-        print qed.header
+        print(qed.header)
     elif args[0] =3D=3D 'l1':
-        print qed.l1_table
+        print(qed.l1_table)
     elif len(args) =3D=3D 2 and args[0] =3D=3D 'l2':
         offset =3D int(args[1])
-        print qed.read_table(offset)
+        print(qed.read_table(offset))
     else:
         err('unrecognized sub-command')
=20
@@ -146,7 +147,7 @@ def cmd_invalidate(qed, table_level):
 def cmd_need_check(qed, *args):
     '''need-check [on|off] - Test, set, or clear the QED_F_NEED_CHECK he=
ader bit'''
     if not args:
-        print bool(qed.header['features'] & QED_F_NEED_CHECK)
+        print(bool(qed.header['features'] & QED_F_NEED_CHECK))
         return
=20
     if args[0] =3D=3D 'on':
@@ -208,11 +209,11 @@ def cmd_copy_metadata(qed, outfile):
     out.close()
=20
 def usage():
-    print 'Usage: %s <file> <cmd> [<arg>, ...]' % sys.argv[0]
-    print
-    print 'Supported commands:'
+    print('Usage: %s <file> <cmd> [<arg>, ...]' % sys.argv[0])
+    print()
+    print('Supported commands:')
     for cmd in sorted(x for x in globals() if x.startswith('cmd_')):
-        print globals()[cmd].__doc__
+        print(globals()[cmd].__doc__)
     sys.exit(1)
=20
 def main():
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3a2d508c35..3643117816 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -11,6 +11,7 @@
 # the COPYING file in the top-level directory.
 #
=20
+from __future__ import print_function
 import os
 import sys
 import logging
@@ -222,7 +223,7 @@ def main(vmcls):
     try:
         args, argv =3D parse_args(vmcls.name)
         if not argv and not args.build_qemu and not args.build_image:
-            print "Nothing to do?"
+            print("Nothing to do?")
             return 1
         logging.basicConfig(level=3D(logging.DEBUG if args.debug
                                    else logging.WARN))
--=20
2.18.0.rc1.1.g3f1ff2140
