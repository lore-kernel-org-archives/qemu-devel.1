Received: from eggs.gnu.org ([2001:4830:134:3::10]:60994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW3yC-0003Ed-49
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW3yB-000749-8x
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:01:36 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW3yB-00073t-1w
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:01:35 -0400
Received: by mail-wm0-x235.google.com with SMTP id i127so28526331wma.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 10:01:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <438bc671-4d94-9efc-540a-151be39583e2@redhat.com>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
	<438bc671-4d94-9efc-540a-151be39583e2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 18:01:13 +0100
Message-ID: <CAFEAcA_e6mnkTAZZ+9incvBuhTgt7tj3k_WMHhMLrB6X01v-MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/11] Make memory_region_init_ram() and
 friends handle migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 10 July 2017 at 11:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 07/07/2017 16:42, Peter Maydell wrote:
>> This patchset changes the memory region functions
>>  - memory_region_init_ram()
>>  - memory_region_init_rom()
>>  - memory_region_init_rom_device()
>> to all automatically register the backing memory they allocate
>> for migration using vmstate_register_ram(). Renamed functions
>>  - memory_region_init_ram_nomigrate()
>>  - memory_region_init_rom_nomigrate()
>>  - memory_region_init_rom_device_nomigrate()
>> are provided which only do the MR init, for the oddball
>> cases which want to manage migration of the backing memory
>> themselves (and to avoid behavioural changes for callers
>> which weren't managing correctly migration themselves...)
>>
>> The idea is based on discussion from a previous patchset:
>>  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00764.html
>>
>> The series includes a largish coccinelle-scripted patch and a
>> few by-hand conversions which change callsites which previously
>> manually created the region and registered its backing ram in
>> two separate steps to use the new functions.
>>
>> This series does not include any patches to fix bugs like:
>>  * caller forgot to call vmstate_register_ram() so region
>>    is not actually migrated (eg hw/arm/highbank.c)
>>  * caller used vmstate_register_ram_global() even though it is
>>    a device, so you can't create 2 copies of the device (eg sm501)
>> because I wanted to stick to strictly no-behaviour-change
>> for this patch -- we can fix the bugs separately (fixes will
>> tend to imply migration compat breaks so can only be done
>> for some boards.) Most of the remaining callers of the
>> _nomigrate functions are buggy, I think (and a demonstration
>> that our current API does not score well on the "hard to
>> get wrong by accident" scale).
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks. I'm going to apply this directly to master (so then
I can check that nothing has got applied to it since which
uses the old semantics for these functions; nothing in
fact has.)

thanks
-- PMM
