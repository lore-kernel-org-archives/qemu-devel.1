Received: from eggs.gnu.org ([209.51.188.92]:55437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyMt4-0001O0-So
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyMsw-0008N4-SQ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:30:05 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-11-jsnow@redhat.com>
	<39df9fc7-6458-759b-e452-3bfdbf39c94d@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <99bc4d62-0dde-e530-b004-f1947916c72a@redhat.com>
Date: Mon, 25 Feb 2019 15:29:09 -0500
MIME-Version: 1.0
In-Reply-To: <39df9fc7-6458-759b-e452-3bfdbf39c94d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/10] iotests: add busy/recording bit
 test to 124
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>



On 2/23/19 5:06 PM, Eric Blake wrote:
> On 2/22/19 6:06 PM, John Snow wrote:
>> This adds a simple test that ensures the busy bit works for push backups,
>> as well as doubling as bonus test for incremental backups that get interrupted
>> by EIO errors.
> 
> This makes 124 longer to run, but it is not in the 'quick' group, so
> that's okay.
> 
> The easy part: I compiled the series, and validated that ./check still
> passes with this applied, so:
> 
> Tested-by: Eric Blake <eblake@redhat.com>
> 
> Now for the fun part (I know from IRC that you had some interesting
> challenges coming up with scenarios to even provoke the states you
> wanted shown in the output):
> 
>>
>> Recording bit tests are already handled sufficiently by 236.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  tests/qemu-iotests/124     | 110 +++++++++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/124.out |   4 +-
>>  2 files changed, 112 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
>> index 5aa1bf1bd6..30f12a2202 100755
>> --- a/tests/qemu-iotests/124
>> +++ b/tests/qemu-iotests/124
>> @@ -634,6 +634,116 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
>>          self.vm.shutdown()
>>          self.check_backups()
>>  
>> +    def test_incremental_pause(self):
>> +        """
>> +        Test an incremental backup that errors into a pause and is resumed.
>> +        """
>> +
>> +        drive0 = self.drives[0]
>> +        result = self.vm.qmp('blockdev-add',
>> +                             node_name=drive0['id'],
>> +                             driver=drive0['fmt'],
>> +                             file={
>> +                                 'driver': 'blkdebug',
>> +                                 'image': {
>> +                                     'driver': 'file',
>> +                                     'filename': drive0['file']
>> +                                 },
>> +                                 'set-state': [{
>> +                                     'event': 'flush_to_disk',
>> +                                     'state': 1,
>> +                                     'new_state': 2
>> +                                 },{
>> +                                     'event': 'read_aio',
>> +                                     'state': 2,
>> +                                     'new_state': 3
>> +                                 }],
>> +                                 'inject-error': [{
>> +                                     'event': 'read_aio',
>> +                                     'errno': 5,
>> +                                     'state': 3,
>> +                                     'immediately': False,
>> +                                     'once': True
>> +                                 }],
> 
> Yeah, it's hairy to come up with sequences that will pause at the right
> place, and this may be sensitive enough that we have to revisit it in
> the future, but for now it works and I don't have any better suggestions.
> 

The problem in this case was that the drive_add itself provokes a
read_aio. I didn't dig too far to see why, but I needed an extra
read_aio state in the sequence there so that the error would occur
during the actual backup job.

I think I'll document this in the test, with at least a comment.

I wonder if there's a syntactical sugar we could write that makes this
easier to read, like:

'inject-error': [{ 'event': 'flush_to_disk->read_aio->read_aio' }] or
some such, but that's probably at odds with the existing interface and
not worth my time to go on a crusade about.

>> +                             })
>> +        self.assert_qmp(result, 'return', {})
>> +        self.create_anchor_backup(drive0)
>> +        bitmap = self.add_bitmap('bitmap0', drive0)
>> +
>> +        # Emulate guest activity
>> +        self.hmp_io_writes(drive0['id'], (('0xab', 0, 512),
>> +                                          ('0xfe', '16M', '256k'),
>> +                                          ('0x64', '32736k', '64k')))
>> +
>> +        # For the purposes of query-block visibility of bitmaps, add a drive
>> +        # frontend after we've written data; otherwise we can't use hmp-io
>> +        result = self.vm.qmp("device_add",
>> +                             id="device0",
>> +                             drive=drive0['id'],
>> +                             driver="virtio-blk")
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        # Bitmap Status Check
>> +        query = self.vm.qmp('query-block')
>> +        ret = [bmap for bmap in query['return'][0]['dirty-bitmaps']
>> +               if bmap.get('name') == bitmap.name][0]
>> +        self.assert_qmp(ret, 'count', 458752)
>> +        self.assert_qmp(ret, 'granularity', 65536)
>> +        self.assert_qmp(ret, 'status', 'active')
>> +        self.assert_qmp(ret, 'busy', False)
>> +        self.assert_qmp(ret, 'recording', True)
> 
> So far, nothing too different from we've seen elsewhere, but then we get
> to the fun part:
> 
>> +
>> +        # Start backup
>> +        parent, _ = bitmap.last_target()
>> +        target = self.prepare_backup(bitmap, parent)
>> +        res = self.vm.qmp('drive-backup',
>> +                          job_id=bitmap.drive['id'],
>> +                          device=bitmap.drive['id'],
>> +                          sync='incremental',
>> +                          bitmap=bitmap.name,
>> +                          format=bitmap.drive['fmt'],
>> +                          target=target,
>> +                          mode='existing',
>> +                          on_source_error='stop')
>> +        self.assert_qmp(res, 'return', {})
>> +
>> +        # Wait for the error
>> +        event = self.vm.event_wait(name="BLOCK_JOB_ERROR",
>> +                                   match={"data":{"device":bitmap.drive['id']}})
>> +        self.assert_qmp(event, 'data', {'device': bitmap.drive['id'],
>> +                                        'action': 'stop',
>> +                                        'operation': 'read'})
>> +
>> +        # Bitmap Status Check
>> +        query = self.vm.qmp('query-block')
>> +        ret = [bmap for bmap in query['return'][0]['dirty-bitmaps']
>> +               if bmap.get('name') == bitmap.name][0]
>> +        self.assert_qmp(ret, 'count', 458752)
>> +        self.assert_qmp(ret, 'granularity', 65536)
>> +        self.assert_qmp(ret, 'status', 'frozen')
>> +        self.assert_qmp(ret, 'busy', True)
>> +        self.assert_qmp(ret, 'recording', True)
> 
> "status":"frozen", "busy":true - yay, you provoked the other QMP states
> that we have not seen elsewhere in the testsuite.
> 

It also tests that you can query a bitmap during an error-paused backup
job which is new.

>> +
>> +        # Resume and check incremental backup for consistency
>> +        res = self.vm.qmp('block-job-resume', device=bitmap.drive['id'])
>> +        self.assert_qmp(res, 'return', {})
>> +        self.wait_qmp_backup(bitmap.drive['id'])
>> +
>> +        # Bitmap Status Check
>> +        query = self.vm.qmp('query-block')
>> +        ret = [bmap for bmap in query['return'][0]['dirty-bitmaps']
>> +               if bmap.get('name') == bitmap.name][0]
>> +        self.assert_qmp(ret, 'count', 0)
>> +        self.assert_qmp(ret, 'granularity', 65536)
>> +        self.assert_qmp(ret, 'status', 'active')
>> +        self.assert_qmp(ret, 'busy', False)
>> +        self.assert_qmp(ret, 'recording', True)
> 
> and even nicer, after the transient error goes away, it does not get in
> the way of further bitmap edits.
> 

And that the job can successfully finish, the bitmap is correct, etc. It
does not, sadly, test further guest writes because of the thorny issue
with the drive frontend prohibiting writes from HMP.

>> +
>> +        # Finalize / Cleanup
>> +        self.make_reference_backup(bitmap)
>> +        self.vm.shutdown()
>> +        self.check_backups()
>> +
>>  
>>  if __name__ == '__main__':
>>      iotests.main(supported_fmts=['qcow2'])
>> diff --git a/tests/qemu-iotests/124.out b/tests/qemu-iotests/124.out
>> index e56cae021b..281b69efea 100644
>> --- a/tests/qemu-iotests/124.out
>> +++ b/tests/qemu-iotests/124.out
>> @@ -1,5 +1,5 @@
>> -...........
>> +............
>>  ----------------------------------------------------------------------
>> -Ran 11 tests
>> +Ran 12 tests
> 
> Pre-existing, but this output is a bear to debug if the test ever starts
> failing.  Not something you have to worry about today, though.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks!
