Received: from eggs.gnu.org ([2001:4830:134:3::10]:53945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=884673768=anthony.perard@citrix.com>)
	id 1gZcPq-0001Y9-40
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=884673768=anthony.perard@citrix.com>)
	id 1gZcPk-0005wy-2p
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:01:37 -0500
Date: Wed, 19 Dec 2018 14:01:18 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181219140118.GC1288@perard.uk.xensource.com>
References: <20181217133011.31433-1-paul.durrant@citrix.com>
	<20181217133011.31433-17-paul.durrant@citrix.com>
	<20181219123926.GA1288@perard.uk.xensource.com>
	<40bdef2962864ca8bc364249196bf9b3@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <40bdef2962864ca8bc364249196bf9b3@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH v6 16/18] xen: automatically create
 XenBlockDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Dec 19, 2018 at 12:43:24PM +0000, Paul Durrant wrote:
> > Kevin seems to say that this could be done without the _flat_confused
> > version. The flat_confused version seems to be useful just because
> > the key "cache.direct" is used earlier, and because everything in qdict
> > is a string.
> 
> It could be, but there's a good reason for wanting everything as a string, and that is so that I can do a qdict_iter to generate my trace message. Also I really don't want to get too elaborate here... this is supposed to be mimicking what would normally come via a json blob, and that would start out as strings.

Mimic JSON ? Not really. JSON has types. If the toolstack wanted
cache.direct or read-only option on a blockdev, it will need to use the
bool type as string type will be rejected.  The expected types when
issuing a QMP request can be found in "qapi/block-core.json", for the
command "blockdev-add".

Also, there is a comment on the qobject_input_visitor_new_flat_confused
function, it reads:
    The block subsystem uses this function to visit its flat QDict with
    possibly confused scalar types.  It should not be used for anything
    else, and it should go away once the block subsystem has been
    cleaned up.

We might as well avoid using it right now, as it's easy to do so.

-- 
Anthony PERARD
