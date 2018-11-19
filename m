Received: from eggs.gnu.org ([2001:4830:134:3::10]:38527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gOn35-0007k3-Up
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gOn34-0006aj-Vn
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:09:23 -0500
References: <20181116093152.27227-1-pbonzini@redhat.com>
	<4c83906c-0d78-3a73-b40d-ae5f7e58ffa3@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c968b33e-a487-3071-a51a-805794598b2c@redhat.com>
Date: Mon, 19 Nov 2018 18:09:11 +0100
MIME-Version: 1.0
In-Reply-To: <4c83906c-0d78-3a73-b40d-ae5f7e58ffa3@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] nvme: fix out-of-bounds access to
 the CMB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org
Cc: Keith Busch <keith.busch@intel.com>, Li Qiang <liq3ea@gmail.com>, qemu-block@nongnu.org, kwolf@redhat.com

On 19/11/18 16:23, Mark Kanda wrote:
> For CVE-2018-16847, I just noticed Kevin pulled in Li's previous fix (a=
s
> opposed to this one). Was this done in error?

Probably.  Kevin, can you revert and apply this one instead?  I don't
care if 3.1 or 3.2, but the previous fix is pointless complication.

Paolo

>=20
> Thanks,
>=20
> -Mark
>=20
> On 11/16/2018 3:31 AM, Paolo Bonzini wrote:
>> Because the CMB BAR has a min_access_size of 2, if you read the last
>> byte it will try to memcpy *2* bytes from n->cmbuf, causing an off-by-=
one
>> error.=C2=A0 This is CVE-2018-16847.
>>
>> Another way to fix this might be to register the CMB as a RAM memory
>> region, which would also be more efficient.=C2=A0 However, that might =
be a
>> change for big-endian machines; I didn't think this through and I don'=
t
>> know how real hardware works.=C2=A0 Add a basic testcase for the CMB i=
n case
>> somebody does this change later on.
>>
>> Cc: Keith Busch <keith.busch@intel.com>
>> Cc: qemu-block@nongnu.org
>> Cc: Li Qiang <liq3ea@gmail.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> =C2=A0 hw/block/nvme.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 +-
>> =C2=A0 tests/Makefile.include |=C2=A0 2 +-
>> =C2=A0 tests/nvme-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 58 ++++++++++=
+++++++++++++++++++++++++++++---
>> =C2=A0 3 files changed, 57 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>> index 09d7c90259..5d92794ef7 100644
>> --- a/hw/block/nvme.c
>> +++ b/hw/block/nvme.c
>> @@ -1192,7 +1192,7 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write =3D nvme_cmb_write,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .impl =3D {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .min_access_size =3D 2,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .min_access_size =3D 1,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .max_access_siz=
e =3D 8,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 };
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 613242bc6e..fb0b449c02 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -730,7 +730,7 @@ tests/test-hmp$(EXESUF): tests/test-hmp.o
>> =C2=A0 tests/machine-none-test$(EXESUF): tests/machine-none-test.o
>> =C2=A0 tests/drive_del-test$(EXESUF): tests/drive_del-test.o
>> $(libqos-virtio-obj-y)
>> =C2=A0 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o
>> $(libqos-pc-obj-y)
>> -tests/nvme-test$(EXESUF): tests/nvme-test.o
>> +tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
>> =C2=A0 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
>> =C2=A0 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
>> =C2=A0 tests/ac97-test$(EXESUF): tests/ac97-test.o
>> diff --git a/tests/nvme-test.c b/tests/nvme-test.c
>> index 7674a446e4..2abb3b6d19 100644
>> --- a/tests/nvme-test.c
>> +++ b/tests/nvme-test.c
>> @@ -8,11 +8,64 @@
>> =C2=A0=C2=A0 */
>> =C2=A0 =C2=A0 #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>> =C2=A0 #include "libqtest.h"
>> +#include "libqos/libqos-pc.h"
>> +
>> +static QOSState *qnvme_start(const char *extra_opts)
>> +{
>> +=C2=A0=C2=A0=C2=A0 QOSState *qs;
>> +=C2=A0=C2=A0=C2=A0 const char *arch =3D qtest_get_arch();
>> +=C2=A0=C2=A0=C2=A0 const char *cmd =3D "-drive
>> id=3Ddrv0,if=3Dnone,file=3Dnull-co://,format=3Draw "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-device nvme,a=
ddr=3D0x4.0,serial=3Dfoo,drive=3Ddrv0
>> %s";
>> +
>> +=C2=A0=C2=A0=C2=A0 if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, =
"x86_64") =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qs =3D qtest_pc_boot(cmd, =
extra_opts ? : "");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 global_qtest =3D qs->qts;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return qs;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 g_printerr("nvme tests are only available on x86\n=
");
>> +=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>> +}
>> +
>> +static void qnvme_stop(QOSState *qs)
>> +{
>> +=C2=A0=C2=A0=C2=A0 qtest_shutdown(qs);
>> +}
>> =C2=A0 -/* Tests only initialization so far. TODO: Replace with functi=
onal
>> tests */
>> =C2=A0 static void nop(void)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 QOSState *qs;
>> +
>> +=C2=A0=C2=A0=C2=A0 qs =3D qnvme_start(NULL);
>> +=C2=A0=C2=A0=C2=A0 qnvme_stop(qs);
>> +}
>> +
>> +static void nvmetest_cmb_test(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const int cmb_bar_size =3D 2 * MiB;
>> +=C2=A0=C2=A0=C2=A0 QOSState *qs;
>> +=C2=A0=C2=A0=C2=A0 QPCIDevice *pdev;
>> +=C2=A0=C2=A0=C2=A0 QPCIBar bar;
>> +
>> +=C2=A0=C2=A0=C2=A0 qs =3D qnvme_start("-global nvme.cmb_size_mb=3D2")=
;
>> +=C2=A0=C2=A0=C2=A0 pdev =3D qpci_device_find(qs->pcibus, QPCI_DEVFN(4=
,0));
>> +=C2=A0=C2=A0=C2=A0 g_assert(pdev !=3D NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 qpci_device_enable(pdev);
>> +=C2=A0=C2=A0=C2=A0 bar =3D qpci_iomap(pdev, 2, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 qpci_io_writel(pdev, bar, 0, 0xccbbaa99);
>> +=C2=A0=C2=A0=C2=A0 g_assert_cmpint(qpci_io_readb(pdev, bar, 0), =3D=3D=
, 0x99);
>> +=C2=A0=C2=A0=C2=A0 g_assert_cmpint(qpci_io_readw(pdev, bar, 0), =3D=3D=
, 0xaa99);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Test partially out-of-bounds accesses.=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 qpci_io_writel(pdev, bar, cmb_bar_size - 1, 0x4433=
2211);
>> +=C2=A0=C2=A0=C2=A0 g_assert_cmpint(qpci_io_readb(pdev, bar, cmb_bar_s=
ize - 1), =3D=3D,
>> 0x11);
>> +=C2=A0=C2=A0=C2=A0 g_assert_cmpint(qpci_io_readw(pdev, bar, cmb_bar_s=
ize - 1), !=3D,
>> 0x2211);
>> +=C2=A0=C2=A0=C2=A0 g_assert_cmpint(qpci_io_readl(pdev, bar, cmb_bar_s=
ize - 1), !=3D,
>> 0x44332211);
>> +=C2=A0=C2=A0=C2=A0 qnvme_stop(qs);
>> =C2=A0 }
>> =C2=A0 =C2=A0 int main(int argc, char **argv)
>> @@ -21,9 +74,8 @@ int main(int argc, char **argv)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_test_init(&argc, &argv, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_add_func("/nvme/nop", nop);
>> +=C2=A0=C2=A0=C2=A0 qtest_add_func("/nvme/cmb_test", nvmetest_cmb_test=
);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 qtest_start("-drive id=3Ddrv0,if=3Dnone,fil=
e=3Dnull-co://,format=3Draw "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "-device nvme,drive=3Ddrv0,serial=3Dfoo");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D g_test_run();
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_end();
>>
