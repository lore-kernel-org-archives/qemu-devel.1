Received: from eggs.gnu.org ([2001:4830:134:3::10]:50719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpHij-00022u-5K
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpHie-0005od-Ia
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:33:05 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dpHie-0005nY-BN
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:33:00 -0400
Received: by mail-wr0-x241.google.com with SMTP id 40so2030196wrv.3
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 10:32:58 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170904141748.GU7570@localhost.localdomain>
References: <cover.1504228916.git.alistair.francis@xilinx.com>
	<5bf40ca8376c537ac05dd848a84e072a88a1d939.1504228916.git.alistair.francis@xilinx.com>
	<20170904141748.GU7570@localhost.localdomain>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 5 Sep 2017 10:32:25 -0700
Message-ID: <CAKmqyKMjQvWFQhnt_or9OhGDND=41p+iEFnQ7TCiMwEdm=W6Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/7] hw/i386: Improve some of the
 warning messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Don Slutz <dslutz@verizon.com>

On Mon, Sep 4, 2017 at 7:17 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Fri, Sep 01, 2017 at 09:51:05AM -0700, Alistair Francis wrote:
> [...]
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 169a214d50..435eb2c458 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -101,9 +101,11 @@ static void pc_q35_init(MachineState *machine)
>>          lowmem = pcms->max_ram_below_4g;
>>          if (machine->ram_size - lowmem > lowmem &&
>>              lowmem & ((1ULL << 30) - 1)) {
>> -            warn_report("Large machine and max_ram_below_4g(%"PRIu64
>> -                        ") not a multiple of 1G; possible bad performance.",
>> -                        pcms->max_ram_below_4g);
>> +            warn_report("Large machine as the ram size (0x%" PRIx64 ") is more"
>> +                        " then twice the size of the internal limit"
>> +                        " (0x%" PRIx64 ") and max-ram-below-4g (%"PRIu64")"
>> +                        " note a multiple of 1G; possible bad performance.",
>> +                        machine->ram_size, lowmem, pcms->max_ram_below_4g);
>
> Here lowmem and max_ram_below_4g have exactly the same value,
> don't they?  There's no internal limit involved in this logic,
> only max_ram_below_4g and ram_size.

Good point, I'll change it to this:

warn_report("There is possibly poor performance as the ram size "
            " (0x%" PRIx64 ") is more then twice the size of"
            " max-ram-below-4g (%"PRIu64") and"
            " max-ram-below-4g is not a multiple of 1G.",
            machine->ram_size, pcms->max_ram_below_4g);

Thanks,
Alistair

>
> --
> Eduardo
