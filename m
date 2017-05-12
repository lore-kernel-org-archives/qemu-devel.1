Received: from eggs.gnu.org ([2001:4830:134:3::10]:39611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1d97hB-00051n-3M
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1d97h7-00064K-Ty
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39440 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1d97h7-0005z5-NT
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:09 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Fri, 12 May 2017 12:20:53 +0200
Message-Id: <20170512102057.5855-1-hare@suse.de>
Subject: [Qemu-devel] [RFC PATCH 0/4] Virtio command timeouts (qemu part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.com>, qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>

Hi all,

we've run into a really awkward customer situation where the guest would
hang forever due to an SG_IO ioctl on the host not returning.
Looking into it we found that qemu will submit direct I/O requests with
an _infinite_ timeout (well, actually UINT_MAX, which due to a kernel
bug gets translated into (ULONG)-2, resulting in a timeout of
4.2 years :-).
And this particular I/O ran into a timeout on the wire due to a flaky
connection. Which resulted in the 'normal' block-level timeout on the
host being disabled, and the SCSI stack never sending any aborts as
the block-layer was still waiting for the I/O timeout to expire.

Unfortunately I didn't find a way to create a stand-alone patch; the
fix I'm proposing relies on fixes for qemu running on the host and
the kernel side running on the guest.

The proposed fix consists of several parts:
- make the standard device-timeout user-settable via a 'timeout'
  attribute to 'scsi-disk' and 'scsi-generic'
- Add a kernel patch to implement a eh_timeout_handler() for
  virtio_scsi(); this patch just checks if the command is still pending
  and resets the timer if so.
- Add a request timeout to allow drivers to modify the timeout
  on a per-request base.
- Implement a new VIRTIO_SCSI_F_TIMEOUT feature allowing virtio-scsi
  to pass in a timeout via the otherwise unused 'crn' field.
- Add a kernel patch to implement the VIRTIO_SCSI_F_TIMEOUT feature
  so that the timeout is added per virtio request.

With that virtio-scsi on the guest can pass in the used timeout to the
qemu on the host side, which then can use this timeout to issue I/O
requests to the host.
The host can then properly aborting a command if the timeout is hit, and
the aborted command will be returned to the guest.
The guest itself doesn't need to (and, in fact, in most cases can't) abort
any commands anymore, so it just need to reset the I/O timer until the
requests are returned.

However, as this is quite an elaborate construct I'd like to get some
feedback for it.

Hannes Reinecke (4):
  scsi: make default command timeout user-settable
  scsi: use host default timeouts for SCSI commands
  scsi: per-request timeouts
  virtio: implement VIRTIO_SCSI_F_TIMEOUT feature

 hw/scsi/scsi-bus.c                           |  1 +
 hw/scsi/scsi-disk.c                          | 16 ++++++++++++----
 hw/scsi/scsi-generic.c                       | 11 +++++++++--
 hw/scsi/virtio-scsi.c                        | 16 ++++++++++++++++
 include/hw/scsi/scsi.h                       |  2 ++
 include/standard-headers/linux/virtio_scsi.h |  1 +
 6 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.12.0
