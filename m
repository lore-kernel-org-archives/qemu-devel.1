Received: from eggs.gnu.org ([2001:4830:134:3::10]:53974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1ebyN3-00074g-8h
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 19:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1ebyN0-0000fF-2u
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 19:47:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ebyMz-0000ee-Py
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 19:47:54 -0500
References: <7e30d2cc-6c42-15e9-78ef-1085e081a386@redhat.com>
	<CAKmqyKOgFg09RAQQVfxHr2OfaNmYouhH=2nu+NT1uD87qZXzUg@mail.gmail.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <b4b9f8f0-38f3-adc5-6dbb-13d5cc7cb41f@redhat.com>
Date: Wed, 17 Jan 2018 19:47:33 -0500
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOgFg09RAQQVfxHr2OfaNmYouhH=2nu+NT1uD87qZXzUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Functional tests (AKA Avocado-based tests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Jeff Nelson <jen@redhat.com>



On 01/17/2018 06:41 PM, Alistair Francis wrote:
> On Wed, Jan 17, 2018 at 12:05 AM, Cleber Rosa <crosa@redhat.com> wrote:
>> TL;DR
>> =====
>>
>> This is about how QEMU developers can get started with functional
>> tests that are built on top of the Avocado libraries (and meant to be
>> run with the Avocado test runner).
>>
>> The past
>> ========
>>
>> The Avocado project[1] has been working, for quite some time now, on a
>> "set of tools and libraries" with the goal of making writing tests
>> easier.  It is supposed to be a framework agnostic to the exact
>> software that will be under test.
>>
>> But, at the same time, the Avocado project cannot deny its inheritance
>> and influences.  Those come from Autotest[2], which had "KVM Autotest"
>> as its largest and most developed "test".  This large Autotest test
>> (KVM Autotest) became virt-test[3] and later got integrated into
>> Avocado and became Avocado-VT[4] which is quite relevant here,
>> together with its QEMU test provider[5].
>>
>> Avocado-VT and the QEMU test provider attempt to provide coverage
>> across platform and QEMU versions, which increases its complexity.
>> Also, it's built on a legacy set of principles and tools that makes
>> some developers stir away from it.
>>
>> What's new?
>> ===========
>>
>> A few months ago, the Avocado developers returned to its
>> "virtualization origins", in an attempt to learn from the QEMU
>> project, and try to help with a way to have more functional tests in
>> the upstream QEMU repo.
>>
>> We believe it's possible to expand the test coverage for QEMU by
>> facilitating
>> the creation of more functional tests QEMU.  This is no different than how
>> other types of tests are already included in the tree itself.
>>
>> How
>> ===
>>
>> How we did it (so far)
>> ----------------------
>>
>> We're aware that there's a dilemma here: to be able to easily write
>> more powerful tests, a lot of the complexity has to be moved
>> elsewhere.  Here, it means moving complexity from the test itself to a
>> framework.  The QEMU source tree itself has proofs of this approach,
>> being the "scripts" and "tests/qemu-iotests" some of the examples.
>>
>> Avocado itself[1] provides a lot of the code that should help to
>> absorb some of the complexities in writing tests, but not exactly
>> everything that is needed for QEMU.  The approach we believe will have
>> the best balance is to reuse upstream Avocado libraries whenever they
>> are useful and generic enough, and on top of that, libraries that are
>> part of QEMU itself.
>>
>> How can you get started with it
>> -------------------------------
>>
>> First of all, get Avocado installed.  Besides the Avocado test runner
>> itself, this will give you the basic libraries on which the other part
>> of this work was built on.  We want that to be simple and painless, so
>> here's our best bet for a one-liner installation:
>>
>>   pip install --user avocado-framework
>> avocado-framework-plugin-varianter-yaml-to-mux aexpect
>>
>> That will install Avocado within the user's home directory.  If you
>> give up on it, it can be uninstalled with another simple one-liner:
>>
>>   pip uninstall -y avocado-framework
>> avocado-framework-plugin-varianter-yaml-to-mux aexpect
>>
>> Now, suppose you're working on a given feature, and want to try your
>> luck writing a test using this work.  To avoid having you fetching and
>> rebasing from our currently in development fork[6] and branch[7], you
>> can just
>> add one commit to your tree with:
>>
>>   curl
>> https://patch-diff.githubusercontent.com/raw/apahim/qemu/pull/17.patch |
>> git am -
>>
>> This will get a simple patch from a snapshot branch[8].  You can, of course,
>> do it "the git way", fetching from that repo[6] and using the
>> non-snapshotted branch.
>>
>> After that, we'd love for you to take a look at some of the existing
>> tests[9][10] and then attempt to create test for your own use case.
>> The basic README[11] file, and the Avocado documentation[12] are also
>> important resources not to be missed.
>>
>> What's next?
>> ============
>>
>> Initially, feedback is what we're looking for.  It would be greatly
>> appreciated to understand if/how this suits (or not) use cases out
>> there.
>>
>> After feedback, further refinements, and more tests are written, the
>> Avocado developers will follow up with an initial patch series for
>> upstream QEMU.  In such a proposal, we intend to have further
>> integration.  Ideally in way that "configure" can be given a
>> "--with-functional-[avocado-]tests" parameter of sorts, and a "make
>>  [functional-]check" would seamlessly include them.
> 
> I have a few thoughts.
> 
> We use pytest/pexpect internally to kick off QEMU runs and monitor the
> output (no interaction with the QEMU source tree) and I think it is
> extremely useful. So I am all for using Python to test things and this
> looks really well done!
> 

Thanks for checking it out, and for the positive words.  Now, sorry if
I'm missing some obvious information, but is this work of yours with
pytest/pexpect publicly available?  I'd like to also take a look at
that, because it does look similar to the Avocado + aexpect approach
taken here.

> What I don't understand though is what this gives us compared to the
> existing QEMU test infrastructure? Besides being able to use Python
> and a better interface what are the main benefits? I think that is
> something worth documenting somewhere.
> 

We currently intend to *add* to the QEMU test infrastructure, not
replace it.

The benefits we envision are, besides hopefully easier and more capable
interfaces, to simply have more upstream tests.  This means avoiding new
regressions and improving coverage.

> Also, it looks like this will require images checked into git
> somewhere is that correct? Is there a good plan on how to handle that?
> 

It won't require images checked into git.  Right now, tests use the
vmimage library:

http://avocado-framework.readthedocs.io/en/57.0/api/utils/avocado.utils.html#avocado.utils.vmimage.get

Which downloads (and caches) images from external sources.

Please let me know if you have more questions!
- Cleber.

> Alistair
> 
>>
>> Thanks!
>>
>> References
>> ==========
>>
>>  [1] http://avocado-framework.github.io/
>>  [2] http://autotest.github.io/
>>  [3] https://github.com/autotest/virt-test
>>  [4] https://github.com/avocado-framework/avocado-vt
>>  [5] https://github.com/autotest/tp-qemu
>>  [6] https://github.com/apahim/qemu
>>  [7] https://github.com/apahim/qemu/tree/avocado_qemu
>>  [8] https://github.com/apahim/qemu/tree/avocado_qemu_snapshot
>>  [9]
>> https://github.com/apahim/qemu/blob/avocado_qemu/tests/avocado/test_info_memdev_host_nodes.py
>> [10]
>> https://github.com/apahim/qemu/blob/avocado_qemu/tests/avocado/test_ovmf_with_240_vcpus.py
>> [11]
>> https://github.com/apahim/qemu/blob/avocado_qemu/tests/avocado/README.rst
>> [12] http://avocado-framework.readthedocs.io/
>>
>> --
>> Cleber Rosa
>> [ Sr Software Engineer - Virtualization Team - Red Hat ]
>> [ Avocado Test Framework - avocado-framework.github.io ]
>> [  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
>>

-- 
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
