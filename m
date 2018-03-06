Received: from eggs.gnu.org ([2001:4830:134:3::10]:59029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etDFG-0003do-Ox
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etDFA-0006GJ-Qr
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:07:10 -0500
Date: Tue, 6 Mar 2018 15:06:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180306140646.GF7139@localhost.localdomain>
References: <cover.1519921268.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1519921268.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] Add checks for corruption in the
 snapshot table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 01.03.2018 um 17:27 hat Alberto Garcia geschrieben:
> Hey ho!
> 
> As we have already discussed in the mailing list, the offset and size
> values of snapshots' L1 tables are almost never validated in the QEMU
> code.
> 
> One way to deal with this is to validate them when the image is being
> opened (in qcow2_read_snapshots()) and return an error if there's
> anything wrong. However this would render the image unusable because
> we wouldn't be able to try to recover data using the active table as
> we can do now.
> 
> Another possibility is to refuse opening the image but add a way to
> fix it using 'qemu-img check'. But this would be a destructive
> operation, and knowing that the image is already corrupted we can't
> guarantee that we wouldn't be corrupting it even more.
> 
> So although having a way to repair this kind of corruption would be
> nice, we should still allow the user to try to open the image and read
> data from it without requiring a potentially destructive operation
> first.

Generally speaking, there is also always the option to refuse opening a
corrupted image read-write, but to allow opening it read-only. This
would probably still require some checks on use, though (or maybe just
hiding all snapshots).

Kevin

> So this series simply validates the snapshots' L1 tables in the places
> where they are actually used. We already have a function to do this
> kind of checks so we only need to call it.
> 
> Regards,
> 
> Berto
> 
> Alberto Garcia (7):
>   qcow2: Generalize validate_table_offset() into qcow2_validate_table()
>   qcow2: Check L1 table offset in qcow2_snapshot_load_tmp()
>   qcow2: Check L1 table parameters in qcow2_expand_zero_clusters()
>   qcow2: Check snapshot L1 tables in qcow2_check_metadata_overlap()
>   qcow2: Check snapshot L1 table in qcow2_snapshot_goto()
>   qcow2: Check snapshot L1 table in qcow2_snapshot_delete()
>   qcow2: Make qemu-img check detect corrupted L1 tables in snapshots
> 
>  block/qcow2-cluster.c      | 20 +++++++-----
>  block/qcow2-refcount.c     | 24 ++++++++++++++-
>  block/qcow2-snapshot.c     | 21 +++++++++++--
>  block/qcow2.c              | 77 ++++++++++++++++++----------------------------
>  block/qcow2.h              | 10 +++---
>  tests/qemu-iotests/080     | 22 ++++++++++++-
>  tests/qemu-iotests/080.out | 54 ++++++++++++++++++++++++++------
>  7 files changed, 155 insertions(+), 73 deletions(-)
> 
> -- 
> 2.11.0
> 
