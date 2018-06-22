Received: from eggs.gnu.org ([2001:4830:134:3::10]:50508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWSMa-0001Oe-0Y
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWSMZ-0002TA-1b
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:08:55 -0400
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<2c62e570-7f4b-9120-0203-2122edb8b1e3@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <27d07ae8-c689-1949-a457-2bcfd5ae8db1@redhat.com>
Date: Fri, 22 Jun 2018 22:08:39 +0200
MIME-Version: 1.0
In-Reply-To: <2c62e570-7f4b-9120-0203-2122edb8b1e3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] request a revert for "block: Remove
 deprecated -drive option serial" (was block: Remove deprecated -drive
 option serial)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: Boris Fiuczynski <fiuczy@linux.ibm.com>, libvir-list@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 22.06.2018 14:51, Christian Borntraeger wrote:
> adding more CC.
> 
> On 06/22/2018 01:38 PM, Christian Borntraeger wrote:
>>
>> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
>>> The -drive option serial was deprecated in QEMU 2.10. It's time to
>>> remove it.
>>>
>>> Tests need to be updated to set the serial number with -global instead
>>> of using the -drive option.
>>
>> libvirt 4.5 still creates those (at least on s390x)
>>
>>     <disk type='file' device='disk'>
>>       <driver name='qemu' type='qcow2' cache='none' io='native' iothread='1'/>
>>       <source file='/var/lib/libvirt/qemu/image.zhyp137'/>
>>       <target dev='hda' bus='virtio'/>
>>       <serial>skel</serial>
>>       <boot order='1'/>
>>       <address type='ccw' cssid='0xfe' ssid='0x0' devno='0x0000'/>
>>     </disk>
>> -> 
>> [...]
>> -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native -device virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0000,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on 
>> [...]
>>
>> 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native: Block format 'qcow2' does not support the option 'serial'
>> 2018-06-22 11:25:21.098+0000: shutting down, reason=failed
>>
>> So it seems that this breaks s390x.

I wonder why nobody noticed the deprecation messages before?

> So what about reverting commit b0083267444a5e0f28391f6c2831a539f878d424
> "block: Remove deprecated -drive option serial" and redo the removal in
> qemu 3.1 (or 3.2) ?
> Even if we fix libvirt today, this is certainly a too short period of 
> time to get things fixed in the field.

Agreed, reverting that commit is likely the best thing we can do right
now, and then kill it in a later QEMU release. Note that you also need
to revert 6266e900b8083945cb766b45c124fb3c42932cb3 first.

 Thomas
