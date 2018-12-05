Received: from eggs.gnu.org ([2001:4830:134:3::10]:37848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fwsgonzo@hotmail.com>) id 1gUWqE-0007IS-9B
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fwsgonzo@hotmail.com>) id 1gUWq9-00031A-N0
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:03:50 -0500
Received: from mail-oln040092071021.outbound.protection.outlook.com
	([40.92.71.21]:58944
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fwsgonzo@hotmail.com>)
	id 1gUWq9-0002zj-3d
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:03:45 -0500
From: Gonzo FWS <fwsgonzo@hotmail.com>
Date: Wed, 5 Dec 2018 13:03:42 +0000
Message-ID: <HE1P190MB0073F38AA6DDA11555CDF704DEA80@HE1P190MB0073.EURP190.PROD.OUTLOOK.COM>
References: <HE1P190MB00739AD5A654DAA3FE9B4662DEAF0@HE1P190MB0073.EURP190.PROD.OUTLOOK.COM>
	<a3fe5633-d031-6a58-40c2-aee43b2bec45@tuxfamily.org>,
	<ced8df86-4fe3-f11e-005c-e9b8127434d6@redhat.com>
In-Reply-To: <ced8df86-4fe3-f11e-005c-e9b8127434d6@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] i386: don't require elf64 for multiboot kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <huth@tuxfamily.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
	Apfelbaum <marcel.apfelbaum@gmail.com>

When I attach a GRUB loader, it doesn't check ELFCLASS at all. It just boot=
s the kernel as expected in protected mode. Only Qemu does the extra check =
that I know of, but I cannot force your opinions on this. We can still cont=
inue to use a chainloader to avoid this problem. (Or worse, build a ELFCLAS=
S32 64-bit kernel. Just kidding, of course.)

-gonzo
________________________________
From: Paolo Bonzini <pbonzini@redhat.com>
Sent: Wednesday, December 5, 2018 1:20 PM
To: Thomas Huth; Gonzo FWS; qemu-devel@nongnu.org
Cc: Richard Henderson; Eduardo Habkost; Michael S. Tsirkin; Marcel Apfelbau=
m
Subject: Re: [Qemu-devel] i386: don't require elf64 for multiboot kernel

On 05/12/18 06:35, Thomas Huth wrote:
> On 2018-12-04 17:55, Gonzo FWS wrote:
>> Right now IncludeOS on x86_64 must use a chainloader for multiboot
>> support. The chainloader is an ELF32 kernel that loads the real
>> ELF64 kernel and jumps to it. As long as the ELF has the .multiboot
>> section and conforms to the spec, meaning _start is be a 32-bit
>> entry, it should be fine.
>>
>> By removing the extra check in multiboot.c, we can also boot ELF64
>> files. As can be seen here:
>> https://cloud.fwsnet.net/index.php/s/XrkBkC8zy7MLa9p
>>
>> Signed-off-by: Alf-Andr=E9 Walla <fwsgonzo@hotmail.com>

I think a 64-bit multiboot specification doesn't exist, but if it
existed, it would require an EM_X86_64 ELF file to be booted already in
long mode.  I don't think it's a good idea to allow booting into an
EM_X86_64 ELF file with the processor in 32-bit mode.

Paolo
