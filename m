Received: from eggs.gnu.org ([2001:4830:134:3::10]:33394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dG5xP-0004h2-Na
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dG5xL-0007PM-R5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:54:47 -0400
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <a3ee5a6d-b16f-c4fd-b66e-da80d06f30a9@virtuozzo.com>
Date: Wed, 31 May 2017 18:54:33 +0300
MIME-Version: 1.0
In-Reply-To: <5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com

On 31.05.2017 18:03, Eric Blake wrote:
> On 05/31/2017 09:43 AM, Pavel Butsykin wrote:
>> This patch adds the reduction of the image file for qcow2. As a result, this
>> allows us to reduce the virtual image size and free up space on the disk without
>> copying the image. Image can be fragmented and reduction is done by punching
>> holes in the image file.
>>
>> # ./qemu-img create -f qcow2 -o size=4G image.qcow2
>> Formatting 'image.qcow2', fmt=qcow2 size=4294967296 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
>>
>> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
> 
> So this is 1G of guest-visible data...
> 
>> # ./qemu-img resize image.qcow2 128M
>> Image resized.
> 
> ...and you are truncating the image by throwing away guest-visible
> content, with no warning or double-checking (such as requiring a -f
> force parameter or something) about the data loss.  Shrinking images is
> something we should allow, but it feels like is a rare enough operation
> that you don't want it to be casually easy to throw away data.

It is assumed that the user has already made a preparatory with the
image:
1. freeing space at the end of the image
2. reducing the last partition on the disk
3. rebuilding fs
Only after these steps, the user can reduce the image by qemu-img.

I think it's not so rare case, sometimes people run out of disk space 
and this is another way to solve the problem (along with the use of
trim).

We already have all the interfaces, left them only to support :)

> Is it feasible to require that a shrink operation will not be performed
> unless all clusters being eliminated have been previously discarded (or
> maybe written to zero), as an assurance that the guest did not care
> about the tail of the image?
> 

Yes.

# ./qemu-img create -f qcow2 -o size=4G image.qcow2

# ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
# ./qemu-io -c "write -P 0x22 1G 1G" image.qcow2

# qemu-img map ./image.qcow2
Offset          Length          Mapped to       File
0               0x20000000      0x50000         ./image.qcow2
0x20000000      0x20000000      0x20060000      ./image.qcow2
0x40000000      0x20000000      0x40070000      ./image.qcow2
0x60000000      0x20000000      0x60080000      ./image.qcow2

# ./qemu-io -c "discard 1G 1G" ./image.qcow2

# qemu-img map ./image.qcow2
Offset          Length          Mapped to       File0 
0x20000000      0x50000         ./image.qcow2
0x20000000      0x20000000      0x20060000      ./image.qcow2
