Received: from eggs.gnu.org ([2001:4830:134:3::10]:58400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1di7bF-0002Nk-RJ
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 19:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1di7bC-0001qu-MG
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 19:19:45 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:37616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1di7bC-0001qI-H6
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 19:19:42 -0400
Received: by mail-it0-x244.google.com with SMTP id 77so3294098itj.4
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 16:19:42 -0700 (PDT)
In-Reply-To: <db1ad643-9dc6-6464-1487-44007b3609ee@redhat.com>
References: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
	<ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
	<5D42D1E3-A946-4E2C-BDC4-BB785D0B880D@gmail.com>
	<db1ad643-9dc6-6464-1487-44007b3609ee@redhat.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <C17DC1B9-FE9A-43CD-B84F-51D321209300@gmail.com>
Content-Transfer-Encoding: quoted-printable
From: G 3 <programmingkidx@gmail.com>
Date: Wed, 16 Aug 2017 19:19:37 -0400
Subject: Re: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>


On Aug 15, 2017, at 6:27 PM, Paolo Bonzini wrote:

> On 15/08/2017 20:46, Programmingkid wrote:
>>
>>> On Aug 14, 2017, at 2:51 AM, Paolo Bonzini <pbonzini@redhat.com> =20
>>> wrote:
>>>
>>> On 13/08/2017 21:13, Programmingkid wrote:
>>>> Lately I found out that Windows NT 4.0 seems to work well with the
>>>> 486 and pentium processors. Using "-cpu 486" made installing it
>>>> actually work. Now I am seeing another issue. When I boot =20
>>>> Windows NT
>>>> 4.0 I see this error message:
>>>>
>>>> *** STOP: 0x0000007B (0x807A8610,0x00000000,0x00000000,0x00000000)
>>>> INACESSIBLE_BOOT_DEVICE
>>>>
>>>> Would anyone know a way to solve this issue?
>>>
>>> Herv=E9 is probably the best person to answer this question.  Maybe =20=

>>> try
>>> installing it with SCSI disks ("-drive if=3Dscsi,id=3Dhd,file=3D... =
-drive
>>> if=3Dscsi,id=3Dcd,file=3D... -device lsi -device scsi-hd,drive=3Dhd =
-device
>>> scsi-cd,drive=3Dcd").
>>>
>>> Thanks,
>>>
>>> Paolo
>>
>> Thanks for the help. Unfortunately trying to boot from the install =20=

>> CD leads to the INACCESSIBLE_BOOT_DEVICE error when using SCSI.
>
> Try with 0.12.

After doing a lot of bisecting I found a patch that did break Windows =20=

NT 4.0 compatibility long ago. Not sure if it is the problem we face =20
today. This is it:

commit 2bec46dc97571a3c34b18fe4ca198e7bfbdca41f
Author: aliguori <aliguori@c046a42c-6fe2-441c-8c8c-71466251a162>
Date:   Mon Nov 24 20:21:41 2008 +0000

     vga optimization (Glauber Costa)

     Hypervisors like KVM perform badly while doing mmio on
     a loop, because it'll generate an exit on each access.
     This is the case with VGA, which results in very bad
     performance.

     In this patch, we map the linear frame buffer as RAM,
     make sure it has dirty region tracking enabled, and then
     just let the region to be written.
