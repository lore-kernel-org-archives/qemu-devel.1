Received: from eggs.gnu.org ([2001:4830:134:3::10]:33210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXGip-0006fR-17
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXGin-0000sR-DG
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:27:30 -0500
References: <20181213015013.15350-1-jsnow@redhat.com>
	<20181213015013.15350-8-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c7b8bbe-6f63-ed65-61c4-dbbae5f07d07@redhat.com>
Date: Wed, 12 Dec 2018 20:27:08 -0600
MIME-Version: 1.0
In-Reply-To: <20181213015013.15350-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/7] iotests: add iotest 236 for testing
 bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 12/12/18 7:50 PM, John Snow wrote:
> New interface, new smoke test.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/236     | 123 +++++++++++++++++
>   tests/qemu-iotests/236.out | 265 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 389 insertions(+)
>   create mode 100755 tests/qemu-iotests/236
>   create mode 100644 tests/qemu-iotests/236.out
> 
> diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236

> +    log('')
> +    log('--- Disabling B & Adding C ---\n')
> +    vm.qmp_log("transaction", actions=[
> +        { "type": "block-dirty-bitmap-disable",
> +          "data": { "node": "drive0", "name": "bitmapB" }},
> +        { "type": "block-dirty-bitmap-add",
> +          "data": { "node": "drive0", "name": "bitmapC" }}
> +    ])

Just for grins, what happens if we extend that transaction to 
additionally call:

        { "type": "block-dirty-bitmap-disable",
          "data": { "node": "drive0", "name": "bitmapC" }},
        { "type": "block-dirty-bitmap-enable",
          "data": { "node": "drive0", "name": "bitmapC" }}

Yes, we have a redundancy where plain '-add' coupled with '-disable' in 
a transaction does the same as '-add' with 'enabled':false.  And I'd 
rather keep 'enabled':false as part of '-add', as it's handy to do that 
without having to code up a transaction.  But the specific act of 
toggling the enabled bit twice on a brand new bitmap as part of the same 
transaction, while unlikely to be done by libvirt, may still prove to be 
a useful validation of our transaction semantics.

> +++ b/tests/qemu-iotests/group
> @@ -233,3 +233,4 @@
>   233 auto quick
>   234 auto quick migration
>   235 auto quick
> +236 auto quick
> \ No newline at end of file

You'll want to fix that.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
