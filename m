Received: from eggs.gnu.org ([2001:4830:134:3::10]:35820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fWMcP-00060v-2I
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fWMcM-0003AJ-2Q
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:00:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37384
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fWMcL-0003A4-T6
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:00:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5MDxFN1088180
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 10:00:48 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2js0vqc9sj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 10:00:48 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Jun 2018 15:00:46 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
Date: Fri, 22 Jun 2018 16:00:40 +0200
MIME-Version: 1.0
In-Reply-To: <ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
Content-Language: en-US
Message-Id: <aba2922a-c995-cb75-6036-06e5851d4936@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 25/26] block: Remove deprecated -drive
 option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Boris Fiuczynski <fiuczy@linux.ibm.com>, libvir-list@redhat.com, eblake@redhat.com, pkrempa@redhat.com, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Peter Maydell <peter.maydell@linaro.org>



On 06/22/2018 03:36 PM, Christian Borntraeger wrote:
> 
> 
> On 06/22/2018 02:55 PM, Kevin Wolf wrote:
>> Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
>>>
>>> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
>>>> The -drive option serial was deprecated in QEMU 2.10. It's time to
>>>> remove it.
>>>>
>>>> Tests need to be updated to set the serial number with -global instead
>>>> of using the -drive option.
>>>
>>> libvirt 4.5 still creates those (at least on s390x)
>>>
>>>     <disk type='file' device='disk'>
>>>       <driver name='qemu' type='qcow2' cache='none' io='native' iothread='1'/>
>>>       <source file='/var/lib/libvirt/qemu/image.zhyp137'/>
>>>       <target dev='hda' bus='virtio'/>
>>>       <serial>skel</serial>
>>>       <boot order='1'/>
>>>       <address type='ccw' cssid='0xfe' ssid='0x0' devno='0x0000'/>
>>>     </disk>
>>>
>>>
>>> -> 
>>> [...]
>>> -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native -device virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0000,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on 
>>> [...]
>>>
>>> 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native: Block format 'qcow2' does not support the option 'serial'
>>> 2018-06-22 11:25:21.098+0000: shutting down, reason=failed
>>>
>>> So it seems that this breaks s390x.
> 
> To me it seems that this is also broken on x86.
>>
>> Thanks for bringing this up. libvirt should fix this before QEMU 3.0 is
>> released.
> 
> I think this is definitely too short notice. We should not break existing
> setups just by insisting that users have to update libvirt when they update
> QEMU. Yes, this might be our policy, but doing so "just because we can"
> is certainly a very bad attitude. I see no fundamental technical reason why
> we should not revert this change.
> 
> 
>>
>> Sadly, it also shows that deprecation warnings in log files go
>> unnoticed.
> 
> In fact whoever added the deprication notice should have followed up
> with the libvirt team to implement that change. no?

FWIW cyls, heads, secs and trans also seem to be affected by this.
