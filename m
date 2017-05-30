Received: from eggs.gnu.org ([2001:4830:134:3::10]:47621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dFmC2-0005jU-4M
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dFmC0-0006UH-NU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:48:34 -0400
Date: Tue, 30 May 2017 14:48:25 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170530184825.GE2665@localhost.localdomain>
References: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
	<1496157773-10779-5-git-send-email-kwolf@redhat.com>
	<20170530155257.GD2665@localhost.localdomain>
	<20170530165705.GE5210@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530165705.GE5210@noname.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/4] qemu-iotests: Block
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Tue, May 30, 2017 at 06:57:05PM +0200, Kevin Wolf wrote:
> Am 30.05.2017 um 17:52 hat Jeff Cody geschrieben:
> > On Tue, May 30, 2017 at 05:22:53PM +0200, Kevin Wolf wrote:
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  tests/qemu-iotests/183     | 143 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/qemu-iotests/183.out |  46 +++++++++++++++
> > >  tests/qemu-iotests/group   |   1 +
> > >  3 files changed, 190 insertions(+)
> > >  create mode 100755 tests/qemu-iotests/183
> > >  create mode 100644 tests/qemu-iotests/183.out
> > > 
> > > diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
> > > new file mode 100755
> > > index 0000000..5eda0e9
> > > --- /dev/null
> > > +++ b/tests/qemu-iotests/183
> > > @@ -0,0 +1,143 @@
> > > +#!/bin/bash
> > > +#
> > > +# Test old-style block migration (migrate -b)
> > > +#
> > > +# Copyright (C) 2017 Red Hat, Inc.
> > > +#
> > > +# This program is free software; you can redistribute it and/or modify
> > > +# it under the terms of the GNU General Public License as published by
> > > +# the Free Software Foundation; either version 2 of the License, or
> > > +# (at your option) any later version.
> > > +#
> > > +# This program is distributed in the hope that it will be useful,
> > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > +# GNU General Public License for more details.
> > > +#
> > > +# You should have received a copy of the GNU General Public License
> > > +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > > +#
> > > +
> > > +# creator
> > > +owner=kwolf@redhat.com
> > > +
> > > +seq=`basename $0`
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +status=1	# failure is the default!
> > > +
> > > +MIG_SOCKET="${TEST_DIR}/migrate"
> > > +
> > > +_cleanup()
> > > +{
> > > +    rm -f "${MIG_SOCKET}"
> > > +    rm -f "${TEST_IMG}.dest"
> > > +	_cleanup_test_img
> > > +    _cleanup_qemu
> > > +}
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common.rc
> > > +. ./common.filter
> > > +. ./common.qemu
> > > +
> > > +_supported_fmt generic
> > 
> > Not sure to what extent we are really keeping the _supported_fmt up to date,
> > but this test will only work on qcow2 and raw, right?
> > 
> > I'd recommend changing this to:
> > 
> > + _supported_fmt qcow2 raw
> > 
> > (that can probably be done when applying, however).
> 
> Seems you are right, but I fail to see why the other formats shouldn't
> work? Are these just bugs or do I make any assumption in the test script
> that is invalid for other image formats?
>

Well, the following formats have live migration blockers:

vmdk, vhdx, vdi, vpc, qcow, vvfat

So that leaves qed, dmg, quorum.

Of those, qed is the only one that fails.  And I would guess it is a bug?

While waiting for  "status: active" from the query-migrate (in the section
where I proposed a timeout), the migration is hanging, and appears to never
get started.  If I redirect that output to a debug file, I just see this
over and over (I prettified the json output here):


{
  "return": {
    "expected-downtime": 300,
    "status": "active",
    "disk": {
      "total": 67108864,
      "postcopy-requests": 0,
      "dirty-sync-count": 0,
      "page-size": 0,
      "remaining": 63963136,
      "mbps": 0,
      "transferred": 3145728,
      "duplicate": 0,
      "dirty-pages-rate": 0,
      "skipped": 0,
      "normal-bytes": 0,
      "normal": 0
    },
    "setup-time": 1,
    "total-time": 4956,
    "ram": {
      "total": 134750208,
      "postcopy-requests": 0,
      "dirty-sync-count": 1,
      "page-size": 4096,
      "remaining": 134750208,
      "mbps": 0,
      "transferred": 0,
      "duplicate": 0,
      "dirty-pages-rate": 0,
      "skipped": 0,
      "normal-bytes": 0,
      "normal": 0
    }
  }
}

The only thing that advances is "total-time".

So I would make _supported_fmt be 'qcow2 raw qed dmg quorum', and the
failure of qed is an actual failure.

[...]

> > > +echo === Do block migration to destination ===
> > > +echo
> > > +
> > > +reply="$(_send_qemu_cmd $src \
> > > +    "{ 'execute': 'migrate',
> > > +       'arguments': { 'uri': 'unix:${MIG_SOCKET}', 'blk': true } }" \
> > > +    'return\|error')"
> > > +echo "$reply"
> > > +if echo "$reply" | grep "compiled without old-style" > /dev/null; then
> > > +    _notrun "migrate -b support not compiled in"
> > > +fi
> > > +
> > > +while _send_qemu_cmd $src "{ 'execute': 'query-migrate' }" "return"  |
> > > +      grep '"status": "active"' > /dev/null
> > > +do
> > > +    sleep 0.1
> > 
> > Would it make sense here to add a timeout?  It would be nice to be able to
> > reply on scripts always failing for git-bisect (rather than potentially
> > hanging at a spot).
> 
> What would you think about squashing this in:
> 
> --- a/tests/qemu-iotests/183
> +++ b/tests/qemu-iotests/183
> @@ -96,11 +96,8 @@ if echo "$reply" | grep "compiled without old-style" > /dev/null; then
>      _notrun "migrate -b support not compiled in"
>  fi
>  
> -while _send_qemu_cmd $src "{ 'execute': 'query-migrate' }" "return"  |
> -      grep '"status": "active"' > /dev/null
> -do
> -    sleep 0.1
> -done
> +QEMU_COMM_TIMEOUT=0.1 qemu_cmd_repeat=50 silent=yes \
> +    _send_qemu_cmd $src "{ 'execute': 'query-migrate' }" '"status": "completed"'
>  _send_qemu_cmd $src "{ 'execute': 'query-status' }" "return"
>  
>  echo
>

I like that approach.  It also worked well with the qed failure case.
Rather than hanging during the query-migrate, it times out nicely.  All
other formats expected to work, still worked for me.


-Jeff
