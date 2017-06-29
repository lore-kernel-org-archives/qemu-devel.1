Received: from eggs.gnu.org ([2001:4830:134:3::10]:59868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQhF7-0002Rv-Vl
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dQhF7-0003Bu-5d
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:44:54 -0400
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
	<20170606162652.112122-2-vsementsov@virtuozzo.com>
	<33cfc00b-1f19-6938-44a2-e2e08ea150e1@redhat.com>
	<5aa5283a-0a2a-7069-ec2a-3bb7f213c106@virtuozzo.com>
	<bee4ba0e-444a-3c88-5d2c-f978f2ef9ad9@redhat.com>
	<e3d7021b-4c71-50ea-87d3-66de1709161a@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f0927df1-cc55-3fdf-4afb-6c6906ebe053@redhat.com>
Date: Thu, 29 Jun 2017 17:44:45 -0400
MIME-Version: 1.0
In-Reply-To: <e3d7021b-4c71-50ea-87d3-66de1709161a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/3] block: add
 bdrv_get_format_alloc_stat format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com


On 06/29/2017 02:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> 29.06.2017 03:15, John Snow wrote:
>>
>> Alright, let me see if I have this straight...
>>
>> used-data: Normal data. We are standing on terra-firma.
>> used-zero: Data that is defined to be zeroes in some way.
>>
>> (Does not necessarily include data clusters if they were not actually
>> zeroed out, I think. May not include regions that ARE zero, even if they
>> are literally zero, because the driver may not especially recognize them
>> as such. Anything marked as zero will DEFINITELY be zero, though. Yes?)
>>
>> used-discarded: I'm not actually sure in this case.
>>
>> used-overrun: Data that is defined to exist, but appears to fall outside
>> of or beyond EOF. Appears to happen with qcow2 metadata before any
>> writes occur.
>>
>> unused-data: Normal data, but not in-use by the schema anywhere. Leaked
>> clusters and the like, effectively.
>>
>> unused-zero: Similar to the above, but definitely zeroes.
>>
>> unused-discarded: Not really sure.
> 
> yes, something like this. again, -data, -zero and -discarded are just
> corresponding to return value of bdrv_get_block_status(bs->file),
> 
> if status & BDRV_BLOCK_DATA
>    it is  -data
> else if status & BDRV_BLOCK_ZERO
>    it is -zero (should be holes for raw)
> else
>    it is -discarded (impossible for raw)
> end
> 

Understood, but I was not too clear on the exact nature of block status,
so I needed to clarify. I'm a lot clearer now, thanks.
