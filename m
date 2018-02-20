Received: from eggs.gnu.org ([2001:4830:134:3::10]:52484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eo4eR-0000bb-Me
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eo4eN-0007Hx-Jp
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:55:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1eo4eN-0007HK-BO
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:55:51 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1K9s5lI139499
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 04:55:49 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g8cms9smp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 04:55:48 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 20 Feb 2018 09:55:45 -0000
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-7-git-send-email-walling@linux.vnet.ibm.com>
	<4e4f13ad-e1fd-fc61-97c8-4892c200d724@linux.vnet.ibm.com>
	<7cc70ad1-d9fd-cd1b-4be5-8689eaf2b98a@linux.vnet.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 20 Feb 2018 10:55:42 +0100
MIME-Version: 1.0
In-Reply-To: <7cc70ad1-d9fd-cd1b-4be5-8689eaf2b98a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <ef832053-42a9-98e6-1a4d-8544ae29e2c1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 06/12] s390-ccw: parse and set boot menu
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 19.02.2018 21:39, Collin L. Walling wrote:
> On 02/19/2018 10:52 AM, Viktor Mihajlovski wrote:
>> On 16.02.2018 23:07, Collin L. Walling wrote:
>> [...]
>>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>>> index 74469b1..f632c59 100644
>>> --- a/hw/s390x/ipl.h
>>> +++ b/hw/s390x/ipl.h
>>> @@ -60,6 +60,9 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>>>
>>> =C2=A0 #define QIPL_ADDRESS=C2=A0 0xcc
>>>
>>> +#define BOOT_MENU_FLAG_CMD_OPTS=C2=A0 0x80
>>> +#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
>>> +
>>> =C2=A0 /*
>>> =C2=A0=C2=A0 * The QEMU IPL Parameters will be stored 32-bit word ali=
gned.
>>> =C2=A0=C2=A0 * Placement of data fields in this area must account for
>>> @@ -67,9 +70,11 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>>> =C2=A0=C2=A0 * The entire structure must not be larger than 28 bytes.
>>> =C2=A0=C2=A0 */
>>> =C2=A0 struct QemuIplParameters {
>>> -=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved1[4];
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 boot_menu_flags;
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved1[3];
>>> +=C2=A0=C2=A0=C2=A0 uint32_t boot_menu_timeout;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t netboot_start_addr;
>>> -=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved2[16];
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved2[12];
>>> =C2=A0 } QEMU_PACKED;Since this has to be touched anyway to re-establ=
ish
>>> proper alignment, I
>> could also imagine to define the struct as
>> =C2=A0=C2=A0 struct QemuIplParameters {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t =
flags:8;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t =
timeout:24;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } QEMU_PACKED boot_menu;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t netboot_start_addr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved2[16];
>> =C2=A0=C2=A0 } QEMU_PACKED;
>> would allow to keep the boot menu stuff together without creating
>> unnecessary holes.
>> It would allow for a timeout value of more than 4 hours. The code to s=
et
>> the boot menu would have to be adapted though to properly deal with th=
e
>> bitfields.
>=20
> I'm currently trying to wrap my brain aroundendian conversion with bit
> fields.
> I'll investigate the best way to handle this in the mean time, but we
> could also
> consider the following:
>=20
> If neighboring related fields is important, how about moving the fields
> below netboot?
>=20
> struct QemuIplParameters {
> =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved1[4];
> =C2=A0=C2=A0=C2=A0 uint64_t netboot_start_addr;
> =C2=A0=C2=A0=C2=A0 uint32_t boot_menu_timeout;
> =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 boot_menu_flags;
> =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved2[11];
> =C2=A0 } QEMU_PACKED;
>=20
I didn't consider the le/be ramifications. They can be dealt with, but
simple is definitely better as we could see in the discussion. No
concerns from my side regarding space.

Another possibility is having a uint8_t field (qipl_flags?) at the
beginning of the struct that could hold the boot menu and other QEMU IPL
flags to come (if any). I.e.
 uint8_t qipl_flags;
 uint8_t reserved1[3];
 uint64_t netboot_start_addr;
 uint32_t boot_menu_timeout;
...
and then use a prefix of QIPL_FLAG_ or so. But that's really only a
matter of taste, so whatever you decide is OK for me.

But while examining this file I noticed that I've put the
QemuIplParameters just before the IplParamenterBlock, since I planned to
use it as a member there. As the intention is to use it stand-alone now,
it could be moved somewhere else, e.g. trailing the IplParameterBlock,
which would improve the readability.
>=20
> If we're concerned about space, we could retreat to timeout as a 16-bit
> field
> (and also bring back the ms -> seconds conversion business)
>=20
> struct QemuIplParameters {
> =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 boot_menu_flags;
> =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved;
> =C2=A0=C2=A0=C2=A0 uint16_t boot_menu_timeout;
> =C2=A0=C2=A0=C2=A0 uint64_t netboot_start_addr;
> =C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved2[16];
> =C2=A0 } QEMU_PACKED;
> [...]


--=20
Regards,
 Viktor Mihajlovski
