Received: from eggs.gnu.org ([2001:4830:134:3::10]:38590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7MJk-00035y-FR
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7MJe-0005sE-Bn
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:06:00 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:49217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7MJe-0005rR-7i
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:05:54 -0400
Received: by mail-qk0-x242.google.com with SMTP id q83so130464qke.6
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 07:05:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171020082538.17124-1-pbonzini@redhat.com>
	<20171025105235.GI1885@perard.uk.xensource.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <76610a16-d6a8-c20c-8e1b-97cb02c1eb34@amsat.org>
Date: Wed, 25 Oct 2017 11:05:01 -0300
MIME-Version: 1.0
In-Reply-To: <20171025105235.GI1885@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pci-assign: Remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org

> On Fri, Oct 20, 2017 at 10:25:38AM +0200, Paolo Bonzini wrote:
>> Legacy PCI device assignment has been removed from Linux in 4.12,
>> and had been deprecated 2 years ago there.  We can remove it from
>> QEMU as well.
>>
>> The ROM loading code was shared with Xen PCI passthrough, so move
>> it to hw/xen.
>>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: xen-devel@lists.xenproject.org
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>         Xen parts only compile-tested.
>>
>>  docs/qdev-device-use.txt                           |   12 +-
>>  hw/i386/Makefile.objs                              |    1 -
>>  hw/i386/kvm/Makefile.objs                          |    2 +-
>>  hw/i386/kvm/pci-assign.c                           | 1883 --------------------

nice cleanup <3

>>  hw/xen/Makefile.objs                               |    1 +
>>  .../xen_pt_load_rom.c}                             |    4 +-
>>  include/hw/pci/pci-assign.h                        |   27 -
>>  qdev-monitor.c                                     |    1 -
>>  scripts/device-crash-test                          |    2 -
>>  9 files changed, 6 insertions(+), 1927 deletions(-)
>>  delete mode 100644 hw/i386/kvm/pci-assign.c
>>  rename hw/{i386/pci-assign-load-rom.c => xen/xen_pt_load_rom.c} (96%)
>>  delete mode 100644 include/hw/pci/pci-assign.h
>>
>> diff --git a/hw/i386/pci-assign-load-rom.c b/hw/xen/xen_pt_load_rom.c
>> similarity index 96%
>> rename from hw/i386/pci-assign-load-rom.c
>> rename to hw/xen/xen_pt_load_rom.c
>> index 43429b66be..2bc3b6c092 100644
>> --- a/hw/i386/pci-assign-load-rom.c
>> +++ b/hw/xen/xen_pt_load_rom.c
>> @@ -12,7 +12,7 @@
>>  #include "qemu/range.h"
>>  #include "sysemu/sysemu.h"
>>  #include "hw/pci/pci.h"
>> -#include "hw/pci/pci-assign.h"
>> +#include "xen_pt.h"
>>  
>>  /*
>>   * Scan the assigned devices for the devices that have an option ROM, and then
>> @@ -80,7 +80,7 @@ close_rom:
>>      fseek(fp, 0, SEEK_SET);
>>      val = 0;
>>      if (!fwrite(&val, 1, 1, fp)) {
>> -        DEBUG("%s\n", "Failed to disable pci-sysfs rom file");
>> +        XEN_PT_WARN("%s\n", "Failed to disable pci-sysfs rom file");
> 
> XEN_PT_WARN takes an extra argument, it should read:
> XEN_PT_WARN(dev, "%s\n", "Failed to disable pci-sysfs rom file");
> 
> With that fixed:
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
