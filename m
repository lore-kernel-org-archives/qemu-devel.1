Received: from eggs.gnu.org ([2001:4830:134:3::10]:45264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1f8Hsx-0000Li-D3
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 00:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1f8Hsw-0007M6-0j
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 00:06:27 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:34942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1f8Hsv-0007Hy-OD
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 00:06:25 -0400
Received: by mail-ot0-x22e.google.com with SMTP id f47-v6so19937709oth.2
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 21:06:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53972762F@ORSMSX110.amr.corp.intel.com>
References: <20180215210932.15490-1-erik.schmauss@intel.com>
	<CAPcyv4hp_pm2n3H_froFkedd_GMQvsrEc8yZxYzfYkPDYvjDww@mail.gmail.com>
	<CF6A88132359CE47947DB4C6E1709ED5397230D6@ORSMSX110.amr.corp.intel.com>
	<3701399.BBZtpt46yJ@aspire.rjw.lan>
	<CAPcyv4j-iC+b07=JPP_TV1MLHA2iO5iKLvc+jaPHoEuRfzoAFQ@mail.gmail.com>
	<CF6A88132359CE47947DB4C6E1709ED539727606@ORSMSX110.amr.corp.intel.com>
	<CAPcyv4jEkQTEWxE=+mf0C5oA0j50ZvjU=QpvL1n6mmtemrnBLg@mail.gmail.com>
	<CF6A88132359CE47947DB4C6E1709ED53972762F@ORSMSX110.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 16 Apr 2018 21:06:24 -0700
Message-ID: <CAPcyv4jBfb469+P3tdVrxT9NNt5OqutHSkyOmMPmYFS33Oa4JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/7] ACPICA: Integrate package handling
 with module-level code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Schmauss, Erik" <erik.schmauss@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>

On Mon, Apr 16, 2018 at 5:05 PM, Schmauss, Erik <erik.schmauss@intel.com> w=
rote:
>
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Dan Williams
>> Sent: Monday, April 16, 2018 4:22 PM
>> To: Schmauss, Erik <erik.schmauss@intel.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Linux ACPI <linux-
>> acpi@vger.kernel.org>; Moore, Robert <robert.moore@intel.com>; linux-
>> nvdimm <linux-nvdimm@lists.01.org>; Qemu Developers <qemu-
>> devel@nongnu.org>
>> Subject: Re: [PATCH v2 5/7] ACPICA: Integrate package handling with modu=
le-
>> level code
>>
>> On Mon, Apr 16, 2018 at 4:15 PM, Schmauss, Erik <erik.schmauss@intel.com=
>
>> wrote:
>> > [ trimming ]
>> >> >> Rafael, we may want to hold back on the module-level code changes
>> >> >> (the patches below) for rc1. Between this and the strange _TSS
>> >> >> issue, it seems like there are a few more things to resolve before
>> >> >> this is ready for kernel upstream.
>> >> >
>> > Hi Rafael,
>> >
>> >> > It looks like you are asking me to queue up reverts as per the
>> >> > Dan's report, is that correct?
>> >
>> > This is indeed what I meant last week. However, I've looked into the
>> > issue and Dan's qemu instance had AML that we no longer support. This
>> > is because the ACPICA commit makes changes to the execution of AML
>> > during table load to match windows AML interpreter behavior so this co=
mmit
>> also got rid of support for executing code containing forward references=
 (except
>> for package elements).
>> >
>> > I've suggested a fix for the firmware in a separate email. So I would
>> > say that this issue is resolved after if Dan can run his test successf=
ully with the
>> adjusted firmware.
>> >
>> > If Dan's test is successful, we don=E2=80=99t need to revert these cha=
nges
>>
>
> Hi Dan,
>
>> I'm concerned about other qemu-kvm users that do not upgrade their hyper=
visor
>> at the same pace as their guest kernel. Especially for cloud providers t=
hat may
>> be running latest mainline kernel on older qemu-kvm this will look like =
a pure
>> kernel regression. Is there a quick fix we can carry in the kernel to su=
pport these
>> forward references, at least until we know that qemu-kvm is no longer sh=
ipping
>> the broken AML?
>
> This is a very good point. Thanks for bringing this up! One option is for=
 them to set
> the global variable acpi_gbl_execute_tables_as_methods in include/acpi/ac=
pixf.h to false.
> This will effectively revert the new behavior in the AML interpreter and =
go back to the old way.
> Since this is a global flag, we could have a command line option for Linu=
x kernel to turn this
> feature on.
>
> Out of curiosity, is this ACPI table somehow customized for your work? I =
have a collection
> of acpi tables and your ACPI tables are the only ones that have an Operat=
ionRegion called
> NRAM. What is the chance that others will be running Linux on the same ta=
bles as the one
> you sent me?

I don't think there's anything atypical about my particular setup. It
creates two virtual NVDIMMs that each represent a 30GB address space.
I suspect any user of the KVM NVDIMM virtualization would see the same
problem.
