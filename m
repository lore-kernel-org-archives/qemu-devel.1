Received: from eggs.gnu.org ([2001:4830:134:3::10]:47464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNgGX-0004iv-HE
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNgGW-0002fh-IH
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:10:25 -0400
Date: Tue, 29 May 2018 17:10:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180529151016.GF4756@localhost.localdomain>
References: <20180425183223.580566-1-eblake@redhat.com>
	<20180425183223.580566-3-eblake@redhat.com>
	<20180528105232.GD4580@localhost.localdomain>
	<b1ae14fa-6305-603e-02ab-e8565095f5e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ae14fa-6305-603e-02ab-e8565095f5e3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/8] qcow: Switch get_cluster_offset to be
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:qcow" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Am 29.05.2018 um 17:03 hat Eric Blake geschrieben:
> On 05/28/2018 05:52 AM, Kevin Wolf wrote:
> > Am 25.04.2018 um 20:32 hat Eric Blake geschrieben:
> > > We are gradually moving away from sector-based interfaces, towards
> > > byte-based.  Make the change for the internal helper function
> > > get_cluster_offset(), by changing n_start and n_end to by byte
> > > offsets rather than sector indices within the cluster being
> > > allocated.
> > > 
> > > A later patch will then switch the qcow driver as a whole over
> > > to byte-based operation.
> > > 
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > >   block/qcow.c | 28 ++++++++++++++--------------
> > >   1 file changed, 14 insertions(+), 14 deletions(-)
> > > 
> 
> > > +                    for (i = 0; i < s->cluster_size; i += BDRV_SECTOR_SIZE) {
> > >                           if (i < n_start || i >= n_end) {
> > > -                            memset(s->cluster_data, 0x00, 512);
> > > +                            memset(s->cluster_data, 0x00, BDRV_SECTOR_SIZE);
> > >                               if (qcrypto_block_encrypt(s->crypto,
> > > -                                                      (start_sect + i) *
> > > -                                                      BDRV_SECTOR_SIZE,
> > > +                                                      start_offset + i,
> > >                                                         s->cluster_data,
> > >                                                         BDRV_SECTOR_SIZE,
> > >                                                         NULL) < 0) {
> > 
> > This code is still working in blocks of BDRV_SECTOR_SIZE here - which
> > you do need to keep at least partially because that's the block size
> > that qcrypto_block_encrypt() works with. qcrypto_block_qcow_encrypt()
> > even asserts it.
> > 
> > However, this means that even though n_start and n_end are byte-based
> > now, the code only works correctly with encrypted images if they are
> > multiples of BDRV_SECTOR_SIZE. This is currently true and we could
> > assert it, but it would kind of defeat the purpose of the patch.
> 
> But in patch 5, I intentionally kept bs->bl.request_alignment at 512, so I'd
> rather just assert that n_start and n_end are properly aligned than to worry
> about rounding issues.

Yes, I hadn't read the whole series yet. So, sure, adding an assertion
works for me.

Kevin
