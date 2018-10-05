Received: from eggs.gnu.org ([2001:4830:134:3::10]:59425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g8SQ8-0003Z0-RO
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g8SQ8-0003An-4T
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:53:40 -0400
Date: Fri, 5 Oct 2018 17:52:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181005155213.GB4606@localhost.localdomain>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
	<20181001102928.20533-14-vsementsov@virtuozzo.com>
	<20181004124421.GC6009@localhost.localdomain>
	<d691c927-e37a-1178-8180-9893278aa02c@virtuozzo.com>
	<20181004145241.GG6009@localhost.localdomain>
	<19e42ee8-fdbe-e637-6728-bfc10b137f63@virtuozzo.com>
	<46e224bd-8c1f-4565-944e-52440e85e2f0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e224bd-8c1f-4565-944e-52440e85e2f0@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 13/18] block: introduce new filter
 driver: fleecing-hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>, "wencongyang2@huawei.com" <wencongyang2@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

Hi Vladimir,

can you please check your mailer settings? The plain text version of the
emails is hardly legible because it mixes quotes text and replies. I
had to manually open the HTML part to figure out what you really wrote.

Am 05.10.2018 um 17:00 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hmm, how to share children?
> 
> backup job has two source BdrvChild'ren - child_job and child_root of
> job blk and two target BdrvChild'ren - again, child_job and
> child_root.
> 
> backup_top has source child - child_backing and second - child_file
> (named "target")..

Right, these are six BdrvChild instances in total. I think we can ignore
the child_job ones, they are internal to the block job infrastructure,
so we have four of them left.

> Which BdrvChild'ren you suggest to remove? They are all different.

Now that you introduced backup_top, I think we don't need any
BlockBackends any more. So I suggest to remove the child_root ones and
to do all I/O through the child_backing and child_file ones of
backup_top.

> I don't know, why job needs both unnamed blk's and child_job's, and I
> don't know is it necessary for backup to use blk's not BdrvChild'ren..

I think we had a case recently where it turned out that it is strictly
speaking even wrong for jobs to use BlockBackends in a function that
intercepts a request on the BDS level (like the copy-before-write of
backup).

So getting rid of the BlockBackends isn't only okay, but actually a good
thing by itself.

> And with internal way in none-mode we'll have two unused blk's  and
> four unused BdrvChild'ren.. Or we want to rewrite backup to use
> BdrvChild'ren for io operations and drop child_job BdrvChild'ren? So
> I'm lost. What did you mean?

child_job isn't actually unused, even though you never use them to make
requests. The child_job BdrvChild is important because of the
BdrvChildRole callbacks it provides to the block job infrastructure.

Kevin
