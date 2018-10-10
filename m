Received: from eggs.gnu.org ([2001:4830:134:3::10]:53049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gAIf0-00008C-EU
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gAIex-0003n2-7F
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gAIew-0003mI-Tl
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:52:35 -0400
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-5-crosa@redhat.com>
	<835fcb24-5832-9e6c-9f57-0364f0bf849a@redhat.com>
	<95a8561c-0511-6a8a-a3eb-25d556029e7a@redhat.com>
	<20181010134656.GE5738@habkost.net>
	<47f72e98-335f-b3c9-54c7-4c8a468d85d6@redhat.com>
	<26fe2055-77c2-45fa-4e88-62101d70b88b@redhat.com>
	<20181010142840.GH5738@habkost.net>
	<118ed8f7-5947-12c6-f3f6-b10597f37aac@redhat.com>
	<CAFEAcA9NBu+L4wHfkLTv93wy90wjnV05EZ12PT6PmLjdZ5h_YA@mail.gmail.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <00aa913d-a7e9-3c5d-34a8-fc9ff59091db@redhat.com>
Date: Wed, 10 Oct 2018 13:52:25 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9NBu+L4wHfkLTv93wy90wjnV05EZ12PT6PmLjdZ5h_YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] scripts/qemu.py: set predefined
 machine type based on arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 10/10/18 12:23 PM, Peter Maydell wrote:
> On 10 October 2018 at 16:47, Cleber Rosa <crosa@redhat.com> wrote:
>> To make sure we're on the same page, we're still going to have default
>> machine types, based on the arch, for those targets that don't provide
>> one (aarch64 is one example).  Right?
> 
> Does it make sense to define a default? The reason arm
> doesn't specify a default machine type is because you
> can't just run any old guest on any old machine type.
> You need to know "this guest image will run on machine
> type X", and run it on machine type X. This is like
> knowing you need to run a test on x86 PC and not
> on PPC spapr.
> 

While requiring tests to specify every single aspect of the environment
that will be used may be OK for low level unit tests, it puts a lot of
burden on higher level tests (which is supposed to be the vast majority
under tests/acceptance).

>From a test writer perspective, working on these higher level tests, it
may want to make sure that feature "X", unrelated to the target arch,
machine type, etc, "just works".  You man want to look at the "vnc.py"
test for a real world example.

Eduardo has suggested that "make check-acceptance" runs all (possible)
tests on all target archs by default.

> Would it make more sense for each test to specify
> which machine types it can work on?
> 

I think it does, but I believe in the black list approach, instead of
the white list.

The reason for that is that I believe that majority of the tests under
"tests/acceptance" can be made to work on every target (which would be
the default).  So far, I've made sure tests behave correctly on the 5
arches included in the "archs.json" file in this series (x86_64, ppc64,
ppc, aarch64, s390x).

To give a full disclosure, "boot_linux.py" (boots a linux kernel) is
x86_64 specific, and CANCELS when asked to be run on other archs.  But,
on the work I've done top of these series, it already works with ppc64
and aarch64.  Also, "boot_linux.py" sent in another series, (which boots
a full linux guest) is also being adapted to work on most of the target
archs.

And, as an exception, you can still define/check the arch and machine
type *in the test*, if it's not supposed to work on most.

Does that make sense?
- Cleber.

> thanks
> -- PMM
> 
