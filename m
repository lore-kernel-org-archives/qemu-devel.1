Received: from eggs.gnu.org ([2001:4830:134:3::10]:52796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmhN4-0007v2-Do
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmhN1-0002a1-3i
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:20:02 -0400
Date: Tue, 29 Aug 2017 15:19:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829141954.GA18927@stefanha-x1.localdomain>
References: <20170829090622.30843-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829090622.30843-1-kchamart@redhat.com>
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
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com

On Tue, Aug 29, 2017 at 11:06:22AM +0200, Kashyap Chamarthy wrote:
> This is the follow-up patch that was discussed[*] as part of feedback to
> qemu-iotest 194.
> 
> Changes in this patch:
> 
>   - Supply 'job-id' parameter to `drive-mirror` invocation.
> 
>   - Issue QMP `block-job-cancel` command on the source QEMU to
>     gracefully complete `drive-mirror` operation.
> 
>   - Stop the NBD server on the destination QEMU.
> 
>   - Finally, check for both the events: MIGRATION and
>     BLOCK_JOB_COMPLETED
> 
> With the above, the test will also be (almost) in sync with the
> procedure outlined in the document 'live-block-operations.rst'[+]
> (section: "QMP invocation for live storage migration with
> ``drive-mirror`` + NBD").
> 
> [*] https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04820.html
>     -- qemu-iotests: add 194 non-shared storage migration test
> [+] https://git.qemu.org/gitweb.cgi?p=qemu.git;a=blob;f=docs/interop/live-block-operations.rst
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> Changes in v2:
>  - Check for both the events: MIGRATION and BLOCK_JOB_COMPLETED (Eric)
> ---
>  tests/qemu-iotests/194     | 25 +++++++++++++++++++------
>  tests/qemu-iotests/194.out | 11 ++++++++---
>  2 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
> index 8028111e21bed5cf4a2e8e32dc04aa5a9ea9caca..9d81189fe3e790d060da5a0fd41836f4b57f95c7 100755
> --- a/tests/qemu-iotests/194
> +++ b/tests/qemu-iotests/194
> @@ -46,16 +46,17 @@ iotests.log('Launching NBD server on destination...')
>  iotests.log(dest_vm.qmp('nbd-server-start', addr={'type': 'unix', 'data': {'path': nbd_sock_path}}))
>  iotests.log(dest_vm.qmp('nbd-server-add', device='drive0', writable=True))
>  
> -iotests.log('Starting drive-mirror on source...')
> +iotests.log('Starting `drive-mirror` on source...')
>  iotests.log(source_vm.qmp(
>                'drive-mirror',
>                device='drive0',
>                target='nbd+unix:///drive0?socket={0}'.format(nbd_sock_path),
>                sync='full',
>                format='raw', # always raw, the server handles the format
> -              mode='existing'))
> +              mode='existing',
> +              job_id='mirror-job0'))
>  
> -iotests.log('Waiting for drive-mirror to complete...')
> +iotests.log('Waiting for `drive-mirror` to complete...')
>  iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
>              filters=[iotests.filter_qmp_event])
>  
> @@ -66,8 +67,20 @@ dest_vm.qmp('migrate-set-capabilities',
>              capabilities=[{'capability': 'events', 'state': True}])
>  iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
>  
> +iotests.log('Gracefully ending the `drive-mirror` job on source...')
> +iotests.log(source_vm.qmp('block-job-cancel', device='mirror-job0'))

Two issues:

1. Migration may not have completed yet so drive-mirror cannot be
   stopped here.  We need to wait for migration to complete on the
   source before cancelling the block job.

2. block-job-cancel is asynchronous.  The block job may still be running
   after this returns.  Therefore it may still be using the NBD drive...

> +
> +iotests.log('Stopping the NBD server on destination...')
> +iotests.log(dest_vm.qmp('nbd-server-stop'))

...and that races with this command on the destination.

We need to wait for the BLOCK_JOB_CANCELLED/COMPLETED event on the
source QEMU before stopping the NBD server on the destination.

> +
>  while True:
> -    event = source_vm.event_wait('MIGRATION')
> -    iotests.log(event, filters=[iotests.filter_qmp_event])
> -    if event['data']['status'] in ('completed', 'failed'):
> +    event1 = source_vm.event_wait('MIGRATION')
> +    iotests.log(event1, filters=[iotests.filter_qmp_event])
> +    if event1['data']['status'] in ('completed', 'failed'):
> +        break
> +
> +while True:
> +    event2 = source_vm.event_wait('BLOCK_JOB_COMPLETED')
> +    iotests.log(event2, filters=[iotests.filter_qmp_event])
> +    if event2['event'] == 'BLOCK_JOB_COMPLETED':
>          break
> diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
> index ae501fecacb706b1851cb9063ce9c9d5a28bb7ea..a461d7e21abb2dee54d72d93d644100f9fbcb17d 100644
> --- a/tests/qemu-iotests/194.out
> +++ b/tests/qemu-iotests/194.out
> @@ -2,12 +2,17 @@ Launching VMs...
>  Launching NBD server on destination...
>  {u'return': {}}
>  {u'return': {}}
> -Starting drive-mirror on source...
> +Starting `drive-mirror` on source...
>  {u'return': {}}
> -Waiting for drive-mirror to complete...
> -{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'drive0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_READY'}
> +Waiting for `drive-mirror` to complete...
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_READY'}
>  Starting migration...
>  {u'return': {}}
> +Gracefully ending the `drive-mirror` job on source...
> +{u'return': {}}
> +Stopping the NBD server on destination...
> +{u'return': {}}
>  {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
>  {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
>  {u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'mirror-job0', u'type': u'mirror', u'speed': 0, u'len': 1073741824, u'offset': 1073741824}, u'event': u'BLOCK_JOB_COMPLETED'}
> -- 
> 2.9.5
> 
> 
