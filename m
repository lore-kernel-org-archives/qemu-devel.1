Received: from eggs.gnu.org ([2001:4830:134:3::10]:44266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etEFe-0005et-1J
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etEFY-00086n-BW
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:11:37 -0500
Date: Tue, 6 Mar 2018 16:11:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180306151117.GH7139@localhost.localdomain>
References: <cover.1519921268.git.berto@igalia.com>
	<d58bbc353563bb9c83ffe90faaa36fadf683e332.1519921268.git.berto@igalia.com>
	<20180306145426.GG7139@localhost.localdomain>
	<w51vae9l041.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51vae9l041.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow2: Check L1 table parameters in
 qcow2_expand_zero_clusters()
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

Am 06.03.2018 um 16:01 hat Alberto Garcia geschrieben:
> On Tue 06 Mar 2018 03:54:26 PM CET, Kevin Wolf wrote:
> >> @@ -2092,11 +2092,18 @@ int qcow2_expand_zero_clusters(BlockDriverState *bs,
> >>      }
> >>  
> >>      for (i = 0; i < s->nb_snapshots; i++) {
> >> -        int l1_sectors = DIV_ROUND_UP(s->snapshots[i].l1_size *
> >> -                                      sizeof(uint64_t), BDRV_SECTOR_SIZE);
> >> +        int l1_size2;
> >> +        uint64_t *new_l1_table;
> >>  
> >> -        uint64_t *new_l1_table =
> >> -            g_try_realloc(l1_table, l1_sectors * BDRV_SECTOR_SIZE);
> >> +        ret = qcow2_validate_table(bs, s->snapshots[i].l1_table_offset,
> >> +                                   s->snapshots[i].l1_size, sizeof(uint64_t),
> >> +                                   QCOW_MAX_L1_SIZE, "", NULL);
> >> +        if (ret < 0) {
> >> +            return ret;
> >
> > Shouldn't this be goto fail?
> 
> You're right, this is a loop, and l1_table could have been initialized
> in previous iterations.
> 
> I'll send a corrected version with this change, but first I'll wait a
> bit in case you see anything else in the series.

I've finished the review now, the rest looks correct.

The only other thing I wondered is about the cases where you pass a
NULL errp because the callers don't get an Error parameter, so they
can't pass it on. Some of these callers already use error_report(), so
it would be okay to use error_report_err() for an error returned by
qcow2_validate_table(), too. I think that would improve the messages.

Kevin
