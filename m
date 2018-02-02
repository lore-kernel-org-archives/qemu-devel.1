Received: from eggs.gnu.org ([2001:4830:134:3::10]:54542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ehP1I-0004PM-OR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ehP0E-0007N2-Lk
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:15:56 -0500
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:42995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ehP0E-0007KH-1X
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 19:14:50 -0500
Received: by mail-lf0-x22a.google.com with SMTP id q17so28890233lfa.9
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 16:14:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a9e73657-211f-ba8b-8828-377e492b61c9@redhat.com>
References: <7e30d2cc-6c42-15e9-78ef-1085e081a386@redhat.com>
	<CAKmqyKOgFg09RAQQVfxHr2OfaNmYouhH=2nu+NT1uD87qZXzUg@mail.gmail.com>
	<a9e73657-211f-ba8b-8828-377e492b61c9@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Feb 2018 16:14:18 -0800
Message-ID: <CAKmqyKPjgYpMZpMOV=NXkKpKtFuoXFYpfy6k=4vKQB6Fw+bhHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Functional tests (AKA Avocado-based tests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Amador Pahim <apahim@redhat.com>, Jeff Nelson <jen@redhat.com>

On Thu, Jan 18, 2018 at 1:25 AM, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com=
> wrote:
> Dne 18.1.2018 v 00:41 Alistair Francis napsal(a):
>> On Wed, Jan 17, 2018 at 12:05 AM, Cleber Rosa <crosa@redhat.com> wrote:
>>> TL;DR
>>> =3D=3D=3D=3D=3D
>>>
>>> This is about how QEMU developers can get started with functional
>>> tests that are built on top of the Avocado libraries (and meant to be
>>> run with the Avocado test runner).
>>>
>>> The past
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> The Avocado project[1] has been working, for quite some time now, on a
>>> "set of tools and libraries" with the goal of making writing tests
>>> easier.  It is supposed to be a framework agnostic to the exact
>>> software that will be under test.
>>>
>>> But, at the same time, the Avocado project cannot deny its inheritance
>>> and influences.  Those come from Autotest[2], which had "KVM Autotest"
>>> as its largest and most developed "test".  This large Autotest test
>>> (KVM Autotest) became virt-test[3] and later got integrated into
>>> Avocado and became Avocado-VT[4] which is quite relevant here,
>>> together with its QEMU test provider[5].
>>>
>>> Avocado-VT and the QEMU test provider attempt to provide coverage
>>> across platform and QEMU versions, which increases its complexity.
>>> Also, it's built on a legacy set of principles and tools that makes
>>> some developers stir away from it.
>>>
>>> What's new?
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> A few months ago, the Avocado developers returned to its
>>> "virtualization origins", in an attempt to learn from the QEMU
>>> project, and try to help with a way to have more functional tests in
>>> the upstream QEMU repo.
>>>
>>> We believe it's possible to expand the test coverage for QEMU by
>>> facilitating
>>> the creation of more functional tests QEMU.  This is no different than =
how
>>> other types of tests are already included in the tree itself.
>>>
>>> How
>>> =3D=3D=3D
>>>
>>> How we did it (so far)
>>> ----------------------
>>>
>>> We're aware that there's a dilemma here: to be able to easily write
>>> more powerful tests, a lot of the complexity has to be moved
>>> elsewhere.  Here, it means moving complexity from the test itself to a
>>> framework.  The QEMU source tree itself has proofs of this approach,
>>> being the "scripts" and "tests/qemu-iotests" some of the examples.
>>>
>>> Avocado itself[1] provides a lot of the code that should help to
>>> absorb some of the complexities in writing tests, but not exactly
>>> everything that is needed for QEMU.  The approach we believe will have
>>> the best balance is to reuse upstream Avocado libraries whenever they
>>> are useful and generic enough, and on top of that, libraries that are
>>> part of QEMU itself.
>>>
>>> How can you get started with it
>>> -------------------------------
>>>
>>> First of all, get Avocado installed.  Besides the Avocado test runner
>>> itself, this will give you the basic libraries on which the other part
>>> of this work was built on.  We want that to be simple and painless, so
>>> here's our best bet for a one-liner installation:
>>>
>>>   pip install --user avocado-framework
>>> avocado-framework-plugin-varianter-yaml-to-mux aexpect
>>>
>>> That will install Avocado within the user's home directory.  If you
>>> give up on it, it can be uninstalled with another simple one-liner:
>>>
>>>   pip uninstall -y avocado-framework
>>> avocado-framework-plugin-varianter-yaml-to-mux aexpect
>>>
>>> Now, suppose you're working on a given feature, and want to try your
>>> luck writing a test using this work.  To avoid having you fetching and
>>> rebasing from our currently in development fork[6] and branch[7], you
>>> can just
>>> add one commit to your tree with:
>>>
>>>   curl
>>> https://patch-diff.githubusercontent.com/raw/apahim/qemu/pull/17.patch =
|
>>> git am -
>>>
>>> This will get a simple patch from a snapshot branch[8].  You can, of co=
urse,
>>> do it "the git way", fetching from that repo[6] and using the
>>> non-snapshotted branch.
>>>
>>> After that, we'd love for you to take a look at some of the existing
>>> tests[9][10] and then attempt to create test for your own use case.
>>> The basic README[11] file, and the Avocado documentation[12] are also
>>> important resources not to be missed.
>>>
>>> What's next?
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Initially, feedback is what we're looking for.  It would be greatly
>>> appreciated to understand if/how this suits (or not) use cases out
>>> there.
>>>
>>> After feedback, further refinements, and more tests are written, the
>>> Avocado developers will follow up with an initial patch series for
>>> upstream QEMU.  In such a proposal, we intend to have further
>>> integration.  Ideally in way that "configure" can be given a
>>> "--with-functional-[avocado-]tests" parameter of sorts, and a "make
>>>  [functional-]check" would seamlessly include them.
>>
>> I have a few thoughts.
>>
>> We use pytest/pexpect internally to kick off QEMU runs and monitor the
>> output (no interaction with the QEMU source tree) and I think it is
>> extremely useful. So I am all for using Python to test things and this
>> looks really well done!
>>
>> What I don't understand though is what this gives us compared to the
>> existing QEMU test infrastructure? Besides being able to use Python
>> and a better interface what are the main benefits? I think that is
>> something worth documenting somewhere.
>>
>
> Hello Alistar,
>
> It was just briefly mentioned by Cleber in the main email, but to be more=
 detailed there are 2 (3) benefits:
>
> 1. Using a test runner avoids boiler-plate code to create and provide res=
ults. Avocado is a test runner and can unify the execution as well as resul=
ts. Avocado results are compatible with multiple results DBs/systems and ev=
en allows diffing (you can see what changed between different executions).
>
> 2. Avocado is not just a test runner, but also set of utils. This can sim=
plify writing tests as one does not have to reinvent the wheel and can simp=
ly say "I require this pkg, install it", "I want to start this service" or =
run commands interactively without the need to worry about setting pty, rea=
ding-out the pipes etc.
>
> 3. There are at least three Red Hat employees based in virt team who work=
 on Avocado development. This means there is a background to support you th=
e community to simplify writing tests (avocado_qemu "helpers" are one examp=
le). In return we expect less regressions as more testing can be performed =
easily before releases/merges/during development.

Cool!

Sorry for the delay here.

If the test doesn't have to integrate with QEMU then does it make
sense to have a separate repo?

The way we handle this kind of testing is we just point to a built
QEMU tree and py.test runs tests on all of the binaries. That way they
can be developed independently, which has advantages and
disadvantages.

I don't have an answer, I was just wondering if you have thought about that=
.

Alistair

>
> Regards,
> Luk=C3=A1=C5=A1
>
>
>> Also, it looks like this will require images checked into git
>> somewhere is that correct? Is there a good plan on how to handle that?
>>
>> Alistair
>>
>>>
>>> Thanks!
>>>
>>> References
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>>  [1] http://avocado-framework.github.io/
>>>  [2] http://autotest.github.io/
>>>  [3] https://github.com/autotest/virt-test
>>>  [4] https://github.com/avocado-framework/avocado-vt
>>>  [5] https://github.com/autotest/tp-qemu
>>>  [6] https://github.com/apahim/qemu
>>>  [7] https://github.com/apahim/qemu/tree/avocado_qemu
>>>  [8] https://github.com/apahim/qemu/tree/avocado_qemu_snapshot
>>>  [9]
>>> https://github.com/apahim/qemu/blob/avocado_qemu/tests/avocado/test_inf=
o_memdev_host_nodes.py
>>> [10]
>>> https://github.com/apahim/qemu/blob/avocado_qemu/tests/avocado/test_ovm=
f_with_240_vcpus.py
>>> [11]
>>> https://github.com/apahim/qemu/blob/avocado_qemu/tests/avocado/README.r=
st
>>> [12] http://avocado-framework.readthedocs.io/
>>>
>>> --
>>> Cleber Rosa
>>> [ Sr Software Engineer - Virtualization Team - Red Hat ]
>>> [ Avocado Test Framework - avocado-framework.github.io ]
>>> [  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
>>>
>
>
