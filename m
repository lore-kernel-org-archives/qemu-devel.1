Received: from eggs.gnu.org ([2001:4830:134:3::10]:49242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpB1h-0002v4-Ji
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpB1c-0003LP-Q6
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:24:13 -0400
Date: Tue, 5 Sep 2017 12:23:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905102348.GG4633@localhost.localdomain>
References: <20170831110518.10741-1-berrange@redhat.com>
	<20170831110518.10741-3-berrange@redhat.com>
	<20170905095215.GF4633@localhost.localdomain>
	<20170905100538.GC311@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170905100538.GC311@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] block: use BDRV_SECTOR_SIZE in
 crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

Am 05.09.2017 um 12:05 hat Daniel P. Berrange geschrieben:
> On Tue, Sep 05, 2017 at 11:52:15AM +0200, Kevin Wolf wrote:
> > Am 31.08.2017 um 13:05 hat Daniel P. Berrange geschrieben:
> > > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > > ---
> > >  block/crypto.c | 32 ++++++++++++++++----------------
> > >  1 file changed, 16 insertions(+), 16 deletions(-)
> > 
> > I'm actually not sure about this one. Anything that is left after
> > patch 3 is probably not the arbitrary unit that qemu uses internally
> > for some interfaces, but the unit in which data is encrypted.
> > 
> > Basically, if just for fun we ever changed the unit of things like
> > bdrv_write() from 512 to 4096, then everything that needs to or at least
> > can be changed to use 4096 is BDRV_SECTOR_SIZE. But everything that
> > needs to stay on 512 (like I suspect most of the occurrences in the
> > crypto driver) is a different constant really (QCRYPTO_SECTOR_SIZE?).
> 
> Yeah for sure LUKSv1 & legacy qcow2 encryption need to stay 512
> forever, so if BDRV_SECTOR_SIZE were to change that would be a
> problem.
> 
> I wrote this on the assumption that we would never change BDRV_SECTOR_SIZE
> though. If we did need different sector sizes in the block layer I figured
> it would surely end up being a dynamic property per disk, rather than just
> changing the compile time constant. So from that POV I thought it ok to
> use BDRV_SECTOR_SIZE.

Yes, I agree that we'll never BDRV_SECTOR_SIZE in practice. I just use
this as a way to check whether this is really BDRV_SECTOR_SIZE, or
whether we have two different quantities that just happen to be both
512.

For example, QDICT_BUCKET_MAX is also 512, but that doesn't make it
right to use here, even though it works and is unlikely to change.

What we may actually want to do at some point (won't be in the near
future, though) is removing BDRV_SECTOR_SIZE because it refers to an
arbitrary unit in APIs and we're in the process of making everything
byte-based instead. This is another way to check whether some value is
BDRV_SECTOR_SIZE: If it will remain even after removing APIs with
sector-based parameters, it's probably something different.

> Perhaps I should instead add a qcrypto_block_get_sector_size() API though
> and use that, so we can fetch the sector size per encryption scheme in
> case we ever get a scheme using a non-512 sector size for encryption.

If you have a use for it, sure. Otherwise, I'd just suggest introducing
another constant for now.

Kevin
