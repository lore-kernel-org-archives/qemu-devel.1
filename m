Received: from eggs.gnu.org ([2001:4830:134:3::10]:46982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gOolN-0001MN-Lo
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gOolL-0000zS-S8
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:59:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gOolL-0000yR-KB
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:59:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3346280495
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 18:59:10 +0000 (UTC)
Date: Mon, 19 Nov 2018 16:59:01 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181119185901.GY3807@habkost.net>
References: <20181109195800.19071-1-wainersm@redhat.com>
	<20181112163140.GM12503@habkost.net>
	<b566882d-18bd-4bc0-96a0-0c2728a785db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b566882d-18bd-4bc0-96a0-0c2728a785db@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Acceptance test: add coverage tests for
 -smp option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org, crosa@redhat.com, philmd@redhat.com, ccarrara@redhat.com

On Mon, Nov 19, 2018 at 04:48:00PM -0200, Wainer dos Santos Moschetta wro=
te:
> On 11/12/2018 02:31 PM, Eduardo Habkost wrote:
> > On Fri, Nov 09, 2018 at 02:58:00PM -0500, Wainer dos Santos Moschetta=
 wrote:
> > > This adds tests for SMP option, by passing -smp with
> > > various combinations of cpus, cores, threads, and sockets
> > > values it checks that invalid topologies are not accepted
> > > as well as missing values are correctly calculated.
> > >=20
> > > Signed-off-by: Wainer dos Santos Moschetta<wainersm@redhat.com>
> > The test code looks nice to me, but: how exactly do you expect
> > this to be executed?
>=20
> 'make check-acceptance' executes it with default parameters (i.e. cores=
=3D2,
> threads=3D2, sockets=3D2, and cpus=3D8).
>=20
> It is possible to overwrite the default parameters by using Avocado's -=
p
> option. For example, 'avocado run -p sockets=3D1 -p cores=3D2 -p thread=
s=3D1
> tests/acceptance/smp_option_coverage.py'.
>=20
> > Do we have a test runner or multiplexer configuration already
> > able to generate the cores/threads/sockets/cpus parameters?
>=20
> I did not have any variants file until you asked. Then I realized the
> problems (see inline below) that I will need to address on a v2 patch.
>=20
> Anyway, the variants YAML file may look like this (adapted from an exam=
ple
> created by Cleber Rosa):
>=20
> # cat smp_variants.yaml
> !mux
> min:
> =A0 sockets: 1
> =A0 cores: 2
> =A0 threads: 1
>=20
> medium:
> =A0 sockets: 2
> =A0 cores: 2
> =A0 threads: 2
>=20
> max:
> =A0 sockets: 2
> =A0 cores: 8
> =A0 threads: 16
>=20
> The smp_variants.yaml defines 3 variants (min, medium, and max), each w=
ith a
> different SMP topology. You can run the tests as:
>=20
> # avocado run tests/acceptance/smp_option_coverage.py -m smp_variants.y=
aml
> JOB ID=A0=A0=A0=A0 : 08d9736942e550226de9c3425a9b65c378b6654a
> JOB LOG=A0=A0=A0 : /root/avocado/job-results/job-2018-11-19T13.19-08d97=
36/job.log
> =A0(01/60) tests/acceptance/smp_option_coverage.py:SmpOption.test_cpus_=
eq_maxcpus;min-7e5d:
> PASS (0.04 s)
> < output omitted >
> =A0(60/60) tests/acceptance/smp_option_coverage.py:SmpOption.test_cpus_=
gt_cores_threads_sockets;max-a8e5:
> PASS (0.02 s)
> RESULTS=A0=A0=A0 : PASS 60 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTER=
RUPT 0 |
> CANCEL 0
> JOB TIME=A0=A0 : 6.25 s
>=20
> If you wish I can distribute that file with this patch too. I can use
> Avocado's test data file mechanism to run the variants as described in:
> https://avocado-framework.readthedocs.io/en/65.0/WritingTests.html#acce=
ssing-test-data-files

If a variants file is necessary to make this test case useful, I
would like it to be distributed with the test code, and it should
be used somehow when running "make check-acceptance".

>=20
> As an alternative I can document all that on docs/devel/testing.rst.
> Whatever you prefer.
>=20
> Thanks for the review!
>=20
> - Wainer
>=20
> >=20
> > > ---
> > >   tests/acceptance/smp_option_coverage.py | 218 +++++++++++++++++++=
+++++
> > >   1 file changed, 218 insertions(+)
> > >   create mode 100644 tests/acceptance/smp_option_coverage.py
> > >=20
> > > diff --git a/tests/acceptance/smp_option_coverage.py b/tests/accept=
ance/smp_option_coverage.py
> > > new file mode 100644
> > > index 0000000000..ab68d1a67d
> > > --- /dev/null
> > > +++ b/tests/acceptance/smp_option_coverage.py
> > > @@ -0,0 +1,218 @@
> > > +# QEMU -smp option coverage test.
> > > +#
> > > +# Copyright (c) 2018 Red Hat, Inc.
> > > +#
> > > +# Author:
> > > +#  Wainer dos Santos Moschetta<wainersm@redhat.com>
> > > +#
> > > +# This work is licensed under the terms of the GNU GPL, version 2 =
or
> > > +# later.  See the COPYING file in the top-level directory.
> > > +
> > > +from functools import reduce
> > > +from avocado.utils.process import run
> > > +
> > > +from avocado_qemu import Test
> > > +
> > > +
> > > +class SmpOption(Test):
> > > +    """
> > > +    Launches QEMU with various cpus, cores, threads, sockets, and =
maxcpus
> > > +    combination through -smp option, to check it does not accept i=
nvalid SMP
> > > +    topologies as well as it is able to calculate correctly any mi=
ssing values.
> > > +
> > > +    :avocado: enable
> > > +    :avocado: tags=3Dslow,coverage
> > > +    """
> > > +    def setUp(self):
> > > +        super().setUp()
> > > +        self.cores =3D self.params.get('cores', default=3D2)
> > > +        self.threads =3D self.params.get('threads', default=3D2)
> > > +        self.sockets =3D self.params.get('sockets', default=3D2)
> > > +        self.cpus =3D self.params.get('cpus', default=3D8)
>=20
> The self.cpus variable should not be a parameter but rather calculated
> (cores * threads * sockets).

Are you sure?  Don't you want to test QEMU behavior when `cpus`
is not `cores*threads*sockets`?

> Also needs to type convert the return of self.params.get from string to
> integer.

You're right.

> [...]

--=20
Eduardo
