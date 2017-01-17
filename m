Received: from eggs.gnu.org ([2001:4830:134:3::10]:33185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cTQY0-0008HE-7R
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cTQXz-0006Kr-1u
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:59:24 -0500
Date: Tue, 17 Jan 2017 09:59:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170117095911.GB27235@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-8-berrange@redhat.com>
	<d3f1e931-cecf-71b2-db82-f43c51361599@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3f1e931-cecf-71b2-db82-f43c51361599@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 07/15] iotests: fix 097 when run with
 qcow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Mon, Jan 16, 2017 at 09:04:31PM +0100, Max Reitz wrote:
> On 03.01.2017 19:27, Daniel P. Berrange wrote:
> > The previous commit:
> > 
> >   commit a3e1505daec31ef56f0489f8c8fff1b8e4ca92bd
> >   Author: Eric Blake <eblake@redhat.com>
> >   Date:   Mon Dec 5 09:49:34 2016 -0600
> > 
> >     qcow2: Don't strand clusters near 2G intervals during commit
> > 
> > extended the 097 test case so that it did two passes, once
> > with an internal snapshot, once without.
> > 
> > qcow (v1) does not support internal snapshots, so this change
> > broke test 097 when run against qcow.
> > 
> > This splits 097 in two, creating a new 173 that tests the
> > internal snapshot codepath, effectively putting 097 back
> > to its content before the above commit.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  tests/qemu-iotests/097     |  10 +---
> >  tests/qemu-iotests/097.out | 125 ++------------------------------------------
> >  tests/qemu-iotests/173     | 126 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/173.out | 119 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/group   |   1 +
> >  5 files changed, 251 insertions(+), 130 deletions(-)
> >  create mode 100755 tests/qemu-iotests/173
> >  create mode 100644 tests/qemu-iotests/173.out
> 
> I don't think the effort is worth it, considering that probably
> literally nobody is still using qcow -- or so I hope, at least.

The reason I fixed this was because I wanted to be able to verify my
refactoring to qcow didn't break anything else. It is much easier if
I can just run "check -qcow" and not have to worry about which failures
are just test bugs, vs genuine code bugs I've created. IOW, as long as
qcow.c exists in the code base, IMHO, we should make sure the iotests
continue to pass

On that point, IMHO, it would be beneficial if we had some CI system
that was setup to run the iotests on all new changes, across all the
different disk formats we expect the iotests to work on. We get far
too many regressions with iotests breaking and no one noticing right
now :-(


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
