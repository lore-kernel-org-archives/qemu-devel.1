Received: from eggs.gnu.org ([2001:4830:134:3::10]:51872)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eFLVx-0003ZT-EF
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eFLVu-0006CE-6t
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:51:37 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:44398 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eFLVt-0006Aq-TQ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 09:51:34 -0500
References: <20171115115246.GA1955@redhat.com>
	<20171116144746.GE29106@stefanha-x1.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <4ddf423b-a713-8f8b-e7dc-c970ad206885@kamp.de>
Date: Thu, 16 Nov 2017 15:51:29 +0100
MIME-Version: 1.0
In-Reply-To: <20171116144746.GE29106@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Effect of qemu-img convert -m and -W options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: libguestfs@redhat.com, qemu-devel@nongnu.org

Am 16.11.2017 um 15:47 schrieb Stefan Hajnoczi:
> On Wed, Nov 15, 2017 at 11:52:46AM +0000, Richard W.M. Jones wrote:
>> [CC to qemu-devel since I'm obviously doing something wrong here,
>> I'm just not sure what.]
>>
>> I was getting ready to add multiple threads to ‘qemu-img convert’ (the
>> longest part of v2v conversions) when I noticed that it had them
>> already!  (To be fair this was only added in February this year so no
>> wonder we didn't notice.)
>>
>> To enable parallel convert we would need to use the ‘qemu-img convert
>> -W’ option (which allows out-of-order writes to the destination) and
>> ‘qemu-img convert -m <#num-coroutines>’ option to select the
>> parallelism (defaults to 8).  The documentation refers to coroutines
>> but I verified from strace that it is using real threads.
> The threads you observed are the thread pool that performs
> preadv(2)/pwritev(2) syscalls.  The Linux AIO API could be used instead
> and does not use threads for read and write operations.  So these
> threads are just an implementation detail.  The caller doing the reads
> and writes is not multi-threaded but a number of coroutines executing in
> a single thread.
>
> The qemu-img convert logic runs in coroutines from just one main loop
> thread in qemu-img.c:convert_do_copy():
>
>    for (i = 0; i < s->num_coroutines; i++) {
>        s->co[i] = qemu_coroutine_create(convert_co_do_copy, s);
>        s->wait_sector_num[i] = -1;
>        qemu_coroutine_enter(s->co[i]);
>    }
>
>    while (s->running_coroutines) {
>        main_loop_wait(false);
>    }
>
>> I did some testing to see what effect this has.  For this I used a
>> large guest image which is approximately a third full of random data
>> (the rest being sparsely allocated):
>>
>>    Source format:       raw
>>    Source virtual size: 100 GB
>>    Source used space:   31 GB
>>    Target format:       qcow2
>>    Version:             qemu-img-2.10.0-7.fc28.x86_64
>>    Conversion command:
>>      rm -f /to/target
>>      time qemu-img convert [-W] [-m ##] -f raw source.img -O qcow2 /to/target
>>
>> Source and target are regular files on two different disks.  The test
>> machine is a Xeon E5 with 16 real cores.
>>
>> ----------------------------------------------------------------------
>>                    Non-preallocated output
>>                    (times are in seconds)
>>                     without -W       -W
>>
>> -m 1                153              -
>>
>> -m 4                155             157
>>
>> -m 8 [default]      158             231
>>
>> -m 16 [max]         166             166
>> ----------------------------------------------------------------------
>>
>> The documentation for ‘-W’ notes that this is only recommended for
>> preallocated outputs (which the test above does not use).  So let's
>> try using a preallocated qcow2 output.
>>
>>    Conversion command:
>>      # the same target file is reused each time
>>      time qemu-img convert -n [-W] [-m ##] -f raw source.img -O qcow2 /to/target
>>
>> ----------------------------------------------------------------------
>>                     Preallocated output
>>                    (times are in seconds)
>>                     without -W       -W
>>
>> -m 1                147              -
>>
>> -m 4                146             145
>>
>> -m 8 [default]      146             199
>>
>> -m 16 [max]         147             146
>> ----------------------------------------------------------------------
>>
>> Based on this there seems to be some issue with the ‘-W’ option -- I
>> even thought I might have it backwards, but checking the code it does
>> seem like ‘-W’ enables (rather than disables) out of order writes.
>> Also some bizarre interaction between ‘-W’ and ‘-m 8’.
> Interesting.  Did you perform multiple runs of each setting to verify
> that the benchmark results are stable with little volatility?
>
> Which command-line did you use to create the preallocated qcow2 file?
>
> Are the source and target files on the same file system and host block
> device?  The benefit of using multiple coroutines depends on the
> performance characteristics of the source and target files.
>
> I don't think this qemu-img convert mode has been heavily tested, so it
> wouldn't be surprising if you encounter unexpected behavior.  Hopefully
> it can be fixed to get even better performance.

The scenario where I tested this patch was with reading a QCOW2
from an NFS (with libnfs) and writing to a RAW iSCSI Target (with libiscsi).
Both having no cache on the local host.

Afaik all writes to the same QCOW2 serialize because of the s->lock that
is held during the write. So its not suprising that there is no benefit from
mutliple threads as long as reading from the RAW file involves no delay.
Which is likely due to readahead of the OS.

Peter
