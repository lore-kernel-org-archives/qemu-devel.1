Received: from eggs.gnu.org ([2001:4830:134:3::10]:42555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTTPD-000596-Tx
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cTTPA-0004P2-Dw
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:02:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cTTPA-0004Or-5x
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:02:28 -0500
References: <1484376662-32063-1-git-send-email-thuth@redhat.com>
	<2296ffa3-8bb9-4652-ebd6-4da5b09596ca@vivier.eu>
	<1ed4fded-4468-16cd-96e2-f70c1b85ab7d@redhat.com>
	<CAKmqyKP0ejNQOd=AYYP+jNNtgMm6Mv8V7bQms2MVbDuDDAtquQ@mail.gmail.com>
	<20170116192520.GB3491@thinpad.lan.raisama.net>
	<CAFEAcA9GdZoM0JPX0bf6gnVbnQ-yP7UvbWoj7QLdtd5OomN2zQ@mail.gmail.com>
	<20170116194453.GD3491@thinpad.lan.raisama.net>
	<CAFEAcA_KO+bANvKLV0AQ3FdS6qBxKk5c16ey7v9gYtcNPP2KsA@mail.gmail.com>
	<20170117123625.GG3491@thinpad.lan.raisama.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bbf5a7e6-8ba9-c3e7-ed5d-17f88f99f146@redhat.com>
Date: Tue, 17 Jan 2017 14:02:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170117123625.GG3491@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/core/null-machine: Add the possibility
 to instantiate a CPU, RAM and kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 17.01.2017 13:36, Eduardo Habkost wrote:
> On Tue, Jan 17, 2017 at 09:29:19AM +0000, Peter Maydell wrote:
>> On 16 January 2017 at 19:44, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
>>> On Mon, Jan 16, 2017 at 07:27:21PM +0000, Peter Maydell wrote:
>>>> On 16 January 2017 at 19:25, Eduardo Habkost <ehabkost@redhat.com> w=
rote:
>>>>> On Mon, Jan 16, 2017 at 10:53:07AM -0800, Alistair Francis wrote:
>>>>>> On Sun, Jan 15, 2017 at 11:59 PM, Thomas Huth <thuth@redhat.com> w=
rote:
>>>>>>> But I think the users also expect the "-kernel" parameter to be w=
orking,
>>>>>>> so I think we should add the loader code in null-machine.c anyway=
.
>>>>>>
>>>>>> I agree that uses probably expect the '-kernel' option to work as =
well.
>>>>>
>>>>> So, is it possible to write a generic load_kernel() function that
>>>>> simply reuses the generic-loader code?
>>>>
>>>> No, because users expect -kernel to actually load a Linux kernel
>>>> (meaning with the calling conventions etc the kernel requires),
>>>> whereas generic-loader is just "load a binary blob and start there".
>>>
>>> I don't mean a generic function that works for all machines and
>>> architectures, but a generic function that is good enough for
>>> "-machine none". Isn't "load a binary blob and start there"
>>> exactly what machine_none_load_kernel() in this patch does?
>>
>> If you just want "load a blob and start it" then we already
>> have -device loader. Making -kernel have yet another set of
>> semantics that this time depends on the machine being selected
>> seems like a bad idea. If -kernel doesn't do what it does
>> for the other machines of the same architecture then we should
>> just not accept it.
>=20
> Good point. In this case, implementing -kernel on "-machine none"
> will require calling an arch-specific hook from the beginning.
> I'm not sure if it's worth the effort, but I won't object if
> somebody really wants to implement that.

The -kernel parameter is not just only dependent on the target
architecture, it is even dependent on the machine type, e.g. on ppc it
is quite different between embedded (e500.c) and server (spapr.c)
variants. So an arch-specific hook might not make too much sense and
using the generic loader is likely the best we can do - if that does not
work, you likely can't use the "none" machine anyway.

> While this is not implemented, I suggest we make "-machine none"
> reject -kernel instead of silently ignoring it.

I'd prefer to use the generic loader for "-kernel" as a shortcut to
"-device loader,file=3D..." here, but if the common sense is rather to
refuse the -kernel option on the "none" machine, that's OK for me, too.
Anybody else got an opinion on this?

 Thomas
