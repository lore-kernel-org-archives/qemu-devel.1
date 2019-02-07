Received: from eggs.gnu.org ([209.51.188.92]:54271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grk3u-0003YM-0b
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grk3s-0001Ds-TK
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:49:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<87mun8gd2x.fsf@dusky.pond.sub.org>
	<4675f707-1215-80ac-fc27-362688e51df9@redhat.com>
Date: Thu, 07 Feb 2019 14:49:25 +0100
In-Reply-To: <4675f707-1215-80ac-fc27-362688e51df9@redhat.com> (Laszlo Ersek's
	message of "Thu, 7 Feb 2019 13:31:13 +0100")
Message-ID: <87sgwzd7yy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org

Laszlo Ersek <lersek@redhat.com> writes:

> Hi Markus,
>
> On 02/07/19 10:30, Markus Armbruster wrote:
>> The thread got long, let me try to summarize, and elaborate a few
>> points.
>>=20
>> * The problem at hand is configuring firmware residing in flash memory
>>   (OVMF requires this) without legacy -drive.
>>=20
>> * The wider problem is configuring onboard devices.  Our general device
>>   configuration interface doesn't cover them.  Instead, we have a zoo of
>>   ad hoc interfaces that are much more limited.  Some of them we'd
>>   rather deprecate (-drive, -net), but can't until we have a suitable
>>   replacements.
>>=20
>>   I think a board should be a composite object that exposes properties
>>   of its own and its parts, just like other composite devices, so that
>>   "create, set properties, realize" just works.  That would extend our
>>   common device configuration mechanism naturally to onboard devices.
>>=20
>>   A PC board's flash memory device would be just another part.  It could
>>   be something like /machine/q35/cfi.pflash01/ in the QOM tree.  To
>>   configure it, you'd set its properties, such as
>>   /machine/q35/cfi.pflash01/drive.
>>=20
>>   Note that this requires a way to set an existing device's properties.
>>   Perhaps qom-set already works.
>>=20
>> * While I do believe we should tackle the wider problem, I'd rather not
>>   sit on the narrow problem until we crack it.  So, what can we do about
>>   it?
>>=20
>>   - Paolo proposed to add block backend properties to the PC machine,
>>     settable like -machine pflash0=3DBLOCK-BACKEND.
>>=20
>>     Possible drawback: if we add /machine/q35/pflash0 to the QOM tree
>>     now, and later replace it by /machine/q35/cfi.pflash01/drive, we'll
>>     have to deal with yet another machine type variation.  We'll live.
>>=20
>>   - I proposed to sidestep our onboard device configuration problem by
>>     adding the cfi.pflash01 devices with our existing general device
>>     configuration interface: -device.  Possible since the onboard
>>     cfi.pflash01 devices are optional.  Requires a small extension to
>>     the firmware descriptors, and a bit of extra work in libvirt to
>>     process that extension.  I think it's workable, but Paolo's idea is
>>     simpler.
>>=20
>>   I can give Paolo's idea a try.  Objections?
>>=20
>> * A flash device supporting multiple regions is desirable, because it's
>>   what physical hardware has.  We currently use multiple flash devices
>>   instead.  We'll be stuck with them for existing machine types due to
>>   guest ABI and migration compatibility.
>>=20
>> * cfi.pflash01 currently requires users to opt out of "bad, do not use".
>>   It should require opt in, to guard against accidental new uses of
>>   "bad".
>>=20
>>=20
>> PS: Big thanks to L=C3=A1szl=C3=B3, whose patient guidance helped me map=
 this part
>> of the jungle.
>>=20
>
> I've read the above carefully.
>
> At the QEMU design level, I don't have any opinion or preference; there
> I simply don't know enough -- and don't suffer from bad decisions enough
> -- to make sensible comments.
>
> Regarding the choice betwen "-machine pflash0=3DBLOCK-BACKEND" and
> "-device pflash": I don't object to exploring the former first.
>
> I'd just like to note that "-machine pflash0=3DBLOCK-BACKEND" will also
> require changes to the firmware descriptor schema. Not to the types that
> the schema defines -- and therefore concrete descriptor *documents* that
> already conform to the schema wouldn't be affected --, but to the
> documentation that the schema directs at management applications.
>
> The schema is supposed to specify (in the documentation) QEMU command
> line options for management applications. If we add "-machine
> pflash0=3DBLOCK-BACKEND", then even if the types in the schema stay the
> same, some mappings to the QEMU cmdline will have to be re-documented.

Good point.

> Of course, that's still easier / less intrusive than changing the types!
> ... Which does make me prefer "-machine pflash0=3DBLOCK-BACKEND", if I'm
> being honest.
>
> (I hope my followup isn't totally useless. I certainly didn't want to
> ignore your summary.)

Pointing out the need to update these comments is anything but useless.

Thanks!
