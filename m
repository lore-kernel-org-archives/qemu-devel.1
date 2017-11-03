Received: from eggs.gnu.org ([2001:4830:134:3::10]:54152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAXuT-0002MB-ON
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAXuO-0001ci-6x
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:05:05 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <21c91b89-d4bf-f220-958a-eec02dddc9a4@redhat.com>
References: <cover.1509550787.git.berto@igalia.com>
	<49d365124cf0bffb3fe705678b50b86445d42605.1509550787.git.berto@igalia.com>
	<21c91b89-d4bf-f220-958a-eec02dddc9a4@redhat.com>
Date: Fri, 03 Nov 2017 10:04:55 +0100
Message-ID: <w51d14zbumg.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] qcow2: Prevent allocating refcount
 blocks at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

On Thu 02 Nov 2017 06:28:18 PM CET, Max Reitz wrote:
>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>> index aa3fd6cf17..9059996c4b 100644
>> --- a/block/qcow2-refcount.c
>> +++ b/block/qcow2-refcount.c
>> @@ -367,6 +367,13 @@ static int alloc_refcount_block(BlockDriverState *bs,
>>          return new_block;
>>      }
>>  
>> +    /* If we're allocating the block at offset 0 then something is wrong */
>> +    if (new_block == 0) {
>> +        qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid "
>
> Technically, the offset is 0 and the size is s->cluster_size, but I
> won't insist.

I actually checked the rest of qcow2_signal_corruption() cases in that
file and almost all use -1, -1.

I understand that the problem is not in [0, s->cluster_size] but in the
refcount table/block (the refcount data is wrong). The documentation of
BLOCK_IMAGE_CORRUPTED says:

# @offset: if the corruption resulted from an image access, this is the
#          host's access offset into the image

# @size: if the corruption resulted from an image access, this is the
#        access size

But that's not quite the case here, or is it?

Berto
