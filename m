Received: from eggs.gnu.org ([2001:4830:134:3::10]:39425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dGLbE-0004Eq-EU
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dGLbD-0004Ym-CT
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:36:56 -0400
Date: Thu, 1 Jun 2017 09:36:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170601083644.GC1490@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-3-berrange@redhat.com>
	<f7fef0e4-7703-9b60-3bd9-bf1b12628cae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7fef0e4-7703-9b60-3bd9-bf1b12628cae@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/5] iotests: fix remainining tests to
 work with LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed, May 31, 2017 at 05:33:26PM +0200, Max Reitz wrote:
> On 2017-05-09 19:33, Daniel P. Berrange wrote:
> > The tests 033, 140, 145 and 157 were all broken
> > when run with LUKS, since they did not correctly use
> > the required image opts args syntax to specify the
> > decryption secret. Further, the 120 test simply does
> > not make sense to run with luks, as the scenario
> > exercised is not relevant.
> > 
> > The test 181 was broken when run with LUKS because
> > it didn't take account of fact that $TEST_IMG was
> > already in image opts syntax. The launch_qemu
> > helper also didn't register the secret object
> > providing the LUKS password.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  tests/qemu-iotests/033         | 12 ++++++++++--
> >  tests/qemu-iotests/120         |  1 +
> >  tests/qemu-iotests/140         | 11 ++++++++++-
> >  tests/qemu-iotests/145         | 19 +++++++++++++++++--
> >  tests/qemu-iotests/157         | 17 ++++++++++++++---
> >  tests/qemu-iotests/157.out     | 16 ++++++++--------
> >  tests/qemu-iotests/174         |  2 +-
> >  tests/qemu-iotests/181         | 21 ++++++++++++++++-----
> >  tests/qemu-iotests/common.qemu |  9 +++++++--
> >  9 files changed, 84 insertions(+), 24 deletions(-)
> 
> [...]
> 
> > diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
> > index 8c80a5a..0a2105c 100755
> > --- a/tests/qemu-iotests/140
> > +++ b/tests/qemu-iotests/140
> > @@ -52,8 +52,17 @@ _make_test_img 64k
> >  
> >  $QEMU_IO -c 'write -P 42 0 64k' "$TEST_IMG" | _filter_qemu_io
> >  
> > +if test "$IMGOPTSSYNTAX" = "true"
> > +then
> > +    SYSEMU_DRIVE_ARG=if=none,media=cdrom,id=drv,$TEST_IMG
> 
> I would like to propose wrapping this (or at least $TEST_IMG) in quotes,
> but I'm aware of the fact that the whole test environment breaks if you
> have a TEST_DIR with whitespace in it, so I don't mind...
> 
> (But it is a bit weird to put $TEST_IMG into quotes below and then use
> $SYSEMU_DRIVE_ARG unquoted.)

Yep, consistency is good.

> 
> > +    SYSEMU_EXTRA_ARGS=""
> > +else
> > +    SYSEMU_DRIVE_ARG=if=none,media=cdrom,id=drv,file="$TEST_IMG",driver=$IMGFMT
> > +    SYSEMU_EXTRA_ARGS=""
> > +fi
> > +
> >  keep_stderr=y \
> > -_launch_qemu -drive if=none,media=cdrom,id=drv,file="$TEST_IMG",format=$IMGFMT \
> > +_launch_qemu $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \
> 
> But could you drop the $SYSEMU_EXTRA_ARGS? It doesn't seem to serve a
> purpose (anymore, now that you added this to _launch_qemu itself).

Opps, yes, forgot to remove this when i last refactored.

> 
> >      2> >(_filter_nbd)
> >  
> >  _send_qemu_cmd $QEMU_HANDLE \
> > diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
> > index e6c6bc4..9cfa940 100755
> > --- a/tests/qemu-iotests/145
> > +++ b/tests/qemu-iotests/145
> > @@ -43,8 +43,23 @@ _supported_proto generic
> >  _supported_os Linux
> >  
> >  _make_test_img 1M
> > -echo quit | $QEMU -nographic -hda "$TEST_IMG" -incoming 'exec:true' -snapshot -serial none -monitor stdio |
> > -    _filter_qemu | _filter_hmp
> > +
> > +if test "$IMGOPTSSYNTAX" = "true"
> > +then
> > +    SYSEMU_DRIVE_ARG=if=none,$TEST_IMG
> > +    SYSEMU_EXTRA_ARGS=""
> > +    if [ -n "$IMGKEYSECRET" ]; then
> > +	SECRET_ARG="secret,id=keysec0,data=$IMGKEYSECRET"
> > +	SYSEMU_EXTRA_ARGS="-object $SECRET_ARG"
> 
> Please use spaces instead of tabs.

Will do.

> (I know there are a lot of tabs in the test files already, but according
> to CODING_STYLE, that is just wrong.)

I wish we'd clean up existing files one day....


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
