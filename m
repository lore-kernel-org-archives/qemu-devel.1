Received: from eggs.gnu.org ([209.51.188.92]:33610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1glH7W-0004s0-N8
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 12:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1glH7V-0001go-RC
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 12:42:54 -0500
Date: Sun, 20 Jan 2019 17:42:20 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190120174220.GU6679@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
	<f10654ba-04d3-3212-94ca-e72c511d51c2@virtuozzo.com>
	<38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
	<928553ea-9694-acc6-1c5f-5a09afc2c64c@redhat.com>
	<20190119113941.GZ27120@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119113941.GZ27120@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/21] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On Sat, Jan 19, 2019 at 11:39:41AM +0000, Richard W.M. Jones wrote:
> 
> Attached is a NON-working patch to nbdkit-partitioning-plugin which
> adds logical partition support.  I don't think I've fully understood
> how the EBR fields are supposed to be initialized (or else they don't
> work how is described in online documentation).  This actually causes
> parted to print an internal error, while fdisk gives a warning and the
> size of the logical partition is wrong.
> 
> Anyway I've run out of time to work on it this weekend, but I may be
> able to have another look next week.

Sheesh.  Apparently the type byte in the link field must
be the extended partition type byte (eg. 0x5 or 0xf), NOT
the type of the next partition.

This fixes it:

$ git diff
diff --git a/plugins/partitioning/partition-mbr.c b/plugins/partitioning/partition-mbr.c
index 6f76432..6b256d1 100644
--- a/plugins/partitioning/partition-mbr.c
+++ b/plugins/partitioning/partition-mbr.c
@@ -129,7 +129,7 @@ create_mbr_layout (void)
          */
         region.start = enext->start - eptr0->start;
         region.len = rnext->end - enext->start + 1;
-        create_mbr_partition_table_entry (&region, false, files[i+1].mbr_id,
+        create_mbr_partition_table_entry (&region, false, 0xf,
                                           &ebr[i-3][0x1ce]);
       }
     }


I'll try to come up with a better patch with tests etc.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
