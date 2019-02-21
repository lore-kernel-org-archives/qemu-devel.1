Received: from eggs.gnu.org ([209.51.188.92]:46564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwr4v-0003bY-T3
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwr4u-0005of-TD
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:20:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwr4u-0004xU-Ma
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:20:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so17906100wrg.9
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 08:19:51 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-3-armbru@redhat.com>
	<2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
	<CAFEAcA9Pe3D=7r+3csriAZO8gkVkwypOBncZzkYTOCAujpKOsA@mail.gmail.com>
	<875ztfuc0j.fsf@dusky.pond.sub.org> <87sgwh5wef.fsf@dusky.pond.sub.org>
	<CAFEAcA8gHp-VD05x9Q1V3_K29wsMeZD1SdM+PDteOXcAE3QHwg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8d278f39-9549-5326-bfd8-b4bcabeacf84@redhat.com>
Date: Thu, 21 Feb 2019 17:19:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8gHp-VD05x9Q1V3_K29wsMeZD1SdM+PDteOXcAE3QHwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>

On 2/21/19 10:38 AM, Peter Maydell wrote:
> On Thu, 21 Feb 2019 at 09:22, Markus Armbruster <armbru@redhat.com> wrote:
>> Double-checking... you want me to keep goto reset_flash, like this:
>>
>> @@ -623,8 +617,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>>                  pfl->wcycle = 0;
>>                  pfl->status |= 0x80;
>>              } else {
>> -                DPRINTF("%s: unknown command for \"write block\"\n", __func__);
>> -                PFLASH_BUG("Write block confirm");
>> +                qemu_log_mask(LOG_GUEST_ERROR,
>> +                              "unknown command for \"write block\"\n");
>>                  goto reset_flash;
>>              }
>>              break;
> 
> Yes. (We seem to handle most kinds of guest errors in programming
> the flash by reset_flash.)

Oh I missed the context of the patch here.

So for the case of the Multi-WRITE command (0xe8):

1/ On first write cycle we have

  - address = flash_page_address (we store it in pfl->counter)
  - data = flash_command (0xe8: enter Multi-WRITE)

2/ Second cycle:

  - address = flash_page_address
    We should check it matches flash_page_address
    of cycle 1/, but we don't.
  - data: N

    "N is the number of elements (bytes / words / double words),
    minus one, to be written to the write buffer. Expected count
    ranges are N = 00h to N = 7Fh (e.g., 1 to 128 bytes) in 8-bit
    mode, N = 00h to N = 003Fh in 16-bit mode, and N = 00h to
    N = 1Fh in 32-bit mode. Bus cycles 3 and higher are for writing
    data into the write buffer. The confirm command (D0h) is
    expected after exactly N + 1 write cycles; any other command at
    that point in the sequence will prevent the transfer of the
    buffer to the array (the write will be aborted)."

    Instead of starting to write the data in a buffer, we write it
    directly to the block backend.
    Instead of starting to write from cycle 3+, we write now in 2,
    and keep cycle count == 2 (pfl->wcycle) until all data is
    written, where we increment at 3.

3/ Cycles 3+

  - address = word index (relative to the page address)
  - data = word value

    We check for the CONFIRM command, and switch the device back
    to READ mode (setting Status), or reset the device (which is
    modelled the same way).

    Very silly: If the guest cancelled and never sent the CONFIRM
    command, the data is already written/flushed back.

So back to the previous code snippet, regardless the value, this
is neither a hw_error() nor a GUEST_ERROR. This code is simply not
correct. Eventually the proper (polite) error message should be:

    qemu_log_mask(LOG_UNIMP, "MULTI_WRITE: Abort not implemented,"
                             " the data is already written"
                             " on storage!\n"
                             "Nevertheless resetting the flash"
                             " into READ mode.\n");

Regards,

Phil.
