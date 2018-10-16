Received: from eggs.gnu.org ([2001:4830:134:3::10]:43445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMEE-000157-7T
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMDy-0003zn-Sb
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:05:22 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCMDt-0003WL-GN
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:05:10 -0400
Received: by mail-ot1-x342.google.com with SMTP id c23so20137312otl.9
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 03:05:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181016110200.0b20a7f3@donnerap.cambridge.arm.com>
References: <40eb19fb56b24e10a5eaa99ccb78aff6@dornerworks.com>
	<73dcea68-2342-63b7-9691-a151f00a42e8@redhat.com>
	<65e2edeee9d94a288938da9cec4b16bb@dornerworks.com>
	<20181016110200.0b20a7f3@donnerap.cambridge.arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 11:04:43 +0100
Message-ID: <CAFEAcA-5Q+L65b25i-qwyy-5fCQEzfaUB+N2D+pts8zVtyi2Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: Increase compliance with
 kernel arm64 boot protocol.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Julien Grall <julien.grall@arm.com>

On 16 October 2018 at 11:02, Andre Przywara <andre.przywara@arm.com> wrote:
> On Tue, 16 Oct 2018 01:19:35 +0000
> Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com> wrote:
>
> Hi,
>
> Stewart, thanks a lot for picking this up!
>
>> On Monday, October 15, 2018 6:05 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> > Hi Stewart,
>> >
>> > On 15/10/2018 23:26, Stewart Hildebrand wrote:
>> > > +            /* For the virt board, we write our startup
>> > > "bootloader" at the very
>> > > +             * bottom of RAM, so that bit can't be used for the
>> > > image. To avoid
>> > > +             * overlap in case the image requests to be loaded
>> > > at an offset
>> > > +             * smaller than our bootloader, we increment the
>> > > load offset to the
>> > > +             * next 2MB.
>> > > +             */
>> > > +            if (kernel_load_offset < FIXUP_MAX) {
>> >
>> > I don't understand how this is related to FIXUP_MAX...
>>
>> You're right, my apologies, it's not directly related.
>> write_bootloader() calculates the size of the bootloader like so:
>>     len =3D 0;
>>     while (insns[len].fixup !=3D FIXUP_TERMINATOR) {
>>         len++;
>>     }
>>
>> The size of the bootloader then would be len * sizeof(uint32_t)
>>
>> It would be nice not to have to repeat that logic in
>> load_aarch64_image(). I'll send out a v2 after I take some time to
>> wrap my head around it...
>
> I wonder if this could be done much easier, since TEXT_OFFSET must
> actually be page aligned. So all we would need is an *upper bound* for
> the bootloader size, as long as that is below 4K we wouldn't even loose
> anything.

Yes, I think it would be fine to just set a max bootloader size of
4K and check against that. (If so, assert() in write_bootloader
that we did stay below the max.)

thanks
-- PMM
