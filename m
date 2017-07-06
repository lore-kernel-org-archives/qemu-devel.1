Received: from eggs.gnu.org ([2001:4830:134:3::10]:49936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTALI-0001RU-1a
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTALH-0007gO-4e
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:13:28 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dTALG-0007fm-Ss
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:13:27 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 77so11494792wrb.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 10:13:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2017 18:13:05 +0100
Message-ID: <CAFEAcA-VGRYZ7+Osa8J1Ew+P=wf42uOtVvmV9mmGBTwC-f++8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] Add new utility function
 memory_region_allocate_aux_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 5 July 2017 at 13:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 04/07/2017 19:02, Peter Maydell wrote:
>> Many board models and several devices need to create auxiliary
>> regions of RAM (in addition to the main lump of 'system' memory),
>> to model static RAMs, video memory, ROMs, etc. Currently they do
>> this with a sequence like:
>>        memory_region_init_ram(sram, NULL, "sram", 0x10000, &error_fatal);
>>        vmstate_register_ram_global(sram);
>
> Instead of vmstate_register_ram_global, you should use
>
>     vmstate_register_ram(mr, owner);
>
> You should even do it for all memory regions, probably.

Slightly awkward because owner is an Object but vmstate_register_ram()
needs a DeviceState. Is this OK, or too much magic?

    DeviceState *owner_dev;
    Error *err = NULL;

    memory_region_init_ram(mr, owner, name, ram_size, &err);
    if (err) {
        error_propagate(errp, err);
        return;
    }
    /* Note that owner_dev may be NULL if owner is not a DeviceState;
     * in that case this is equivalent to calling vmstate_register_ram_global().
     */
    owner_dev = object_dynamic_cast(owner, TYPE_DEVICE);
    vmstate_register_ram(mr, owner_dev);

thanks
-- PMM
