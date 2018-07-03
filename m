Received: from eggs.gnu.org ([2001:4830:134:3::10]:37661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa9Ou-0003i9-1P
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 20:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa9Os-0004IM-PR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 20:42:36 -0400
References: <20180702191458.28741-1-eblake@redhat.com>
	<20180702191458.28741-3-eblake@redhat.com>
	<2f27c085-5942-c562-375e-2ed557968ff0@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a18317d-eabb-3405-922a-53220c4152a4@redhat.com>
Date: Mon, 2 Jul 2018 19:42:25 -0500
MIME-Version: 1.0
In-Reply-To: <2f27c085-5942-c562-375e-2ed557968ff0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: New test 223 for exporting
 dirty bitmap over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/02/2018 04:27 PM, John Snow wrote:

>> +{ "execute": "block-dirty-bitmap-add",
>> +  "arguments": {
>> +    "node": "n",
>> +    "name": "b",
> 
> Saving a few precious bytes.

Would "mynode" and "mybitmap" be any friendlier? :)

> 
>> +    "persistent": true
>> +  }
>> +}
>> +{ "execute": "quit" }
>> +EOF
>> +
>> +echo
>> +echo "=== Write part of the file under active bitmap ==="
>> +echo
>> +
>> +$QEMU_IO -c 'w -P 0x22 2M 2M' "$TEST_IMG" | _filter_qemu_io
>> +
> 
> - Write 0x22 to [2M, 4M) recorded by the bitmap.

I debated about playing with smaller writes, since the bitmap tracking 
rounds up to bitmap granularity. But for this test, sticking to aligned 
boundaries seemed easiest (and I think we have other tests of bitmap 
granularities, although I didn't search today).

>> +=== Contrast normal status with dirty-bitmap status ===
>> +
>> +read 1048576/1048576 bytes at offset 0
>> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +read 1048576/1048576 bytes at offset 1048576
>> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +read 2097152/2097152 bytes at offset 2097152
>> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false},
>> +{ "start": 1048576, "length": 3145728, "depth": 0, "zero": false, "data": true}]
> 
> Looks right.

Note for potential future test: discarding a block should also show up 
as a dirty bitmap change, even though it would disappear from the normal 
block status allocated.

> 
> It Works!:
> 
> Tested-by: John Snow <jsnow@redhat.com>
> 
> Tests what it aims to:
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 

Thanks; I'll queue this through my NBD tree and send a pull request in a 
few hours.

> 
> I think the trick will be combining 222 and 223 into one workflow. I
> think we might be missing a piece.
> 
> Consider this:
> 
> - We have some image which has a bitmap 'B' tracking writes since the
> last incremental backup was made or fleeced, using the traditional "one
> bitmap per backup regimen" strategy.
> 
> - We prepare to fleece by creating a new temporary store for fleecing,
> and add the target drive as a backing node.
> 
> At this point, there's no point-in-time established just yet; we're
> still "live" and so is the bitmap.
> 
> - We run blockdev-backup sync=none to start achieving PIT semantics for
> the fleecing node.
> 
> - We start the NBD server, and add the fleecing node export.
> 
> - We attempt to link the bitmap to the NBD export, but we can't! It's
> still active, and we never froze it for the PIT.

We do have this:

transaction {
  - x-block-dirty-bitmap-disable B1
  - block-dirty-bitmap-add B2
  - blockdev-backup sync=none
}

which starts bitmap B2 from the same point in time that we used the 
disabled bitmap B1.  We can then do what we want with B1 (perhaps 
copying it elsewhere or merging in other bitmaps), taking all the time 
we need before finally exporting a bitmap over NBD, because it was 
frozen at the same PIT, _and_ we are still tracking changes since then 
via B2.

Later, if we change our mind (for example, if creating the NBD server 
failed, or the 3rd party didn't get to read everything they wanted), 
then we want to merge B1 and B2 back into a single live bitmap so that 
the next attempt still has a single bitmap tracking all changes since 
the PIT that B1 was created.  But for that, we can first re-enable B1, 
then use x-block-dirty-bitmap-merge to merge B2 into B1, then 
block-dirty-bitmap-remove B2.  Although that cleanup sequence is not 
transactionable, it doesn't have to be (we temporarily have two bitmaps 
running at once, but the merge of those two bitmaps is going to be the 
same whether done atomically or whether one or the other got a few more 
dirty clusters in the meantime).

So, I think we have the pieces we need, as long as we have a working 
3-way transaction to disable the old, create a new, and start 
blockdev-sync, and nothing else is tied to a point in time.

> 
> 
> 
> We need a way to freeze this bitmap manually like in sync=incremental,
> to associate it with this PIT... or, we need to allow the "merge"
> command to operate under the transaction so we can copy a bitmap out at
> that PIT, e.g.
> 
> - Create bitmap "foo"
> - Disable bitmap "foo"
> Transaction {
>    - blockdev-backup sync=none
>    - merge "B" into "foo"
> }
> - NBD start, export, add bitmap "foo"
> 
> 
> 
> I think there's no escaping that we need at least one of the following:
> 
> - Merge (or copy) in transactions
> - Manual bitmap freeze/thaw commands (transactionable)
> - blockdev-fleece job & QMP command that does the following items:
> 	- Handles the creating of a temporary fleecing node
> 	- Establishes the blockdev-backup semantics for PIT export
> 	- Accepts a bitmap and forks it just like blockdev-backup does

Having one QMP command that does all things in order might be nice, but 
I think we're okay with our existing building blocks.

> 
> In the case of the block job, we don't need to tie it to NBD
> necessarily; we can leave it as the creation of the node. This would
> allow us to export it over a different transport later.
> 
> The "add bitmap to NBD server" mechanism would then change to accept
> either a disabled OR frozen bitmap.

Right now, NBD bitmap export refuses a live bitmap, and accepts a 
disabled bitmap. I'm not sure if it accepts a frozen bitmap.

> 
> Canceling/completing the job manually dictates if we clear the bitmap or
> merge in the new changes, just like blockdev-backup.
> 
> The job could be implemented as a form of blockdev-backup with most of
> the same code, but some new setup/teardown code.
> 
> That's a fanciful operation though, and too late for 3.0.

Yeah, any further polish will have to come in 3.1 (and also dropping the 
x- prefix and getting libvirt to utilize everything); but I think 3.0 
has enough building blocks to at least play with it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
