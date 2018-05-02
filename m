Received: from eggs.gnu.org ([2001:4830:134:3::10]:57267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDuWc-00073Q-QT
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDuWY-00047l-HF
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:22:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fDuWY-00047F-9C
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:22:34 -0400
From: Cleber Rosa <crosa@redhat.com>
References: <20180419164642.9536-1-f4bug@amsat.org>
	<585ca5e3-8477-49d0-7132-981a95435a75@amsat.org>
Message-ID: <b5ba1d09-cf30-6ee8-d4e3-aeecdd0af508@redhat.com>
Date: Wed, 2 May 2018 12:22:23 -0400
MIME-Version: 1.0
In-Reply-To: <585ca5e3-8477-49d0-7132-981a95435a75@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] avocado: Add acceptance tests
 parsing the Linux boot console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, avocado-devel@redhat.com, Peter Maydell <peter.maydell@linaro.org>



On 04/20/2018 12:17 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Cross-posting qemu-devel + avocado-devel.
>=20
>> While previously working on a Super I/O refactor, I encountered some p=
roblems
>> at runtime, after building the codebase successfully and running qtest=
s.
>> I had to manually start to boot different guests and check the bootlog=
.
>>
>> I wanted to give a try at Avocado which seems designed to simplify tha=
t kind
>> of functional tests.
>>
>> I applied Amador Pahim work following Cleber Rosa documentation from
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg03891.html,
>> however I had to modify few things to parse the boot console.
>> Since his work is not merged, I included it in this series.
>>
>> The tests simply expect to find a string reported by Linux printk when=
 a
>> device is detected/initialized, such "ttyS0 at I/O 0x3f8 (irq =3D 4) i=
s a 16550A"
>> and "i8042 KBD port at 0x60,0x64 irq 1" for the Super I/O chip, or suc=
h
>> "registered as PCnet/PCI II 79C970A" to confirms the PCI subsystem and=
 network
>> device are correctly detected:
>>
>>
>>     self.assertIn(u'ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A', bootl=
og)
>>     self.assertIn(u'ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A', bootl=
og)
>>     self.assertIn(u'i8042 KBD port at 0x60,0x64 irq 1', bootlog)
>>     self.assertIn(u'i8042 AUX port at 0x60,0x64 irq 12', bootlog)
>>
>> Example of the tests output:
>>
>>     $ avocado run test_linux-boot-console.py -m test_linux-boot-consol=
e.py.data/parameters.yaml=20
>>     JOB ID     : 695094c9bbe8f6011226da7c2031c2c53e949910
>>     JOB LOG    : /home/phil/avocado/job-results/job-2018-04-19T13.36-6=
95094c/job.log
>>      (1/6) test_linux-boot-console.py:TestAlphaClipperBoot2_6.test_boo=
t_console;alpha-2582: PASS (4.76 s)
>>      (2/6) test_linux-boot-console.py:TestAlphaClipperBoot2_6.test_boo=
t_console;mips-4a72: PASS (0.00 s)
>>      (3/6) test_linux-boot-console.py:TestMips4kcMaltaBoot2_6.test_boo=
t_console;alpha-2582: PASS (0.00 s)
>>      (4/6) test_linux-boot-console.py:TestMips4kcMaltaBoot2_6.test_boo=
t_console;mips-4a72: PASS (3.92 s)
>>      (5/6) test_linux-boot-console.py:TestMips4kcMaltaBoot3_2.test_boo=
t_console;alpha-2582: PASS (0.00 s)
>>      (6/6) test_linux-boot-console.py:TestMips4kcMaltaBoot3_2.test_boo=
t_console;mips-4a72: PASS (4.08 s)
>>     RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRU=
PT 0 | CANCEL 0
>>     JOB TIME   : 13.31 s
>>
>> Please apologize my ugly Python, this series is just a proof-of-concep=
t :)
>> I couldn't figure out how to use the @skipUnless(correct arch) decorat=
or.
>=20
> Eduardo asked me to share my first impressions after trying this
> framework with QEMU.
>=20
> So far it seems more designed to run tests _inside_ a qemu instance
> (think user-space), eventually testing packages/scripts.
>=20

The first tests written indeed involved interacting with the guest OS
more often than not.  I tried to show one example that did not envolve a
guest here:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03468.html

Just as short exercise, this is another example (sorry for the lack of
creativity):

class CpuSmp(test.QemuTest):
    """
    :avocado: enable
    """
    def test(self):
        smp_max =3D int(self.params.get('smp_max', default=3D255))
        self.vm._args.extend(['-smp', '%s' % smp_max])
        self.vm.launch()
        res =3D self.vm.qmp('query-cpus-fast')
        self.assertEqual(len(res[u'return']), smp_max)

> My tests are targeting the machine model itself, if the devices are
> correctly instantiated and so.
> The fastest approach was to check the Linux kernel bootlog, but if you
> look at the TestAlphaClipperBoot console you'll see a boot "firmware" i=
s
> executed before the kernel. Casually this firmware also send informatio=
n
> on the console, but what if the console is not accessible?
> We can use a chardev for the ioport80 POST, but some firmwares post boo=
t
> events via I2C, SPI, CAN...
>=20
> To improve the testing, my idea is to use the Tracing framework.
> The machine trace events would be logged in a db and avogado would
> verify some of the trace events, did they occur? in the correct sequenc=
e
> order? with the correct arguments? We can also check relative
> timestamps, is this sequence timing fast enough?
>=20

Right, I think I see where you're going here.

For the record, the Avocado test runner has the ability to check the
test output against a previously recorded file, and that can determine
the test status.  Maybe a second implementation of the same concept can
be applied to your idea.

> I plan to use the gdb API to insert breakpoints and follow part
> execution flow, eventually injecting (faulty) events.
>=20

Just to be clear, do you mean the Avocado GDB API?

> The multi-arch/machines support is a bit weak yet.
>=20

Yes.  One of the ways I believe the multi-arch/machines support can be
significantly improved is by using some level of parameter
standardization, together with tools to generate the intended test
"matrix".  On a quick experiment with "pict" (an indepedent
combinatorial testing tool) on this matter, I came up with:

---

arch: x86_64, ppc64, ppcemb, ppc, aarch64, alpha, s390x
machine_type: pc, q35, pseries-2.12, virt, 40p, bamboo, g3beige, mac99,
mpc8544ds, ppce500, prep, sam460ex, clipper, s390-ccw-virtio-2.12
machine_accel: kvm, tcg

smp_max: 1, 4, 8, 15, 248, 255

IF [arch] =3D "x86_64" THEN
   [machine_type] =3D "q35" OR
   [machine_type] =3D "pc";

IF [arch] =3D "ppc" THEN
   [machine_type] =3D "40p" OR
   [machine_type] =3D "bamboo" OR
   [machine_type] =3D "g3beige" OR
   [machine_type] =3D "mac99" OR
   [machine_type] =3D "mpc8544ds" OR
   [machine_type] =3D "ppce500" OR
   [machine_type] =3D "prep" OR
   [machine_type] =3D "sam460ex";

IF [arch] =3D "alpha" THEN [machine_type] =3D "clipper";
IF [arch] =3D "ppc64" THEN [machine_type] =3D "pseries-2.12";
IF [arch] =3D "ppcemb" THEN [machine_type] =3D "bamboo";
IF [arch] =3D "aarch64" THEN [machine_type] =3D "virt";
IF [arch] =3D "s390x" THEN [machine_type] =3D "s390-ccw-virtio-2.12";

# On my machine, only x86_64 can do KVM
IF NOT [arch] =3D "x86_64" THEN [machine_accel] =3D "tcg";

IF [machine_type] =3D "q35" THEN [smp_max] =3D 255;
IF [machine_type] =3D "pc" THEN [smp_max] =3D 255;
IF [machine_type] =3D "s390-ccw-virtio-2.12" THEN [smp_max] =3D 248;
IF [machine_type] =3D "virt" THEN [smp_max] =3D 8;
IF [machine_type] =3D "mpc8544ds" THEN [smp_max] =3D 15;
IF [machine_type] =3D "clipper" THEN [smp_max] =3D 4;
IF [machine_type] =3D "40p" THEN [smp_max] =3D 1;
IF [machine_type] =3D "bamboo" THEN [smp_max] =3D 1;
IF [machine_type] =3D "g3beige" THEN [smp_max] =3D 1;
IF [machine_type] =3D "mac99" THEN [smp_max] =3D 1;
IF [machine_type] =3D "sam460ex" THEN [smp_max] =3D 1;
IF [machine_type] =3D "ppce500" THEN [smp_max] =3D 1;
IF [machine_type] =3D "prep" THEN [smp_max] =3D 1;

---

With this *very partial* definition of the arch/machine support in QEMU,
a single test can be run in 22 different scenarios.  I've used it to run
the 4 VNC tests and the one CpuSmp test printed above, resulting in 110
different test executions:

   https://cleber.fedorapeople.org/results.html

The first three parameters are already supported by avocado_qemu, and
more can follow.

And to be fully honest, "avocado_qemu" has more weaknesses than
strengthens at the moment.  That's partially because it's so young (and
immature), but, can be made into our ideal grown "being".

> I'm personally more interested in automatically testing [real world]
> firmware or full machine boot process, the kind of integration testing =
I
> can not do with qtests.
>=20
> I liked the possibility to generate coredumps, or the replay function.
>=20
> I also liked to be able to write a test on how a machine boots, in ~20
> LOC (see TestAlphaClipperBoot2_6).
>=20
> The storage API is OK to fetch a full VM image, but not a single file
> like a kernel or a flash image.
>=20

As pointed elsewhere, fetching/caching is probably OK at this point.
But handling the (optional) gzip compression can use some TLC.

> Enough for my second try, good work :)
>=20
> I hope this was helpful.
>=20
> Regards,
>=20
> Phil.
>=20

Thanks for the review!
- Cleber.
