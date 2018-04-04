Received: from eggs.gnu.org ([2001:4830:134:3::10]:39757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3f41-0004GE-Pp
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3f40-0002id-SF
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:50:45 -0400
Date: Wed, 4 Apr 2018 11:50:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180404095029.GC4482@localhost.localdomain>
References: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
	<1522422996-14235-2-git-send-email-vsementsov@virtuozzo.com>
	<20180403135458.GD11070@localhost.localdomain>
	<e4d7751e-3d88-e31b-7b73-23b8417eca88@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d7751e-3d88-e31b-7b73-23b8417eca88@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] iotests.py: improve
 verify_image_format helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com, den@openvz.org

Am 04.04.2018 um 10:48 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 03.04.2018 16:54, Kevin Wolf wrote:
> > Am 30.03.2018 um 17:16 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > Add an assert (we don't want set both arguments) and remove
> > > duplication.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > ---
> > >   tests/qemu-iotests/iotests.py | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> > > index b5d7945..83c454d 100644
> > > --- a/tests/qemu-iotests/iotests.py
> > > +++ b/tests/qemu-iotests/iotests.py
> > > @@ -532,9 +532,9 @@ def notrun(reason):
> > >       sys.exit(0)
> > >   def verify_image_format(supported_fmts=[], unsupported_fmts=[]):
> > > -    if supported_fmts and (imgfmt not in supported_fmts):
> > > -        notrun('not suitable for this image format: %s' % imgfmt)
> > > -    if unsupported_fmts and (imgfmt in unsupported_fmts):
> > > +    assert not (supported_fmts and unsupported_fmts)
> > > +    not_sup = supported_fmts and (imgfmt not in supported_fmts)
> > > +    if not_sup or (imgfmt in unsupported_fmts):
> > >           notrun('not suitable for this image format: %s' % imgfmt)
> > Before the change, we accepted None for both parameters. Now None is
> > still accepted for supported_fmts, but not for unsupported_fmts any
> > more.
> > 
> > I don't think we actually make use of None for either, so I don't really
> > mind whether we allow it or not, but we should be consistent between
> > both parameters.
> > 
> > Kevin
> 
> I think, we should not care about it. The function takes lists. So, you can
> 1. pass a parameter, which must be list
> 2. do not pass it, it will become [] by default.
> 
> So if someone pass None directly, its a bug. Like if someone will pass int
> or float..

Yeah, brain fart. Somehow I thought you could just check 'imgfmt not in
supported_fmts' without checking 'supported_fmt' first, but obviously
that would make the default that nothing is accepted. Your version is
fine.

Kevin
