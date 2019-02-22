Received: from eggs.gnu.org ([209.51.188.92]:43739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gx56X-0008RP-1d
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gx56V-0008Cn-Fy
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:18:40 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-3-armbru@redhat.com>
	<2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
	<CAFEAcA9Pe3D=7r+3csriAZO8gkVkwypOBncZzkYTOCAujpKOsA@mail.gmail.com>
	<875ztfuc0j.fsf@dusky.pond.sub.org>
	<87sgwh5wef.fsf@dusky.pond.sub.org>
	<CAFEAcA8gHp-VD05x9Q1V3_K29wsMeZD1SdM+PDteOXcAE3QHwg@mail.gmail.com>
	<8d278f39-9549-5326-bfd8-b4bcabeacf84@redhat.com>
Date: Fri, 22 Feb 2019 08:17:47 +0100
In-Reply-To: <8d278f39-9549-5326-bfd8-b4bcabeacf84@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	21 Feb 2019 17:19:48 +0100")
Message-ID: <8736ogs350.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] pflash: Macro PFLASH_BUG() is used
 just once, expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/21/19 10:38 AM, Peter Maydell wrote:
>> On Thu, 21 Feb 2019 at 09:22, Markus Armbruster <armbru@redhat.com> wrot=
e:
>>> Double-checking... you want me to keep goto reset_flash, like this:
>>>
>>> @@ -623,8 +617,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>>>                  pfl->wcycle =3D 0;
>>>                  pfl->status |=3D 0x80;
>>>              } else {
>>> -                DPRINTF("%s: unknown command for \"write block\"\n", _=
_func__);
>>> -                PFLASH_BUG("Write block confirm");
>>> +                qemu_log_mask(LOG_GUEST_ERROR,
>>> +                              "unknown command for \"write block\"\n");
>>>                  goto reset_flash;
>>>              }
>>>              break;
>>=20
>> Yes. (We seem to handle most kinds of guest errors in programming
>> the flash by reset_flash.)
>
> Oh I missed the context of the patch here.
>
> So for the case of the Multi-WRITE command (0xe8):

Since I'm a clueless idiot on pflash, I need to process your argument
real slow, so I can write a commit message that doesn't document my
cluelessness forever.

We have a little state machine, and its state is encoded in
pfl->wcycle. pfl->cmd, pfl->counter.  I'm going to show it as

    (value of pfl->wcycle, value of pfl->cmd, value of pfl->counter)

for brevity.

We start with (0, don't care, don't care).

A guest write sends us a width, an address, and a value.
pflash_mem_write_with_attrs() does permission checking, and
pflash_write() the actual work.  We enter it with @offset, @value and
@width holding the message.

    cmd =3D value;

    trace_pflash_write(offset, value, width, pfl->wcycle);
    if (!pfl->wcycle) {
        /* Set the device in I/O access mode */
        memory_region_rom_device_set_romd(&pfl->mem, false);
    }

@cmd is @value truncated to 8 bits.

> 1/ On first write cycle we have
>
>   - address =3D flash_page_address (we store it in pfl->counter)
>   - data =3D flash_command (0xe8: enter Multi-WRITE)

    switch (pfl->wcycle) {
    case 0:
        /* read mode */
        switch (cmd) {
        [...]
        case 0xe8: /* Write to buffer */
            DPRINTF("%s: Write to buffer\n", __func__);
            pfl->status |=3D 0x80; /* Ready! */
            break;
        [...]
        pfl->wcycle++;
        pfl->cmd =3D cmd;
        break;

Transition from (0, don't care, don't care) to (1, 0xE8, don't care).

I can't see "we store it in pfl->counter".

Note that the address (passed in @offset) is entirely ignored.

> 2/ Second cycle:
>
>   - address =3D flash_page_address
>     We should check it matches flash_page_address
>     of cycle 1/, but we don't.
>   - data: N
>
>     "N is the number of elements (bytes / words / double words),
>     minus one, to be written to the write buffer. Expected count
>     ranges are N =3D 00h to N =3D 7Fh (e.g., 1 to 128 bytes) in 8-bit
>     mode, N =3D 00h to N =3D 003Fh in 16-bit mode, and N =3D 00h to
>     N =3D 1Fh in 32-bit mode. Bus cycles 3 and higher are for writing
>     data into the write buffer. The confirm command (D0h) is
>     expected after exactly N + 1 write cycles; any other command at
>     that point in the sequence will prevent the transfer of the
>     buffer to the array (the write will be aborted)."
>
>     Instead of starting to write the data in a buffer, we write it
>     directly to the block backend.

    case 1:
        switch (pfl->cmd) {
        [...]
        case 0xe8:
            /* Mask writeblock size based on device width, or bank width if
             * device width not specified.
             */
            if (pfl->device_width) {
                value =3D extract32(value, 0, pfl->device_width * 8);
            } else {
                value =3D extract32(value, 0, pfl->bank_width * 8);
            }
            DPRINTF("%s: block write of %x bytes\n", __func__, value);
            pfl->counter =3D value;
            pfl->wcycle++;
            break;
        [...]
        }
        break;

Transition from (1, 0xE8, don't care) to (2, 0xE8, N), where N is passed
in @value.

Again, the address (passed in @offset) is ignored.

Nothing is written to the block backend, yet.

>     Instead of starting to write from cycle 3+, we write now in 2,
>     and keep cycle count =3D=3D 2 (pfl->wcycle) until all data is
>     written, where we increment at 3.

    case 2:
        switch (pfl->cmd) {
        case 0xe8: /* Block write */
            if (!pfl->ro) {
                pflash_data_write(pfl, offset, value, width, be);
            } else {
                pfl->status |=3D 0x10; /* Programming error */
            }

Write to memory, with pflash_data_write(), but don't flush to the
backend, yet.  This is (guest-visibly!) wrong.  It's not quite "instead
of starting to write the data in a buffer, we write it directly to the
block backend."

Note that we happily accept any address and width.  I suspect we should
only accept consecutive addresses and consistent width.

            pfl->status |=3D 0x80;

            if (!pfl->counter) {
                hwaddr mask =3D pfl->writeblock_size - 1;
                mask =3D ~mask;

                DPRINTF("%s: block write finished\n", __func__);
                pfl->wcycle++;
                if (!pfl->ro) {
                    /* Flush the entire write buffer onto backing storage. =
 */
                    pflash_update(pfl, offset & mask, pfl->writeblock_size);
                } else {
                    pfl->status |=3D 0x10; /* Programming error */
                }
            }

If this is the multi-write's last write, flush the entire write block to
the backend *boggle*.

            pfl->counter--;
            break;
        [...]
        }
        break;

Transition from (2, 0xE8, N) to

    (2, 0xE8, N-1)          if N>0
    (3, 0xE8, don't care)   if N=3D=3D0

> 3/ Cycles 3+
>
>   - address =3D word index (relative to the page address)
>   - data =3D word value
>
>     We check for the CONFIRM command, and switch the device back
>     to READ mode (setting Status), or reset the device (which is
>     modelled the same way).
>
>     Very silly: If the guest cancelled and never sent the CONFIRM
>     command, the data is already written/flushed back.

    case 3: /* Confirm mode */
        switch (pfl->cmd) {
        case 0xe8: /* Block write */
            if (cmd =3D=3D 0xd0) {
                pfl->wcycle =3D 0;
                pfl->status |=3D 0x80;

On CONFIRM, transition from (3, 0xE8, don't care) back to the intial
state (0, don't care, don't care).

            } else {
                DPRINTF("%s: unknown command for \"write block\"\n", __func=
__);
                PFLASH_BUG("Write block confirm");
                goto reset_flash;
            }

On anything else, pea brain implodes, and we exit(1).

            break;

The fact that we let a hack job like this anywhere near "secure boot" is
either frightening or amusing, depending on one's level of cynicism
towards virtual secure boot.

> So back to the previous code snippet, regardless the value, this
> is neither a hw_error() nor a GUEST_ERROR. This code is simply not
> correct. Eventually the proper (polite) error message should be:
>
>     qemu_log_mask(LOG_UNIMP, "MULTI_WRITE: Abort not implemented,"
>                              " the data is already written"
>                              " on storage!\n"
>                              "Nevertheless resetting the flash"
>                              " into READ mode.\n");

Yup, makes sense.

Perhaps we should also LOG_UNIMP on the first write of a multi-write
already, because the guest-visible wrongness starts right there.  You
tell me.

Two things left to do for this series: FIXME comments, and a commit
message.  Before I tackle them, I'll give you a chance to correct
misunderstandings in my reasoning.
