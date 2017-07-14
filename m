Received: from eggs.gnu.org ([2001:4830:134:3::10]:54209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dW763-0003lB-4j
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dW75z-0004Mc-4w
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:21:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dW75y-0004Ld-Si
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:21:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D93FA8F28C
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 20:21:49 +0000 (UTC)
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714222705-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <71fd872e-ca59-169d-07fb-5e304713fa84@redhat.com>
Date: Fri, 14 Jul 2017 22:21:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170714222705-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/8] KASLR kernel dump support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com

On 07/14/17 21:59, Michael S. Tsirkin wrote:
> On Fri, Jul 14, 2017 at 08:20:03PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Recent linux kernels enable KASLR to randomize phys/virt memory
>> addresses. This series aims to provide enough information in qemu
>> dumps so that crash utility can work with randomized kernel too (it
>> hasn't been tested on other archs than x86 though, help welcome).
>>
>> The vmcoreinfo device is an emulated ACPI device that exposes a 4k
>> memory range to the guest to store various informations useful to
>> debug the guest OS. (it is greatly inspired by the VMGENID device
>> implementation). The version field with value 0 is meant to give
>> paddr/size of the VMCOREINFO ELF PT_NOTE, other values can be used for
>> different purposes or OSes. (note: some wanted to see pvpanic somehow
>> merged with this device, I have no clear idea how to do that, nor do I
>> think this is a good idea since the devices are quite different, used
>> at different time for different purposes. And it can be done as a
>> future iteration if it is appropriate, feel free to send patches)
>=20
> First, I think you underestimate the difficulty of maintaining
> compatibility.
>=20
> Second, this seems racy - how do you know when is guest done writing ou=
t
> the data?

What data exactly?

The guest kernel module points the fields in the "vmcoreinfo page" to
the then-existent vmcoreinfo ELF note. At that point, the ELF note is
complete.

If we catch the guest with a dump request while the kernel module is
setting up the fields (i.e., the fields are not consistent), then we'll
catch that in our sanity checks, and the note won't be extracted. This
is no different from the case when you simply dump the guest RAM before
the module got invoked.

> Given you have very little data to export (PA, size - do
> you even need size?)

Yes, it tells us in advance how much memory to allocate before we copy
out the vmcoreinfo ELF note (and we enforce a sanity limit on the size).

> - how about just using an ACPI method do it,

Do what exactly?

> instead of exporting a physical addess and storing address there.  This
> way you can add more methods as you add functionality.

I'm not saying this is a bad idea (especially because I don't fully
understand your point), but I will say that I'm quite sad that you are
sending Marc-Andr=C3=A9 back to the drawing board after he posted v4 -- a=
lso
invalidating my review efforts. :/

Laszlo
