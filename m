Received: from eggs.gnu.org ([2001:4830:134:3::10]:33542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dmhnW-0003pt-Ip
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dmhnV-0000cJ-6h
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:47:22 -0400
Date: Tue, 29 Aug 2017 16:47:01 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170829144701.yt7t6akywnqbox7v@eukaryote>
References: <20170829090622.30843-1-kchamart@redhat.com>
	<20170829141954.GA18927@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829141954.GA18927@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qemu-iotests: Extend
 non-shared storage migration test (194)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com

On Tue, Aug 29, 2017 at 03:19:54PM +0100, Stefan Hajnoczi wrote:
> On Tue, Aug 29, 2017 at 11:06:22AM +0200, Kashyap Chamarthy wrote:

[...]

> > +iotests.log('Gracefully ending the `drive-mirror` job on source...')
> > +iotests.log(source_vm.qmp('block-job-cancel', device='mirror-job0'))
> 
> Two issues:
> 
> 1. Migration may not have completed yet so drive-mirror cannot be
>    stopped here.  We need to wait for migration to complete on the
>    source before cancelling the block job.
> 
> 2. block-job-cancel is asynchronous.  The block job may still be running
>    after this returns.  Therefore it may still be using the NBD drive...
> 
> > +
> > +iotests.log('Stopping the NBD server on destination...')
> > +iotests.log(dest_vm.qmp('nbd-server-stop'))
> 
> ...and that races with this command on the destination.
> 
> We need to wait for the BLOCK_JOB_CANCELLED/COMPLETED event on the
> source QEMU before stopping the NBD server on the destination.

Yes, both good points.  How about the following `diff` to address both
the issues you raised?

#----------------------------------------------------------------------
diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 9d81189..a3e3bad 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -67,20 +67,18 @@ dest_vm.qmp('migrate-set-capabilities',
             capabilities=[{'capability': 'events', 'state': True}])
 iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
 
-iotests.log('Gracefully ending the `drive-mirror` job on source...')
-iotests.log(source_vm.qmp('block-job-cancel', device='mirror-job0'))
-
-iotests.log('Stopping the NBD server on destination...')
-iotests.log(dest_vm.qmp('nbd-server-stop'))
-
 while True:
     event1 = source_vm.event_wait('MIGRATION')
     iotests.log(event1, filters=[iotests.filter_qmp_event])
     if event1['data']['status'] in ('completed', 'failed'):
+        iotests.log('Gracefully ending the `drive-mirror` job on source...')
+        iotests.log(source_vm.qmp('block-job-cancel', device='mirror-job0'))
         break
 
 while True:
     event2 = source_vm.event_wait('BLOCK_JOB_COMPLETED')
     iotests.log(event2, filters=[iotests.filter_qmp_event])
     if event2['event'] == 'BLOCK_JOB_COMPLETED':
+        iotests.log('Stopping the NBD server on destination...')
+        iotests.log(dest_vm.qmp('nbd-server-stop'))
         break
#----------------------------------------------------------------------

And the output would be:

#----------------------------------------------------------------------
Launching VMs...
Launching NBD server on destination...
{u'return': {}}
{u'return': {}}
Starting `drive-mirror` on source...
{u'return': {}}
Waiting for `drive-mirror` to complete...
{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_READY'}
Starting migration...
{u'return': {}}
{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
Gracefully ending the `drive-mirror` job on source...
{u'return': {}}
{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_COMPLETED'}
Stopping the NBD server on destination...
{u'return': {}}
#----------------------------------------------------------------------

-- 
/kashyap
