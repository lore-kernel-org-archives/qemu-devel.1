Received: from eggs.gnu.org ([2001:4830:134:3::10]:34271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fMG9I-0000NM-CM
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fMG9G-00037a-Uo
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:05:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fMG9G-00037P-Pq
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:05:02 -0400
References: <20180525005839.11556-1-crosa@redhat.com>
	<20180525060827.GD28589@lemon.usersys.redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <c62333c5-aca4-9d9b-2c1c-af040d5ec7cb@redhat.com>
Date: Fri, 25 May 2018 13:04:57 -0400
MIME-Version: 1.0
In-Reply-To: <20180525060827.GD28589@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] Acceptance/functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Amador Pahim <amador@pahim.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 05/25/2018 02:08 AM, Fam Zheng wrote:
> On Thu, 05/24 20:58, Cleber Rosa wrote:
>> TL;DR
>> =====
>>
>> Another version, with a minimalist approach, to the acceptance tests
>> infrastructure for QEMU, based on the Avocado Testing Framework.
>>
>> Background
>> ==========
>>
>> The previous version, still considered an RFC, was sent to the list by
>> Eduardo[1] was based on the work held in Amador's branch[2].  After
>> reviewing in under a different light, including the experiences
>> done and reported by Philippe[3].
>>
>> Differences from previous versions
>> ==================================
>>
>> The main difference is that this series include only the minimal
>> changes deemed necessary to have a starting point.  I like to think
>> that it's better connected to the QEMU community and project needs,
>> and will hopefully allow for a more organic growth.
>>
>> Since this version has less features than the previous versions,
>> provided it's accepted, these are the next probable development tasks:
>>
>>  * Provide a simple variants mechanism to allow the same tests to be
>>    run under different targets, machine models and devices (present on
>>    the previous versions as a "YAML to Mux" file with architecture
>>    definitions)
>>  * Implement QEMUMachine migration support (present on the previous
>>    version in the "avocado_qemu.test._VM" class)
>>  * Implement Guest OS image selection and download (mostly an Avocado
>>    feature, paired with a parameter convention and cloud-init support
>>    code)
>>  * Implement interactive support for Guest OS sessions (present on
>>    the previous versions, supported by the aexpect Python module)
>>
>> Even though this version shares very little (if any) code with the
>> previous versions, the following is a list of noteworthy changes:
>>
>>  * Tests directory is now "tests/acceptance" (was "tests/avocado")
>>  * Base test class is now "avocado_qemu.Test" (was
>>    "avocado_qemu.test.QemuTest")
>>  * Base test class is now hosted in "avocado_qemu/__init__.py" (was
>>    "avocado_qemu/test.py")
>>  * Direct use of "qemu.QEMUMachine", that is, the
>>    avocado_qemu.test._VM class is gone
>>  * avocado_qemu.Test won't search for QEMU binaries on $PATH.  To use
>>    QEMU binary on a custom system location it's necessary to use the
>>    "qemu_bin" parameter
>>  * Example test in README.rst is distributed as a real test
>>    ("test_version.py")
>>  * A new "Linux boot console" test, loosely modeled after Phillipe's
>>    use case
> 
> I like the direction this series is leading us to.  Making it easy to write
> 'correct' and 'effective' tests is the most important thing IMO, and the few
> tests you add here look promising.
> 

The soft targets that these adjectives ("easy", "correct" and
"effective") bring, are kind of hard to get right, but I'm really glad
you like what you see.

> I'm also curious to see a test case involving a guest OS image. (I'm also open to
> a re-implementation of tests/vm/basevm.py with Avocado, if you find it
> worthwhile.)
> 

We had such tests in the previous incarnations of this work[1].  But by
doing it in smaller steps, I believe we can achieve a better result,
specially when it comes to the exposed API.

- Cleber.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03466.html

> Fam
> 
>>
>> Commit summary
>> ==============
>>
>> Cleber Rosa (5):
>>   Add functional/acceptance tests infrastructure
>>   scripts/qemu.py: allow adding to the list of extra arguments
>>   Acceptance tests: add quick VNC tests
>>   scripts/qemu.py: introduce set_console() method
>>   Acceptance tests: add Linux kernel boot and console checking test
>>
>>  scripts/qemu.py                             | 103 +++++++++++++++-
>>  scripts/test_qemu.py                        | 176 +++++++++++++++++++++++++++
>>  tests/acceptance/README.rst                 | 141 +++++++++++++++++++++
>>  tests/acceptance/avocado_qemu/__init__.py   |  45 +++++++
>>  tests/acceptance/test_boot_linux_console.py |  37 ++++++
>>  tests/acceptance/test_version.py            |  13 ++
>>  tests/acceptance/test_vnc.py                |  50 ++++++++
>>  7 files changed, 564 insertions(+), 1 deletion(-)
>>  create mode 100644 scripts/test_qemu.py
>>  create mode 100644 tests/acceptance/README.rst
>>  create mode 100644 tests/acceptance/avocado_qemu/__init__.py
>>  create mode 100644 tests/acceptance/test_boot_linux_console.py
>>  create mode 100644 tests/acceptance/test_version.py
>>  create mode 100644 tests/acceptance/test_vnc.py
>>
>> ---
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03443.html
>> [2] https://github.com/apahim/qemu/commits/avocado_qemu
>> [3] https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03076.html
>>
> 
