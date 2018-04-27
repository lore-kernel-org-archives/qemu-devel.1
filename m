Received: from eggs.gnu.org ([2001:4830:134:3::10]:42950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fC6Ga-0003kE-Ag
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fC6GY-00079p-Ix
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:30:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
	<62dba5cf-b497-1a98-0af5-971e169a3458@redhat.com>
	<877eou2nek.fsf@dusky.pond.sub.org>
	<099d2af4-8fe3-f80c-693f-495accb26a17@redhat.com>
	<CAFEAcA_VAckXDgARe5dJdxe9N19quUD5Dn+Dseuj=itLbFmG0g@mail.gmail.com>
	<40c06711-f9a0-3440-9a47-8230cbcb3d55@redhat.com>
Date: Fri, 27 Apr 2018 18:30:18 +0200
In-Reply-To: <40c06711-f9a0-3440-9a47-8230cbcb3d55@redhat.com> (Thomas Huth's
	message of "Fri, 27 Apr 2018 12:24:57 +0200")
Message-ID: <87muxoehnp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-arm]  qom-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Thomas Huth <thuth@redhat.com> writes:

> On 27.04.2018 12:20, Peter Maydell wrote:
>> On 27 April 2018 at 07:06, Thomas Huth <thuth@redhat.com> wrote:
>>> On 26.04.2018 13:54, Markus Armbruster wrote:
>>> [...]
>>>> Actually, a worse offender in the "waste everybody's time via redunancy"
>>>> department could be qom-test.

Supporting numbers:

$ time for i in *-softmmu/qemu-system-*; do [ -x $i ] || continue; QTEST_QEMU_BINARY=$i QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} gtester -k --verbose -m=quick  tests/qom-test ; done
[...]
real	3m27.427s
user	2m7.141s
sys	1m44.354s

aarch64, arm, i386, x86_64 each take more than 30s.

For each target, we walk /machine and qom-get every property.  The test
passes if qom-get doesn't crash, the values we get don't matter.

For x86_64 alone, qom-test executes qom-get more than 45,000 times to
test almost 9,500 objects.  It gets the properties of more than 5000
qemu:memory-region objects, more than 2500 irq objects, almost 300
smbus-eeprom objects, 110 IDE objects, ...  It's nice we can test
qom-get doesn't crash on any of IDE's properties in 110 very slight
variations.  But most of the time, one of the variations would be
enough.

>>> Shall we change qom-test to also only test with the "none" machine in
>>> the normal "make check" mode and only do the full test with all machines
>>> in "make check SPEED=slow" ?
>> 
>> We definitely want something that tries to instantiate every
>> machine, because that does catch bugs.
>
> Yes, after having a closer look at this one, I also think that we should
> *not* change it to run with "none" by default only. The 'qom-list'
> command results in quite a different output depending on which machine
> you run it on.

Only running "none" is too naive.
