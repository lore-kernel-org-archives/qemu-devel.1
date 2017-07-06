Received: from eggs.gnu.org ([2001:4830:134:3::10]:37496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTAsB-0000ZU-9p
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTAsA-0006eX-LS
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:47:27 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dTAsA-0006dV-D7
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:47:26 -0400
Received: by mail-wr0-x235.google.com with SMTP id k67so12669310wrc.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 10:47:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6861810e-0546-d1e4-4573-7cdb18696c03@redhat.com>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
	<CAFEAcA-VGRYZ7+Osa8J1Ew+P=wf42uOtVvmV9mmGBTwC-f++8w@mail.gmail.com>
	<6861810e-0546-d1e4-4573-7cdb18696c03@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2017 18:47:04 +0100
Message-ID: <CAFEAcA9pWLRnLVez5syRVrQLRmcEdO5o8mApTfyzZr-Szu3LjQ@mail.gmail.com>
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

On 6 July 2017 at 18:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 06/07/2017 19:13, Peter Maydell wrote:
>> Slightly awkward because owner is an Object but vmstate_register_ram()
>> needs a DeviceState. Is this OK, or too much magic?
>>
>>     DeviceState *owner_dev;
>>     Error *err = NULL;
>>
>>     memory_region_init_ram(mr, owner, name, ram_size, &err);
>>     if (err) {
>>         error_propagate(errp, err);
>>         return;
>>     }
>>     /* Note that owner_dev may be NULL if owner is not a DeviceState;
>>      * in that case this is equivalent to calling vmstate_register_ram_global().
>>      */
>>     owner_dev = object_dynamic_cast(owner, TYPE_DEVICE);
>>     vmstate_register_ram(mr, owner_dev);
>
> Maybe, for memory_region_init_ram only, the owner argument can be made a
> DeviceState (or NULL)?

Something that might influence things here -- of the twelve
callers of vmstate_register_ram(), only 6 use an 'owner'
pointer that's the same as the one they use for initializing
the memory region (and 3 of those are using _init_rom or
_init_rom_device rather than init_ram directly).

thanks
-- PMM
