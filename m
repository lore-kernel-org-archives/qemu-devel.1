Received: from eggs.gnu.org ([2001:4830:134:3::10]:48354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fWLX9-0001PO-5Y
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fWLX4-0001wc-8D
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:51:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52030
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fWLX4-0001vy-2d
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:51:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5MCmsVZ133310
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:51:17 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2js0vq9eqw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:51:16 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Jun 2018 13:51:15 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
Date: Fri, 22 Jun 2018 14:51:10 +0200
MIME-Version: 1.0
In-Reply-To: <7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
Content-Language: en-US
Message-Id: <2c62e570-7f4b-9120-0203-2122edb8b1e3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] request a revert for "block: Remove deprecated -drive
 option serial" (was block: Remove deprecated -drive option serial)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Boris Fiuczynski <fiuczy@linux.ibm.com>, libvir-list@redhat.com, qemu-s390x <qemu-s390x@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>

adding more CC.

On 06/22/2018 01:38 PM, Christian Borntraeger wrote:
> 
> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
>> The -drive option serial was deprecated in QEMU 2.10. It's time to
>> remove it.
>>
>> Tests need to be updated to set the serial number with -global instead
>> of using the -drive option.
> 
> libvirt 4.5 still creates those (at least on s390x)
> 
>     <disk type='file' device='disk'>
>       <driver name='qemu' type='qcow2' cache='none' io='native' iothread='1'/>
>       <source file='/var/lib/libvirt/qemu/image.zhyp137'/>
>       <target dev='hda' bus='virtio'/>
>       <serial>skel</serial>
>       <boot order='1'/>
>       <address type='ccw' cssid='0xfe' ssid='0x0' devno='0x0000'/>
>     </disk>
> 
> 
> -> 
> [...]
> -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native -device virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0000,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on 
> [...]
> 
> 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native: Block format 'qcow2' does not support the option 'serial'
> 2018-06-22 11:25:21.098+0000: shutting down, reason=failed
> 
> So it seems that this breaks s390x.

So what about reverting commit b0083267444a5e0f28391f6c2831a539f878d424
"block: Remove deprecated -drive option serial" and redo the removal in
qemu 3.1 (or 3.2) ?
Even if we fix libvirt today, this is certainly a too short period of 
time to get things fixed in the field.
