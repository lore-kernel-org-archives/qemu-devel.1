Received: from eggs.gnu.org ([209.51.188.92]:47371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gwn8g-0008PR-Jg
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gwn8e-00021u-A9
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:07:42 -0500
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-3-armbru@redhat.com>
	<2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
	<CAFEAcA9Pe3D=7r+3csriAZO8gkVkwypOBncZzkYTOCAujpKOsA@mail.gmail.com>
	<875ztfuc0j.fsf@dusky.pond.sub.org> <87sgwh5wef.fsf@dusky.pond.sub.org>
	<CAFEAcA8gHp-VD05x9Q1V3_K29wsMeZD1SdM+PDteOXcAE3QHwg@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <83b8edf2-8a4b-3d1b-bdde-63738ffb6479@redhat.com>
Date: Thu, 21 Feb 2019 13:07:26 +0100
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
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>

somewhat off-topic:

On 02/21/19 10:38, Peter Maydell wrote:
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

since we're talking "reset_flash", I'll note that there is no actual
reset handler for cfi.pflash01. I found out recently, via:

https://bugzilla.redhat.com/show_bug.cgi?id=1678713

Thanks
Laszlo
