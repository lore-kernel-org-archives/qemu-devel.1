Received: from eggs.gnu.org ([2001:4830:134:3::10]:60903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dQUXO-0000eA-Ad
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dQUXJ-0007N5-2G
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:10:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1dQUXI-0007KS-Nl
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:10:48 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5T88aao118021
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 04:10:46 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bcs1ba3y5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 04:10:45 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 29 Jun 2017 09:10:43 +0100
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<23ec1642-053c-a15a-c03f-d9e48d1447e7@linux.vnet.ibm.com>
	<c664ff99-e98d-459d-2b07-306e0d00c5b7@redhat.com>
	<29018087-c00b-abb2-47e6-4ebfc954ff1f@linux.vnet.ibm.com>
	<b1bf85e6-20b8-a77c-d20b-ffc6fe570e9b@redhat.com>
	<0ead8e59-be76-f80a-3266-2df20ebb5581@redhat.com>
	<0279acfe-61e7-3861-da31-ddd2ffd43212@linux.vnet.ibm.com>
	<e4e2eebf-db08-298a-f20d-4b742beb977c@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 10:10:39 +0200
MIME-Version: 1.0
In-Reply-To: <e4e2eebf-db08-298a-f20d-4b742beb977c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <61b13982-1b60-e60e-54a5-7d4c745f5be7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfreiman@redhat.com>, David Hildenbrand <david@redhat.com>

On 29.06.2017 09:58, Thomas Huth wrote:
> On 28.06.2017 17:02, Viktor Mihajlovski wrote:
>> On 28.06.2017 12:56, Thomas Huth wrote:
>>> On 28.06.2017 10:02, Thomas Huth wrote:
>>>> On 28.06.2017 09:28, Viktor Mihajlovski wrote:
>>>>> On 27.06.2017 23:40, Thomas Huth wrote:
>>>>> [...]
>>>>>>>> - Is it OK to require loading an .INS file first? Or does anybod=
y
>>>>>>>>   have a better idea how to load multiple files (kernel, initrd,
>>>>>>>>   etc. ...)?
>>>>>>> It would be nice to support PXE-style boot, because the majority =
of boot
>>>>>>> servers is set up that way. A straightforward way would be to do =
a PXE
>>>>>>> emulation by attempting to download a pxelinux.cfg from the well-=
known
>>>>>>> locations, parsing the content (menu) and finally load the kernel=
,
>>>>>>> initrd and set the kernel command line as specified there. (I kno=
w, but
>>>>>>> you're already parsing the INS-File).
>>>>>>
>>>>>> Please, don't mix up PXE and pxelinux (since you've used both term=
s in
>>>>>> above paragraph). Assuming that you're only talking about pxlinux =
config
>>>>>> files... are they that common on s390x already? Using the pxelinux
>>>>>> config file syntax sounds like we would be completely bound to onl=
y
>>>>>> loading Linux guests to me, since the boot loader has to know wher=
e to
>>>>>> load the initrd and how to patch the kernel so that it can find th=
e initrd.
>>>>>> Using .INS files sounds more flexible to me instead, since you can=
 also
>>>>>> specify the addresses here - so you can theoretically also load ot=
her
>>>>>> guest kernels, and that's IMHO the better approach since a firmwar=
e
>>>>>> should stay as generic as possible.
>>>>>>
>>>>> In order to be consumable, the network boot should support the most
>>>>> common configurations. I would think that most network boot servers=
 are
>>>>> setup as PXE boot servers using pxelinux configs.
>>>>
>>>> Are you really sure about the popularity of pxelinux? It's just one
>>>> flavor of secondary stage network boot loaders - which also only exi=
st
>>>> on x86 so far, as far as I know.
>>>
>>> And it seems like it also only works with legacy BIOSes, i.e. you can
>>> not use it on EFI-only systems, if I've got that right:
>>>
>>> https://github.com/openSUSE/kiwi/wiki/Setup-PXE-boot-with-EFI-Using-G=
RUB2
>>>
>>> So I guess the significance of pxelinux will very likely decrease in
>>> the next years...
>>>
>> Maybe, but supposed goners tend to linger more often than not. I.e., t=
he
>> syslinux project offers a EFI bootloader called syslinux.efi equivalen=
t
>> to the pexelinux.0 BIOS loader.
>> Further, the OPAL firmware of newer POWER systems embeds petitboot and
>> thus offers PXELINUX-compatible network boot as well.
>=20
> OK, true, ... you're slowly get me convinced that this pxelinux.cfg
> stuff is maybe not such a bad idea after all ... So I guess supporting
> at least the basic commands from the pxelinux config file would be
> appropriate... (the full set of commands is huge, see
> http://www.syslinux.org/wiki/index.php?title=3DConfig )
>=20
>> I appreciate the idea of a proper BOOTP implementation though, so mayb=
e
>> a compromise could be to start off with your proposal with the slight
>> modification that the final boot action is controlled by the bootfile
>> content (file magic), similar to what you suggested in order to suppor=
t
>> both insfile and binary kernel. PXELINUX emulation could be triggered =
by
>> a specially crafted bootfile then. What do you think?
>=20
> Yes, something like this could work:
>=20
> 1) Do DHCP to get TFTP server address and boot file name
> 2) Load the boot file from the TFTP server to address 0
> 3) If the boot file name ended with ".ins" or ".INS" (and the content
>    starts with the "* " magic), treat it as an .INS file and load the
>    files that are listed in there accordingly
> 4) If the boot file looks like a kernel, start it directly
> 5) If not successful in 3 or 4, start looking for a pxelinux config
>    file by trying to download the config files as specified in
>    http://www.syslinux.org/wiki/index.php?title=3DPXELINUX#Configuratio=
n
>    and then parse the file and load the kernel + initrd accordingly.
>=20
> Quite a bit of work, so I'll continue to ignore 5 for the first
> versions, but I agree now that it can certainly be added later.
That sounds more than fair. Thanks!
>=20
>  Thomas
>=20


--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
