Received: from eggs.gnu.org ([209.51.188.92]:39462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQnI-0005Jb-3n
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKQnH-0007e9-9D
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:07:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKQnH-0007cg-3O
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:07:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so7842035wmf.5
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 10:07:19 -0700 (PDT)
References: <20190427141905.20393-1-philmd@redhat.com>
	<2f8710be-0005-a8dc-ac28-c572e55f2d20@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6a887505-c8f1-8bdf-fd6a-ec87a60841c2@redhat.com>
Date: Sat, 27 Apr 2019 19:07:16 +0200
MIME-Version: 1.0
In-Reply-To: <2f8710be-0005-a8dc-ac28-c572e55f2d20@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386: The i440fx is not a machine,
 remove it from the machine list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 4/27/19 4:49 PM, Thomas Huth wrote:
> On 27/04/2019 16.19, Philippe Mathieu-Daudé wrote:
>> When building with CONFIG_ISAPC=n and CONFIG_I440FX=y we get:
>>
>>   $ make subdir-x86_64-softmmu
>>   [...]
>>   /usr/bin/ld: hw/i386/pc_piix.o: in function `pc_init1':
>>   /source/qemu/hw/i386/pc_piix.c:261: undefined reference to `isa_ide_init'
>>   /usr/bin/ld: /source/qemu/hw/i386/pc_piix.c:261: undefined reference to `isa_ide_init'
>>   collect2: error: ld returned 1 exit status
>>   make[1]: *** [Makefile:204: qemu-system-x86_64] Error 1
>>
>> This is because the I440FX device is a North Bridge, not a machine.
> 
> Really? I thought CONFIG_I440FX was there to configure the
> "pc-i440fx-x.y" machine types?

Ah, I just found in hw/i386/pc_piix.c:

    if (pcmc->pci_enabled) {
        pci_bus = i440fx_init(host_type,
                              pci_type,
                              &i440fx_state, &piix3_devfn,
                              &isa_bus, pcms->gsi,
                              system_memory, system_io,
                              machine->ram_size,
                              pcms->below_4g_mem_size,
                              pcms->above_4g_mem_size,
                              pci_memory, ram_memory);
        pcms->bus = pci_bus;
    } else {
        pci_bus = NULL;
        i440fx_state = NULL;
        isa_bus = isa_bus_new(NULL, get_system_memory(), system_io,
                              &error_abort);
        no_hpet = 1;
    }

So I guess I'll have to figure it out from here ;)

Thanks,

Phil.
