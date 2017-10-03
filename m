Received: from eggs.gnu.org ([2001:4830:134:3::10]:49014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzDjc-0000tZ-OC
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 23:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzDjb-0008VY-OG
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 23:19:04 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-24-eblake@redhat.com>
	<ae5bcf8e-57de-68c2-8a1a-6599f0e5c9ea@redhat.com>
	<47998e8d-69fa-9fa9-7647-efca89c3b98d@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a7952b2a-748f-7b72-e99e-6aab7f5327b4@redhat.com>
Date: Mon, 2 Oct 2017 23:18:58 -0400
MIME-Version: 1.0
In-Reply-To: <47998e8d-69fa-9fa9-7647-efca89c3b98d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 23/23] qemu-io: Relax 'alloc' now that
 block-status doesn't assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 10/02/2017 07:56 PM, Eric Blake wrote:
> On 10/02/2017 04:27 PM, John Snow wrote:
>>
>>
>> On 09/13/2017 12:03 PM, Eric Blake wrote:
>>> Previously, the alloc command required that input parameters be
>>> sector-aligned and clamped to 32 bits, because the underlying
>>> bdrv_is_allocated used a 32-bit parameter and asserted aligned
>>> inputs.  But now that we have fixed block status to report a
>>> 64-bit bytes value, and to properly round requests on behalf of
>>> guests, we can pass any values, and can use qemu-io to add
>>> coverage that our rounding is correct regardless of the guest
>>> alignment constraints.
>>>
>>> Update iotest 177 to intentionally probe block status at
>>> unaligned boundaries as well as with a bytes value that does not
>>> map to 32-bit sectors, which also required tweaking the image
>>> prep to leave an unallocated portion to the image under test.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
> 
>>>  echo
>>> +echo "== block status smaller than alignment =="
>>> +limits=align=4k
>>> +$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
>>> +	 -c "alloc 1 1" -c "alloc 0x6dffff0 1000" -c "alloc 127m 5P" \
>>> +	 -c map | _filter_qemu_io
>>> +
> 
>>
>> aaand I'll hold off on this one until the respin so I don't have to
>> review the test twice.
> 
> Fair enough; thanks for the reviews.
> 
> By the way, it's operations like the above additions where you can step
> through bdrv_co_block_status in gdb to see all the rounding/alignment
> steps in action, so I do feel pretty confident that my changes in 21/23
> were fairly well covered.
> 

I do actually trust you, but I wasn't able to *quickly* convince myself,
so I held up on the r-b. I didn't spot any problems either, to be fair...!

>>
>> I'll say I'm done for v4 for now :)
> 
> I'll try to get v5 posted in the next day or two.
> 

No rush on my end ...

--js
