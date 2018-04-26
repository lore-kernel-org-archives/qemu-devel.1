Received: from eggs.gnu.org ([2001:4830:134:3::10]:54431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fBhPQ-0004VN-Ea
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fBhPL-0004LZ-Jw
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fBhPL-0004KA-A5
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:57:59 -0400
Date: Thu, 26 Apr 2018 10:57:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180426135755.GI29865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Yash Mankad <ymankad@redhat.com>

(Starting a new thread, for more visibility)

(This was: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test
devices with all machines, not only with "none")

On Thu, Apr 26, 2018 at 01:54:43PM +0200, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> > On 17.04.2018 14:12, Markus Armbruster wrote:
> >> Thomas Huth <thuth@redhat.com> writes:
> >> 
> >>> Many device introspection crashes only happen if you are using a
> >>> certain machine, e.g.:
> >>>
> >>> $ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=qtest -qmp stdio
> >>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
> >>>  "package": "build-all"}, "capabilities": []}}
> >>> { 'execute': 'qmp_capabilities' }
> >>> {"return": {}}
> >>> { 'execute': 'device-list-properties',
> >>>   'arguments': {'typename': 'macio-newworld'}}
> >>> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
> >>> Device 'serial0' is in use
> >>> Aborted (core dumped)
> >>>
> >>> To be able to catch these problems, let's extend the device-introspect
> >>> test to check the devices on all machine types. Since this is a rather
> >>> slow operation, the test is only run in "SPEED=slow" mode.
> >> 
> >> If the device works with one machine type, it has a decent chance to
> >> work with others, too.  Thus, testing each device with every machine
> >> type is overkill.  I appreciate having overkill as an option :)
> >> 
> >> What I'd like to see for a quick "make check" is testing each device
> >> once.  That should flush out most bugs.  
> >
> > That's already done with the "none" machine.
> 
> I was too terse.  We test each device with -machine none for every
> target.  Fine if that's quick enough.  If not, we might want to reduce
> redundancy there.
> 
> Actually, a worse offender in the "waste everybody's time via redunancy"
> department could be qom-test.
> 
> > Anyway, do you think my patch here is useful and has a chance of getting
> > included? I.e. shall I re-spin this as a non-RFC patch? Or shall we
> > rather wait for Eduardo's python-based tests to get included into the
> > repository?
> 
> I don't mind having make check SPEED=slow run more extensive tests.
> Assuming we actually run them at least once in a while, which seems
> doubtful.

We probably don't do that, but we really must be running a more
extensive (and slower) test set at least once before every
release.

Maybe some people are running SPEED=slow tests, or even more
extensive test suites like avocado-vt once in a while, but we
need to know who is running them, and when.

Today, the only test set I know people really run and would
surely block a release is "make check [SPEED=quick]".

So, for anybody that runs automated QEMU tests once in a while,
can we know:

* What test cases are you running?  Where can we get more
  information about the tests you run?
* When do you run them?  What triggers a new test run?

Peter, do you have additional tests you run before merging a pull
request?  Additional test sets run before tagging a release?

-- 
Eduardo
