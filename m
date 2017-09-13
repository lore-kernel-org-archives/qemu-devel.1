Received: from eggs.gnu.org ([2001:4830:134:3::10]:41937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1ds69g-0007pK-FZ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1ds69b-0003cd-Gz
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:48:32 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:17065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1ds69b-0003Zm-89
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:48:27 -0400
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id v8DBmOuD022158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:48:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v8DBmNTX006195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:48:23 GMT
Received: from ubhmp0007.oracle.com (ubhmp0007.oracle.com [156.151.24.60])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v8DBmMej013811
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:48:23 GMT
Message-ID: <59B91B00.20208@oracle.com>
Date: Wed, 13 Sep 2017 12:48:16 +0100
From: Darren Kenny <darren.kenny@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Q: Report of leaked clusters with qcow2 when disk is
 resized with a live VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

It was observed during some testing of Qemu 2.9 that it appeared that if you
resized a qcow2 block device while the VM is running, that an qemu-img check
would report that there were leaked clusters.

The steps to reproduce are:

- First create the test image:

     # /usr/bin/qemu-img create -f qcow2 test.qcow2 10G
     Formatting 'test.qcow2', fmt=qcow2 size=10737418240 encryption=off
     cluster_size=65536 lazy_refcounts=off refcount_bits=16

     # qemu-img check test.qcow2
     No errors were found on the image.

- Now run a VM based here on Oracle Linux 7, but the disto really isn't
   important here, since the test disk is not even mounted in the VM at this
   point in time:

     # /usr/bin/qemu-kvm \
         -name 'test-vm' \
         -monitor stdio  \
         -drive 
id=drive_image1,if=none,snapshot=on,format=qcow2,file=./ol73-64.qcow2 \
         -device 
virtio-blk-pci,id=image1,drive=drive_image1,bootindex=0,bus=pci.0,addr=0x4 \
         -drive id=drive_test,if=none,format=qcow2,file=./stg.qcow2 \
         -device 
virtio-blk-pci,id=stg,drive=drive_test,bootindex=1,serial=TARGET_DISK0,bus=pci.0,addr=0x5 
\
         -net bridge,br=br1 -net 
nic,model=virtio,macaddr=52:54:00:90:91:92 \
         -m 4096  \
         -smp 2,maxcpus=2,cores=1,threads=1,sockets=2  \
         -vnc :0

- Resize the img size to 15g from qemu monitor (on stdio after above 
command)

     QEMU 2.5.0 monitor - type 'help' for more information
     (qemu) block_resize drive_test 15360

- Now, in a separate terminal, while leaving the VM running, check the img
   again from host side:

     # qemu-img check ./test.qcow2
     Leaked cluster 3 refcount=1 reference=0

     1 leaked clusters were found on the image.
     This means waste of disk space, but no harm to data.
     Image end offset: 327680

As it suggests above, this is not really corruption, but it is a bit
misleading, and could make people think there is an issue here
(hence the reason I've been asked to find a fix).

What I observed, then was that if I powered down the VM, or even just 
quit the
VM, that the subsequent check of the disk would say that everything was just
fine, and there no longer were leaked clusters.

In looking at the code in qcow2_truncate() it would appear that in the case
where prealloc has the value PREALLOC_MODE_OFF, that we don't flush the
metadata to disk - which seems to be the case here.

If I ignore the if test, and always execute the block in block/qcow2.c,
lines 3250 to 3258:

   if (prealloc != PREALLOC_MODE_OFF) {
       /* Flush metadata before actually changing the image size */
       ret = bdrv_flush(bs);
       if (ret < 0) {
           error_setg_errno(errp, -ret,
                            "Failed to flush the preallocated area to 
disk");
           return ret;
       }
   }

causing the flush to always be done, then the check will succeed when the VM
is still running.

While I know that this resolves the issue, I can only imagine that there was
some reason that this check for !PREALLOC_MODE_OFF was being done in the
first place.

So, I'm hoping that someone here might be able to explain to me why that 
check
is needed, but also why it might be wrong to do the flush regardless of the
value of prealloc here.

If it is wrong to do that flush here, then would anyone have suggestions 
as to
an alternative solution to this issue?

Thanks,

Darren.
