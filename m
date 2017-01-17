Received: from eggs.gnu.org ([2001:4830:134:3::10]:41915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <f.gruenbichler@proxmox.com>) id 1cTOr2-0004ok-EF
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <f.gruenbichler@proxmox.com>) id 1cTOqx-0003oh-GW
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:10:56 -0500
Date: Tue, 17 Jan 2017 09:03:26 +0100
From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Message-ID: <20170117080326.dfjqzwstfxusuhgc@nora.maurer-it.com>
References: <5878AF90.8020709@kamp.de>
	<260873230.6154791.1484638426777.JavaMail.zimbra@oxygem.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <260873230.6154791.1484638426777.JavaMail.zimbra@oxygem.tv>
Subject: Re: [Qemu-devel] [Qemu-stable]  Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 17, 2017 at 08:33:46AM +0100, Alexandre DERUMIER wrote:
> Hi,
> 
> proxmox users have reported recently corruption with qemu 2.7 and scsi-block (with passing physical /dev/sdX to virtio-scsi).
> 
> working fine with qemu 2.6.
> 
> qemu 2.7 + scsi-hd works fine
> 
> https://forum.proxmox.com/threads/proxmox-4-4-virtio_scsi-regression.31471/page-2
> 

I am fairly sure this is a separate issue.

Commit 8fdc7839e40f43a426bc7e858cf1dbfe315a3804 (first included in
2.7.0)[1] changed the behaviour of scsi-block passthrough. Previously
this worked with SATA disks, now it doesn't anymore. A bisect run
confirmed this, scsi-block with a SATA disk passed through via
virtio-scsi-single corrupts on writes since that commit, scsi-hd and
scsi-disk work fine (scsi-generic corrupts as well).

PVE's detection logic for passthrough just differentiated between disks
and tape drives, and unfortunately the SG_IO ioctl says SATA disks are
disks as well.. we probably need to default to scsi-hd or scsi-disk
instead of scsi-block, and only when we explicitly detect a "real" SCSI
disk we are allowed to use scsi-block?

@Paolo: was the old behaviour just an accident and the new bevaviour
intentional? documentation is quite sparse, or maybe I am looking in the
wrong places..

1: scsi-block: always use SG_IO

Using pread/pwrite or io_submit has the advantage of eliminating the
bounce buffer, but drops the SCSI status.  This keeps the guest from
seeing unit attention codes, as well as statuses such as RESERVATION
CONFLICT.  Because we know scsi-block operates on an SBC device we can
still use the DMA helpers with SG_IO; just remember to patch the CDBs
if the transfer is split into multiple segments.

This means that scsi-block will always use the thread-pool unfortunately,
instead of respecting aio=native.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
