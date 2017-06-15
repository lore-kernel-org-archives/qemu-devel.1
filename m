Received: from eggs.gnu.org ([2001:4830:134:3::10]:52219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dLUvK-0001ws-L5
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 09:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dLUvG-0000nC-6x
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 09:34:58 -0400
References: <20170522135704.842-1-stefanha@redhat.com>
	<20170522135704.842-4-stefanha@redhat.com>
	<add32dd6-f842-9d66-0f7f-6e0e2b7c8100@virtuozzo.com>
	<99f414f1-7a0f-b659-be81-d6f38fd04ff4@virtuozzo.com>
	<20170614144324.GA4785@noname.redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <a54fd15d-6404-b8a7-0781-248d72b6d480@virtuozzo.com>
Date: Thu, 15 Jun 2017 16:33:53 +0300
MIME-Version: 1.0
In-Reply-To: <20170614144324.GA4785@noname.redhat.com>
Content-Type: multipart/mixed; boundary="------------6C47B725A1D8742B4545B58F"
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 3/4] migration: avoid recursive
 AioContext locking in save_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org

This is a multi-part message in MIME format.
--------------6C47B725A1D8742B4545B58F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.06.2017 17:43, Kevin Wolf wrote:
> Am 14.06.2017 um 15:15 hat Pavel Butsykin geschrieben:
>> On 14.06.2017 13:10, Pavel Butsykin wrote:
>>>
>>> On 22.05.2017 16:57, Stefan Hajnoczi wrote:
>>>> AioContext was designed to allow nested acquire/release calls.  It uses
>>>> a recursive mutex so callers don't need to worry about nesting...or so
>>>> we thought.
>>>>
>>>> BDRV_POLL_WHILE() is used to wait for block I/O requests.  It releases
>>>> the AioContext temporarily around aio_poll().  This gives IOThreads a
>>>> chance to acquire the AioContext to process I/O completions.
>>>>
>>>> It turns out that recursive locking and BDRV_POLL_WHILE() don't mix.
>>>> BDRV_POLL_WHILE() only releases the AioContext once, so the IOThread
>>>> will not be able to acquire the AioContext if it was acquired
>>>> multiple times.
>>>>
>>>> Instead of trying to release AioContext n times in BDRV_POLL_WHILE(),
>>>> this patch simply avoids nested locking in save_vmstate().  It's the
>>>> simplest fix and we should step back to consider the big picture with
>>>> all the recent changes to block layer threading.
>>>>
>>>> This patch is the final fix to solve 'savevm' hanging with -object
>>>> iothread.
>>>
>>> The same I see in external_snapshot_prepare():
>>> [...]
>>> and at the moment BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE),
>>> we have at least two locks.. So here is another deadlock.
>>
>> Sorry, here different kind of deadlock. In external_snapshot case, the
>> deadlock can happen only if state->old_bs->aio_context == my_iothread->ctx,
>> because in this case the aio_co_enter() always calls aio_co_schedule():
> 
> Can you please write qemu-iotests case for any deadlock case that we're
> seeing? Stefan, we could also use one for the bug fixed in this series.

It's 085 test, only need to enable iothread. (patch attached)
# ./check -qcow2 085 -iothread
...
+Timeout waiting for return on handle 0
Failures: 085
Failed 1 of 1 tests

The timeout because of the deadlock.


Actually the deadlock for the same reason :D

A recursive lock occurs when in the transaction more than one action:
void qmp_transaction(TransactionActionList *dev_list,
...
     /* We don't do anything in this loop that commits us to the 
operations */
     while (NULL != dev_entry) {
...
         state->ops->prepare(state, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             goto delete_and_fail;
         }
     }

     QSIMPLEQ_FOREACH(state, &snap_bdrv_states, entry) {
         if (state->ops->commit) {
             state->ops->commit(state);

There the contex lock is acquired in state->ops->prepare(), but is
released in state->ops->commit() (at bdrv_reopen_multiple()). And when
in a transaction two or more actions, we will see a recursive lock.
Unfortunately I have no idea how cheap it is to fix this.

> Kevin
> 

--------------6C47B725A1D8742B4545B58F
Content-Type: text/x-patch;
 name="0001-qemu-iotests-add-iothread-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-qemu-iotests-add-iothread-option.patch"

>From 674132232f94c1db8015ed780ba84f49fb0fd2bc Mon Sep 17 00:00:00 2001
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Thu, 15 Jun 2017 15:42:26 +0300
Subject: [PATCH] qemu-iotests: add -iothread option

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 tests/qemu-iotests/085         | 9 ++++++++-
 tests/qemu-iotests/common      | 7 +++++++
 tests/qemu-iotests/common.qemu | 9 +++++++--
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index b97adcd8db..7b4419deeb 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -131,7 +131,14 @@ echo === Running QEMU ===
 echo
 
 qemu_comm_method="qmp"
-_launch_qemu -drive file="${TEST_IMG}.1",if=virtio -drive file="${TEST_IMG}.2",if=virtio
+if [ "${IOTHREAD_QEMU}" = "y" ]; then
+    _launch_qemu -drive file="${TEST_IMG}.1",if=none,id=virtio0 \
+    -device virtio-blk-pci,iothread=iothread1,drive=virtio0 \
+    -drive file="${TEST_IMG}.2",if=none,id=virtio1 \
+    -device virtio-blk-pci,iothread=iothread1,drive=virtio1
+else
+    _launch_qemu -drive file="${TEST_IMG}.1",if=virtio -drive file="${TEST_IMG}.2",if=virtio
+fi
 h=$QEMU_HANDLE
 
 echo
diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index f2a7199c4b..fffbf39d55 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -53,6 +53,7 @@ export QEMU_IO_OPTIONS=""
 export CACHEMODE_IS_DEFAULT=true
 export QEMU_OPTIONS="-nodefaults -machine accel=qtest"
 export VALGRIND_QEMU=
+export IOTHREAD_QEMU=
 export IMGKEYSECRET=
 export IMGOPTSSYNTAX=false
 
@@ -165,6 +166,7 @@ image protocol options
 other options
     -xdiff              graphical mode diff
     -nocache            use O_DIRECT on backing file
+    -iothread           enable iothread
     -misalign           misalign memory allocations
     -n                  show me, do not run tests
     -o options          -o options to pass to qemu-img create/convert
@@ -297,6 +299,11 @@ testlist options
             xpand=false
             ;;
 
+        -iothread)
+            IOTHREAD_QEMU='y'
+            xpand=false
+            ;;
+
         -g)        # -g group ... pick from group file
             group=true
             xpand=false
diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 7a78a00999..230898ab43 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -139,6 +139,7 @@ function _launch_qemu()
     local comm=
     local fifo_out=
     local fifo_in=
+    local iothread=
 
     if (shopt -s nocasematch; [[ "${qemu_comm_method}" == "monitor" ]])
     then
@@ -148,6 +149,10 @@ function _launch_qemu()
         comm="-monitor none -qmp stdio"
     fi
 
+    if [ "${IOTHREAD_QEMU}" = "y" ]; then
+        iothread="--enable-kvm -object iothread,id=iothread1"
+    fi
+
     fifo_out=${QEMU_FIFO_OUT}_${_QEMU_HANDLE}
     fifo_in=${QEMU_FIFO_IN}_${_QEMU_HANDLE}
     mkfifo "${fifo_out}"
@@ -155,12 +160,12 @@ function _launch_qemu()
 
     if [ -z "$keep_stderr" ]; then
         QEMU_NEED_PID='y'\
-        ${QEMU} -nographic -serial none ${comm} "${@}" >"${fifo_out}" \
+        ${QEMU} ${iothread} -nographic -serial none ${comm} "${@}" >"${fifo_out}" \
                                                        2>&1 \
                                                        <"${fifo_in}" &
     elif [ "$keep_stderr" = "y" ]; then
         QEMU_NEED_PID='y'\
-        ${QEMU} -nographic -serial none ${comm} "${@}" >"${fifo_out}" \
+        ${QEMU} ${iothread} -nographic -serial none ${comm} "${@}" >"${fifo_out}" \
                                                        <"${fifo_in}" &
     else
         exit 1
-- 
2.13.0


--------------6C47B725A1D8742B4545B58F--
