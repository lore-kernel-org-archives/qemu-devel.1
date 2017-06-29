Received: from eggs.gnu.org ([2001:4830:134:3::10]:57742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQULe-0000rn-Ia
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQULb-0008Ge-Fq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:58:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dQULb-0008G3-7k
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:58:43 -0400
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<23ec1642-053c-a15a-c03f-d9e48d1447e7@linux.vnet.ibm.com>
	<c664ff99-e98d-459d-2b07-306e0d00c5b7@redhat.com>
	<29018087-c00b-abb2-47e6-4ebfc954ff1f@linux.vnet.ibm.com>
	<b1bf85e6-20b8-a77c-d20b-ffc6fe570e9b@redhat.com>
	<0ead8e59-be76-f80a-3266-2df20ebb5581@redhat.com>
	<0279acfe-61e7-3861-da31-ddd2ffd43212@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e4e2eebf-db08-298a-f20d-4b742beb977c@redhat.com>
Date: Thu, 29 Jun 2017 09:58:33 +0200
MIME-Version: 1.0
In-Reply-To: <0279acfe-61e7-3861-da31-ddd2ffd43212@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfreiman@redhat.com>, David Hildenbrand <david@redhat.com>

On 28.06.2017 17:02, Viktor Mihajlovski wrote:
> On 28.06.2017 12:56, Thomas Huth wrote:
>> On 28.06.2017 10:02, Thomas Huth wrote:
>>> On 28.06.2017 09:28, Viktor Mihajlovski wrote:
>>>> On 27.06.2017 23:40, Thomas Huth wrote:
>>>> [...]
>>>>>>> - Is it OK to require loading an .INS file first? Or does anybody
>>>>>>>   have a better idea how to load multiple files (kernel, initrd,
>>>>>>>   etc. ...)?
>>>>>> It would be nice to support PXE-style boot, because the majority o=
f boot
>>>>>> servers is set up that way. A straightforward way would be to do a=
 PXE
>>>>>> emulation by attempting to download a pxelinux.cfg from the well-k=
nown
>>>>>> locations, parsing the content (menu) and finally load the kernel,
>>>>>> initrd and set the kernel command line as specified there. (I know=
, but
>>>>>> you're already parsing the INS-File).
>>>>>
>>>>> Please, don't mix up PXE and pxelinux (since you've used both terms=
 in
>>>>> above paragraph). Assuming that you're only talking about pxlinux c=
onfig
>>>>> files... are they that common on s390x already? Using the pxelinux
>>>>> config file syntax sounds like we would be completely bound to only
>>>>> loading Linux guests to me, since the boot loader has to know where=
 to
>>>>> load the initrd and how to patch the kernel so that it can find the=
 initrd.
>>>>> Using .INS files sounds more flexible to me instead, since you can =
also
>>>>> specify the addresses here - so you can theoretically also load oth=
er
>>>>> guest kernels, and that's IMHO the better approach since a firmware
>>>>> should stay as generic as possible.
>>>>>
>>>> In order to be consumable, the network boot should support the most
>>>> common configurations. I would think that most network boot servers =
are
>>>> setup as PXE boot servers using pxelinux configs.
>>>
>>> Are you really sure about the popularity of pxelinux? It's just one
>>> flavor of secondary stage network boot loaders - which also only exis=
t
>>> on x86 so far, as far as I know.
>>
>> And it seems like it also only works with legacy BIOSes, i.e. you can
>> not use it on EFI-only systems, if I've got that right:
>>
>> https://github.com/openSUSE/kiwi/wiki/Setup-PXE-boot-with-EFI-Using-GR=
UB2
>>
>> So I guess the significance of pxelinux will very likely decrease in
>> the next years...
>>
> Maybe, but supposed goners tend to linger more often than not. I.e., th=
e
> syslinux project offers a EFI bootloader called syslinux.efi equivalent
> to the pexelinux.0 BIOS loader.
> Further, the OPAL firmware of newer POWER systems embeds petitboot and
> thus offers PXELINUX-compatible network boot as well.

OK, true, ... you're slowly get me convinced that this pxelinux.cfg
stuff is maybe not such a bad idea after all ... So I guess supporting
at least the basic commands from the pxelinux config file would be
appropriate... (the full set of commands is huge, see
http://www.syslinux.org/wiki/index.php?title=3DConfig )

> I appreciate the idea of a proper BOOTP implementation though, so maybe
> a compromise could be to start off with your proposal with the slight
> modification that the final boot action is controlled by the bootfile
> content (file magic), similar to what you suggested in order to support
> both insfile and binary kernel. PXELINUX emulation could be triggered b=
y
> a specially crafted bootfile then. What do you think?

Yes, something like this could work:

1) Do DHCP to get TFTP server address and boot file name
2) Load the boot file from the TFTP server to address 0
3) If the boot file name ended with ".ins" or ".INS" (and the content
   starts with the "* " magic), treat it as an .INS file and load the
   files that are listed in there accordingly
4) If the boot file looks like a kernel, start it directly
5) If not successful in 3 or 4, start looking for a pxelinux config
   file by trying to download the config files as specified in
   http://www.syslinux.org/wiki/index.php?title=3DPXELINUX#Configuration
   and then parse the file and load the kernel + initrd accordingly.

Quite a bit of work, so I'll continue to ignore 5 for the first
versions, but I agree now that it can certainly be added later.

 Thomas
