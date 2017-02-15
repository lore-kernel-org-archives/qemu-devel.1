Received: from eggs.gnu.org ([2001:4830:134:3::10]:55946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ipavlikevich@gmail.com>) id 1ce1lt-00053j-7r
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ipavlikevich@gmail.com>) id 1ce1ls-0006Ov-23
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:45:33 -0500
MIME-Version: 1.0
In-Reply-To: <97012317-0db8-a272-1802-7a402ebe78a5@msgid.tls.msk.ru>
References: <CA+O_+ExjKRNyfbXWzh7RRHgTjqTBC+WscYCiBGyjLK2XOvoPmQ@mail.gmail.com>
	<97012317-0db8-a272-1802-7a402ebe78a5@msgid.tls.msk.ru>
From: Igor Pavlikevich <ipavlikevich@gmail.com>
Date: Wed, 15 Feb 2017 18:45:26 +0300
Message-ID: <CA+O_+Ex6E291g0BKLWox+x8g16j2ij4KYJ9PwiwrH7Qx4J-Epw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/acpi/tco.c: fix tco timer stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Wed, Feb 15, 2017 at 1:34 PM, Michael Tokarev <mjt@tls.msk.ru> wrote:
> 06.02.2017 17:44, Igor Pavlikevich wrote:
>> TCO timer does not actually stop
>>
>> Signed-off-by: Igor Pavlikevich <ipavlikevich@gmail.com>
>> ---
>>  hw/acpi/tco.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
>> index 8ce7daf..b4adac8 100644
>> --- a/hw/acpi/tco.c
>> +++ b/hw/acpi/tco.c
>> @@ -49,6 +49,7 @@ static inline void tco_timer_reload(TCOIORegs *tr)
>>  static inline void tco_timer_stop(TCOIORegs *tr)
>>  {
>>      tr->expire_time = -1;
>> +    timer_del(tr->tco_timer);
>>  }
>>
>>  static void tco_timer_expired(void *opaque)
>>
>
> I'm not sure this is really trivial change.
> Can you elaborate a bit please?

When linux guest goes to first reboot, it calls
watchdog_open()->watchdog_start()->iTCO_wdt_start() and write 0 to
TCO1_CNT.
After that can_start_tco_timer() returns true, starts timer in
tco_timer_reload() and guest kernel starts flooding
[  590.392055] Uhhuh. NMI received for unknown reason 30 on CPU 0.
[  590.392055] Do you have a strange power saving mode enabled?
[  590.392055] Dazed and confused, but trying to continue
[  620.392035] Uhhuh. NMI received for unknown reason 20 on CPU 0.
[  620.392035] Do you have a strange power saving mode enabled?
[  620.392035] Dazed and confused, but trying to continue

Timer keeps reloading after ich9_generate_nmi() so there is only one
way to stop reloading by clearing ICH9_CC_GCS_NO_REBOOT and reset
guest via  watchdog_perform_action(), becasue tco_timer_stop() does
not actually modify tr->tco_timer.

Tested on Debian wheezy/jessie guests with default kernels and qemu
2.5+ q35 machine.

>
> And please Cc qemu-devel@ too (doing this now).
>
> Thanks,
>
> /mjt
