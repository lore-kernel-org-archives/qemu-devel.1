Received: from eggs.gnu.org ([2001:4830:134:3::10]:44398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkR8q-0000UQ-Fl
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkR8n-0005JR-De
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:36:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dkR8n-0005Ik-5H
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:35:57 -0400
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
	<20170823091650.48e7c44e.cohuck@redhat.com>
	<54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
	<5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
Date: Wed, 23 Aug 2017 10:35:43 +0200
MIME-Version: 1.0
In-Reply-To: <5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On 23.08.2017 10:01, Paolo Bonzini wrote:
> On 23/08/2017 09:49, Thomas Huth wrote:
>> While we're at it: I'd like to have a "make check-fast", too. Sometime=
s
>> the normal "make check" is already too slow, e.g. while developing new
>> patches, I sometimes just want to do a very quick sanity test to see
>> whether I broke some basic things or not, and only do the "make check"
>> before I submit my patches.
>> So we would get three stages:
>>
>> - make check-fast =3D> For very, very quick sanity tests only
>>
>> - make check =3D> E.g. has to be run before submitting patches
>>
>> - make check-harder =3D> might run a very long time, so best suited fo=
r
>>                        nightly regression tests etc.?
>>
>> Does that sound reasonable? And the crucial question: Who is going to
>> implement the basic framework for this?
>=20
> There's already make check-unit or make check-qtest-x86_64 depending on
> what you're working on.

True. And I just learned that you can also already set the SPEED
variable to either "quick" or "slow" and that we're already using
g_test_quick() and g_test_slow() in a couple of places to check this. So
the framework for running quick vs. thorough tests is already there ...
we just might want to add this to some more tests, I guess...

Question for the maintainers and the test automation folks: Is anybody
already running "make check SPEED=3Dslow" or is this just rather an
unheard-of way of running the tests?

> If you have a many-core machine, of course, there's no simpler solution
> than throwing more CPUs at it. :)

Is it safe nowadays to run "make check -j4" for example? Last time I
tried (maybe 1 or 2 years ago), there were still issues since some tests
were using hard-coded temporary file names, so the parallel tests were
disturbing each other, for example...

 Thomas
