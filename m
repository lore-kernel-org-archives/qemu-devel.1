Received: from eggs.gnu.org ([2001:4830:134:3::10]:35724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRBKk-0006pq-A9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRBKg-0001TK-S7
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:20:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRBKg-0001SX-MI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:20:22 -0500
Date: Wed, 11 Jan 2017 13:20:07 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170111052007.GA4450@pxdev.xzpeter.org>
References: <1483934694-32425-1-git-send-email-peterx@redhat.com>
	<1483934694-32425-2-git-send-email-peterx@redhat.com>
	<20170110172841.dlnj4ed2pppeh7r5@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170110172841.dlnj4ed2pppeh7r5@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v4 1/2] run_tests: put logs
 into per-test file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Tue, Jan 10, 2017 at 06:28:41PM +0100, Andrew Jones wrote:
> On Mon, Jan 09, 2017 at 12:04:53PM +0800, Peter Xu wrote:
> > We were using test.log before to keep all the test logs. This patch
> > creates one log file per test case under logs/ directory with name
> > "TESTNAME.log". Meanwhile, we will keep the last time log into
> > logs.old/.
> > 
> > Renaming scripts/functions.bash into scripts/common.bash to store some
> > more global variables.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  .gitignore                              |  3 ++-
> >  Makefile                                |  4 ++--
> >  run_tests.sh                            | 22 +++++++++++++++-------
> >  scripts/{functions.bash => common.bash} | 13 +++++++++++--
> >  scripts/mkstandalone.sh                 |  2 +-
> >  5 files changed, 31 insertions(+), 13 deletions(-)
> >  rename scripts/{functions.bash => common.bash} (75%)
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 3155418..0dc9a39 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -12,7 +12,8 @@ cscope.*
> >  /lib/asm
> >  /config.mak
> >  /*-run
> > -/test.log
> >  /msr.out
> >  /tests
> >  /build-head
> > +logs
> > +logs.old
> 
> Without the leading '/' logs[.old] files or dirs in subdirs will
> also be ignored. You can add trailing '/' to all the dirs in
> .gitignore too in order to ensure we only ignore dirs.

Will do.

> 
> > diff --git a/Makefile b/Makefile
> > index a32333b..bd8843a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -94,9 +94,9 @@ libfdt_clean:
> >  	$(LIBFDT_objdir)/.*.d
> >  
> >  distclean: clean libfdt_clean
> > -	$(RM) lib/asm config.mak $(TEST_DIR)-run test.log msr.out cscope.* \
> > +	$(RM) lib/asm config.mak $(TEST_DIR)-run msr.out cscope.* \
> >  	      build-head
> 
> Can move build-head up now

Yep.

[...]

> > -
> >  config=$TEST_DIR/unittests.cfg
> > -rm -f test.log
> > -printf "BUILD_HEAD=$(cat build-head)\n\n" > test.log
> > +
> > +rm -rf $unittest_log_dir.old
> > +if ! mv $unittest_log_dir $unittest_log_dir.log; then
> 
> You remove the destination above, so this should never fail.

Hmm looks so... :) Let me fix.

(And I used rm -rf again, but with ".old" it looks much safer so I
 dare to use it)

Thanks,

-- peterx
