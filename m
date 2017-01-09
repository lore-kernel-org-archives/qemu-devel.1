Received: from eggs.gnu.org ([2001:4830:134:3::10]:51117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cQQP1-0003Ih-23
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cQQOx-0001Ew-S9
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:13:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cQQOx-0001Er-Jd
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:13:39 -0500
Date: Mon, 9 Jan 2017 11:13:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170109031333.GF4135@pxdev.xzpeter.org>
References: <1483673581-7843-1-git-send-email-peterx@redhat.com>
	<1483673581-7843-2-git-send-email-peterx@redhat.com>
	<20170106135158.ml3t7nxgpoi4zedp@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106135158.ml3t7nxgpoi4zedp@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v3 1/2] run_tests: put logs
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

On Fri, Jan 06, 2017 at 02:51:58PM +0100, Andrew Jones wrote:
> On Fri, Jan 06, 2017 at 11:33:00AM +0800, Peter Xu wrote:
> > We were using test.log before to keep all the test logs. This patch
> > creates one log file per test case under logs/ directory with name
> > "TESTNAME.log".
> > 
> > A new file global.bash is added to store global informations.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  Makefile               |  4 ++--
> >  run_tests.sh           | 14 ++++++++------
> >  scripts/functions.bash | 11 +++++++++--
> >  scripts/global.bash    |  2 ++
> >  4 files changed, 21 insertions(+), 10 deletions(-)
> >  create mode 100644 scripts/global.bash
> > 
> > diff --git a/Makefile b/Makefile
> > index a32333b..f632c6c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -94,9 +94,9 @@ libfdt_clean:
> >  	$(LIBFDT_objdir)/.*.d
> >  
> >  distclean: clean libfdt_clean
> > -	$(RM) lib/asm config.mak $(TEST_DIR)-run test.log msr.out cscope.* \
> > +	$(RM) lib/asm config.mak $(TEST_DIR)-run msr.out cscope.* \
> >  	      build-head
> > -	$(RM) -r tests
> > +	$(RM) -r tests logs
> 
> We need .gitignore changes for this.

Yep.

> 
> >  
> >  cscope: cscope_dirs = lib lib/libfdt lib/linux $(TEST_DIR) $(ARCH_LIBDIRS) lib/asm-generic
> >  cscope:
> > diff --git a/run_tests.sh b/run_tests.sh
> > index 254129d..e1bb3a6 100755
> > --- a/run_tests.sh
> > +++ b/run_tests.sh
> > @@ -7,6 +7,7 @@ if [ ! -f config.mak ]; then
> >      exit 1
> >  fi
> >  source config.mak
> > +source scripts/global.bash
> >  source scripts/functions.bash
> 
> Rather than add a new file, can't we just rename functions.bash to
> something less function specific (common.bash?) and then add the
> globals to that?

Sure, common.bash is a good one, will use that.

> 
> >  
> >  function usage()
> > @@ -46,17 +47,18 @@ while getopts "g:hv" opt; do
> >      esac
> >  done
> >  
> > -RUNTIME_log_stderr () { cat >> test.log; }
> > +# RUNTIME_log_file will be configured later
> > +RUNTIME_log_stderr () { cat >> $RUNTIME_log_file; }
> >  RUNTIME_log_stdout () {
> >      if [ "$PRETTY_PRINT_STACKS" = "yes" ]; then
> > -        ./scripts/pretty_print_stacks.py $1 >> test.log
> > +        ./scripts/pretty_print_stacks.py $1 >> $RUNTIME_log_file
> >      else
> > -        cat >> test.log
> > +        cat >> $RUNTIME_log_file
> >      fi
> >  }
> >  
> > -
> >  config=$TEST_DIR/unittests.cfg
> > -rm -f test.log
> > -printf "BUILD_HEAD=$(cat build-head)\n\n" > test.log
> > +rm -rf $ut_log_dir
> 
> Instead of the 'rm', let's do
>  'mv $ut_log_dir $ut_log_dir.old || { echo [...]; exit 2; }'
> as I never liked that test.log was silently overwritten.

"Move" is indeed a much better way than "remove", especially "rm -rf"
(I think I should avoid using "rm -rf" in the future scripts as
well...). Will fix it.

> 
> > +mkdir $ut_log_dir
> > +printf "BUILD_HEAD=$(cat build-head)\n\n" > $ut_log_summary
> 
> I'm not sure we need the ut_ prefix on these variables. If we
> do think we need to start prefixing variables, then I'd prefer
> not to abbreviate, i.e. 'unittest_'

Since I would prefer a prefix, I'll use "unittest_" then.

[...]

> > diff --git a/scripts/global.bash b/scripts/global.bash
> > new file mode 100644
> > index 0000000..77b0b29
> > --- /dev/null
> > +++ b/scripts/global.bash
> > @@ -0,0 +1,2 @@
> > +: ${ut_log_dir:=logs}
> > +: ${ut_log_summary:=${ut_log_dir}/SUMMARY}
> 
> Do we even need these variables? When/why would someone override these
> defaults?

I use variables when I write constant more than once. This suites the
case for log_dir. I can remove the latter log_summary, but I'll still
prefer keep the log_dir if you don't mind.

Thanks!

-- peterx
