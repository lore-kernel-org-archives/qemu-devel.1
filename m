Received: from eggs.gnu.org ([2001:4830:134:3::10]:58618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clBy4-0007Nr-8P
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clBy2-0008Og-Qi
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:03:44 -0500
Date: Tue, 7 Mar 2017 10:03:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170307100328.GC2869@work-vm>
References: <20170307025328.53409-1-haoqf@linux.vnet.ibm.com>
	<20170307025328.53409-2-haoqf@linux.vnet.ibm.com>
	<20170307092951.GA5871@noname.str.redhat.com>
	<80495689-674c-5dde-ae49-d80a2eb20372@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80495689-674c-5dde-ae49-d80a2eb20372@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] vmstate: draft fix for failed
 iotests case 68 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Kevin Wolf <kwolf@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, liujbjl@linux.vnet.ibm.com, famz@redhat.com, mreitz@redhat.com, quintela@redhat.com

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 03/07/2017 10:29 AM, Kevin Wolf wrote:
> > Am 07.03.2017 um 03:53 hat QingFeng Hao geschrieben:
> >> I am not very clear about the logic in vmstate.c, but from its context in
> >> vmstate_save_state, it seems size should not be 0, otherwise the followed
> >> for loop will keep working on the same element. So I just add a simple
> >> check to pass that case, not sure if it's right but it can pass iotest
> >> case 68 and 91 now.
> >>
> >> The iotest's failed output is:
> >> 068 1s ... - output mismatch (see 068.out.bad)
> >> --- /home/haoqf/KVMonz/gitcheck/work/qemu-master/tree/qemu/tests/qemu-iotests/068.out   2017-03-06 05:52:24.817328899 +0100
> >> +++ 068.out.bad 2017-03-07 03:28:44.426714519 +0100
> >> @@ -3,9 +3,13 @@
> >>  === Saving and reloading a VM state to/from a qcow2 image ===
> >>
> >>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
> >> +qemu-system-s390x: migration/vmstate.c:336: vmstate_save_state: Assertion `first_elem || !n_elems' failed.
> >> +./common.config: line 109: 52497 Aborted                 ( if [ -n "${QEMU_NEED_PID}" ]; then
> >> +    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
> >> +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
> >>  QEMU X.Y.Z monitor - type 'help' for more information
> >>  (qemu) savevm 0
> >> -(qemu) quit
> >> +qemu-system-s390x: Device 'virtio0' does not have the requested snapshot '0'
> >>  QEMU X.Y.Z monitor - type 'help' for more information
> >>  (qemu) quit
> >>  *** done
> >>
> >> 091 1s ... [failed, exit status 1] - output mismatch (see 091.out.bad)
> >>     --- tests/qemu-iotests/091.out	2016-08-30 12:35:04.207683276 +0200
> >>     +++ 091.out.bad	2017-03-06 13:08:03.717135426 +0100
> >>     @@ -11,18 +11,23 @@
> >>      
> >>      vm1: qemu-io disk write complete
> >>      vm1: live migration started
> >>     -vm1: live migration completed
> >>     -
> >>     -=== VM 2: Post-migration, write to disk, verify running ===
> >>     -
> >>     -vm2: qemu-io disk write complete
> >>     -vm2: qemu process running successfully
> >>     -vm2: flush io, and quit
> >>     -Check image pattern
> >>     -read 4194304/4194304 bytes at offset 0
> >>     -4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >>     -Running 'qemu-img check -r all $TEST_IMG'
> >>     -No errors were found on the image.
> >>     -80/16384 = 0.49% allocated, 0.00% fragmented, 0.00% compressed clusters
> >>     -Image end offset: 5570560
> >>     -*** done
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +./common.qemu: line 110: write error: Broken pipe
> >>     +Timeout waiting for completed on handle 0
> >>
> >> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> >> ---
> >>  migration/vmstate.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/migration/vmstate.c b/migration/vmstate.c
> >> index 78b3cd4..ff28dde 100644
> >> --- a/migration/vmstate.c
> >> +++ b/migration/vmstate.c
> >> @@ -106,6 +106,10 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >>              int i, n_elems = vmstate_n_elems(opaque, field);
> >>              int size = vmstate_size(opaque, field);
> >>  
> >> +            if (size == 0) {
> >> +                field++;
> >> +                continue;
> >> +            }
> >>              vmstate_handle_alloc(first_elem, field, opaque);
> >>              if (field->flags & VMS_POINTER) {
> >>                  first_elem = *(void **)first_elem;
> >> @@ -322,6 +326,10 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> >>              int64_t old_offset, written_bytes;
> >>              QJSON *vmdesc_loop = vmdesc;
> >>  
> >> +            if (size == 0) {
> >> +                field++;
> >> +                continue;
> >> +            }
> >>              trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
> >>              if (field->flags & VMS_POINTER) {
> >>                  first_elem = *(void **)first_elem;
> > 
> > This is really a live migration fix, so I'm adding Juan and Dave to CC.
> 
> You are right, this is migration stuff and has very little to do with
> qemu-block.
> > 
> > I suspect the real question is why a field with size 0 was even stored
> > in the vmstate to begin with.
> > 
> 
> I have looked onto the issue. It affects s390x only if we
> are running without KVM. Basically, S390CPU.irqstate is unused
> if we do not use KVM, and thus no buffer is allocated.
> 
> IMHO this is a missing field and the cleaner way to handle such
> missing fields is exist. However this used to work, and I recommended
> QuiFeng Hao to discuss the problem upstream.
> 
> By the way, I think, if we want to go back to the old behavior
> and support VMS_VBUFFER with size 0 and nullptr, a much
> cleaner way to do the fix is to change the assert to:
> 
> assert(first_elem  || !n_elems || !size)
> 
> Obviously the other clean way to fix is to implement exists.
> 
> I think the migration maintainers (Juan and Dave) should make a
> call regarding if the described usage  of VMS_BUFFER is a legal
> or an illegal one.

So is it this code in target/s390x/machine.c ?

        VMSTATE_VBUFFER_UINT32(irqstate, S390CPU, 4, NULL,
                               irqstate_saved_size),

it should be legal for that to be zero length.
It also makes sense that if that's zero length it should be OK for
the pointer to be NULL.

I think it's best if you do change that assert.

Dave


> Regards,
> Halil
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
