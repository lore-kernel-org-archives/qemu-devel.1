Received: from eggs.gnu.org ([2001:4830:134:3::10]:39241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn2GS-0005ms-I4
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn2GO-0007Ht-KM
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:38:36 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn2GO-0007Hh-C1
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 08:38:32 -0400
Received: by mail-wm0-x233.google.com with SMTP id u126so8969348wmg.1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 05:38:32 -0700 (PDT)
Date: Wed, 30 Aug 2017 13:38:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830123827.GM24565@stefanha-x1.localdomain>
References: <CAAeL1MGV5zSPq0OCVCsw4+xzRXm95z-yd_oN2__yskd6aUmESQ@mail.gmail.com>
	<20170829100936.GP25960@stefanha-x1.localdomain>
	<20170829204055.GD4428@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829204055.GD4428@localhost.localdomain>
Subject: Re: [Qemu-devel] Make NVME device "migratable" (savevm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keith Busch <keith.busch@intel.com>
Cc: Sergei Dyshel <qyron.private@gmail.com>, qemu-devel@nongnu.org

On Tue, Aug 29, 2017 at 04:40:55PM -0400, Keith Busch wrote:
> On Tue, Aug 29, 2017 at 11:09:36AM +0100, Stefan Hajnoczi wrote:
> > On Fri, Aug 25, 2017 at 11:39:30AM +0300, Sergei Dyshel wrote:
> > > Hi all,
> > > From what I understand, I can't "savevm" a VM that uses NVME device because
> > > it has ".unmigratable = 1" in the code. What support must be implemented in
> > > order to make it "migratable"?
> > 
> > CCing Keith Busch, the NVMe maintainer.
> 
> To make it migratable, you'll need implement the VMStateDescription to
> save and restore the entire controller state, including all the queues.
> It doesn't actually look like there's a much state to track compared to
> other migratale devices, I just never got any time to write it out.

One thing unique to QEMU's block layer is that the -drive
werror=/rerror= option lets the user specify an error handling policy
for I/O requests.

If the policy is 'stop' or 'enospc' then the emulated storage controller
must hang on to the I/O request and re-submit it when VM execution
resumes (usually when the user issues the 'cont' command at the
monitor).

For example, if QEMU hits ENOSPC while writing a previously unwritten
sector in the disk image file, then VM execution can be paused.  The
host system administrator can arrange for more disk space and then issue
the 'cont' QEMU monitor command.  This resumes the VM and QEMU retries
the I/O request without ever reporting an I/O error to the guest.

You can see how this is implemented in hw/block/virtio-blk.c and other
emulated storage controllers.  This feature requires live migration
support so that the list of failed I/O requests can be sent to the
destination host during live migration.

If you decide to enable live migration, please consider how this should
be implemented for NVMe.

Stefan
