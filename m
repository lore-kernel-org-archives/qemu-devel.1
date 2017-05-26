Received: from eggs.gnu.org ([2001:4830:134:3::10]:33465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dEEf2-0001JF-Nz
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dEEf1-0005OF-Hp
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:48:08 -0400
References: <cover.1495536228.git.berto@igalia.com>
	<142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
	<w51shjutjz7.fsf@maestria.local.igalia.com>
	<0e3fc298-d47b-4066-c8c8-02f620c50b89@virtuozzo.com>
	<20170526101727.GF7211@noname.str.redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <cc4efd40-46e8-82c0-10f7-148e84ab477a@virtuozzo.com>
Date: Fri, 26 May 2017 15:47:55 +0300
MIME-Version: 1.0
In-Reply-To: <20170526101727.GF7211@noname.str.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: Reduce the number of I/O ops
 when doing COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>


On 05/26/2017 01:17 PM, Kevin Wolf wrote:
> Am 24.05.2017 um 18:09 hat Anton Nefedov geschrieben:
>> I agree; as mentioned we have similar patches and they don't conflict much.
>> We noticed a performance regression on HDD though, for the
>> presumably optimized case (random 4k write over a large backed
>> image); so the patches were put on hold.
> 
> You're talking about your own patches that should do the same thing,
> right? Can you re-do the same test with Berto's patches? Maybe there was
> just an implementation glitch in yours.
> 
> This approach should very obviously result in a performance improvement,
> and the patches are relatively simple, so I'm very much inclined to
> merge this as soon as possible.
> 
> Kevin
> 


Tried the another machine; about 10% improvement here

[root@dpclient centos-7.3-x86_64]# qemu-img info ./harddisk2.hdd
image: ./harddisk2.hdd
file format: qcow2
virtual size: 2.0G (2147483648 bytes)
disk size: 260K
cluster_size: 65536
backing file: harddisk2.hdd.base (actual path: ./harddisk2.hdd.base)
Format specific information:
compat: 1.1
lazy refcounts: false
refcount bits: 16
corrupt: false
[root@dpclient centos-7.3-x86_64]# qemu-img info ./harddisk2.hdd.base
image: ./harddisk2.hdd.base
file format: qcow2
virtual size: 2.0G (2147483648 bytes)
disk size: 2.0G
cluster_size: 65536
Format specific information:
compat: 1.1
lazy refcounts: true
refcount bits: 16
corrupt: false
[root@dpclient centos-7.3-x86_64]# filefrag ./harddisk2.hdd.base
./harddisk2.hdd.base: 3 extents found


[root@localhost ~]# fio --name=randwrite --blocksize=4k
--filename=/dev/sdb --rw=randwrite --direct=1 --ioengine=libaio
--size=2g --io_size=32m

/* master */
write: io=32768KB, bw=372785B/s, iops=91, runt= 90010msec
/* Berto's patches */
write: io=32768KB, bw=404304B/s, iops=98, runt= 82993msec


/Anton
