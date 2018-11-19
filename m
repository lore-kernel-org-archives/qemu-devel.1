Received: from eggs.gnu.org ([2001:4830:134:3::10]:42183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gOoas-0004o8-Nw
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gOoan-0003Sj-PD
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:48:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gOoan-0003QO-GX
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:48:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DA7430DDBBD
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 18:48:16 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20181109195800.19071-1-wainersm@redhat.com>
	<20181112163140.GM12503@habkost.net>
Message-ID: <b566882d-18bd-4bc0-96a0-0c2728a785db@redhat.com>
Date: Mon, 19 Nov 2018 16:48:00 -0200
MIME-Version: 1.0
In-Reply-To: <20181112163140.GM12503@habkost.net>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, crosa@redhat.com, philmd@redhat.com, ccarrara@redhat.com



On 11/12/2018 02:31 PM, Eduardo Habkost wrote:
> On Fri, Nov 09, 2018 at 02:58:00PM -0500, Wainer dos Santos Moschetta w=
rote:
>> This adds tests for SMP option, by passing -smp with
>> various combinations of cpus, cores, threads, and sockets
>> values it checks that invalid topologies are not accepted
>> as well as missing values are correctly calculated.
>>
>> Signed-off-by: Wainer dos Santos Moschetta<wainersm@redhat.com>
> The test code looks nice to me, but: how exactly do you expect
> this to be executed?

'make check-acceptance' executes it with default parameters (i.e.=20
cores=3D2, threads=3D2, sockets=3D2, and cpus=3D8).

It is possible to overwrite the default parameters by using Avocado's -p=20
option. For example, 'avocado run -p sockets=3D1 -p cores=3D2 -p threads=3D=
1=20
tests/acceptance/smp_option_coverage.py'.

> Do we have a test runner or multiplexer configuration already
> able to generate the cores/threads/sockets/cpus parameters?

I did not have any variants file until you asked. Then I realized the=20
problems (see inline below) that I will need to address on a v2 patch.

Anyway, the variants YAML file may look like this (adapted from an=20
example created by Cleber Rosa):

# cat smp_variants.yaml
!mux
min:
 =C2=A0 sockets: 1
 =C2=A0 cores: 2
 =C2=A0 threads: 1

medium:
 =C2=A0 sockets: 2
 =C2=A0 cores: 2
 =C2=A0 threads: 2

max:
 =C2=A0 sockets: 2
 =C2=A0 cores: 8
 =C2=A0 threads: 16

The smp_variants.yaml defines 3 variants (min, medium, and max), each=20
with a different SMP topology. You can run the tests as:

# avocado run tests/acceptance/smp_option_coverage.py -m smp_variants.yam=
l
JOB ID=C2=A0=C2=A0=C2=A0=C2=A0 : 08d9736942e550226de9c3425a9b65c378b6654a
JOB LOG=C2=A0=C2=A0=C2=A0 : /root/avocado/job-results/job-2018-11-19T13.1=
9-08d9736/job.log
 =C2=A0(01/60)=20
tests/acceptance/smp_option_coverage.py:SmpOption.test_cpus_eq_maxcpus;mi=
n-7e5d:=20
PASS (0.04 s)
< output omitted >
 =C2=A0(60/60)=20
tests/acceptance/smp_option_coverage.py:SmpOption.test_cpus_gt_cores_thre=
ads_sockets;max-a8e5:=20
PASS (0.02 s)
RESULTS=C2=A0=C2=A0=C2=A0 : PASS 60 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 =
| INTERRUPT 0=20
| CANCEL 0
JOB TIME=C2=A0=C2=A0 : 6.25 s

If you wish I can distribute that file with this patch too. I can use=20
Avocado's test data file mechanism to run the variants as described in:
https://avocado-framework.readthedocs.io/en/65.0/WritingTests.html#access=
ing-test-data-files

As an alternative I can document all that on docs/devel/testing.rst.=20
Whatever you prefer.

Thanks for the review!

- Wainer

>
>> ---
>>   tests/acceptance/smp_option_coverage.py | 218 ++++++++++++++++++++++=
++
>>   1 file changed, 218 insertions(+)
>>   create mode 100644 tests/acceptance/smp_option_coverage.py
>>
>> diff --git a/tests/acceptance/smp_option_coverage.py b/tests/acceptanc=
e/smp_option_coverage.py
>> new file mode 100644
>> index 0000000000..ab68d1a67d
>> --- /dev/null
>> +++ b/tests/acceptance/smp_option_coverage.py
>> @@ -0,0 +1,218 @@
>> +# QEMU -smp option coverage test.
>> +#
>> +# Copyright (c) 2018 Red Hat, Inc.
>> +#
>> +# Author:
>> +#  Wainer dos Santos Moschetta<wainersm@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +from functools import reduce
>> +from avocado.utils.process import run
>> +
>> +from avocado_qemu import Test
>> +
>> +
>> +class SmpOption(Test):
>> +    """
>> +    Launches QEMU with various cpus, cores, threads, sockets, and max=
cpus
>> +    combination through -smp option, to check it does not accept inva=
lid SMP
>> +    topologies as well as it is able to calculate correctly any missi=
ng values.
>> +
>> +    :avocado: enable
>> +    :avocado: tags=3Dslow,coverage
>> +    """
>> +    def setUp(self):
>> +        super().setUp()
>> +        self.cores =3D self.params.get('cores', default=3D2)
>> +        self.threads =3D self.params.get('threads', default=3D2)
>> +        self.sockets =3D self.params.get('sockets', default=3D2)
>> +        self.cpus =3D self.params.get('cpus', default=3D8)

The self.cpus variable should not be a parameter but rather calculated=20
(cores * threads * sockets).
Also needs to type convert the return of self.params.get from string to=20
integer.

>> +
>> +    def get_smp_topology(self):
>> +        """
>> +        Returns a dict with the id of cores, threads and sockets.
>> +        """
>> +        res =3D self.vm.qmp('query-hotpluggable-cpus')['return']
>> +        cpus =3D [x['props'] for x in res]
>> +
>> +        return reduce(lambda x, y: {'core-id': x['core-id'].union([y[=
'core-id']]),
>> +                                    'thread-id': x['thread-id'].union=
([y['thread-id']]),
>> +                                    'socket-id': x['socket-id'].union=
([y['socket-id']])},
>> +                      cpus, {'core-id': set(), 'thread-id': set(), 's=
ocket-id': set()})
>> +
>> +    @staticmethod
>> +    def build_option(**kwargs):
>> +        """
>> +        Builds string for the -smp option.
>> +        Use cpus, cores, threads, sockets, maxcpus keys.
>> +        """
>> +        option_list =3D []
>> +        if kwargs.get('cpus', None) is not None:
>> +            option_list.append(str(kwargs.get('cpus')))
>> +        for key, val in kwargs.items():
>> +            if key =3D=3D 'cpus':
>> +                continue
>> +            option_list.append('%s=3D%s' % (key, val))
>> +
>> +        return ",".join(option_list)
>> +
>> +    def launch_and_check(self, expect_cores=3D1, expect_threads=3D1,
>> +                         expect_sockets=3D1, **kwargs):
>> +        """
>> +        Launches VM and check its SMP topology was correctly set.
>> +        Use cpus, cores, threads, sockets, and maxcpus keys to specif=
y the
>> +        topology.
>> +        """
>> +        option =3D self.build_option(**{key: val for key, val in kwar=
gs.items()
>> +                                      if key in ['cpus', 'cores', 'th=
reads',
>> +                                                 'sockets', 'maxcpus'=
]})
>> +        self.vm.add_args('-smp', option)
>> +        self.vm.launch()
>> +        smp =3D self.get_smp_topology()
>> +        self.assertEqual(smp['core-id'], set(range(0, expect_cores)))
>> +        self.assertEqual(smp['thread-id'], set(range(0, expect_thread=
s)))
>> +        self.assertEqual(smp['socket-id'], set(range(0, expect_socket=
s)))
>> +
>> +    def launch_and_check_fail(self, **kwargs):
>> +        """
>> +        Launches VM and check the process exits with expected error c=
ode, for
>> +        cases where the topology is expected not valid.
>> +        """
>> +        option =3D self.build_option(**kwargs)
>> +        res =3D run("%s -smp %s" % (self.qemu_bin, option), timeout=3D=
10,
>> +                  ignore_status=3DTrue)
>> +        self.assertNotEqual(res.exit_status, 0)
>> +
>> +    # Passing cpus and maxcpus only.
>> +    #
>> +
>> +    def test_cpus_eq_maxcpus(self):
>> +        self.launch_and_check(cpus=3Dself.cpus,
>> +                              maxcpus=3Dself.cpus,
>> +                              expect_sockets=3Dself.cpus)
>> +
>> +    def test_cpus_lt_maxcpus(self):
>> +        maxcpus =3D self.cpus * 2
>> +        self.launch_and_check(cpus=3Dself.cpus,
>> +                              maxcpus=3Dmaxcpus,
>> +                              expect_sockets=3Dmaxcpus)
>> +
>> +    def test_cpus_gt_maxcpus(self):
>> +        self.launch_and_check_fail(cpus=3Dself.cpus,
>> +                                   maxcpus=3Dself.cpus // 2)
>> +
>> +    # Passing a combination of cores, threads and sockets only.
>> +    #
>> +
>> +    def test_no_cores_no_threads_no_sockets(self):
>> +        self.launch_and_check(cpus=3Dself.cpus,
>> +                              expect_sockets=3Dself.cpus)
>> +
>> +    def test_no_cores_no_threads_sockets(self):
>> +        self.launch_and_check(sockets=3Dself.sockets,
>> +                              expect_sockets=3Dself.sockets)
>> +
>> +    def test_no_cores_threads_no_sockets(self):
>> +        self.launch_and_check(threads=3Dself.threads,
>> +                              expect_threads=3Dself.threads)
>> +
>> +    def test_no_cores_threads_sockets(self):
>> +        self.launch_and_check(threads=3Dself.threads,
>> +                              sockets=3Dself.sockets,
>> +                              expect_threads=3Dself.threads,
>> +                              expect_sockets=3Dself.sockets)
>> +
>> +    def test_cores_no_threads_no_sockets(self):
>> +        self.launch_and_check(cores=3Dself.cores,
>> +                              expect_cores=3Dself.cores)
>> +
>> +    def test_cores_no_threads_sockets(self):
>> +        self.launch_and_check(cores=3Dself.cores,
>> +                              sockets=3Dself.sockets,
>> +                              expect_cores=3Dself.cores,
>> +                              expect_sockets=3Dself.sockets)
>> +
>> +    def test_cores_threads_no_sockets(self):
>> +        self.launch_and_check(cores=3Dself.cores,
>> +                              threads=3Dself.threads,
>> +                              expect_cores=3Dself.cores,
>> +                              expect_threads=3Dself.threads)
>> +
>> +    def test_cores_threads_sockets(self):
>> +        self.launch_and_check(cores=3Dself.cores,
>> +                              threads=3Dself.threads,
>> +                              sockets=3Dself.sockets,
>> +                              expect_cores=3Dself.cores,
>> +                              expect_threads=3Dself.threads,
>> +                              expect_sockets=3Dself.sockets)
>> +
>> +    # Passing cpus always and a combination of cores, threads and soc=
kets.
>> +    #
>> +
>> +    def test_cpus_no_cores_no_threads_sockets(self):
>> +        self.launch_and_check(cpus=3Dself.cpus,
>> +                              sockets=3Dself.sockets,
>> +                              expect_cores=3Dself.cpus // self.socket=
s,
>> +                              expect_sockets=3Dself.sockets)
>> +
>> +    def test_cpus_no_cores_threads_no_sockets(self):
>> +        self.launch_and_check(cpus=3Dself.cpus,
>> +                              threads=3Dself.threads,
>> +                              expect_threads=3Dself.threads,
>> +                              expect_sockets=3Dself.cpus // self.thre=
ads)
>> +
>> +    def test_cpus_no_cores_threads_sockets(self):
>> +        self.launch_and_check(cpus=3Dself.cpus,
>> +                              threads=3Dself.threads,
>> +                              sockets=3Dself.sockets,
>> +                              expect_threads=3Dself.threads,
>> +                              expect_sockets=3Dself.sockets,
>> +                              expect_cores=3Dself.cpus // (self.threa=
ds * self.sockets))
>> +
>> +    def test_cpus_cores_no_threads_no_sockets(self):
>> +        self.launch_and_check(cpus=3Dself.cpus,
>> +                              cores=3Dself.cores,
>> +                              expect_cores=3Dself.cores,
>> +                              expect_sockets=3Dself.cpus // self.core=
s)
>> +
>> +    def test_cpus_cores_no_threads_sockets(self):
>> +        self.launch_and_check(cpus=3Dself.cpus,
>> +                              cores=3Dself.cores,
>> +                              sockets=3Dself.sockets,
>> +                              expect_cores=3Dself.cores,
>> +                              expect_sockets=3Dself.sockets,
>> +                              expect_threads=3Dself.cpus // (self.cor=
es * self.sockets))
>> +
>> +    def test_cpus_cores_threads_no_sockets(self):
>> +        self.launch_and_check(cpus=3Dself.cpus,
>> +                              cores=3Dself.cores,
>> +                              threads=3Dself.threads,
>> +                              expect_cores=3Dself.cores,
>> +                              expect_threads=3Dself.threads,
>> +                              expect_sockets=3Dself.cpus // (self.cor=
es * self.threads))
>> +
>> +    def test_cpus_cores_threads_sockets(self):
>> +        self.launch_and_check(cpus=3Dself.cores * self.threads * self=
.sockets,
>> +                              cores=3Dself.cores,
>> +                              threads=3Dself.threads,
>> +                              sockets=3Dself.sockets,
>> +                              expect_cores=3Dself.cores,
>> +                              expect_threads=3Dself.threads,
>> +                              expect_sockets=3Dself.sockets)
>> +
>> +    # Passing cpus less (or greater) than cores, threads and sockets.
>> +    #
>> +
>> +    def test_cpus_lt_cores_threads_sockets(self):
>> +        self.launch_and_check_fail(cpus=3D(self.cores * self.threads =
* self.sockets) // 2,
>> +                                   cores=3Dself.cores,
>> +                                   threads=3Dself.threads,
>> +                                   sockets=3Dself.sockets,)
>> +
>> +    def test_cpus_gt_cores_threads_sockets(self):
>> +        self.launch_and_check_fail(cpus=3Dself.cores * self.threads *=
 self.sockets * 2,
>> +                                   cores=3Dself.cores,
>> +                                   threads=3Dself.threads,
>> +                                   sockets=3Dself.sockets)
>> --=20
>> 2.17.2
>>
