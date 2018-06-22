Received: from eggs.gnu.org ([2001:4830:134:3::10]:45977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fWNDL-0003Ll-3p
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fWNDH-0001fu-Tw
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:39:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fWNDH-0001em-Kc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:38:59 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5MEcsVo075838
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 10:38:58 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2js157wmwy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 10:38:57 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Jun 2018 15:38:54 +0100
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 22 Jun 2018 16:38:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180622142513.GH4366@localhost.localdomain>
Content-Language: en-US
Message-Id: <930d6481-0da2-f5cd-15bf-1f09a8769c76@de.ibm.com>
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



On 06/22/2018 04:25 PM, Kevin Wolf wrote:
> Am 22.06.2018 um 15:36 hat Christian Borntraeger geschrieben:
>>
>>
>> On 06/22/2018 02:55 PM, Kevin Wolf wrote:
>>> Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
>>>>
>>>> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
>>>>> The -drive option serial was deprecated in QEMU 2.10. It's time to
>>>>> remove it.
>>>>>
>>>>> Tests need to be updated to set the serial number with -global instead
>>>>> of using the -drive option.
>>>>
>>>> libvirt 4.5 still creates those (at least on s390x)
>>>>
>>>>     <disk type='file' device='disk'>
>>>>       <driver name='qemu' type='qcow2' cache='none' io='native' iothread='1'/>
>>>>       <source file='/var/lib/libvirt/qemu/image.zhyp137'/>
>>>>       <target dev='hda' bus='virtio'/>
>>>>       <serial>skel</serial>
>>>>       <boot order='1'/>
>>>>       <address type='ccw' cssid='0xfe' ssid='0x0' devno='0x0000'/>
>>>>     </disk>
>>>>
>>>>
>>>> -> 
>>>> [...]
>>>> -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native -device virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0000,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on 
>>>> [...]
>>>>
>>>> 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native: Block format 'qcow2' does not support the option 'serial'
>>>> 2018-06-22 11:25:21.098+0000: shutting down, reason=failed
>>>>
>>>> So it seems that this breaks s390x.
>>
>> To me it seems that this is also broken on x86.
>>>
>>> Thanks for bringing this up. libvirt should fix this before QEMU 3.0 is
>>> released.
>>
>> I think this is definitely too short notice. We should not break existing
>> setups just by insisting that users have to update libvirt when they update
>> QEMU. Yes, this might be our policy, but doing so "just because we can"
>> is certainly a very bad attitude. I see no fundamental technical reason why
>> we should not revert this change.
> 
> This was in fact one release longer than our deprecation policy says.
> Are we serious about the deprecation policy or aren't we?

I think it makes more sense to have 2 releases after everything was fixed
instead of 2 releases after it was announced.

So if everyone has adopted we can certainly follow our deprecation policy.
Now if deprecation breaks some real world cases it makes no sense to
"insist" on that deprecation policy. Really: If latest greatest libvirt
does not work 2 weeks before soft freeze I consider this too late.

Why: This breaks MY regression test setup before softfreeze. So I will stop
testing qemu in the most critical point in time.

If you would come up with your statement (taking deprecation policy more
serious than users) in the Linux kernel I can pretty much guarantee that
Linus would call you names.


> 
> I might consider reverting a change if it turned out that this requires
> some massive work in libvirt. But I think this one should be rather easy
> to fix in libvirt until 3.0 is released.

I have not heard any reason what we gain by removing these features (and no
I dont believe that this increases your maintenance burden a lot). But it
clearly breaks things.

I suggest: revert the removal patches (all of them cyls,secs,serial etc)
and redo them for 3.1.



> 
>>> Sadly, it also shows that deprecation warnings in log files go
>>> unnoticed.
>>
>> In fact whoever added the deprication notice should have followed up
>> with the libvirt team to implement that change. no?
> 
> I expect the libvirt developers to read the QEMU Changelog at least for
> incompatible changes and deprecations. We can't reasonably go and hunt
> for developers for every management tool for QEMU that exists.
> 
> And anyway, if you come across a deprecation warning, that's the time
> you should act, not only when it finally breaks.
> 
> Kevin
> 
