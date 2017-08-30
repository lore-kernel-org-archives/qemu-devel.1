Received: from eggs.gnu.org ([2001:4830:134:3::10]:55316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn3AM-0001On-Hl
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn3AL-0003Fp-G5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:36:22 -0400
Date: Wed, 30 Aug 2017 14:36:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830133611.GP24565@stefanha-x1.localdomain>
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Persistent bitmaps for non-qcow2
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Aug 22, 2017 at 03:07:04PM -0400, John Snow wrote:
> (3) Add either a new flag that turns qcow2's backing file into a full
> R/W backing file, or add a new extension to qcow2 entirely (bypassing
> the traditional backing file mechanism to avoid confusion for older
> tooling) that adds a new read-write backing file field.
> 
> This RW backing file field will be used for all reads AND writes; the
> qcow2 in question becomes a metadata container on top of the BDS chain.
> We can re-use Vladimir's bitmap persistence extension to save bitmaps in
> a qcow2 shell.
> 
> The qcow2 becomes effectively a metadata cache for a new (essentially)
> filter node that handles features such as bitmaps. This could also be
> used to provide allocation map data for RAW files and other goodies down
> the road.
> 
> Hopefully this achieves our desire to not create new formats AND our
> desire to concentrate features (and debugging, testing, etc) into qcow2,
> while allowing users to "have bitmaps with raw files."
> 
> Of course, in this scenario, users now have two files: a qcow2 wrapper
> and the actual raw file in question; but regardless of how we were going
> to solve this, a raw file necessitates an external file of some sort,
> else we give up the idea that it was a raw file.

There is some complexity here for management tools:

If the underlying image is resized, who resizes the qcow2 and how do
they know to do it?

If QEMU's resize/truncate command it used, does first try to resize the
underlying image and then resize the qcow2?  This is probably the sanest
approach.

If the underlying image is moved to a new location, does the qcow2 file
need to be modified and who does that?

Management tools need to figure out how to represent manage this extra
qcow2 file.  The easiest solution is to punt it to the user and treat it
as part of a backing file chain.  If the management tool wants to
automatically manage the qcow2 so the user just specifies the underlying
image and enables the persistent bitmap checkbox, then it becomes more
complicated.

Stefan
