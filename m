Received: from eggs.gnu.org ([2001:4830:134:3::10]:52381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cGx7R-00077x-MI
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 19:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cGx7O-0000ze-GS
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 19:08:25 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cGx7O-0000uN-BX
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 19:08:22 -0500
Received: by mail-io0-f195.google.com with SMTP id y124so1500767iof.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 16:07:59 -0800 (PST)
MIME-Version: 1.0
From: ashish mittal <ashmit602@gmail.com>
Date: Tue, 13 Dec 2016 16:06:58 -0800
Message-ID: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 RFC] block/vxhs: Initial commit to add
 Veritas HyperScale VxHS block device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Gaurav Bhandarkar <Gaurav.Bhandarkar@veritas.com>, Abhishek Kane <Abhishek.Kane@veritas.com>, Ketan Mahajan <Ketan.Mahajan@veritas.com>, Niranjan Pendharkar <Niranjan.Pendharkar@veritas.com>, Nirendra Awasthi <Nirendra.Awasthi@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

Hi,

I am requesting feedback on the following design proposal for libqnio.

This adds an access control mechanism between libqnio client and
server. It is not a full client-server authentication model, and it is
not intended to substitute an authentication mechanism.

We wanted to check if the following would be acceptable for the first
version of VxHS patch while we design/implement a proper
authentication mechanism (possibly on a libqnio side branch)?

1.       Client passes VM ID and vdisk ID to the server when it wants
to open a vdisk.
2.       Server verifies whether the client/VM has access to open the
disk and passes/fails the open request.
3.       Server returns unique token for every open vdisk.
4.       Client passes this token with every request to server.
5.       Server verifies this token for every request.
6.       Server invalidates token when a client closes the corresponding vdisk.

Thanks,
Ashish

On Wed, Nov 30, 2016 at 1:01 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Nov 28, 2016 at 02:17:56PM +0000, Stefan Hajnoczi wrote:
>> Please take a look at vhost-user-scsi, which folks from Nutanix are
>> currently working on.  See "[PATCH v2 0/3] Introduce vhost-user-scsi and
>> sample application" on qemu-devel.  It is a true zero-copy local I/O tap
>> because it shares guest RAM.  This is more efficient than cross memory
>> attach's single memory copy.  It does not require running the server as
>> root.  This is the #1 thing you should evaluate for your final
>> architecture.
>>
>> vhost-user-scsi works on the virtio-scsi emulation level.  That means
>> the server must implement the virtio-scsi vring and device emulation.
>> It is not a block driver.  By hooking in at this level you can achieve
>> the best performance but you lose all QEMU block layer functionality and
>> need to implement your own SCSI target.  You also need to consider live
>> migration.
>
> To clarify why I think vhost-user-scsi is best suited to your
> requirements for performance:
>
> With vhost-user-scsi the qnio server would be notified by kvm.ko via
> eventfd when the VM submits new I/O requests to the virtio-scsi HBA.
> The QEMU process is completely bypassed for I/O request submission and
> the qnio server processes the SCSI command instead.  This avoids the
> context switch to QEMU and then to the qnio server.  With cross memory
> attach QEMU first needs to process the I/O request and hand it to
> libqnio before the qnio server can be scheduled.
>
> The vhost-user-scsi qnio server has shared memory access to guest RAM
> and is therefore able to do zero-copy I/O into guest buffers.  Cross
> memory attach always incurs a memory copy.
>
> Using this high-performance architecture requires significant changes
> though.  vhost-user-scsi hooks into the stack at a different layer so a
> QEMU block driver is not used at all.  QEMU also wouldn't use libqnio.
> Instead everything will live in your qnio server process (not part of
> QEMU).
>
> You'd have to rethink the resiliency strategy because you currently rely
> on the QEMU block driver connecting to a different qnio server if the
> local qnio server fails.  In the vhost-user-scsi world it's more like
> having a phyiscal SCSI adapter - redundancy and multipathing are used to
> achieve resiliency.
>
> For example, virtio-scsi HBA #1 would connect to the local qnio server
> process.  virtio-scsi HBA #2 would connect to another local process
> called the "proxy process" which forwards requests to a remote qnio
> server (using libqnio?).  If HBA #1 fails then I/O is sent to HBA #2
> instead.  The path can reset back to HBA #1 once that becomes
> operational again.
>
> If the qnio server is supposed to run in a VM instead of directly in the
> host environment then it's worth looking at the vhost-pci work that Wei
> Wang <wei.w.wang@intel.com> is working on.  The email thread is called
> "[PATCH v2 0/4] *** vhost-user spec extension for vhost-pci ***".  The
> idea here is to allow inter-VM virtio device emulation so that instead
> of terminating the virtio-scsi device in the qnio server process on the
> host, you can terminate it inside another VM with good performance
> characteristics.
>
> Stefan
