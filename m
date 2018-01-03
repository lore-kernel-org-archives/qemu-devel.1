Received: from eggs.gnu.org ([2001:4830:134:3::10]:35255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eWj8a-0005up-5b
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eWj8Z-00056K-5v
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:31:20 -0500
Date: Wed, 3 Jan 2018 14:31:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180103143104.2b814aa0@redhat.com>
In-Reply-To: <10087bbd-28b0-b5ad-101a-e6d5ac648548@huawei.com>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-3-git-send-email-gengdongjiu@huawei.com>
	<20171228151809.10495a90@igors-macbook-pro.local>
	<10087bbd-28b0-b5ad-101a-e6d5ac648548@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: pbonzini@redhat.com, mst@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, james.morse@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

On Wed, 3 Jan 2018 10:21:06 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

[...]  =20
> >  =20
> >> In order to simulation, we hard code the error
> >> type to Multi-bit ECC. =20
> > Not sure what this is about, care to elaborate? =20
>=20
> please see Memory Error Record in [1], in which the "Memory Error Type" f=
ield is used to describe the
> error type, such as  Multi-bit ECC or Parity Error etc. Because KVM or ho=
st does not pass the memory
> error type to Qemu, so Qemu does not know what is the error type for the =
memory section. Hence we let QEMU simulate
> the error type to Multi-bit ECC.
Agreed that in case of TCG qemu won't likely have any way to get hw error f=
rom kernel
so it could be useful only for testing purposes (i.e. 'make check' and/or t=
esting
how guest OS handles errors)

But with KVM in kernel it should be possible to fish error out from host ke=
rnel
and forward it to guest. If this are intended for handling HW errors,
I'm not sure that 'Multi-bit ECC' could replace all real errors reported by=
 host
firmware.


> [1]:
> UEFI Spec 2.6 Errata A:
>=20
> "N.2.5 Memory Error Section"
> -----------------+---------------+--------------+------------------------=
-------------------+
>         Mnemonic |   Byte Offset |  Byte Length |        Description     =
                   |
> -----------------+---------------+--------------+------------------------=
-------------------+
>         ........ |  ............ |  .........   |        ...........     =
                   |
> -----------------+---------------+--------------+------------------------=
-------------------+
> Memory Error Type|     72        |       1      |Identifies the type of e=
rror that occurred:|
> 		 |		 |		| 0 =E2=80=93 Unknown                              |
> 		 |		 |		| 1 =E2=80=93 No error                             |
> 		 |		 |		| 2 =E2=80=93 Single-bit ECC                       |
> 		 |		 |		| 3 =E2=80=93 Multi-bit ECC                        |
> 		 |		 |		| 4 =E2=80=93 Single-symbol ChipKill ECC           |
> 		 |		 |		| 5 =E2=80=93 Multi-symbol ChipKill ECC            |
> 		 |		 |		| 6 =E2=80=93 Master abort			    |
> 		 |		 |		| 7 =E2=80=93 Target abort			    |
> 		 |		 |		| 8 =E2=80=93 Parity Error			    |
> 		 |		 |		| 9 =E2=80=93 Watchdog timeout			    |
> 		 |		 |		| 10 =E2=80=93 Invalid address			    |
> 		 |		 |		| 11 =E2=80=93 Mirror Broken			    |
> 		 |		 |		| 12 =E2=80=93 Memory Sparing			    |
> 		 |		 |		| 13 - Scrub corrected error		    |
> 		 |		 |		| 14 - Scrub uncorrected error		    |
> 		 |		 |		| 15 - Physical Memory Map-out event	    |
> 		 |		 |		| All other values reserved.		    |
> -----------------+---------------+--------------+------------------------=
-------------------+
>         ........ |  ............ |  .........   |        ...........     =
                   |
> -----------------+---------------+--------------+------------------------=
-------------------+
[...]
