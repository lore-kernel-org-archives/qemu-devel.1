Received: from eggs.gnu.org ([2001:4830:134:3::10]:50321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZhcH-0006xj-Kw
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZhcG-0002OD-Mg
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:34:49 -0500
References: <20181219015230.18652-1-jsnow@redhat.com>
	<20181219015230.18652-6-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bdcee774-5139-894e-634b-924728accb6f@redhat.com>
Date: Wed, 19 Dec 2018 13:34:36 -0600
MIME-Version: 1.0
In-Reply-To: <20181219015230.18652-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/5] iotests: add iotest 236 for testing
 bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 12/18/18 7:52 PM, John Snow wrote:
> New interface, new smoke test.
> ---
>   tests/qemu-iotests/236     | 131 ++++++++++++++++++++++++
>   tests/qemu-iotests/236.out | 198 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 330 insertions(+)
>   create mode 100755 tests/qemu-iotests/236
>   create mode 100644 tests/qemu-iotests/236.out
> 

> +
> +    log('')
> +    log('--- Disabling B & Adding C ---\n')
> +    vm.qmp_log("transaction", indent=2, actions=[
> +        { "type": "block-dirty-bitmap-disable",
> +          "data": { "node": "drive0", "name": "bitmapB" }},
> +        { "type": "block-dirty-bitmap-add",
> +          "data": { "node": "drive0", "name": "bitmapC",
> +                    "granularity": granularity }},
> +        # Purely extraneous, but test that it works:
> +        { "type": "block-dirty-bitmap-disable",
> +          "data": { "node": "drive0", "name": "bitmapC" }},
> +        { "type": "block-dirty-bitmap-enable",
> +          "data": { "node": "drive0", "name": "bitmapC" }},
> +    ])

One other possible addition just before this point:

qmp_log("transaction", indent=2, actions=[
         { "type": "block-dirty-bitmap-disable",
           "data": { "node": "drive0", "name": "bitmapB" }},
         { "type": "block-dirty-bitmap-add",
           "data": { "node": "drive0", "name": "bitmapC",
                     "granularity": granularity }},
         { "type": "block-dirty-bitmap-remove",
           "data": { "node": "drive0", "name": "bitmapA" }},
         { "type": "abort", "data": {}}
   ])

to check that we properly undo things on an aborted transaction (B 
should still be enabled, C should not exist, and A should not be damaged).

> +    # A and D should be equivalent.
> +    # Some formats round the size of the disk, so don't print the checksums.
> +    check_a = vm.qmp('x-debug-block-dirty-bitmap-sha256',
> +                     node="drive0", name="bitmapA")['return']['sha256']
> +    check_b = vm.qmp('x-debug-block-dirty-bitmap-sha256',
> +                     node="drive0", name="bitmapD")['return']['sha256']
> +    assert(check_a == check_b)

Image agnostic also means that you avoid an 32- vs. 64-bit platform 
discrepancies (we've had issues in the past where the sum is different 
for some image sizes, because the bitmap is always in terms of 'long's, 
but there is one less 'long' in a 32-bit bitmap for the disk size). 
Makes sense.

Also, I don't see any tests of block-dirty-bitmap-remove - this would be 
a good point in the test to insert a final cleanup.


> +++ b/tests/qemu-iotests/group
> @@ -233,3 +233,4 @@
>   233 auto quick
>   234 auto quick migration
>   235 auto quick
> +236 auto quick
> \ No newline at end of file

Umm - what's that still doing here?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
