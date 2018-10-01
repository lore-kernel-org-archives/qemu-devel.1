Received: from eggs.gnu.org ([2001:4830:134:3::10]:42513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g6uPR-0002Ii-84
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g6uPM-0005Zb-2D
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:22:33 -0400
References: <20180904091549.6361-1-zyimin@linux.ibm.com>
	<d1694693-0bfc-a8b3-c1b2-afc1c9954eac@linux.ibm.com>
	<9f3259d4-5403-18b8-5588-1c51fd1f3da1@redhat.com>
	<809560dd-3fff-3cec-5b65-cb7e5cd32383@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2b7b5736-f461-4c07-1af8-a46796f22564@redhat.com>
Date: Mon, 1 Oct 2018 11:22:24 +0200
MIME-Version: 1.0
In-Reply-To: <809560dd-3fff-3cec-5b65-cb7e5cd32383@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x]  [PATCH] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>

On 2018-09-29 07:48, Yi Min Zhao wrote:
>=20
> =E5=9C=A8 2018/9/19 =E4=B8=8B=E5=8D=883:53, Thomas Huth =E5=86=99=E9=81=
=93:
>> On 2018-09-19 09:08, Yi Min Zhao wrote:
[...]
>>>> diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
>>>> index 1f7f9b5814..fdf13a19c0 100644
>>>> --- a/hw/s390x/s390-pci-bus.h
>>>> +++ b/hw/s390x/s390-pci-bus.h
>>>> @@ -286,6 +286,28 @@ typedef struct S390PCIIOMMUTable {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390PCIIOMMU *iommu[PCI_SLOT_MA=
X];
>>>> =C2=A0=C2=A0 } S390PCIIOMMUTable;
>>>> =C2=A0=C2=A0 +/* Function Measurement Block */
>>>> +#define DEFAULT_MUI 4000
>>>> +#define UPDATE_U_BIT 0x1ULL
>>>> +#define FMBK_MASK 0xfULL
>>>> +
>>>> +typedef struct ZpciFmbFmt0 {
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t dma_rbytes;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t dma_wbytes;
>>>> +} ZpciFmbFmt0;
>>>> +
>>>> +typedef struct ZpciFmb {
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t format;
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t fmt_ind[3];
>>>> +=C2=A0=C2=A0=C2=A0 uint32_t sample;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t last_update;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t ld_ops;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t st_ops;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t stb_ops;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t rpcit_ops;
>>>> +=C2=A0=C2=A0=C2=A0 ZpciFmbFmt0 fmt0;
>>>> +} QEMU_PACKED __attribute((__aligned__(8))) ZpciFmb;
>> All the fields in this struct are naturally aligned already, so I'd
>> maybe rather drop the QEMU_PACKED and add a
>> QEMU_BUILD_BUG_MSG(sizeof(ZpciFmb) !=3D xx, ...) statement afterwards.
> Currently we only implement FMT0. There're other FMTs to be implemented
> in future.
> So here there would be a union and we can't give a specific size to
> QEMU_BUILD_BUG_MSG.
> Can we use the max size for checking?

I think you could use this to check the beginning of the struct:

QEMU_BUILD_BUG_MSG(offsetof(ZpciFmb, fmt0) !=3D 48, "padding in ZpciFmb")=
;

>>>> =C2=A0=C2=A0 struct S390PCIBusDevice {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState qdev;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCIDevice *pdev;
>>>> @@ -297,6 +319,8 @@ struct S390PCIBusDevice {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t fid;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool fid_defined;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t fmb_addr;
>>>> +=C2=A0=C2=A0=C2=A0 ZpciFmb fmb;
>> ... since you embed it here in another struct which does not have any
>> alignment requirements. This is likely going to cause an error with GC=
C
>> 8.1, we've had this problem in the past already:
>>
>> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da6e4385dea94850d=
7b06b0
> Ah...I didn't test the code with gcc 8+. GCC I used is 7.2.
> It should get the same warining.

Nobody reported the warning in the s390-ccw bios until GCC 8 had been
released, so I assume this is a new warning in GCC 8.

>> Is the __align__(8) required at all? As far as I understand the code,
>> the struct is not living inside the guest memory, is it? So you could
>> simply drop the __align__(8).
>> But if you need it, I think you have to allocate the memory for ZpciFm=
b
>> separately (and use a "ZpciFmb *fmb" here instead).
> I want to copy the entire structure to the guest memory during updating
> FMB.
> It's not a good idea to do copy for all members multiple times.

Sure, but you're doing the updates through address_space_write(), so as
far as I can see there is currently no need for the
attribute((__aligned__(8))) here (or did I miss something?). Thus I'd
like to suggest to simply remove that attribute here.

 Thomas
