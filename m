Received: from eggs.gnu.org ([209.51.188.92]:51222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grQkv-0000EX-Af
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1grQbJ-0007tl-11
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:03:07 -0500
References: <20190202005610.24048-1-crosa@redhat.com>
	<20190202005610.24048-3-crosa@redhat.com>
	<20190206153639.61a5411c.cohuck@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <85b0f519-38d8-cf7d-a22a-537dab8470a7@redhat.com>
Date: Wed, 6 Feb 2019 12:02:55 -0500
MIME-Version: 1.0
In-Reply-To: <20190206153639.61a5411c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/20] Acceptance tests: show avocado
 test execution by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>



On 2/6/19 9:36 AM, Cornelia Huck wrote:
> On Fri,  1 Feb 2019 19:55:52 -0500
> Cleber Rosa <crosa@redhat.com> wrote:
>=20
>> The current version of the "check-acceptance" target will only show
>> one line for execution of all tests.  That's probably OK if the tests
>> to be run are quick enough and they're always the same.
>>
>> But, there's already one test alone that takes on average ~5 seconds
>> to run, we intend to adapt the list of tests to match the user's build
>> environment (among other choices).
>=20
> Btw: What are our expectations regarding execution time for tests?
> Especially if we continue adding tests, and architecture-specific tests
> are bound to be slower if run on a foreign architecture via tcg.
>=20
> Would a make check-acceptance-quick command make sense? ("I only want
> to verify quickly that I didn't break too much, so run the quicker
> tests only, probably only for my host architecture")
>=20

Yes, it definitely makes sense.  Now, let me know if the following also
makes sense to you:

1) Because these tests focus on functional testing, the default
target/shortcut ("make check-acceptance") should run the complete set of
test cases (including the slow ones).

2) Requirements vary greatly from user to user, to while adding a
"check-acceptance-quick" is fine, you just mentioned one extra test
execution variation ("for my host architecture").  For those, the idea
is that:

 a) "make check-acceptance[-quick]" will adapt to the build environment
(if you only built s390x targets, that's all it's going to use)

 b) "avocado" command line interface *should* be easy enough to fulfill
other requirements, and not necessarily require a "make" target.  For
instance, if you're only interested in your host arch and one specific
machine type, a command line such as the following should do the trick:

  $ make check-venv
  $ ./tests/venv/bin/avocado run -t arch:`uname -m` -t
machine:WHAT_I_CARE_ABOUT tests/acceptance/

How does that sound?

Regards,
- Cleber.

>>
>> Because of that, let's present the default Avocado UI by default.
>> Users can always choose a different output by setting the AVOCADO_SHOW
>> variable.
>>
>> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  .travis.yml            | 2 +-
>>  tests/Makefile.include | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
