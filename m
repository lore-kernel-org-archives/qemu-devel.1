Received: from eggs.gnu.org ([2001:4830:134:3::10]:53415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqeZm-0001d8-Oi
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 07:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqeZj-0001wc-M6
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 07:41:46 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <e56321ad-d08f-5061-b356-2bebae25dc98@redhat.com>
References: <cover.1518711805.git.berto@igalia.com>
	<894433c083e20bbb82e208ea8b067b13609dbc19.1518711805.git.berto@igalia.com>
	<e56321ad-d08f-5061-b356-2bebae25dc98@redhat.com>
Date: Tue, 27 Feb 2018 13:41:39 +0100
Message-ID: <w518tbe4nb0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] qcow2: Allow checking and
 repairing corrupted internal snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Mon 26 Feb 2018 02:40:08 PM CET, Max Reitz wrote:
>> +                        "L1 table is too large; snapshot table entry corrupted\n",
>> +                        (fix & BDRV_FIX_ERRORS) ? "Deleting" : "ERROR",
>> +                        sn->id_str, sn->name, sn->l1_size);
>> +                found_corruption = true;
>> +            }
>
> This code assumes the snapshot table itself has been valid.  Why should
> it be when it contains garbage entries?
>
>> +
>> +            if (found_corruption) {
>> +                result->corruptions++;
>> +                sn->l1_size = 0; /* Prevent this L1 table from being used */
>> +                if (fix & BDRV_FIX_ERRORS) {
>> +                    ret = qcow2_snapshot_delete(bs, sn->id_str, sn->name, NULL);
>
> So calling this is actually very dangerous.  It modifies the snapshot
> table which I wouldn't trust is actually just a snapshot table.  It
> could intersect any other structure in the qcow2 image.  Yes, we do an
> overlap check, but that only protects metadata, and I don't really
> want to see an overlap check corruption when repairing the image;
> especially since this means you cannot fix the corruption.

I think you're right. One thing that could be done is check that the
area where the snapshot table is supposed to be doesn't overlap with any
other data structures.

> I don't quite know myself what to do instead, but I guess my main
> point would be: Before any (potentially) destructive changes are made,
> the user should have the chance of still opening the image read-only
> and copying all the data off somewhere else.  Which of course again
> means we shouldn't prevent the user from opening an image because a
> snapshot is broken.

Ok, you've convinced me. I'll see what I can come up with. I guess
initially we can simply add checks for sn->l1_table_offset and
sn->l1_size in the places where they're used.

Berto
