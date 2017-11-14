Received: from eggs.gnu.org ([2001:4830:134:3::10]:52805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEfz7-0001HN-Pn
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eEfz6-0003he-VV
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:30:57 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
	<7ce0d647-14c7-6874-b9d8-606a58c66b6e@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <5216d1a4-84b9-3ae2-0aab-187a12588b17@virtuozzo.com>
Date: Tue, 14 Nov 2017 21:30:44 +0300
MIME-Version: 1.0
In-Reply-To: <7ce0d647-14c7-6874-b9d8-606a58c66b6e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5 for-2.11?] qcow2: reject unaligned
 offsets in write compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com

On 14/11/2017 7:50 PM, Eric Blake wrote:
> On 11/14/2017 04:16 AM, Anton Nefedov wrote:
>> Misaligned compressed write is not supported.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/qcow2.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Should this one be applied in 2.11?
> 

For the record, this one is pretty hard to trigger; backup and qemu-img
convert currently use compressed write, both make sure they operate in
clusters.

qemu-io is almighty though

qemu-io> write -c -P 7 512 64k
wrote 65536/65536 bytes at offset 512
64 KiB, 1 ops; 0.0187 sec (3.329 MiB/sec and 53.2566 ops/sec)
qemu-io> read -P 7 512 64k
Pattern verification failed at offset 512, 65536 bytes
read 65536/65536 bytes at offset 512
64 KiB, 1 ops; 0.0002 sec (248.016 MiB/sec and 3968.2540 ops/sec)
qemu-io> read -P 7 0 64k
read 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0000 sec (1.606 GiB/sec and 26315.7895 ops/sec)

/Anton
