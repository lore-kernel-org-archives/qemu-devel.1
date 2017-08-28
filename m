Received: from eggs.gnu.org ([2001:4830:134:3::10]:59179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dmM4o-0000Ae-RD
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dmM4n-0005xr-M0
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:35:46 -0400
Date: Mon, 28 Aug 2017 17:35:25 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170828153525.d4wgjfcqfnpxavrt@eukaryote>
References: <20170828112952.22965-1-kchamart@redhat.com>
	<a80aaf11-a962-c9d6-e271-c8ad5e1365b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80aaf11-a962-c9d6-e271-c8ad5e1365b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Extend non-shared storage
 migration test (194)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com, dgilbert@redhat.com

On Mon, Aug 28, 2017 at 09:51:43AM -0500, Eric Blake wrote:
> On 08/28/2017 06:29 AM, Kashyap Chamarthy wrote:
> > This is the follow-up patch that was discussed[*] as part of feedback to
> > qemu-iotest 194.
> > 
> > Changes in this patch:
> > 
> >   - Supply 'job-id' parameter to `drive-mirror` invocation.
> > 
> >   - Issue `block-job-cancel` command on the source QEMU to gracefully
> >     complete the mirroring operation.
> > 
> >   - Stop the NBD server on the destination QEMU.
> > 
> >   - Finally, exit once the event BLOCK_JOB_COMPLETED is emitted.
> > 
> > With the above, the test will also be (almost) in sync with the
> > procedure outlined in the document live-block-operations.rst[+]
> > (section: "QMP invocation for live storage migration with
> > ``drive-mirror`` + NBD").
> > 
> > [*] https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04820.html
> >     -- qemu-iotests: add 194 non-shared storage migration test
> > [+] https://git.qemu.org/gitweb.cgi?p=qemu.git;a=blob;f=docs/interop/live-block-operations.rst
> > 
> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > ---
> > I wonder:
> >   - Is it worth printing the MIGRATION event state change?
> 
> I think waiting for both the BLOCK_JOB_COMPLETED and MIGRATION events
> make sense (in other words, let's check both events in the expected
> order, rather than just one or the other).

That sounds more robust, will do in the next iteration.

> >   - Since we're not checking on the MIGRATION event anymore, can
> >     the migration state change events related code (that is triggerred
> >     by setting 'migrate-set-capabilities') be simply removed?
> 
> If we're going to mirror libvirt's non-shared storage migration
> sequence, I think we want to keep everything, rather than drop the
> migration half.

Yes, noted.

[...]

> > -iotests.log('Starting drive-mirror on source...')
> > +iotests.log('Starting `drive-mirror` on source...')
> >  iotests.log(source_vm.qmp(
> >                'drive-mirror',
> >                device='drive0',
> >                target='nbd+unix:///drive0?socket={0}'.format(nbd_sock_path),
> >                sync='full',
> >                format='raw', # always raw, the server handles the format
> > -              mode='existing'))
> > +              mode='existing',
> > +              job_id='mirror-job0'))
> >  
> > -iotests.log('Waiting for drive-mirror to complete...')
> > +iotests.log('Waiting for `drive-mirror` to complete...')
> 
> So, up to here is okay,
> 
> >  iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
> >              filters=[iotests.filter_qmp_event])
> >  
> > @@ -66,8 +67,14 @@ dest_vm.qmp('migrate-set-capabilities',
> >              capabilities=[{'capability': 'events', 'state': True}])
> >  iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))
> >  
> > +iotests.log('Gracefully ending the `drive-mirror` job on source...')
> > +iotests.log(source_vm.qmp('block-job-cancel', device='mirror-job0'))
> > +
> > +iotests.log('Stopping the NBD server on destination...')
> > +iotests.log(dest_vm.qmp('nbd-server-stop'))
> > +
> >  while True:
> > -    event = source_vm.event_wait('MIGRATION')
> > +    event = source_vm.event_wait('BLOCK_JOB_COMPLETED')
> 
> And this event makes sense for catching the block-job-cancel, but I
> think you STILL want to keep a while loop for catching migration as well.

Yes, will do.

Thanks for the quick feedback.

[...]

-- 
/kashyap
