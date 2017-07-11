Received: from eggs.gnu.org ([2001:4830:134:3::10]:47283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUvFc-0007Y0-19
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUvFX-0000Yv-UU
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:30:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUvFX-0000Xg-Ku
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:30:47 -0400
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
	<1499700760-4777-9-git-send-email-thuth@redhat.com>
	<20170711105224.717ffaa3@dhcp-192-215.str.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cb092091-68ae-119e-378c-1fb9484a3e49@redhat.com>
Date: Tue, 11 Jul 2017 15:30:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170711105224.717ffaa3@dhcp-192-215.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/10] pc-bios/s390-ccw: Add core files
 for the network bootloading program
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 11.07.2017 10:52, Cornelia Huck wrote:
> On Mon, 10 Jul 2017 17:32:38 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> This is just a preparation for the next steps: Add a makefile and a
>> stripped down copy of pc-bios/s390-ccw/main.c as a basis for the network
>> bootloader program, linked against the libc from SLOF already (which we
>> will need for SLOF's libnet). The networking code is not included yet.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  pc-bios/s390-ccw/Makefile    |  11 +++-
>>  pc-bios/s390-ccw/netboot.mak |  41 +++++++++++++
>>  pc-bios/s390-ccw/netmain.c   | 140 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 190 insertions(+), 2 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/netboot.mak
>>  create mode 100644 pc-bios/s390-ccw/netmain.c
>>
> 
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> new file mode 100644
>> index 0000000..fcdd7a1
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -0,0 +1,140 @@
>> +/*
>> + * S390 virtio-ccw network boot loading program
>> + *
>> + * Copyright 2017 Thomas Huth, Red Hat Inc.
>> + *
>> + * Based on the S390 virtio-ccw loading program (main.c)
>> + * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
>> + *
>> + * This code is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; either version 2 of the License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +#include <stdint.h>
>> +#include <stdbool.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <time.h>
>> +
>> +#include "s390-ccw.h"
>> +#include "virtio.h"
>> +
>> +extern char _start[];
>> +
>> +char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SIZE)));
>> +IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
>> +
>> +static SubChannelId blk_schid = { .one = 1 };
> 
> Call that net_schid instead? ;)

Yes, makes sense.

>> +static uint64_t dest_timer;
>> +
>> +static uint64_t get_timer_ms(void)
>> +{
>> +    uint64_t clk;
>> +
>> +    asm volatile(" stck %0 " : : "Q"(clk) : "memory");
>> +
>> +    /* Bit 51 is incrememented each microsecond */
>> +    return (clk >> (63 - 51)) / 1000;
>> +}
>> +
>> +void set_timer(int val)
>> +{
>> +    dest_timer = get_timer_ms() + val;
>> +}
>> +
>> +int get_timer(void)
>> +{
>> +    return dest_timer - get_timer_ms();
>> +}
>> +
>> +int get_sec_ticks(void)
>> +{
>> +    return 1000;    /* number of ticks in 1 second */
>> +}
>> +
>> +void panic(const char *string)
>> +{
>> +    sclp_print(string);
>> +    for (;;) {
>> +        disabled_wait();
>> +    }
>> +}
>> +
>> +static bool find_dev(Schib *schib, int dev_no)
>> +{
>> +    int i, r;
>> +
>> +    for (i = 0; i < 0x10000; i++) {
>> +        blk_schid.sch_no = i;
>> +        r = stsch_err(blk_schid, schib);
>> +        if (r == 3 || r == -EIO) {
>> +            break;
>> +        }
>> +        if (!schib->pmcw.dnv) {
>> +            continue;
>> +        }
>> +        if (!virtio_is_supported(blk_schid)) {
>> +            continue;
>> +        }
>> +        /* Skip net devices since no IPLB is created and therefore no
>> +         * no network bootloader has been loaded
>> +         */
>> +        if (virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
>> +            continue;
> 
> Don't you explicitly want to find net devices here? Confused.

Copy-n-paste left-over. It worked by accident since dev_no was not
negative in my tests, but that piece of code should look different in
netmain.c, of course...

I'll send a v4 ...

 Thomas
