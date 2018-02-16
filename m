Received: from eggs.gnu.org ([2001:4830:134:3::10]:60239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emjHr-0006YR-1m
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emjHn-0003ct-Us
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:55:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1emjHn-0003cf-Lq
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:54:59 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GGsQHK068309
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:54:58 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g62yvrkbk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:54:56 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 16:54:54 -0000
References: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518735273-16089-7-git-send-email-walling@linux.vnet.ibm.com>
	<4ff97ab0-d848-05a4-9ac2-344bd67e73ef@redhat.com>
	<10e144ef-cc5d-8958-adf1-03cc4ef13580@linux.vnet.ibm.com>
	<0fbc3022-dc3f-7dbc-10e4-d7d75ff9742e@linux.vnet.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 17:54:49 +0100
MIME-Version: 1.0
In-Reply-To: <0fbc3022-dc3f-7dbc-10e4-d7d75ff9742e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <03975725-a290-143b-4066-83ee2ced75b5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6 06/12] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 16.02.2018 17:44, Collin L. Walling wrote:
> On 02/16/2018 11:36 AM, Viktor Mihajlovski wrote:
>> On 16.02.2018 17:20, Thomas Huth wrote:
>> [...]
>>>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>>>> index cab8a97..7c3cab8 100644
>>>> --- a/hw/s390x/ipl.h
>>>> +++ b/hw/s390x/ipl.h
>>>> @@ -60,10 +60,15 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi=
;
>>>> =C2=A0 =C2=A0 #define QIPL_ADDRESS=C2=A0 0xcc
>>>> =C2=A0 +#define BOOT_MENU_FLAG_CMD_OPTS=C2=A0 0x80
>>>> +#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
>>>> +
>>>> =C2=A0 struct QemuIplParameters {
>>>> -=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved1[4];
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 boot_menu_flags;
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved1;
>>>> +=C2=A0=C2=A0=C2=A0 uint32_t boot_menu_timeout;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t netboot_start_addr;
>>> The netboot_start_addr field is now never aligned anymore, neither on
>>> the host side, nor in guest memory. Not a big problem since the struc=
t
>>> is declared with "QEMU_PACKED", but still ... it's always nicer to tr=
y
>>> to align fields to their natural boundaries. So maybe move
>>> boot_menu_flags and reserved1 after netboot_start_addr ?
>>>
>> Good catch ... we probably should document the alignment needs and sta=
te
>> that the ipl parameters starts on a word boundary (and that the block
>> may not be larger than 28 bytes) in a comment block.
>=20
> How does this sound?
>=20
> /* word aligned and cannot exceed 28 bytes */
>=20
Maybe:
/*
 * The Qemu IPL Parameters will be stored 32-bit word aligned.
 * Placement of data fields in this area must account for
 * their alignment needs.
 * The entire structure must not be larger than 28 bytes.
 */
>=20
>>>> -=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved2[16];
>>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 reserved2[14];
>>>> =C2=A0 } QEMU_PACKED;
>>>> =C2=A0 typedef struct QemuIplParameters QemuIplParameters;
>>> =C2=A0 Thomas
>>>
>>
>=20
>=20


--=20
Regards,
 Viktor Mihajlovski
