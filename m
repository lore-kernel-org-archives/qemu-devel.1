Received: from eggs.gnu.org ([209.51.188.92]:55303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2GT1-0007Fh-1E
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2GT0-0004ve-6q
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 09:27:19 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190307130323.9353-1-armbru@redhat.com>
	<20190307130323.9353-7-armbru@redhat.com>
	<a8a862f1-1f1e-818a-2ac6-bd54375c4dc3@redhat.com>
Date: Fri, 08 Mar 2019 15:27:05 +0100
In-Reply-To: <a8a862f1-1f1e-818a-2ac6-bd54375c4dc3@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 8 Mar 2019 15:04:28
	+0100")
Message-ID: <87wol9bfwm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/14] sam460ex: Don't size flash memory
 to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 3/7/19 2:03 PM, Markus Armbruster wrote:
>> Machine "sam460ex" maps its flash memory at address 0xFFF00000.  When
>> no image is supplied, its size is 1MiB (0x100000), and 512KiB of ROM
>> get mapped on top of its second half.  Else, it's the size of the
>> image rounded up to the next multiple of 64KiB.
>>=20
>> The rounding is actually useless: pflash_cfi01_realize() fails with
>> "failed to read the initial flash content" unless it's a no-op.
>>=20
>> I have no idea what happens when the pflash's size exceeds 1MiB.
>> Useful outcomes seem unlikely.
>
> You now have! [*] "Hardwiring address lines leaves part of the hardware
> unaddressable." Anything bigger than 1MiB mapped at 0xFFF00000 only has
> the first MiB addressable. IOW anything above 1MiB is unaddressable, but
> you still can map a such bigger flash.
>
> [*] https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg01380.html

Well, that's what would happen with real hardware.  But this device
model doesn't actually model address lines.  It simply asks
pflash_cfi01_register() to map blk_getlength() bytes at the base
address.  If you ask it to map gigabytes, it'll happily do so (as long
as malloc plays along).
