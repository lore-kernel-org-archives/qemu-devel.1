Received: from eggs.gnu.org ([2001:4830:134:3::10]:43230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceQi4-0002Z6-VM
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceQi3-0007e6-Su
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:23:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170216175251.GJ4869@noname.redhat.com>
References: <20170203195037.4238-1-nirsof@gmail.com>
	<20170216175251.GJ4869@noname.redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Thu, 16 Feb 2017 20:23:13 +0200
Message-ID: <CAMr-obsQExOZmpiieJt33v+x1TW4axV6+7YyfatEqngocF5Djw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Do not truncate before
 preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, Feb 16, 2017 at 7:52 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 03.02.2017 um 20:50 hat Nir Soffer geschrieben:
>> When using file system that does not support fallocate() (e.g. NFS <
>> 4.2), truncating the file only when preallocation=OFF speeds up creating
>> raw file.
>>
>> Here is example run, tested on Fedora 24 machine, creating raw file on
>> NFS version 3 server.
>>
>> $ time ./qemu-img-master create -f raw -o preallocation=falloc mnt/test 1g
>> Formatting 'mnt/test', fmt=raw size=1073741824 preallocation=falloc
>>
>> real  0m21.185s
>> user  0m0.022s
>> sys   0m0.574s
>>
>> $ time ./qemu-img-fix create -f raw -o preallocation=falloc mnt/test 1g
>> Formatting 'mnt/test', fmt=raw size=1073741824 preallocation=falloc
>>
>> real  0m11.601s
>> user  0m0.016s
>> sys   0m0.525s
>>
>> $ time dd if=/dev/zero of=mnt/test bs=1M count=1024 oflag=direct
>> 1024+0 records in
>> 1024+0 records out
>> 1073741824 bytes (1.1 GB, 1.0 GiB) copied, 15.6627 s, 68.6 MB/s
>>
>> real  0m16.104s
>> user  0m0.009s
>> sys   0m0.220s
>>
>> Running with strace we can see that without this change we do one
>> pread() and one pwrite() for each block. With this change, we do only
>> one pwrite() per block.
>>
>> $ strace ./qemu-img-master create -f raw -o preallocation=falloc mnt/test 8192
>> ...
>> pread64(9, "\0", 1, 4095)               = 1
>> pwrite64(9, "\0", 1, 4095)              = 1
>> pread64(9, "\0", 1, 8191)               = 1
>> pwrite64(9, "\0", 1, 8191)              = 1
>>
>> $ strace ./qemu-img-fix create -f raw -o preallocation=falloc mnt/test 8192
>> ...
>> pwrite64(9, "\0", 1, 4095)              = 1
>> pwrite64(9, "\0", 1, 8191)              = 1
>>
>> This happens because posix_fallocate is checking if each block is
>> allocated before writing a byte to the block, and when truncating the
>> file before preallocation, all blocks are unallocated.
>>
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>
> Thanks, applied to the block branch.
>
> I'm not completely sure if doing an ftruncate() first couldn't improve
> PREALLOC_MODE_FULL somewhat in some cases, but I agree that the patch
> should still result in correct images.

Good point, I'll do some tests with full mode to check this.

Do you know which cases can benefit from ftruncate() before full preallocation?

Nir
