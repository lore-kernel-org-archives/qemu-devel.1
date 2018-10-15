Received: from eggs.gnu.org ([2001:4830:134:3::10]:49161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC3fS-0000mm-Mh
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC3fE-00080G-Ik
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:16:21 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Oct 2018 16:14:53 +0200
Message-Id: <20181015141453.32632-10-mreitz@redhat.com>
In-Reply-To: <20181015141453.32632-1-mreitz@redhat.com>
References: <20181015141453.32632-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 9/9] iotests: Unify log outputs between Python
 2 and 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

When dumping an object into the log, there are differences between
Python 2 and 3.  First, unicode strings are prefixed by 'u' in Python 2
(they are no longer in 3, because unicode strings are the default
there).  Second, the order of keys in dicts may differ.  Third,
especially long numbers are longs in Python 2 and thus get an 'L'
suffix, which does not happen in Python 3.

To get around these differences, this patch introduces functions to
convert an object to a string that looks the same regardless of the
Python version: In Python 2, they decode unicode strings to byte strings
(normal str); in Python 3, they encode byte strings to unicode strings
(normal str).  They also manually convert lists and dicts to strings,
which allows sorting the dicts by key, so we are no longer at the mercy
of the internal implementation when it comes to how the keys appear in
the output.

This changes the output of all tests that use these logging functions.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/194.out    |  22 +-
 tests/qemu-iotests/202.out    |  12 +-
 tests/qemu-iotests/203.out    |  14 +-
 tests/qemu-iotests/206.out    | 144 +++++-----
 tests/qemu-iotests/207.out    |  52 ++--
 tests/qemu-iotests/208.out    |   8 +-
 tests/qemu-iotests/210.out    |  72 ++---
 tests/qemu-iotests/211.out    |  66 ++---
 tests/qemu-iotests/212.out    | 102 +++----
 tests/qemu-iotests/213.out    | 124 ++++----
 tests/qemu-iotests/216.out    |   4 +-
 tests/qemu-iotests/218.out    |  20 +-
 tests/qemu-iotests/219.out    | 526 +++++++++++++++++-----------------
 tests/qemu-iotests/222.out    |  24 +-
 tests/qemu-iotests/iotests.py |  42 ++-
 15 files changed, 634 insertions(+), 598 deletions(-)

diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index 50ac50da5e..722af888f6 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -1,18 +1,18 @@
 Launching VMs...
 Launching NBD server on destination...
-{u'return': {}}
-{u'return': {}}
+{'return': {}}
+{'return': {}}
 Starting `drive-mirror` on source...
-{u'return': {}}
+{'return': {}}
 Waiting for `drive-mirror` to complete...
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_READY'}
+{'data': {'device': 'mirror-job0', 'len': 1073741824, 'offset': 1073741824, 'speed': 0, 'type': 'mirror'}, 'event': 'BLOCK_JOB_READY', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 Starting migration...
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
+{'return': {}}
+{'data': {'status': 'setup'}, 'event': 'MIGRATION', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'status': 'active'}, 'event': 'MIGRATION', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'status': 'completed'}, 'event': 'MIGRATION', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 Gracefully ending the `drive-mirror` job on source...
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_COMPLETED'}
+{'return': {}}
+{'data': {'device': 'mirror-job0', 'len': 1073741824, 'offset': 1073741824, 'speed': 0, 'type': 'mirror'}, 'event': 'BLOCK_JOB_COMPLETED', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 Stopping the NBD server on destination...
-{u'return': {}}
+{'return': {}}
diff --git a/tests/qemu-iotests/202.out b/tests/qemu-iotests/202.out
index d5ea374e17..d133f09fe2 100644
--- a/tests/qemu-iotests/202.out
+++ b/tests/qemu-iotests/202.out
@@ -1,11 +1,11 @@
 Launching VM...
 Adding IOThread...
-{u'return': {}}
+{'return': {}}
 Adding blockdevs...
-{u'return': {}}
-{u'return': {}}
+{'return': {}}
+{'return': {}}
 Setting iothread...
-{u'return': {}}
-{u'return': {}}
+{'return': {}}
+{'return': {}}
 Creating external snapshots...
-{u'return': {}}
+{'return': {}}
diff --git a/tests/qemu-iotests/203.out b/tests/qemu-iotests/203.out
index 1a11f0975c..b156388a0b 100644
--- a/tests/qemu-iotests/203.out
+++ b/tests/qemu-iotests/203.out
@@ -1,11 +1,11 @@
 Launching VM...
 Setting IOThreads...
-{u'return': {}}
-{u'return': {}}
+{'return': {}}
+{'return': {}}
 Enabling migration QMP events...
-{u'return': {}}
+{'return': {}}
 Starting migration...
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
+{'return': {}}
+{'data': {'status': 'setup'}, 'event': 'MIGRATION', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'status': 'active'}, 'event': 'MIGRATION', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'status': 'completed'}, 'event': 'MIGRATION', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 789eebe57b..8fb3228cac 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -1,16 +1,16 @@
 === Successful image creation (defaults) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-add', 'arguments': {'node_name': 'imgfile', 'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}}
-{u'return': {}}
+{'execute': 'blockdev-add', 'arguments': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2', 'node_name': 'imgfile'}}
+{'return': {}}
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'imgfile', 'size': 134217728}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -24,15 +24,15 @@ Format specific information:
 
 === Successful image creation (inline blockdev-add, explicit defaults) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'nocow': False, 'preallocation': 'off', 'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2', 'nocow': False, 'preallocation': 'off', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 65536, 'refcount-bits': 16, 'version': 'v3', 'preallocation': 'off', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}, 'lazy-refcounts': False, 'driver': 'qcow2', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 65536, 'driver': 'qcow2', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}, 'lazy-refcounts': False, 'preallocation': 'off', 'refcount-bits': 16, 'size': 67108864, 'version': 'v3'}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -46,15 +46,15 @@ Format specific information:
 
 === Successful image creation (v3 non-default options) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'nocow': True, 'preallocation': 'falloc', 'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2', 'nocow': True, 'preallocation': 'falloc', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 2097152, 'refcount-bits': 1, 'version': 'v3', 'preallocation': 'metadata', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}, 'lazy-refcounts': True, 'driver': 'qcow2', 'size': 33554432}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 2097152, 'driver': 'qcow2', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}, 'lazy-refcounts': True, 'preallocation': 'metadata', 'refcount-bits': 1, 'size': 33554432, 'version': 'v3'}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -68,15 +68,15 @@ Format specific information:
 
 === Successful image creation (v2 non-default options) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 512, 'backing-fmt': 'qcow2', 'driver': 'qcow2', 'version': 'v2', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}, 'backing-file': 'TEST_DIR/PID-t.qcow2.base', 'size': 33554432}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'backing-file': 'TEST_DIR/PID-t.qcow2.base', 'backing-fmt': 'qcow2', 'cluster-size': 512, 'driver': 'qcow2', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}, 'size': 33554432, 'version': 'v2'}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -90,10 +90,10 @@ Format specific information:
 
 === Successful image creation (encrypted) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'encrypt': {'key-secret': 'keysec0', 'iter-time': 10, 'cipher-mode': 'ctr', 'ivgen-hash-alg': 'md5', 'cipher-alg': 'twofish-128', 'format': 'luks', 'ivgen-alg': 'plain64', 'hash-alg': 'sha1'}, 'driver': 'qcow2', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}, 'size': 33554432}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'encrypt': {'cipher-alg': 'twofish-128', 'cipher-mode': 'ctr', 'format': 'luks', 'hash-alg': 'sha1', 'iter-time': 10, 'ivgen-alg': 'plain64', 'ivgen-hash-alg': 'md5', 'key-secret': 'keysec0'}, 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.qcow2'}, 'size': 33554432}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -145,112 +145,112 @@ Format specific information:
 === Invalid BlockdevRef ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': "this doesn't exist", 'size': 33554432}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cannot find device=this doesn't exist nor node_name=this doesn't exist
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Invalid sizes ===
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 1234}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Image size must be a multiple of 512 bytes
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 18446744073709551104L}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 18446744073709551104}}}
+{'return': {}}
 Job failed: Could not resize image: Image size cannot be negative
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 9223372036854775808L}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 9223372036854775808}}}
+{'return': {}}
 Job failed: Could not resize image: Image size cannot be negative
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 9223372036854775296}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Could not resize image: Failed to grow the L1 table: File too large
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Invalid version ===
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'version': 'v1', 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'error': {u'class': u'GenericError', u'desc': u"Invalid parameter 'v1'"}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'size': 67108864, 'version': 'v1'}}}
+{'error': {'class': 'GenericError', 'desc': "Invalid parameter 'v1'"}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'lazy-refcounts': True, 'version': 'v2', 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'lazy-refcounts': True, 'size': 67108864, 'version': 'v2'}}}
+{'return': {}}
 Job failed: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'refcount-bits': 8, 'version': 'v2', 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'refcount-bits': 8, 'size': 67108864, 'version': 'v2'}}}
+{'return': {}}
 Job failed: Different refcount widths than 16 bits require compatibility level 1.1 or above (use version=v3 or greater)
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Invalid backing file options ===
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'preallocation': 'full', 'driver': 'qcow2', 'backing-file': '/dev/null', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'backing-file': '/dev/null', 'driver': 'qcow2', 'file': 'node0', 'preallocation': 'full', 'size': 67108864}}}
+{'return': {}}
 Job failed: Backing file and preallocation cannot be used at the same time
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'backing-fmt': 'qcow2', 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Backing format cannot be used without backing file
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Invalid cluster size ===
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 1234, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cluster size must be a power of two between 512 and 2048k
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 128, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cluster size must be a power of two between 512 and 2048k
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 4194304, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cluster size must be a power of two between 512 and 2048k
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 0, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cluster size must be a power of two between 512 and 2048k
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 512, 'driver': 'qcow2', 'file': 'node0', 'size': 281474976710656}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Could not resize image: Failed to grow the L1 table: File too large
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Invalid refcount width ===
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'refcount-bits': 128, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'refcount-bits': 128, 'size': 67108864}}}
+{'return': {}}
 Job failed: Refcount width must be a power of two and may not exceed 64 bits
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'refcount-bits': 0, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'refcount-bits': 0, 'size': 67108864}}}
+{'return': {}}
 Job failed: Refcount width must be a power of two and may not exceed 64 bits
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'refcount-bits': 7, 'driver': 'qcow2', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'qcow2', 'file': 'node0', 'refcount-bits': 7, 'size': 67108864}}}
+{'return': {}}
 Job failed: Refcount width must be a power of two and may not exceed 64 bits
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
index 078b7e63cb..e18ff4e26a 100644
--- a/tests/qemu-iotests/207.out
+++ b/tests/qemu-iotests/207.out
@@ -1,9 +1,9 @@
 === Successful image creation (defaults) ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/PID-t.img', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
@@ -16,49 +16,49 @@ virtual size: 4.0M (4194304 bytes)
 
 === Test host-key-check options ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/PID-t.img', 'host-key-check': {'mode': 'none'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 8388608}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'host-key-check': {'mode': 'none'}, 'path': 'TEST_DIR/PID-t.img', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 8388608}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/PID-t.img', 'host-key-check': {'mode': 'known_hosts'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'host-key-check': {'mode': 'known_hosts'}, 'path': 'TEST_DIR/PID-t.img', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
 virtual size: 4.0M (4194304 bytes)
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/PID-t.img', 'host-key-check': {'hash': 'wrong', 'type': 'md5', 'mode': 'hash'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 2097152}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'host-key-check': {'hash': 'wrong', 'mode': 'hash', 'type': 'md5'}, 'path': 'TEST_DIR/PID-t.img', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 2097152}}}
+{'return': {}}
 Job failed: remote host key does not match host_key_check 'wrong'
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/PID-t.img', 'host-key-check': {'hash': HASH, 'type': 'md5', 'mode': 'hash'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 8388608}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'host-key-check': {'hash': HASH, 'mode': 'hash', 'type': 'md5'}, 'path': 'TEST_DIR/PID-t.img', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 8388608}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
 virtual size: 8.0M (8388608 bytes)
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/PID-t.img', 'host-key-check': {'hash': 'wrong', 'type': 'sha1', 'mode': 'hash'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 2097152}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'host-key-check': {'hash': 'wrong', 'mode': 'hash', 'type': 'sha1'}, 'path': 'TEST_DIR/PID-t.img', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 2097152}}}
+{'return': {}}
 Job failed: remote host key does not match host_key_check 'wrong'
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/PID-t.img', 'host-key-check': {'hash': HASH, 'type': 'sha1', 'mode': 'hash'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'host-key-check': {'hash': HASH, 'mode': 'hash', 'type': 'sha1'}, 'path': 'TEST_DIR/PID-t.img', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"server.host": "127.0.0.1", "server.port": "22", "driver": "ssh", "path": "TEST_IMG"}}
 file format: IMGFMT
@@ -66,15 +66,15 @@ virtual size: 4.0M (4194304 bytes)
 
 === Invalid path and user ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': '/this/is/not/an/existing/path', 'host-key-check': {'mode': 'none'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'host-key-check': {'mode': 'none'}, 'path': '/this/is/not/an/existing/path', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
+{'return': {}}
 Job failed: failed to open remote file '/this/is/not/an/existing/path': Failed opening remote file (libssh2 error code: -31)
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/PID-t.img', 'host-key-check': {'mode': 'none'}, 'user': 'invalid user', 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 4194304}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'ssh', 'location': {'host-key-check': {'mode': 'none'}, 'path': 'TEST_DIR/PID-t.img', 'server': {'host': '127.0.0.1', 'port': '22'}, 'user': 'invalid user'}, 'size': 4194304}}}
+{'return': {}}
 Job failed: failed to authenticate using publickey authentication and the identities held by your ssh-agent
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
diff --git a/tests/qemu-iotests/208.out b/tests/qemu-iotests/208.out
index 3687e9d0dd..38c26457eb 100644
--- a/tests/qemu-iotests/208.out
+++ b/tests/qemu-iotests/208.out
@@ -1,9 +1,9 @@
 Launching VM...
 Starting NBD server...
-{u'return': {}}
+{'return': {}}
 Adding NBD export...
-{u'return': {}}
+{'return': {}}
 Creating external snapshot...
-{u'return': {}}
+{'return': {}}
 Stopping NBD server...
-{u'return': {}}
+{'return': {}}
diff --git a/tests/qemu-iotests/210.out b/tests/qemu-iotests/210.out
index 078ba544a1..49a8dcf268 100644
--- a/tests/qemu-iotests/210.out
+++ b/tests/qemu-iotests/210.out
@@ -1,16 +1,16 @@
 === Successful image creation (defaults) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.luks'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.luks', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-add', 'arguments': {'node_name': 'imgfile', 'driver': 'file', 'filename': 'TEST_DIR/PID-t.luks'}}
-{u'return': {}}
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'key-secret': 'keysec0', 'iter-time': 10, 'driver': 'luks', 'file': 'imgfile', 'size': 134217728}}}
-{u'return': {}}
+{'execute': 'blockdev-add', 'arguments': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.luks', 'node_name': 'imgfile'}}
+{'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'luks', 'file': 'imgfile', 'iter-time': 10, 'key-secret': 'keysec0', 'size': 134217728}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
@@ -54,15 +54,15 @@ Format specific information:
 
 === Successful image creation (with non-default options) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.luks'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.luks', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'key-secret': 'keysec0', 'hash-alg': 'sha1', 'cipher-mode': 'ctr', 'cipher-alg': 'twofish-128', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.luks'}, 'iter-time': 10, 'ivgen-alg': 'plain64', 'ivgen-hash-alg': 'md5', 'driver': 'luks', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cipher-alg': 'twofish-128', 'cipher-mode': 'ctr', 'driver': 'luks', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.luks'}, 'hash-alg': 'sha1', 'iter-time': 10, 'ivgen-alg': 'plain64', 'ivgen-hash-alg': 'md5', 'key-secret': 'keysec0', 'size': 67108864}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
@@ -107,17 +107,17 @@ Format specific information:
 === Invalid BlockdevRef ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'luks', 'file': "this doesn't exist", 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cannot find device=this doesn't exist nor node_name=this doesn't exist
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Zero size ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'key-secret': 'keysec0', 'iter-time': 10, 'driver': 'luks', 'file': 'node0', 'size': 0}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'luks', 'file': 'node0', 'iter-time': 10, 'key-secret': 'keysec0', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
@@ -161,34 +161,34 @@ Format specific information:
 
 === Invalid sizes ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'key-secret': 'keysec0', 'driver': 'luks', 'file': 'node0', 'size': 18446744073709551104L}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'luks', 'file': 'node0', 'key-secret': 'keysec0', 'size': 18446744073709551104}}}
+{'return': {}}
 Job failed: The requested file size is too large
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'key-secret': 'keysec0', 'driver': 'luks', 'file': 'node0', 'size': 9223372036854775808L}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'luks', 'file': 'node0', 'key-secret': 'keysec0', 'size': 9223372036854775808}}}
+{'return': {}}
 Job failed: The requested file size is too large
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'key-secret': 'keysec0', 'driver': 'luks', 'file': 'node0', 'size': 9223372036854775296}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'luks', 'file': 'node0', 'key-secret': 'keysec0', 'size': 9223372036854775296}}}
+{'return': {}}
 Job failed: The requested file size is too large
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Resize image with invalid sizes ===
 
-{'execute': 'block_resize', 'arguments': {'size': 9223372036854775296, 'node_name': 'node1'}}
-{u'error': {u'class': u'GenericError', u'desc': u'The requested file size is too large'}}
-{'execute': 'block_resize', 'arguments': {'size': 9223372036854775808L, 'node_name': 'node1'}}
-{u'error': {u'class': u'GenericError', u'desc': u"Invalid parameter type for 'size', expected: integer"}}
-{'execute': 'block_resize', 'arguments': {'size': 18446744073709551104L, 'node_name': 'node1'}}
-{u'error': {u'class': u'GenericError', u'desc': u"Invalid parameter type for 'size', expected: integer"}}
-{'execute': 'block_resize', 'arguments': {'size': -9223372036854775808, 'node_name': 'node1'}}
-{u'error': {u'class': u'GenericError', u'desc': u"Parameter 'size' expects a >0 size"}}
+{'execute': 'block_resize', 'arguments': {'node_name': 'node1', 'size': 9223372036854775296}}
+{'error': {'class': 'GenericError', 'desc': 'The requested file size is too large'}}
+{'execute': 'block_resize', 'arguments': {'node_name': 'node1', 'size': 9223372036854775808}}
+{'error': {'class': 'GenericError', 'desc': "Invalid parameter type for 'size', expected: integer"}}
+{'execute': 'block_resize', 'arguments': {'node_name': 'node1', 'size': 18446744073709551104}}
+{'error': {'class': 'GenericError', 'desc': "Invalid parameter type for 'size', expected: integer"}}
+{'execute': 'block_resize', 'arguments': {'node_name': 'node1', 'size': -9223372036854775808}}
+{'error': {'class': 'GenericError', 'desc': "Parameter 'size' expects a >0 size"}}
 image: json:{"driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_IMG"}, "key-secret": "keysec0"}
 file format: IMGFMT
 virtual size: 0 (0 bytes)
diff --git a/tests/qemu-iotests/211.out b/tests/qemu-iotests/211.out
index 6feaea3978..3816d89b40 100644
--- a/tests/qemu-iotests/211.out
+++ b/tests/qemu-iotests/211.out
@@ -1,16 +1,16 @@
 === Successful image creation (defaults) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-add', 'arguments': {'node_name': 'imgfile', 'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi'}}
-{u'return': {}}
+{'execute': 'blockdev-add', 'arguments': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi', 'node_name': 'imgfile'}}
+{'return': {}}
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': 'imgfile', 'size': 134217728}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -21,15 +21,15 @@ cluster_size: 1048576
 
 === Successful image creation (explicit defaults) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'preallocation': 'off', 'driver': 'vdi', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi'}, 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi'}, 'preallocation': 'off', 'size': 67108864}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -40,15 +40,15 @@ cluster_size: 1048576
 
 === Successful image creation (with non-default options) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'preallocation': 'metadata', 'driver': 'vdi', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi'}, 'size': 33554432}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vdi'}, 'preallocation': 'metadata', 'size': 33554432}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -61,17 +61,17 @@ cluster_size: 1048576
 === Invalid BlockdevRef ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': "this doesn't exist", 'size': 33554432}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cannot find device=this doesn't exist nor node_name=this doesn't exist
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Zero size ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': 'node0', 'size': 0}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -81,9 +81,9 @@ cluster_size: 1048576
 === Maximum size ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': 'node0', 'size': 562949819203584}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -92,21 +92,21 @@ cluster_size: 1048576
 
 === Invalid sizes ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': 'node0', 'size': 18446744073709551104L}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': 'node0', 'size': 18446744073709551104}}}
+{'return': {}}
 Job failed: Unsupported VDI image size (size is 0xfffffffffffffe00, max supported is 0x1fffff8000000)
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': 'node0', 'size': 9223372036854775808L}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': 'node0', 'size': 9223372036854775808}}}
+{'return': {}}
 Job failed: Unsupported VDI image size (size is 0x8000000000000000, max supported is 0x1fffff8000000)
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vdi', 'file': 'node0', 'size': 562949819203585}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Unsupported VDI image size (size is 0x1fffff8000001, max supported is 0x1fffff8000000)
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
diff --git a/tests/qemu-iotests/212.out b/tests/qemu-iotests/212.out
index 9150da7a2c..9779d3a4cb 100644
--- a/tests/qemu-iotests/212.out
+++ b/tests/qemu-iotests/212.out
@@ -1,16 +1,16 @@
 === Successful image creation (defaults) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.parallels'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.parallels', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-add', 'arguments': {'node_name': 'imgfile', 'driver': 'file', 'filename': 'TEST_DIR/PID-t.parallels'}}
-{u'return': {}}
+{'execute': 'blockdev-add', 'arguments': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.parallels', 'node_name': 'imgfile'}}
+{'return': {}}
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': 'imgfile', 'size': 134217728}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -18,15 +18,15 @@ virtual size: 128M (134217728 bytes)
 
 === Successful image creation (explicit defaults) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.parallels'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.parallels', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 1048576, 'driver': 'parallels', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.parallels'}, 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -34,15 +34,15 @@ virtual size: 64M (67108864 bytes)
 
 === Successful image creation (with non-default options) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.parallels'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.parallels', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 65536, 'driver': 'parallels', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.parallels'}, 'size': 33554432}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -51,17 +51,17 @@ virtual size: 32M (33554432 bytes)
 === Invalid BlockdevRef ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': "this doesn't exist", 'size': 33554432}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cannot find device=this doesn't exist nor node_name=this doesn't exist
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Zero size ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': 'node0', 'size': 0}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -70,9 +70,9 @@ virtual size: 0 (0 bytes)
 === Maximum size ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': 'node0', 'size': 4503599627369984}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -81,76 +81,76 @@ virtual size: 4096T (4503599627369984 bytes)
 === Invalid sizes ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': 'node0', 'size': 1234}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Image size must be a multiple of 512 bytes
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': 'node0', 'size': 18446744073709551104L}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': 'node0', 'size': 18446744073709551104}}}
+{'return': {}}
 Job failed: Image size is too large for this cluster size
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': 'node0', 'size': 9223372036854775808L}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': 'node0', 'size': 9223372036854775808}}}
+{'return': {}}
 Job failed: Image size is too large for this cluster size
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': 'node0', 'size': 9223372036854775296}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Image size is too large for this cluster size
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'parallels', 'file': 'node0', 'size': 4503599627370497}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Image size is too large for this cluster size
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Invalid cluster size ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 1234, 'driver': 'parallels', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cluster size must be a multiple of 512 bytes
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 128, 'driver': 'parallels', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cluster size must be a multiple of 512 bytes
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 4294967296, 'driver': 'parallels', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cluster size is too large
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 9223372036854775808L, 'driver': 'parallels', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 9223372036854775808, 'driver': 'parallels', 'file': 'node0', 'size': 67108864}}}
+{'return': {}}
 Job failed: Cluster size is too large
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 18446744073709551104L, 'driver': 'parallels', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 18446744073709551104, 'driver': 'parallels', 'file': 'node0', 'size': 67108864}}}
+{'return': {}}
 Job failed: Cluster size is too large
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 0, 'driver': 'parallels', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Image size is too large for this cluster size
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'cluster-size': 512, 'driver': 'parallels', 'file': 'node0', 'size': 281474976710656}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Image size is too large for this cluster size
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
diff --git a/tests/qemu-iotests/213.out b/tests/qemu-iotests/213.out
index e1dcd47201..9e214d4fc5 100644
--- a/tests/qemu-iotests/213.out
+++ b/tests/qemu-iotests/213.out
@@ -1,16 +1,16 @@
 === Successful image creation (defaults) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-add', 'arguments': {'node_name': 'imgfile', 'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx'}}
-{u'return': {}}
+{'execute': 'blockdev-add', 'arguments': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx', 'node_name': 'imgfile'}}
+{'return': {}}
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'imgfile', 'size': 134217728}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -19,15 +19,15 @@ cluster_size: 8388608
 
 === Successful image creation (explicit defaults) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'block-size': 8388608, 'driver': 'vhdx', 'subformat': 'dynamic', 'log-size': 1048576, 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx'}, 'block-state-zero': True, 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'block-size': 8388608, 'block-state-zero': True, 'driver': 'vhdx', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx'}, 'log-size': 1048576, 'size': 67108864, 'subformat': 'dynamic'}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -36,15 +36,15 @@ cluster_size: 8388608
 
 === Successful image creation (with non-default options) ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'size': 0, 'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx'}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx', 'size': 0}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'block-size': 268435456, 'driver': 'vhdx', 'subformat': 'fixed', 'log-size': 8388608, 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx'}, 'block-state-zero': False, 'size': 33554432}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'block-size': 268435456, 'block-state-zero': False, 'driver': 'vhdx', 'file': {'driver': 'file', 'filename': 'TEST_DIR/PID-t.vhdx'}, 'log-size': 8388608, 'size': 33554432, 'subformat': 'fixed'}}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -54,17 +54,17 @@ cluster_size: 268435456
 === Invalid BlockdevRef ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': "this doesn't exist", 'size': 33554432}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Cannot find device=this doesn't exist nor node_name=this doesn't exist
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Zero size ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'size': 0}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -74,9 +74,9 @@ cluster_size: 8388608
 === Maximum size ===
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'size': 70368744177664}}}
-{u'return': {}}
+{'return': {}}
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 image: TEST_IMG
 file format: IMGFMT
@@ -85,85 +85,85 @@ cluster_size: 67108864
 
 === Invalid sizes ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'size': 18446744073709551104L}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'size': 18446744073709551104}}}
+{'return': {}}
 Job failed: Image size too large; max of 64TB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'size': 9223372036854775808L}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'size': 9223372036854775808}}}
+{'return': {}}
 Job failed: Image size too large; max of 64TB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'size': 9223372036854775296}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Image size too large; max of 64TB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 {'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'size': 70368744177665}}}
-{u'return': {}}
+{'return': {}}
 Job failed: Image size too large; max of 64TB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Invalid block size ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'block-size': 1234567, 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'block-size': 1234567, 'driver': 'vhdx', 'file': 'node0', 'size': 67108864}}}
+{'return': {}}
 Job failed: Block size must be a multiple of 1 MB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'block-size': 128, 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'block-size': 128, 'driver': 'vhdx', 'file': 'node0', 'size': 67108864}}}
+{'return': {}}
 Job failed: Block size must be a multiple of 1 MB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'block-size': 3145728, 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'block-size': 3145728, 'driver': 'vhdx', 'file': 'node0', 'size': 67108864}}}
+{'return': {}}
 Job failed: Block size must be a power of two
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'block-size': 536870912, 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'block-size': 536870912, 'driver': 'vhdx', 'file': 'node0', 'size': 67108864}}}
+{'return': {}}
 Job failed: Block size must not exceed 268435456
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'block-size': 0, 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'block-size': 0, 'driver': 'vhdx', 'file': 'node0', 'size': 67108864}}}
+{'return': {}}
 Job failed: Block size must be a multiple of 1 MB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
 === Invalid log size ===
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'log-size': 1234567, 'driver': 'vhdx', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'log-size': 1234567, 'size': 67108864}}}
+{'return': {}}
 Job failed: Log size must be a multiple of 1 MB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'log-size': 128, 'driver': 'vhdx', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'log-size': 128, 'size': 67108864}}}
+{'return': {}}
 Job failed: Log size must be a multiple of 1 MB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'log-size': 4294967296, 'driver': 'vhdx', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'log-size': 4294967296, 'size': 67108864}}}
+{'return': {}}
 Job failed: Log size must be smaller than 4 GB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
-{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'log-size': 0, 'driver': 'vhdx', 'file': 'node0', 'size': 67108864}}}
-{u'return': {}}
+{'execute': 'blockdev-create', 'arguments': {'job_id': 'job0', 'options': {'driver': 'vhdx', 'file': 'node0', 'log-size': 0, 'size': 67108864}}}
+{'return': {}}
 Job failed: Log size must be a multiple of 1 MB
 {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
-{u'return': {}}
+{'return': {}}
 
diff --git a/tests/qemu-iotests/216.out b/tests/qemu-iotests/216.out
index 45ea857ee1..908f9314ac 100644
--- a/tests/qemu-iotests/216.out
+++ b/tests/qemu-iotests/216.out
@@ -7,8 +7,8 @@ Done
 
 --- Doing COR ---
 
-{u'return': {}}
-{u'return': u''}
+{'return': {}}
+{'return': ''}
 
 --- Checking COR result ---
 
diff --git a/tests/qemu-iotests/218.out b/tests/qemu-iotests/218.out
index 7dbf78e682..9d270e4834 100644
--- a/tests/qemu-iotests/218.out
+++ b/tests/qemu-iotests/218.out
@@ -4,27 +4,27 @@
 --- force=false ---
 
 Cancelling job
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 65536, u'len': 1048576, u'offset': 65536}, u'event': u'BLOCK_JOB_CANCELLED'}
+{'return': {}}
+{'data': {'device': 'mirror', 'len': 1048576, 'offset': 65536, 'speed': 65536, 'type': 'mirror'}, 'event': 'BLOCK_JOB_CANCELLED', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 
 --- force=true ---
 
 Cancelling job
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 65536, u'len': 1048576, u'offset': 65536}, u'event': u'BLOCK_JOB_CANCELLED'}
+{'return': {}}
+{'data': {'device': 'mirror', 'len': 1048576, 'offset': 65536, 'speed': 65536, 'type': 'mirror'}, 'event': 'BLOCK_JOB_CANCELLED', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 
 === Cancel mirror job after convergence ===
 
 --- force=false ---
 
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 0, u'len': 1048576, u'offset': 1048576}, u'event': u'BLOCK_JOB_READY'}
+{'data': {'device': 'mirror', 'len': 1048576, 'offset': 1048576, 'speed': 0, 'type': 'mirror'}, 'event': 'BLOCK_JOB_READY', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 Cancelling job
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 0, u'len': 1048576, u'offset': 1048576}, u'event': u'BLOCK_JOB_COMPLETED'}
+{'return': {}}
+{'data': {'device': 'mirror', 'len': 1048576, 'offset': 1048576, 'speed': 0, 'type': 'mirror'}, 'event': 'BLOCK_JOB_COMPLETED', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 
 --- force=true ---
 
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 0, u'len': 1048576, u'offset': 1048576}, u'event': u'BLOCK_JOB_READY'}
+{'data': {'device': 'mirror', 'len': 1048576, 'offset': 1048576, 'speed': 0, 'type': 'mirror'}, 'event': 'BLOCK_JOB_READY', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 Cancelling job
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror', u'type': u'mirror', u'speed': 0, u'len': 1048576, u'offset': 1048576}, u'event': u'BLOCK_JOB_CANCELLED'}
+{'return': {}}
+{'data': {'device': 'mirror', 'len': 1048576, 'offset': 1048576, 'speed': 0, 'type': 'mirror'}, 'event': 'BLOCK_JOB_CANCELLED', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
diff --git a/tests/qemu-iotests/219.out b/tests/qemu-iotests/219.out
index 6dc07bc41e..9acf1e89ac 100644
--- a/tests/qemu-iotests/219.out
+++ b/tests/qemu-iotests/219.out
@@ -2,326 +2,326 @@ Launching VM...
 
 
 Starting block job: drive-mirror (auto-finalize: True; auto-dismiss: True)
-{u'return': {}}
-{u'return': [{u'status': u'running', u'current-progress': 'FILTERED', u'total-progress': 'FILTERED', u'id': u'job0', u'type': u'mirror'}]}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'created', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
+{'return': {}}
+{'return': [{'current-progress': 'FILTERED', 'id': 'job0', 'status': 'running', 'total-progress': 'FILTERED', 'type': 'mirror'}]}
+{'data': {'id': 'job0', 'status': 'created'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 
 Pause/resume in RUNNING
 === Testing block-job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 65536, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 131072, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 65536, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 131072, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'mirror'}]}
 === Testing block-job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 131072, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 196608, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 131072, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 196608, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'mirror'}]}
 === Testing job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 196608, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 262144, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 196608, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 262144, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'mirror'}]}
 === Testing job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 262144, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 327680, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
-{u'return': {}}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 262144, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 327680, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'mirror'}]}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
+{'return': {}}
 
 Waiting for READY state...
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
+{'data': {'id': 'job0', 'status': 'ready'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'ready', 'total-progress': 4194304, 'type': 'mirror'}]}
 
 Pause/resume in READY
 === Testing block-job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'standby', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'standby'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'standby', 'total-progress': 4194304, 'type': 'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'ready'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'ready', 'total-progress': 4194304, 'type': 'mirror'}]}
 === Testing block-job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'standby', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'standby'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'standby', 'total-progress': 4194304, 'type': 'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'ready'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'ready', 'total-progress': 4194304, 'type': 'mirror'}]}
 === Testing job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'standby', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'standby'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'standby', 'total-progress': 4194304, 'type': 'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'ready'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'ready', 'total-progress': 4194304, 'type': 'mirror'}]}
 === Testing job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'standby', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'ready' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'ready' cannot accept command verb 'dismiss'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'ready' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'ready' cannot accept command verb 'dismiss'"}}
-{u'return': {}}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'standby'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'standby', 'total-progress': 4194304, 'type': 'mirror'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'ready'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'ready', 'total-progress': 4194304, 'type': 'mirror'}]}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'ready' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'ready' cannot accept command verb 'dismiss'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'ready' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'ready' cannot accept command verb 'dismiss'"}}
+{'return': {}}
 
 Waiting for PENDING state...
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'waiting', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'pending', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'concluded', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'null', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': []}
+{'data': {'id': 'job0', 'status': 'waiting'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'pending'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'concluded'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'null'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': []}
 
 
 Starting block job: drive-backup (auto-finalize: True; auto-dismiss: True)
-{u'return': {}}
-{u'return': [{u'status': u'running', u'current-progress': 'FILTERED', u'total-progress': 'FILTERED', u'id': u'job0', u'type': u'backup'}]}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'created', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
+{'return': {}}
+{'return': [{'current-progress': 'FILTERED', 'id': 'job0', 'status': 'running', 'total-progress': 'FILTERED', 'type': 'backup'}]}
+{'data': {'id': 'job0', 'status': 'created'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 
 Pause/resume in RUNNING
 === Testing block-job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 65536, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 131072, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 65536, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 131072, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing block-job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 131072, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 196608, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 131072, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 196608, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 196608, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 262144, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 196608, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 262144, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 262144, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 327680, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
-{u'return': {}}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 262144, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 327680, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
+{'return': {}}
 
 Waiting for PENDING state...
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'waiting', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'pending', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'concluded', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'null', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': []}
+{'data': {'id': 'job0', 'status': 'waiting'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'pending'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'concluded'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'null'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': []}
 
 
 Starting block job: drive-backup (auto-finalize: True; auto-dismiss: False)
-{u'return': {}}
-{u'return': [{u'status': u'running', u'current-progress': 'FILTERED', u'total-progress': 'FILTERED', u'id': u'job0', u'type': u'backup'}]}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'created', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
+{'return': {}}
+{'return': [{'current-progress': 'FILTERED', 'id': 'job0', 'status': 'running', 'total-progress': 'FILTERED', 'type': 'backup'}]}
+{'data': {'id': 'job0', 'status': 'created'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 
 Pause/resume in RUNNING
 === Testing block-job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 65536, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 131072, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 65536, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 131072, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing block-job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 131072, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 196608, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 131072, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 196608, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 196608, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 262144, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 196608, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 262144, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 262144, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 327680, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
-{u'return': {}}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 262144, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 327680, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
+{'return': {}}
 
 Waiting for PENDING state...
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'waiting', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'pending', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'concluded', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'concluded', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'pause'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'pause'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'finalize'"}}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'null', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': []}
+{'data': {'id': 'job0', 'status': 'waiting'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'pending'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'concluded'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'concluded', 'total-progress': 4194304, 'type': 'backup'}]}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'pause'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'pause'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'finalize'"}}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'null'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': []}
 
 
 Starting block job: drive-backup (auto-finalize: False; auto-dismiss: True)
-{u'return': {}}
-{u'return': [{u'status': u'running', u'current-progress': 'FILTERED', u'total-progress': 'FILTERED', u'id': u'job0', u'type': u'backup'}]}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'created', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
+{'return': {}}
+{'return': [{'current-progress': 'FILTERED', 'id': 'job0', 'status': 'running', 'total-progress': 'FILTERED', 'type': 'backup'}]}
+{'data': {'id': 'job0', 'status': 'created'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 
 Pause/resume in RUNNING
 === Testing block-job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 65536, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 131072, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 65536, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 131072, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing block-job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 131072, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 196608, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 131072, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 196608, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 196608, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 262144, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 196608, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 262144, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 262144, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 327680, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
-{u'return': {}}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 262144, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 327680, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
+{'return': {}}
 
 Waiting for PENDING state...
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'waiting', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'pending', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'pending', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'pause'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'dismiss'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'pause'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'dismiss'"}}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'concluded', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'null', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': []}
+{'data': {'id': 'job0', 'status': 'waiting'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'pending'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'pending', 'total-progress': 4194304, 'type': 'backup'}]}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'pause'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'dismiss'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'pause'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'dismiss'"}}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'concluded'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'null'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': []}
 
 
 Starting block job: drive-backup (auto-finalize: False; auto-dismiss: False)
-{u'return': {}}
-{u'return': [{u'status': u'running', u'current-progress': 'FILTERED', u'total-progress': 'FILTERED', u'id': u'job0', u'type': u'backup'}]}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'created', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
+{'return': {}}
+{'return': [{'current-progress': 'FILTERED', 'id': 'job0', 'status': 'running', 'total-progress': 'FILTERED', 'type': 'backup'}]}
+{'data': {'id': 'job0', 'status': 'created'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
 
 Pause/resume in RUNNING
 === Testing block-job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 65536, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 131072, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 65536, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 131072, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing block-job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 131072, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 196608, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 131072, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 196608, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing job-pause/block-job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 196608, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 262144, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 196608, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 262144, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
 === Testing job-pause/job-resume ===
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'paused', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'paused', u'current-progress': 262144, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'running', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'running', u'current-progress': 327680, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
-{u'return': {}}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'paused'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 262144, 'id': 'job0', 'status': 'paused', 'total-progress': 4194304, 'type': 'backup'}]}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'running'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 327680, 'id': 'job0', 'status': 'running', 'total-progress': 4194304, 'type': 'backup'}]}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'running' cannot accept command verb 'dismiss'"}}
+{'return': {}}
 
 Waiting for PENDING state...
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'waiting', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'pending', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'pending', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'pause'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'dismiss'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'pause'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'pending' cannot accept command verb 'dismiss'"}}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'concluded', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': [{u'status': u'concluded', u'current-progress': 4194304, u'total-progress': 4194304, u'id': u'job0', u'type': u'backup'}]}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'pause'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'finalize'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'pause'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'complete'"}}
-{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state 'concluded' cannot accept command verb 'finalize'"}}
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'null', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
-{u'return': []}
+{'data': {'id': 'job0', 'status': 'waiting'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'data': {'id': 'job0', 'status': 'pending'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'pending', 'total-progress': 4194304, 'type': 'backup'}]}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'pause'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'dismiss'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'pause'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'pending' cannot accept command verb 'dismiss'"}}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'concluded'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': [{'current-progress': 4194304, 'id': 'job0', 'status': 'concluded', 'total-progress': 4194304, 'type': 'backup'}]}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'pause'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'finalize'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'pause'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'complete'"}}
+{'error': {'class': 'GenericError', 'desc': "Job 'job0' in state 'concluded' cannot accept command verb 'finalize'"}}
+{'return': {}}
+{'data': {'id': 'job0', 'status': 'null'}, 'event': 'JOB_STATUS_CHANGE', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': []}
diff --git a/tests/qemu-iotests/222.out b/tests/qemu-iotests/222.out
index 48f336a02b..37455f6c2d 100644
--- a/tests/qemu-iotests/222.out
+++ b/tests/qemu-iotests/222.out
@@ -8,13 +8,13 @@ Done
 
 --- Setting up Fleecing Graph ---
 
-{u'return': {}}
-{u'return': {}}
+{'return': {}}
+{'return': {}}
 
 --- Setting up NBD Export ---
 
-{u'return': {}}
-{u'return': {}}
+{'return': {}}
+{'return': {}}
 
 --- Sanity Check ---
 
@@ -29,13 +29,13 @@ read -P0 0x3fe0000 64k
 --- Testing COW ---
 
 write -P0xab 0 64k
-{u'return': u''}
+{'return': ''}
 write -P0xad 0x00f8000 64k
-{u'return': u''}
+{'return': ''}
 write -P0x1d 0x2008000 64k
-{u'return': u''}
+{'return': ''}
 write -P0xea 0x3fe0000 64k
-{u'return': u''}
+{'return': ''}
 
 --- Verifying Data ---
 
@@ -49,10 +49,10 @@ read -P0 0x3fe0000 64k
 
 --- Cleanup ---
 
-{u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'drive0', u'type': u'backup', u'speed': 0, u'len': 67108864, u'offset': 393216}, u'event': u'BLOCK_JOB_CANCELLED'}
-{u'return': {}}
-{u'return': {}}
+{'return': {}}
+{'data': {'device': 'drive0', 'len': 67108864, 'offset': 393216, 'speed': 0, 'type': 'backup'}, 'event': 'BLOCK_JOB_CANCELLED', 'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}}
+{'return': {}}
+{'return': {}}
 
 --- Confirming writes ---
 
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index a64ea90fb4..f8dbc8cc71 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -250,10 +250,45 @@ def filter_img_info(output, filename):
         lines.append(line)
     return '\n'.join(lines)
 
+def log_to_string_repr(obj):
+    # Normal Python 3 strings are the unicode strings from Python 2;
+    # and normal Python 2 strings are byte strings in Python 3.  Thus,
+    # we convert bytes -> str in py3 and unicode -> str in py2.
+    if sys.version_info.major >= 3:
+        if type(obj) is bytes:
+            return repr(obj.decode('utf-8'))
+    else:
+        if type(obj) is unicode:
+            return repr(obj.encode('utf-8'))
+        elif type(obj) is long:
+            return str(obj) # repr() would include an 'L' suffix
+
+    if type(obj) is list:
+        return '[' + ', '.join(map(log_to_string_repr, obj)) + ']'
+    elif type(obj) is dict:
+        return '{' + ', '.join(map(lambda k: log_to_string_repr(k) + ': ' +
+                                             log_to_string_repr(obj[k]),
+                                   sorted(obj.keys()))) + '}'
+    else:
+        return repr(obj)
+
+def log_to_string(obj):
+    if type(obj) is str:
+        return obj
+
+    if sys.version_info.major >= 3:
+        if type(obj) is bytes:
+            return obj.decode('utf-8')
+    else:
+        if type(obj) is unicode:
+            return obj.encode('utf-8')
+
+    return log_to_string_repr(obj)
+
 def log(msg, filters=[]):
     for flt in filters:
         msg = flt(msg)
-    print(msg)
+    print(log_to_string(msg))
 
 class Timeout:
     def __init__(self, seconds, errmsg = "Timeout"):
@@ -441,10 +476,11 @@ class VM(qtest.QEMUQtestMachine):
         return result
 
     def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
-        logmsg = "{'execute': '%s', 'arguments': %s}" % (cmd, kwargs)
+        logmsg = "{'execute': '%s', 'arguments': %s}" % \
+            (cmd, log_to_string(kwargs))
         log(logmsg, filters)
         result = self.qmp(cmd, **kwargs)
-        log(str(result), filters)
+        log(log_to_string(result), filters)
         return result
 
     def run_job(self, job, auto_finalize=True, auto_dismiss=False):
-- 
2.17.1
