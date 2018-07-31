Received: from eggs.gnu.org ([2001:4830:134:3::10]:33800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkUZG-0005Rm-Dt
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkUZD-0006EI-2w
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:20:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58066
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fkUZC-0006Dz-R4
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:19:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6VDJMaT083124
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 09:19:58 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kjr2shcdu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 09:19:57 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Tue, 31 Jul 2018 14:19:55 +0100
References: <20180731120908.9202-1-frankja@linux.ibm.com>
	<20180731120908.9202-3-frankja@linux.ibm.com>
	<20180731150636.6ecc8850.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 31 Jul 2018 15:19:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180731150636.6ecc8850.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4w4UoTApCwUQb2mPEsaerJPK33YgFc1Y3"
Message-Id: <cae4408c-cc96-770b-5b79-1946d2a7afbd@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] s390x: Enable KVM huge page backing
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4w4UoTApCwUQb2mPEsaerJPK33YgFc1Y3
From: Janosch Frank <frankja@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, david@redhat.com
Message-ID: <cae4408c-cc96-770b-5b79-1946d2a7afbd@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] s390x: Enable KVM huge page backing
 support
References: <20180731120908.9202-1-frankja@linux.ibm.com>
 <20180731120908.9202-3-frankja@linux.ibm.com>
 <20180731150636.6ecc8850.cohuck@redhat.com>
In-Reply-To: <20180731150636.6ecc8850.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.07.2018 15:06, Cornelia Huck wrote:
> On Tue, 31 Jul 2018 13:09:08 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> QEMU has had huge page support for a longer time already, but KVM
>> memory management under s390x needed some changes to work with huge
>> backings.
>>
>> Now that we have support, let's enable it if requested and
>> available. Otherwise we now properly tell the user if there is no
>> support and back out instead of failing to run the VM later on.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  target/s390x/kvm.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index d923cf4240..f961c3b84a 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -34,6 +34,7 @@
>>  #include "qapi/error.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/timer.h"
>> +#include "qemu/mmap-alloc.h"
>>  #include "sysemu/sysemu.h"
>>  #include "sysemu/hw_accel.h"
>>  #include "hw/hw.h"
>> @@ -285,6 +286,20 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>  {
>>      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>> =20
>> +    if (mem_path) {
>> +        if (qemu_mempath_getpagesize(mem_path) !=3D (1 << 20)) {
>=20
> 1 * MiB ?

I only looked for page size definitions, didn't know it exists, yes 1 *
MiB is a bit nicer.

I'd wait for more comments before sending the v4 out, so consider this
fixed.

>=20
>> +            error_report("Huge page backing with pages > 1M was speci=
fied, "
>> +                         "but KVM does not support this memory backin=
g");
>> +            return -EINVAL;
>> +
>> +        }
>> +        if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
>> +            error_report("Huge page backing with 1M pages was specifi=
ed, "
>> +                         "but KVM does not support this memory backin=
g");
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>>      mc->default_cpu_type =3D S390_CPU_TYPE_NAME("host");
>>      cap_sync_regs =3D kvm_check_extension(s, KVM_CAP_SYNC_REGS);
>>      cap_async_pf =3D kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>=20
>=20



--4w4UoTApCwUQb2mPEsaerJPK33YgFc1Y3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbYGH2AAoJEBcO/8Q8ZEV5e+0P/jmf3yoA50mfSIND/0otdnC1
sISGHOxV2uczdHQNQHI+HK1xQhPzl5nZzvX6C0ILs1n9K2iX/PTpyINJluOfFN3O
kXnaQmj7swsXUGpuTWYU2vG2tOSJZpWEKy/RFYQlJvwKHAm9eBbUVumP8i6rJR/z
VrN2Xz9OoRcqW/rKQS5Rcd7OC1iem/D0t0Cc9f0nPMPPM0qGfKVaX+DhU7drVXhD
k00Ef4zB4V63uw2+HbdQHq7Zmeu8u88vVFko5c6HeKfoXNr4tzFcdiXDTo1fhZdx
siJONOiyGYpBZcglhTxynHuC03/j4C6nEgA93yF5IH1Sj1unsS3pitV4G3wM4OPN
c+wDngxfcysGEPZpKKDbQXfZFVwLttj4thITPDnKdSTeLyBQzyYS6CWGUwGOAoEX
5dqjGMwYrnB/VG327kuNnxazPXR1xZ/7faMo8xtY5kKBv6Sr090iPZxPjcIOyF+1
6SGXK3SCiFMJ3A8LDJGXJU5GoWNfCNxZ4Y3uE9p879461YGPVQ3W8/t87R51Dov9
OaGy32JztE98/XkXptHG5BnSfw4NYwtsfCxAuJnLxIUlI/DCb3oCNJoUqdHNZYXV
iGtdUCfAJGmVzsSjpC3c6Ak7zvUdeFLz1JUhWd2cckSGjQROnV10Lnm/rWLqY9CF
oLnH+Msu1EOSyKwoee5Q
=zB/H
-----END PGP SIGNATURE-----

--4w4UoTApCwUQb2mPEsaerJPK33YgFc1Y3--
