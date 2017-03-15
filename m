Received: from eggs.gnu.org ([2001:4830:134:3::10]:45967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cnyg9-0002Zz-JV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 22:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cnyg8-0005iS-FK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 22:28:45 -0400
MIME-Version: 1.0
In-Reply-To: <420d9095-bde2-6573-e883-ab6b57d4a860@redhat.com>
References: <1489478243-10366-1-git-send-email-jemmy858585@gmail.com>
	<420d9095-bde2-6573-e883-ab6b57d4a860@redhat.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 15 Mar 2017 10:28:40 +0800
Message-ID: <CAOGPPbcD67Xt1qkCD070QZxf5hp-jVtL9agN=DLLsOP4itgkhg@mail.gmail.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: stefanha@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Tue, Mar 14, 2017 at 11:12 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/14/2017 02:57 AM, jemmy858585@gmail.com wrote:
>> From: Lidong Chen <jemmy858585@gmail.com>
>>
>> Increase bmds->cur_dirty after submit io, so reduce the frequency involve into blk_drain, and improve the performance obviously when block migration.
>
> Long line; please wrap your commit messages, preferably around 70 bytes
> since 'git log' displays them indented, and it is still nice to read
> them in an 80-column window.
>
> Do you have benchmark numbers to prove the impact of this patch, or even
> a formula for reproducing the benchmark testing?
>

the test result is base on current git master version.

the xml of guest os:
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2' cache='none'/>
      <source file='/instanceimage/ab3ba978-c7a3-463d-a1d0-48649fb7df00/ab3ba978-c7a3-463d-a1d0-48649fb7df00_vda.qcow2'/>
      <target dev='vda' bus='virtio'/>
      <alias name='virtio-disk0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
function='0x0'/>
    </disk>
    <disk type='block' device='disk'>
      <driver name='qemu' type='raw' cache='none' io='native'/>
      <source dev='/dev/domu/ab3ba978-c7a3-463d-a1d0-48649fb7df00_vdb'/>
      <target dev='vdb' bus='virtio'/>
      <alias name='virtio-disk1'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x05'
function='0x0'/>
    </disk>

i used fio running in guest os.  and the context of  fio configuration is below:
[randwrite]
ioengine=libaio
iodepth=128
bs=512
filename=/dev/vdb
rw=randwrite
direct=1

when the vm is not durning migrate, the iops is about 10.7K.

then i used this command to start migrate virtual machine.

virsh migrate-setspeed ab3ba978-c7a3-463d-a1d0-48649fb7df00 1000
virsh migrate --live ab3ba978-c7a3-463d-a1d0-48649fb7df00
--copy-storage-inc qemu+ssh://10.59.163.38/system

before apply this patch, during the block dirty save phase, the iops
in guest os is  only 4.0K, the migrate speed is about 505856 rsec/s.
after apply this patch, during the block dirty save phase, the iops in
guest os is is 9.5K. the migrate speed is about 855756 rsec/s.

with old version qemu(1.2.0), call bdrv_drain_all function to wait aio
complete, before apply this patch, the result is worse.
because the main thread is block by bdrv_drain_all for a long time,
the vnc is becoming response very slowly.
this bug is only obvious when set the migrate speed with a big number.

>>
>> Signed-off-by: Lidong Chen <jemmy858585@gmail.com>
>> ---
>>  migration/block.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/migration/block.c b/migration/block.c
>> index 6741228..f059cca 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -576,6 +576,8 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
>>              }
>>
>>              bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, sector, nr_sectors);
>> +            sector += nr_sectors;
>> +            bmds->cur_dirty = sector;
>>              break;
>>          }
>>          sector += BDRV_SECTORS_PER_DIRTY_CHUNK;
>>
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
