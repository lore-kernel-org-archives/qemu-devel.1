Received: from eggs.gnu.org ([2001:4830:134:3::10]:51018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dkRW4-0006xE-VN
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dkRW4-0001Ba-18
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:00:01 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
Date: Wed, 23 Aug 2017 11:59:38 +0300
MIME-Version: 1.0
In-Reply-To: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

22.08.2017 22:07, John Snow wrote:
> Well, we knew we'd want this sooner or later. I've got some pings
> downstream over whether or not we support persistent bitmaps for
> non-qcow2 formats.
>
> Currently: no, we don't.
>
> We tried two different ideas for storage agnostic bitmap persistence:
>
>
> (1) Using qcow2 as a storage container format (similar to VM save
> states) for information not associated with that particular drive.
>
> This didn't go over so well; we decided it was too messy logistically to
> manage data in any meaningful sense in a file that didn't share any
> semantic relationship to the qcow2 in question.
>
> Well, "We" decided is more like "Kevin and Max" decided. They are right,
> though.
>
>
> (2) Using a new proto-wrapper format that Fam Zheng designed that serves
> as a simple top-layer redirect for metadata that allows us to associate
> raw bitmap data with an arbitrary backing image.
>
> This also didn't go over so well, the desire for a "new format" was
> pretty thin, even if it was only a pseudo-format.
>
>
> We'd still like to be able to use bitmaps with non-qcow2 formats
> however, and people are going to keep asking. So here's a third thought:
>
>
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
>
>
> Sound good?

Looks interesting. It is a clean reusing of qcow2-bitmaps without any 
modifications to them.

Should there be some problems with internal snapshots and other things?



-- 
Best regards,
Vladimir
