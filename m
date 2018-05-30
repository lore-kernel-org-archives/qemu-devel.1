Received: from eggs.gnu.org ([2001:4830:134:3::10]:60361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fO1uk-0001gO-Qc
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fO1uj-0005Gn-M0
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:17:22 -0400
Date: Wed, 30 May 2018 17:16:56 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180530141656.GA2400@rkaganb.sw.ru>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<14e14e4f-4d43-9c94-7dd6-c295a09b6432@redhat.com>
	<20180530134738.GB2448@rkaganb.sw.ru>
	<d97043ad-8b03-681e-ff59-917e6cf3cef1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97043ad-8b03-681e-ff59-917e6cf3cef1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/17] iotests: don't choke on disabled
 drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Wed, May 30, 2018 at 03:53:52PM +0200, Max Reitz wrote:
> On 2018-05-30 15:47, Roman Kagan wrote:
> > On Wed, May 30, 2018 at 02:35:34PM +0200, Max Reitz wrote:
> >> On 2018-04-26 18:19, Roman Kagan wrote:
> >>> Some iotests assume availability of certain block drivers, and fail if
> >>> the driver is not supported by QEMU because it was disabled at configure
> >>> time.
> >>>
> >>> This series tries to address that, by making QEMU report the actual list
> >>> of supported block drivers in response to "-drive format=?", and using
> >>> this information to skip the parts of the io testsuite that can not be
> >>> run in this configuration.
> >>>
> >>> Roman Kagan (17):
> >>>   block: iterate_format with account of whitelisting
> >>>   iotests: iotests.py: prevent deadlock in subprocess
> >>>   iotests: ask qemu for supported formats
> >>>   iotest 030: skip quorum test setup/teardown too
> >>>   iotest 030: require blkdebug
> >>>   iotest 055: skip unsupported backup target formats
> >>>   iotest 055: require blkdebug
> >>>   iotest 056: skip testcases using blkdebug if disabled
> >>>   iotest 071: notrun if blkdebug or blkverify is disabled
> >>>   iotest 081: notrun if quorum is disabled
> >>>   iotest 087: notrun if null-co is disabled
> >>>   iotest 093: notrun if null-co or null-aio is disabled
> >>>   iotest 099: notrun if blkdebug or blkverify is disabled
> >>>   iotest 124: skip testcases using blkdebug if disabled
> >>>   iotest 139: skip testcases using disabled drivers
> >>>   iotest 147: notrun if nbd is disabled
> >>>   iotest 184: notrun if null-co or throttle is disabled
> >>>
> >>>  include/block/block.h         |  2 +-
> >>>  block.c                       | 23 ++++++++++++++++++----
> >>>  blockdev.c                    |  4 +++-
> >>>  qemu-img.c                    |  2 +-
> >>>  tests/qemu-iotests/030        |  7 +++++++
> >>>  tests/qemu-iotests/055        | 13 ++++++++++++
> >>>  tests/qemu-iotests/056        |  3 +++
> >>>  tests/qemu-iotests/071        |  1 +
> >>>  tests/qemu-iotests/081        |  1 +
> >>>  tests/qemu-iotests/087        |  1 +
> >>>  tests/qemu-iotests/093        |  1 +
> >>>  tests/qemu-iotests/099        |  1 +
> >>>  tests/qemu-iotests/124        |  5 +++++
> >>>  tests/qemu-iotests/139        |  4 ++++
> >>>  tests/qemu-iotests/147        |  1 +
> >>>  tests/qemu-iotests/184        |  1 +
> >>>  tests/qemu-iotests/common.rc  | 19 ++++++++++++++++++
> >>>  tests/qemu-iotests/iotests.py | 46 ++++++++++++++++++++++++++++++++-----------
> >>>  18 files changed, 117 insertions(+), 18 deletions(-)
> >>
> >> I'll stop reviewing this series for now, because there are more iotests
> >> that use drivers outside of their format/protocol combination.
> >>
> >> For instance:
> >>
> >> $ grep -l null-co ??? | wc -l
> >> 15
> >> $ grep -l blkdebug ??? | wc -l
> >> 30
> >> $ (grep -l '"raw"' ???; grep -l "'raw'" ???) | wc -l
> >> 22
> >>
> >> As I've written in my reply to patch 8, I'm not sure whether it's the
> >> right solution to check for the availability of these block drivers in
> >> every single test that needs them.  It makes sense for quorum, because
> >> quorum needs an external library for hashing, so it may not be trivial
> >> to enable.  But it does not seem too useful for other formats that do
> >> not have such a dependency (e.g. null-co, blkdebug, raw).
> >>
> >> The thing is that it's OK to whitelist everything for testing, and then
> >> disable some drivers when building a release.  I don't think one needs
> >> to run the iotests with the release version if the whole difference is
> >> whether some drivers have been disabled or not.
> > 
> > This patchset was created when we started to run (quick) iotests as a part
> > of the package build, which looked like a decent alternative to building
> > separate CI infrastructure.
> > 
> > If there's no general interest in running iotests against QEMU built in
> > a release configuration with certain drivers blacklisted, I think we
> > should be fine handling this locally.
> 
> It's not like the majority of drivers uses blkdebug, but still, it seems
> at least suboptimal to run the tests if you then disable a big chunk of
> them because some drivers were not whitelisted.

Indeed.  In fact, our configuration (based on RedHat's) has those three
(null-co, blkdebug, raw) enabled so the patchset didn't result in
massive test skips.

> If you're OK with a local solution...  OK, but naively I'd think that
> it'd be better to just build two versions for packaging: One that's
> actually going to be packaged, and one that's used for testing.  (Though
> I don't know how well that fits into your process.)

It doesn't: we just added a couple of lines to the %check section of the
RPM .spec

> In any case, I'm not fully opposed to this series, but it would need to
> be complete and make every test require every block driver that is not
> part of its protocol/format combination.

OK this doesn't look like too much of work; I'll see if I can do it
quickly.

Thanks,
Roman.
