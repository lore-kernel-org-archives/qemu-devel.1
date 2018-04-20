Received: from eggs.gnu.org ([2001:4830:134:3::10]:38866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9VKF-0002js-Na
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9VKB-0005tK-NY
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:39:39 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9VKB-0005rv-Ih
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:39:35 -0400
Received: by mail-qt0-x243.google.com with SMTP id q13-v6so9308112qtl.3
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 05:39:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180419220914.959-1-f4bug@amsat.org>
	<20180419220914.959-2-f4bug@amsat.org>
	<CAFEAcA-LYpqaYfdmjzXwMDau8bZH_zxXaRCCL5dRT1p6spjUxQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f89278ba-b805-e47d-7e5e-d103ab9c4294@amsat.org>
Date: Fri, 20 Apr 2018 09:39:31 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-LYpqaYfdmjzXwMDau8bZH_zxXaRCCL5dRT1p6spjUxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/isa/superio: Fix inconsistent use
 of Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi Peter,

On 04/20/2018 05:43 AM, Peter Maydell wrote:
> On 19 April 2018 at 23:09, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> 4c3119a6e3e and cd9526ab7c0 introduced an incorrect and inconsistent
>> use of Chardev->be. Also, this CharBackend member is private and is
>> not supposed to be accessible.
>>
>> Fix it by removing the inconsistent check.
>>
>> Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/isa/isa-superio.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
>> index b95608a003..08afe44731 100644
>> --- a/hw/isa/isa-superio.c
>> +++ b/hw/isa/isa-superio.c
>> @@ -43,7 +43,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
>>          if (!k->parallel.is_enabled || k->parallel.is_enabled(sio, i)) {
>>              /* FIXME use a qdev chardev prop instead of parallel_hds[] */
>>              chr = parallel_hds[i];
>> -            if (chr == NULL || chr->be) {
>> +            if (chr == NULL) {
>>                  name = g_strdup_printf("discarding-parallel%d", i);
>>                  chr = qemu_chr_new(name, "null");
>>              } else {
>> @@ -83,7 +83,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
>>          if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
>>              /* FIXME use a qdev chardev prop instead of serial_hds[] */
>>              chr = serial_hds[i];
>> -            if (chr == NULL || chr->be) {
>> +            if (chr == NULL) {
>>                  name = g_strdup_printf("discarding-serial%d", i);
>>                  chr = qemu_chr_new(name, "null");
>>              } else {
> 
> You should not need to create fake null devices like this. The
> device using the chardev should just cope with having a NULL
> pointer now we have commit 12051d82f004024.

I am trying to model a SoC with 4 uarts, and started using the current
pattern:

  for (i = 0; i < MAX_SERIAL_PORTS; i+++) {
    if (serial_hds[i]) {
      serial_mm_init(..., serial_hds[i], ...);

Then the test firmware failed due to unassigned access after rebasing,
due to:

  commit ed860129acd3fcd0b1e47884e810212aaca4d21b
  Author: Peter Maydell <peter.maydell@linaro.org>
  Date:   Thu Sep 7 13:54:54 2017 +0100

    boards.h: Define new flag ignore_memory_transaction_failures

    Define a new MachineClass field ignore_memory_transaction_failures.
    If this is flag is true then the CPU will ignore memory transaction
    failures which should cause the CPU to take an exception due to an
    access to an unassigned physical address; the transaction will
    instead return zero (for a read) or be ignored (for a write).  This
    should be set only by legacy board models which rely on the old
    RAZ/WI behaviour for handling devices that QEMU does not yet model.
    New board models should instead use "unimplemented-device" for all
    memory ranges where the guest will attempt to probe for a device that
    QEMU doesn't implement and a stub device is required.

    We need this for ARM boards, where we're about to implement support for
    generating external aborts on memory transaction failures. Too many
    of our legacy board models rely on the RAZ/WI behaviour and we
    would break currently working guests when their "probe for device"
    code provoked an external abort rather than a RAZ.

Which is fine, I understand new boards shouldn't use the
ignore_memory_transaction_failures flag.

The chardev subsystem is still confuse to me.
I think than checking if a chardev backend is connected to instantiate
and mmap a device and his irqs is incorrect, since boards/SoCs always
come with the same hardware.

Indeed previous to 12051d82f004024, qemu_chr_fe_init(s=NULL) was doing

     if (CHARDEV_IS_MUX(s)) {
         ...
     } else {
         s->be = b; /* NULL deref... */
     }

Which seems the original reason of my bogus "if (chr == NULL || chr->be)
..." check.

Since we can now safely call serial_mm_init(..., chr=NULL, ...), I'll
work on simplifying and fixing this.

> Also consider having cc:stable on this patchset?

Once we get a consensus on the series, OK.

Thanks,

Phil.
