Received: from eggs.gnu.org ([2001:4830:134:3::10]:49372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dClxV-0001z3-EF
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dClxS-0000FT-CG
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:57:09 -0400
References: <1495376506-13227-1-git-send-email-den@openvz.org>
	<705cdc34-b45d-5f56-3fb2-f8a67c4d2b9f@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <8d854387-01fc-1f36-7452-7e9cc3cdbcc2@openvz.org>
Date: Mon, 22 May 2017 14:56:55 +0300
MIME-Version: 1.0
In-Reply-To: <705cdc34-b45d-5f56-3fb2-f8a67c4d2b9f@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] qcow2: handle cluster leak happening
 with a guest TRIM command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 05/22/2017 02:37 PM, Eric Blake wrote:
> On 05/21/2017 09:21 AM, Denis V. Lunev wrote:
>>   qemu-img create -f qcow2 1.img 64G
>>   qemu-io -c "write -P 0x32 0 64k" 1.img
>> results in
>>   324 -rw-r--r-- 1 den den 393216 May 21 16:48 1.img
>> Subsequent
>>   qemu-io -c "write -z 0 64k" 1.img
>>   qemu-io -c "write -P 0x32 0 64k" 1.img
>> results in
>>   388 -rw-r--r-- 1 den den 458752 May 21 16:50 1.img
>> which looks like we have 1 cluster leaked.
>>
>> Indeed, qcow2_co_pwrite_zeroes calls qcow2_zero_clusters/zero_single_l=
2,
>> which does not update refcount for the host cluster and keep the offse=
t
>> as used. Later on handle_copied() does not take into account
>> QCOW2_CLUSTER_ZERO type of the cluster.
> NACK.  We've already fixed this upstream, at commit 564a6b693.
My bad. I am updating sources too infrequently :(

> $ ./qemu-img create -f qcow2 1.img 64g
> Formatting '1.img', fmt=3Dqcow2 size=3D68719476736 encryption=3Doff
> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> $ ./qemu-io -c 'w -P 0x32 0 64k' 1.img
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0410 sec (1.524 MiB/sec and 24.3902 ops/sec)
> $ ls -l 1.img
> -rw-r--r--. 1 eblake eblake 393216 May 22 06:35 1.img
> $ ./qemu-io -c 'w -z 0 64k' 1.img
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0055 sec (11.345 MiB/sec and 181.5211 ops/sec)
> $ ./qemu-io -c 'w -P 0x32 0 64k' 1.img
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0160 sec (3.903 MiB/sec and 62.4415 ops/sec)
> $ ls -l 1.img
> -rw-r--r--. 1 eblake eblake 393216 May 22 06:35 1.img
>
>
> As it is, your patch doesn't apply to master.  And even if it did, your=

> patch breaks semantics - we CANNOT discard clusters that must read back=

> as zeroes.
>
Can you pls give some details why the cluster can not be
discarded? This is something that I can not understand.

At my opinion the cluster is clearly marked with QCOW_OFLAG_ZERO
and thus will be read with zeroes regardless of the content of the
cluster which is pointed by the offset. This is actually what
happens on the FS without PUNCH_HOLE support.

That is why this offset can be actually reused for any other
block, what is I am trying to propose.

Den
