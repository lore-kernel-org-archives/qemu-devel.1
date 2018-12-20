Received: from eggs.gnu.org ([2001:4830:134:3::10]:39337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ga5KE-0005IT-O8
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ga5KD-0001YK-UL
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:53:46 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-12-jsnow@redhat.com>
	<36691b89-1f25-2c82-3009-e86fff587f6c@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f380e46d-4d94-5590-badd-683b52d1bb45@redhat.com>
Date: Thu, 20 Dec 2018 15:53:38 -0500
MIME-Version: 1.0
In-Reply-To: <36691b89-1f25-2c82-3009-e86fff587f6c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 11/11] iotests: add iotest 236 for
 testing bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/20/18 7:12 AM, Vladimir Sementsov-Ogievskiy wrote:
> 20.12.2018 5:29, John Snow wrote:
>> New interface, new smoke test.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
> 
> [...]
> 
>> +    # A: 7 clusters
>> +    # B: 4 clusters
>> +    # C: 6 clusters
>> +    log(query_bitmaps(vm), indent=2)
>> +
>> +    log('\n--- Submitting Bad Merge ---\n')
> 
> aha, spent some time, trying to understand, what is bad with merge, until understand that
> that is abort. I didn't sleep enough last night, but anyway, 'Aborting Merge Transaction'
> is a bit clearer, I think.
> 

Sure, I'll rephrase it: "Submitting & Aborting Merge Transaction"

>> +    vm.qmp_log("transaction", indent=2, actions=[
>> +        { "type": "block-dirty-bitmap-add",
>> +          "data": { "node": "drive0", "name": "bitmapD",
>> +                    "disabled": True, "granularity": granularity }},
>> +        { "type": "block-dirty-bitmap-merge",
>> +          "data": { "node": "drive0", "target": "bitmapD",
>> +                    "bitmaps": ["bitmapB", "bitmapC"] }},
>> +        { "type": "abort", "data": {}}
>> +    ])
>> +    log(query_bitmaps(vm), indent=2)
>> +
>> +    log('\n--- Creating D as a merge of B & C ---\n')
>> +    # Good hygiene: create a disabled bitmap as a merge target.
>> +    vm.qmp_log("transaction", indent=2, actions=[
>> +        { "type": "block-dirty-bitmap-add",
>> +          "data": { "node": "drive0", "name": "bitmapD",
>> +                    "disabled": True, "granularity": granularity }},
>> +        { "type": "block-dirty-bitmap-merge",
>> +          "data": { "node": "drive0", "target": "bitmapD",
>> +                    "bitmaps": ["bitmapB", "bitmapC"] }}
>> +    ])
>> +
>> +    # A and D should now both have 7 clusters apiece.
>> +    # B and C remain unchanged with 4 and 6 respectively.
>> +    log(query_bitmaps(vm), indent=2)
>> +
>> +    # A and D should be equivalent.
>> +    # Some formats round the size of the disk, so don't print the checksums.
> 
> Just interested: round 64M? to what?
> 

VPC does weird stuff. If you ask for 64M you get 64M+16K. "round" is
maybe a bad adjective here, but VPC really won't give you what you ask
for. Loosening the restriction to "generic" was a good idea.

>> +    check_a = vm.qmp('x-debug-block-dirty-bitmap-sha256',
>> +                     node="drive0", name="bitmapA")['return']['sha256']
>> +    check_b = vm.qmp('x-debug-block-dirty-bitmap-sha256',
>> +                     node="drive0", name="bitmapD")['return']['sha256']
>> +    assert(check_a == check_b)
> 
> hmm, a funny suggestion: s/check_b/check_d/

Oh, yes, that would be better.

> 
>> +
>> +    log('\n--- Removing bitmaps A, B, C, and D ---\n')
> 
> what about failed transaction with remove command, for a full kit?
> 

Remove isn't transactionable!

>> +    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="bitmapA")
>> +    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="bitmapB")
>> +    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="bitmapC")
>> +    vm.qmp_log("block-dirty-bitmap-remove", node="drive0", name="bitmapD")
>> +
>> +    log('\n--- Final Query ---\n')
>> +    log(query_bitmaps(vm), indent=2)
>> +
>> +    log('\n--- Done ---\n')
>> +    vm.shutdown()
> 
> 
> with or without any of my suggestions:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

Thanks!

--js
