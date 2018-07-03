Received: from eggs.gnu.org ([2001:4830:134:3::10]:60269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faJNz-0006pz-Hn
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faJNy-0004G7-OC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:22:19 -0400
Date: Tue, 3 Jul 2018 13:22:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180703112211.GC3812@localhost.localdomain>
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-3-vsementsov@virtuozzo.com>
	<32ad25bf-0427-e286-94f1-0566af2ea8ed@redhat.com>
	<0f766c07-dfe5-1886-5635-f76780220757@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f766c07-dfe5-1886-5635-f76780220757@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/fleecing-filter: new filter
 driver for fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, famz@redhat.com, den@openvz.org

Am 02.07.2018 um 13:57 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 29.06.2018 20:30, John Snow wrote:
> > 
> > On 06/29/2018 11:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> > > We need to synchronize backup job with reading from fleecing image
> > > like it was done in block/replication.c.
> > > 
> > > Otherwise, the following situation is theoretically possible:
> > > 
> > > 1. client start reading
> > > 2. client understand, that there is no corresponding cluster in
> > >     fleecing image
> > I don't think the client refocuses the read, but QEMU does. (the client
> > has no idea if it is reading from the fleecing node or the backing file.)
> > 
> > ... but understood:
> > 
> > > 3. client is going to read from backing file (i.e. active image)
> > > 4. guest writes to active image
> > My question here is if QEMU will allow reads and writes to interleave in
> > general. If the client is reading from the backing file, the active
> > image, will QEMU allow a write to modify that data before we're done
> > getting that data?
> 
> If I understand correctly: yes. Physical drives allows intersecting
> operations too and there no guarantee on result. We have serializing
> requests, but in general only unaligned requests are marked serializing.

Copy on read (in the context of image streaming) is the feature which
actually introduced it. It has some similarities with the backup job, so
the idea of using it for backup, too, isn't exactly revolutionary.

Kevin
