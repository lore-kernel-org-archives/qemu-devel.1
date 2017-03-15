Received: from eggs.gnu.org ([2001:4830:134:3::10]:36368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cnzLb-0001cH-PV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cnzLa-0007FV-OY
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:11:35 -0400
MIME-Version: 1.0
In-Reply-To: <20170315025716.GA3088@lemon.lan>
References: <1489478243-10366-1-git-send-email-jemmy858585@gmail.com>
	<420d9095-bde2-6573-e883-ab6b57d4a860@redhat.com>
	<CAOGPPbcD67Xt1qkCD070QZxf5hp-jVtL9agN=DLLsOP4itgkhg@mail.gmail.com>
	<20170315025716.GA3088@lemon.lan>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 15 Mar 2017 11:11:31 +0800
Message-ID: <CAOGPPbe5wZEQatN-ooB7WqQ-0O2cmQNH4ubn=Ax9y7Rr-ZC9Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] migration/block: Avoid involve into
 blk_drain too frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, stefanha@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Wed, Mar 15, 2017 at 10:57 AM, Fam Zheng <famz@redhat.com> wrote:
> On Wed, 03/15 10:28, 858585 jemmy wrote:
>> On Tue, Mar 14, 2017 at 11:12 PM, Eric Blake <eblake@redhat.com> wrote:
>> > On 03/14/2017 02:57 AM, jemmy858585@gmail.com wrote:
>> >> From: Lidong Chen <jemmy858585@gmail.com>
>> >>
>> >> Increase bmds->cur_dirty after submit io, so reduce the frequency involve into blk_drain, and improve the performance obviously when block migration.
>> >
>> > Long line; please wrap your commit messages, preferably around 70 bytes
>> > since 'git log' displays them indented, and it is still nice to read
>> > them in an 80-column window.
>> >
>> > Do you have benchmark numbers to prove the impact of this patch, or even
>> > a formula for reproducing the benchmark testing?
>> >
>>
>> the test result is base on current git master version.
>>
>> the xml of guest os:
>>     <disk type='file' device='disk'>
>>       <driver name='qemu' type='qcow2' cache='none'/>
>>       <source file='/instanceimage/ab3ba978-c7a3-463d-a1d0-48649fb7df00/ab3ba978-c7a3-463d-a1d0-48649fb7df00_vda.qcow2'/>
>>       <target dev='vda' bus='virtio'/>
>>       <alias name='virtio-disk0'/>
>>       <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
>> function='0x0'/>
>>     </disk>
>>     <disk type='block' device='disk'>
>>       <driver name='qemu' type='raw' cache='none' io='native'/>
>>       <source dev='/dev/domu/ab3ba978-c7a3-463d-a1d0-48649fb7df00_vdb'/>
>>       <target dev='vdb' bus='virtio'/>
>>       <alias name='virtio-disk1'/>
>>       <address type='pci' domain='0x0000' bus='0x00' slot='0x05'
>> function='0x0'/>
>>     </disk>
>>
>> i used fio running in guest os.  and the context of  fio configuration is below:
>> [randwrite]
>> ioengine=libaio
>> iodepth=128
>> bs=512
>> filename=/dev/vdb
>> rw=randwrite
>> direct=1
>>
>> when the vm is not durning migrate, the iops is about 10.7K.
>>
>> then i used this command to start migrate virtual machine.
>>
>> virsh migrate-setspeed ab3ba978-c7a3-463d-a1d0-48649fb7df00 1000
>> virsh migrate --live ab3ba978-c7a3-463d-a1d0-48649fb7df00
>> --copy-storage-inc qemu+ssh://10.59.163.38/system
>>
>> before apply this patch, during the block dirty save phase, the iops
>> in guest os is  only 4.0K, the migrate speed is about 505856 rsec/s.
>> after apply this patch, during the block dirty save phase, the iops in
>> guest os is is 9.5K. the migrate speed is about 855756 rsec/s.
>
> Thanks, please include these numbers in the commit message too.
OK, i will.
>
> Fam
