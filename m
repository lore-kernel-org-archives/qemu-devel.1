Received: from eggs.gnu.org ([2001:4830:134:3::10]:60223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eWx32-0002jE-An
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 23:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eWx31-0004QJ-35
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 23:22:32 -0500
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-3-git-send-email-gengdongjiu@huawei.com>
	<20171228151809.10495a90@igors-macbook-pro.local>
	<10087bbd-28b0-b5ad-101a-e6d5ac648548@huawei.com>
	<20180103143104.2b814aa0@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <ceefdb58-f41c-5a4b-08c4-27f24efb121e@huawei.com>
Date: Thu, 4 Jan 2018 12:21:55 +0800
MIME-Version: 1.0
In-Reply-To: <20180103143104.2b814aa0@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v14 2/9] ACPI: Add APEI GHES table
 generation and CPER record support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, James Morse <james.morse@arm.com>
Cc: pbonzini@redhat.com, mst@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

On 2018/1/3 21:31, Igor Mammedov wrote:
> On Wed, 3 Jan 2018 10:21:06 +0800
> gengdongjiu <gengdongjiu@huawei.com> wrote:
>=20
> [...]  =20
>>>  =20
>>>> In order to simulation, we hard code the error
>>>> type to Multi-bit ECC. =20
>>> Not sure what this is about, care to elaborate? =20
>>
>> please see Memory Error Record in [1], in which the "Memory Error Type=
" field is used to describe the
>> error type, such as  Multi-bit ECC or Parity Error etc. Because KVM or=
 host does not pass the memory
>> error type to Qemu, so Qemu does not know what is the error type for t=
he memory section. Hence we let QEMU simulate
>> the error type to Multi-bit ECC.
> Agreed that in case of TCG qemu won't likely have any way to get hw err=
or from kernel
> so it could be useful only for testing purposes (i.e. 'make check' and/=
or testing
> how guest OS handles errors)
>=20
> But with KVM in kernel it should be possible to fish error out from hos=
t kernel
> and forward it to guest. If this are intended for handling HW errors,
> I'm not sure that 'Multi-bit ECC' could replace all real errors reporte=
d by host
> firmware.
Thanks for the mail.
I understand your meaning, I explain it more.

(1). In fact the Memory Error type is not important to guest OS, when the=
 OS(such as guest OS) do memory recovery,
it does not uses the memory error type, OS(such as guest OS) mainly uses =
the memory_failure() function[1] to do recovery ,
In this function, it does not care what is the memory error type, It even=
 does not know what is the memory error type.
(2). If KVM forward the error type to guest, it needs more efforts, may b=
e not worth to do. The real memory error type exists in host
APEI table, only host APEI driver can get it, KVM can not directly get it=
. If forward it to guest, KVM needs to firstly get the error
type from APEI driver and forward it to guest, which may be opposed by Ja=
mes(james.morse@arm.com), I ever export more error information
to guest, but James does not agree that. In the ARM64 platform, we do not=
 have implementation to get the error information from the
APEI driver to KVM or to other kernel modules.


[1]:
int memory_failure(unsigned long pfn, int trapno, int flags)
{
  ......
 }

>=20
>=20
>> [1]:
>> UEFI Spec 2.6 Errata A:
>>
>> "N.2.5 Memory Error Section"
>> -----------------+---------------+--------------+---------------------=
----------------------+
>>         Mnemonic |   Byte Offset |  Byte Length |        Description  =
                      |
>> -----------------+---------------+--------------+---------------------=
----------------------+
>>         ........ |  ............ |  .........   |        ...........  =
                      |
>> -----------------+---------------+--------------+---------------------=
----------------------+
>> Memory Error Type|     72        |       1      |Identifies the type o=
f error that occurred:|
>> 		 |		 |		| 0 =E2=80=93 Unknown                              |
>> 		 |		 |		| 1 =E2=80=93 No error                             |
>> 		 |		 |		| 2 =E2=80=93 Single-bit ECC                       |
>> 		 |		 |		| 3 =E2=80=93 Multi-bit ECC                        |
>> 		 |		 |		| 4 =E2=80=93 Single-symbol ChipKill ECC           |
>> 		 |		 |		| 5 =E2=80=93 Multi-symbol ChipKill ECC            |
>> 		 |		 |		| 6 =E2=80=93 Master abort			    |
>> 		 |		 |		| 7 =E2=80=93 Target abort			    |
>> 		 |		 |		| 8 =E2=80=93 Parity Error			    |
>> 		 |		 |		| 9 =E2=80=93 Watchdog timeout			    |
>> 		 |		 |		| 10 =E2=80=93 Invalid address			    |
>> 		 |		 |		| 11 =E2=80=93 Mirror Broken			    |
>> 		 |		 |		| 12 =E2=80=93 Memory Sparing			    |
>> 		 |		 |		| 13 - Scrub corrected error		    |
>> 		 |		 |		| 14 - Scrub uncorrected error		    |
>> 		 |		 |		| 15 - Physical Memory Map-out event	    |
>> 		 |		 |		| All other values reserved.		    |
>> -----------------+---------------+--------------+---------------------=
----------------------+
>>         ........ |  ............ |  .........   |        ...........  =
                      |
>> -----------------+---------------+--------------+---------------------=
----------------------+
> [...]
>=20
> .
>=20
