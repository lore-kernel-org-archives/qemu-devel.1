Received: from eggs.gnu.org ([2001:4830:134:3::10]:47867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKnXA-0000mT-1V
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKnX8-0001K5-SI
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:51:55 -0500
Date: Thu, 8 Nov 2018 14:51:36 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181108165136.GK12503@habkost.net>
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
	<20181106141302.GP12503@habkost.net>
	<87efbxxw1c.fsf@dusky.pond.sub.org>
	<8ecdbb0e-aaf8-ddc5-6442-87977585d9d8@redhat.com>
	<87y3a4ot3g.fsf@dusky.pond.sub.org>
	<f69012ad-af21-783c-d378-acd3131451e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69012ad-af21-783c-d378-acd3131451e4@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tests: Fix Python 3 detection
 on older GNU make versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, Nov 08, 2018 at 11:06:45AM -0500, Cleber Rosa wrote:
> 
> 
> On 11/8/18 3:45 AM, Markus Armbruster wrote:
> > Cleber Rosa <crosa@redhat.com> writes:
> > 
> >> On 11/7/18 1:05 AM, Markus Armbruster wrote:
> >>> Eduardo Habkost <ehabkost@redhat.com> writes:
> >>>
> >>>> The $(SHELLSTATUS) variable requires GNU make >= 4.2, but Travis
> >>>> seems to provide an older version.  Change the existing rules to
> >>>> use command output instead of exit code, to make it compatible
> >>>> with older GNU make versions.
> >>>>
> >>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >>>> ---
> >>>> I think that's the cause of the Travis failures.  I have
> >>>> submitted a test job right now, at:
> >>>>   https://travis-ci.org/ehabkost/qemu-hacks/jobs/451387962
> >>>> Let's see if it fixes the issue.
> >>>> ---
> >>>>  tests/Makefile.include | 4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
> >>>> index d2e577eabb..074eece558 100644
> >>>> --- a/tests/Makefile.include
> >>>> +++ b/tests/Makefile.include
> >>>> @@ -913,8 +913,8 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
> >>>>  # information please refer to "avocado --help".
> >>>>  AVOCADO_SHOW=none
> >>>>  
> >>>> -$(shell $(PYTHON) -c 'import sys; assert sys.version_info >= (3,0)' >/dev/null 2>&1)
> >>>> -ifeq ($(.SHELLSTATUS),0)
> >>>> +PYTHON3 = $(shell $(PYTHON) -c 'import sys; print(1 if sys.version_info >= (3, 0) else 0)')
> >>>> +ifeq ($(PYTHON3), 1)
> >>>>  $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
> >>>>  	$(call quiet-command, \
> >>>>              $(PYTHON) -m venv --system-site-packages $@, \
> >>>
> >>> PEP 394 recommends software distributions install Python 3 into the
> >>> default path as python3, and users use that instead of python, except
> >>> for programs that are source compatible with both 2 and 3.  So, is
> >>> finding out whether python is a Python 3 really appropriate?  Why can't
> >>> we just use python3 and be done with it?
> >>>
> >>
> >> I mentioned that before, when you pointed out the issue you fix here,
> >> that configure may be the best place to get the Python version (not only
> >> the major version) and make it available elsewhere.  Even if not used
> >> for other purposes, it is IMO important information to show on the
> >> resulting "configure" output.
> >>
> >> I'm sending patches to do that in a few.
> >>
> >>> If we can't: isn't this a configure problem?
> >>>
> >>
> >> I believe adhering to PEP394 is a good thing, but even that document
> >> recognizes that the real world is not a perfect place: "however, end
> >> users should be aware that python refers to python3 on at least Arch
> >> Linux".  And it only covers *nix systems, so if we hope to care for
> >> non-*nix systems, we have to check the Python version manually.
> >>
> >> So, I guess the safest approach from QEMU's side is to check for the
> >> version indeed.
> > 
> > If somebody can point to a system people still use where python3 doesn't
> > get you a Python 3, but python does, catering for such (crappy) systems
> > in configure makes sense.  Until then, it's a waste of brain waves and
> > configure run time.
> > 
> > PEP 394 mentions Arch Linux.  It's been seven years.  What's the most
> > recent version of Arch Linux that's still crappy in this regard?
> > 
> 
> I'm not taking the mission of looking for those odd distros, I agree
> it's not productive.  My point is that the Python version is an
> important thing to keep track of, specially with the advent of running
> Python dependent tests on environments we don't fully control.
> 
> Supposing the Python version is captured and tracked by configure, then
> the "python" binary name becomes a non-issue.

I'm not sure I agree with the "is an important thing to keep
track of" part.  I don't think we'll have any need to keep track
of the Python version in shell script or makefiles after we start
requiring Python 3.

Extra cleanups (like moving version checks to ./configure) are
still welcome, but keep in mind that this will probably be thrown
away once we drop Python 2 support.

-- 
Eduardo
