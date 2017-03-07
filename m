Received: from eggs.gnu.org ([2001:4830:134:3::10]:47162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cl5Ft-0006WL-Fx
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cl5Fo-0005TR-GW
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:53:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cl5Fo-0005Sy-6k
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:53:36 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v272mjLs020471
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 21:53:34 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2917qnkft8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 21:53:34 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 7 Mar 2017 02:53:32 -0000
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue,  7 Mar 2017 03:53:28 +0100
In-Reply-To: <20170307025328.53409-1-haoqf@linux.vnet.ibm.com>
References: <20170307025328.53409-1-haoqf@linux.vnet.ibm.com>
Message-Id: <20170307025328.53409-2-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC 1/1] vmstate: draft fix for failed iotests
 case 68 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com

I am not very clear about the logic in vmstate.c, but from its context in
vmstate_save_state, it seems size should not be 0, otherwise the followed
for loop will keep working on the same element. So I just add a simple
check to pass that case, not sure if it's right but it can pass iotest
case 68 and 91 now.

The iotest's failed output is:
068 1s ... - output mismatch (see 068.out.bad)
--- /home/haoqf/KVMonz/gitcheck/work/qemu-master/tree/qemu/tests/qemu-iotests/068.out   2017-03-06 05:52:24.817328899 +0100
+++ 068.out.bad 2017-03-07 03:28:44.426714519 +0100
@@ -3,9 +3,13 @@
 === Saving and reloading a VM state to/from a qcow2 image ===

 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
+qemu-system-s390x: migration/vmstate.c:336: vmstate_save_state: Assertion `first_elem || !n_elems' failed.
+./common.config: line 109: 52497 Aborted                 ( if [ -n "${QEMU_NEED_PID}" ]; then
+    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
+fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm 0
-(qemu) quit
+qemu-system-s390x: Device 'virtio0' does not have the requested snapshot '0'
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
 *** done

091 1s ... [failed, exit status 1] - output mismatch (see 091.out.bad)
    --- tests/qemu-iotests/091.out	2016-08-30 12:35:04.207683276 +0200
    +++ 091.out.bad	2017-03-06 13:08:03.717135426 +0100
    @@ -11,18 +11,23 @@
     
     vm1: qemu-io disk write complete
     vm1: live migration started
    -vm1: live migration completed
    -
    -=== VM 2: Post-migration, write to disk, verify running ===
    -
    -vm2: qemu-io disk write complete
    -vm2: qemu process running successfully
    -vm2: flush io, and quit
    -Check image pattern
    -read 4194304/4194304 bytes at offset 0
    -4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -Running 'qemu-img check -r all $TEST_IMG'
    -No errors were found on the image.
    -80/16384 = 0.49% allocated, 0.00% fragmented, 0.00% compressed clusters
    -Image end offset: 5570560
    -*** done
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +./common.qemu: line 110: write error: Broken pipe
    +Timeout waiting for completed on handle 0

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
---
 migration/vmstate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 78b3cd4..ff28dde 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -106,6 +106,10 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
 
+            if (size == 0) {
+                field++;
+                continue;
+            }
             vmstate_handle_alloc(first_elem, field, opaque);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
@@ -322,6 +326,10 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
             int64_t old_offset, written_bytes;
             QJSON *vmdesc_loop = vmdesc;
 
+            if (size == 0) {
+                field++;
+                continue;
+            }
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
-- 
2.8.4
