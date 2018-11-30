Received: from eggs.gnu.org ([2001:4830:134:3::10]:50843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gSjV8-00017l-0I
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gSjV5-00078x-SS
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:10:37 -0500
Date: Fri, 30 Nov 2018 15:10:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181130141017.GF5106@localhost.localdomain>
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
	<2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
	<e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
	<abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
	<73cb2885-3a40-6d2b-24fa-c528decdbc9b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73cb2885-3a40-6d2b-24fa-c528decdbc9b@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jcody@redhat.com" <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

Am 30.11.2018 um 14:48 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 30.11.2018 16:13, Max Reitz wrote:
> > On 30.11.18 14:06, Vladimir Sementsov-Ogievskiy wrote:
> >> 30.11.2018 15:30, Max Reitz wrote:
> >>> On 29.11.18 11:18, Vladimir Sementsov-Ogievskiy wrote:
> >>>> This test is broken without previous commit fixing dead-lock in mirror.
> >>>>
> >>>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> >>>> ---
> >>>>    tests/qemu-iotests/235     | 59 ++++++++++++++++++++++++++++++++++++++
> >>>>    tests/qemu-iotests/235.out |  1 +
> >>>>    tests/qemu-iotests/group   |  1 +
> >>>>    3 files changed, 61 insertions(+)
> >>>>    create mode 100755 tests/qemu-iotests/235
> >>>>    create mode 100644 tests/qemu-iotests/235.out
> >>> I'll get to the first patch in a second, but first a suggestion for this
> >>> patch: I think it's not so good to use 2 GB of space for a test (1 GB
> >>> for the source, 1 GB for the target).  So I tried my luck and found that
> >>> the test works, too, if you just use preallocation=metadata for the
> >>> source (instead of actually writing data) and blockdev-mirror'ing the
> >>> data to a throttled null-co device.
> >>
> >> Hmm, so parsing metadata is enough for qcow2 to yield on write, yes?
> > 
> > Apparently so.  If you can confirm that applying those changes to the
> > test still make it work (i.e., fail before patch 1, pass afterwards),
> > then I think it is just as good.
> 
> Ok, I've checked that your changes works for me.
> 
> hm, but we write to null, so, yield on write comes from throttling, however,
> without preallocation=metadata, it don't work.., do you know, why we need
> preallocation to reproduce?

If I should take a guess, probably because mirror only copies allocated
clusters?

Kevin
