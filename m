Received: from eggs.gnu.org ([2001:4830:134:3::10]:52749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGjAg-0007Bt-Kx
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGjAd-0002B1-RS
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:19:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eGjAd-0002AY-Iv
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:19:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAKAEuEO133755
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 05:19:11 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ebrdxev09-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 05:19:10 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 20 Nov 2017 10:19:08 -0000
References: <20171120091520.86128-1-borntraeger@de.ibm.com>
	<5a4be37f-29b5-1d0d-91ab-9cb15c93e088@suse.de>
	<08cec003-1291-8302-1280-d53cba5c7538@de.ibm.com>
	<5a6cd622-3064-a920-8f72-bc820aa13203@suse.de>
	<ca89eb6e-4565-c789-02f4-98ea6ab05b2f@de.ibm.com>
	<7c64f444-d9b7-f2d0-0717-717365efa268@suse.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Nov 2017 11:19:04 +0100
MIME-Version: 1.0
In-Reply-To: <7c64f444-d9b7-f2d0-0717-717365efa268@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Message-Id: <c2859af2-e14c-9a36-9842-11ee5d90b989@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: build s390 bios with
 -fno-zero-initialized-in-bss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>



On 11/20/2017 11:16 AM, Alexander Graf wrote:
> On 11/20/2017 11:02 AM, Christian Borntraeger wrote:
>>
>> On 11/20/2017 10:29 AM, Alexander Graf wrote:
>>> On 11/20/2017 10:27 AM, Christian Borntraeger wrote:
>>>> On 11/20/2017 10:19 AM, Alexander Graf wrote:
>>>>> On 11/20/2017 10:15 AM, Christian Borntraeger wrote:
>>>>>> The QEMU ELF loader does not initialize the bss segment. This has
>>>>>> triggered several bugs in the past, e.g. see commit 5d739a4787a5
>>>>>> ("s390-ccw.img: Fix sporadic errors with ccw boot image - initiali=
ze
>>>>>> css").
>>>>>>
>>>>>> Instead of fixing these things one-by-one we can build the BIOS
>>>>>> with -fno-zero-initialized-in-bss. This will move the zero variabl=
es
>>>>>> also into the data segment, which is then part of a LOAD section.
>>>>> Doesn't this bloat the firmware? Why don't we just manually clear b=
ss in the firmware itself? It's what all other firmwares do :)
>>>> Yes the proper fix is to initialize bss in the bios itself.
>>>> I was trying to come up with something for 2.11, but since the patch=
 does not solve the original issues, lets drop it.
>>>
>>> Initializing bss is quite simple. You can probably even do it from C.=
 Just set two variables before and after .bss in the linker script and me=
mset(0) from start to end :).
>> Yes, I know but then we have to change the build process to use a link=
er script.(we rely on the default
>> linker script right now).
>=20
>=20
> I'm not sure how common generic linker scripts are, but in our default =
script we have existing markers for bss and end. You can look at the defa=
ult linker script using gcc <c file> -Wl,-verbose. This simple source wor=
ked for me:

Are we sure that the range between __bss_start and _end does not include =
other elements (besides bss)?
>=20
>=20
> #include <stdio.h>
>=20
> extern char __bss_start[];
> extern char _end[];
>=20
> int main(void)
> {
> =A0=A0=A0 printf("BSS size: %lx\n", (long)_end - (long)__bss_start);
> =A0=A0=A0 return 0;
> }
>=20
>=20
>=20
> Alex
>=20
>=20
