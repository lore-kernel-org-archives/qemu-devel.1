Received: from eggs.gnu.org ([2001:4830:134:3::10]:50774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dqHPB-0005CI-O4
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dqHP7-00006c-2r
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:25:01 -0400
Date: Fri, 8 Sep 2017 13:24:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170908132439.3ab53d7d.cohuck@redhat.com>
In-Reply-To: <20170908110425.GC3283@localhost.localdomain>
References: <20170905151614.31303-1-cohuck@redhat.com>
	<20170905151614.31303-3-cohuck@redhat.com>
	<20170908110425.GC3283@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: use -ccw on s390x for 051
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, haoqf@linux.vnet.ibm.com

On Fri, 8 Sep 2017 13:04:25 +0200
Kevin Wolf <kwolf@redhat.com> wrote:

> Am 05.09.2017 um 17:16 hat Cornelia Huck geschrieben:
> > The default cpu model on s390x does not provide zPCI, which is
> > not yet wired up on tcg. Moreover, virtio-ccw is the standard
> > on s390x, so use the -ccw instead of the -pci versions of virtio
> > devices on s390x.
> > 
> > Provide an output file for s390x.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  tests/qemu-iotests/051                     |   9 +-
> >  tests/qemu-iotests/051.s390-ccw-virtio.out | 434 +++++++++++++++++++++++++++++
> >  2 files changed, 442 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/qemu-iotests/051.s390-ccw-virtio.out  
> 
> It's already a pain to have two separate output files for 051, let's try
> to avoid adding a third one. Even more so since I think that the split
> between 051.out and 051.pc.out was already made for s390, so I'm not
> sure if anyone would actually still make use of the plain 051.out
> output if s390 got it's own one.

Are there no non-pc and non-s390 machines for which this is run?

> 
> > diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
> > index c8cfc764bc..f6ad0f4f0b 100755
> > --- a/tests/qemu-iotests/051
> > +++ b/tests/qemu-iotests/051
> > @@ -103,7 +103,14 @@ echo
> >  echo === Device without drive ===
> >  echo
> >  
> > -run_qemu -device virtio-scsi-pci -device scsi-hd
> > +case "$QEMU_DEFAULT_MACHINE" in
> > +  s390-ccw-virtio)
> > +      run_qemu -device virtio-scsi-ccw -device scsi-hd
> > +      ;;
> > +  *)
> > +      run_qemu -device virtio-scsi-pci -device scsi-hd
> > +      ;;
> > +esac  
> 
> The only real difference between 051.out and 051.s390-ccw-virtio.out is
> in this one command line. So if we don't want to just skip this part of
> the test for non-pc like we already skip ther parts, 

I don't think there's a reason to skip this: The only difference is
that we (currently) don't have a by-default usable virtio-pci
implementation on s390 - but any virtio transport should do.

Another approach would be to drop the -pci postfix, but I don't want to
introduce more usage of aliases.

> we generally solve
> this kind of thing by just filtering out strings that differ between
> setups.
> 
> For example:
> 
>     case "$QEMU_DEFAULT_MACHINE" in
>       s390-ccw-virtio)
>           virtio_scsi=virtio-scsi-ccw
>           ;;
>       *)
>           virtio_scsi=virtio-scsi-pci
>           ;;
>     esac
> 
>     run_qemu -device $virtio_scsi -device scsi-hd |
>         sed -e "s/$virtio_scsi/VIRTIO-SCSI/"

Yes, I can try this.
