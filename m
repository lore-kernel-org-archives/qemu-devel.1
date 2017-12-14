Received: from eggs.gnu.org ([2001:4830:134:3::10]:43662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePY6s-0006TM-04
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePY6q-0006g9-Vy
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:19:53 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:41196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePY6q-0006fb-Qj
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:19:52 -0500
Received: by mail-it0-x241.google.com with SMTP id x28so13606252ita.0
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 10:19:52 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAKmqyKOFxKz1c6NfU8pJer1b3tk1H010zVaekotgQgEKbJ6t-g@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-12-f4bug@amsat.org>
	<CAKmqyKOFxKz1c6NfU8pJer1b3tk1H010zVaekotgQgEKbJ6t-g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 15:19:51 -0300
Message-ID: <CAAdtpL6uEqsSj2Zd-X8bN9nGmvVTERLQS_nzNGCKpjTwBMEV2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/14] sdhci: convert the DPRINT() calls
 into trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Dec 14, 2017 at 2:54 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
> <f4bug@amsat.org> wrote:
>> zero-initialize ADMADescr 'dscr' in sdhci_do_adma() to avoid:
>>
>>   hw/sd/sdhci.c: In function =E2=80=98sdhci_do_adma=E2=80=99:
>>   hw/sd/sdhci.c:714:29: error: =E2=80=98dscr.addr=E2=80=99 may be used u=
ninitialized in this function [-Werror=3Dmaybe-uninitialized]
>>              trace_sdhci_adma("link", s->admasysaddr);
>>                              ^
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks, note this patch has two incorrect uint64_t string format, I'll
add your Acked-by in the respin with "%x" replaced by PRIx64.

>> +# hw/sd/sdhci.c
>> +sdhci_set_inserted(const char *level) "card state changed: %s"
>> +sdhci_send_command(uint8_t cmd, uint32_t arg) "sending CMD%02u ARG[0x%0=
8x]"
>> +sdhci_error(const char *msg) "%s"
>> +sdhci_response4(uint32_t r0) "Response: RSPREG[31..0]=3D0x%08x"
>> +sdhci_response16(uint32_t r3, uint32_t r2, uint32_t r1, uint32_t r0) "R=
esponse received: RSPREG[127..96]=3D0x%08x, RSPREG[95..64]=3D0x%08x, RSPREG=
[63..32]=3D0x%08x, RSPREG[31..0]=3D0x%08x"
>> +sdhci_end_transfer(uint8_t cmd, uint32_t arg) "Automatically issue CMD%=
02u 0x%08x"
>> +sdhci_adma(const char *desc, uint32_t sysad) "ADMA %s: admasysaddr=3D0x=
%" PRIx32
>> +sdhci_adma_loop(uint64_t addr, uint16_t length, uint8_t attr) "ADMA loo=
p: addr=3D0x%08" HWADDR_PRIx ", len=3D%d, attr=3D0x%x"

^ incorrect uint64_t format

>> +sdhci_adma_transfer_completed(void) "ADMA transfer completed"
>> +sdhci_access(const char *access, unsigned int size, uint64_t offset, co=
nst char *dir, uint64_t val, uint64_t val2) "%s %ub: addr[0x%04" HWADDR_PRI=
x "] %s %" PRIu64 "(0x%" PRIx64 ")"
>> +sdhci_read_dataport(uint16_t data_count) "all %u bytes of data have bee=
n read from input buffer"
>> +sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u =
bytes of data"
