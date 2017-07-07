Received: from eggs.gnu.org ([2001:4830:134:3::10]:40661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTQjQ-0005Kh-SG
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTQjQ-0001DI-1s
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:43:28 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dTQjP-0001Bp-PK
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:43:27 -0400
Received: by mail-wr0-x22a.google.com with SMTP id k67so41008189wrc.2
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 03:43:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pWLRnLVez5syRVrQLRmcEdO5o8mApTfyzZr-Szu3LjQ@mail.gmail.com>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
	<CAFEAcA-VGRYZ7+Osa8J1Ew+P=wf42uOtVvmV9mmGBTwC-f++8w@mail.gmail.com>
	<6861810e-0546-d1e4-4573-7cdb18696c03@redhat.com>
	<CAFEAcA9pWLRnLVez5syRVrQLRmcEdO5o8mApTfyzZr-Szu3LjQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jul 2017 11:43:05 +0100
Message-ID: <CAFEAcA-gKqHaW+abQ3YRVPt7Mb=mthx2+5AhQ4Ewth6sB2g23A@mail.gmail.com>
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

On 6 July 2017 at 18:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 6 July 2017 at 18:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Maybe, for memory_region_init_ram only, the owner argument can be made a
>> DeviceState (or NULL)?
>
> Something that might influence things here -- of the twelve
> callers of vmstate_register_ram(), only 6 use an 'owner'
> pointer that's the same as the one they use for initializing
> the memory region (and 3 of those are using _init_rom or
> _init_rom_device rather than init_ram directly).

Conversely there are 14 or so places that init a RAM MR
with a non-NULL owner but then use vmstate_register_ram_global
rather than vmstate_register_ram, and so which would be
stuck using the old _nomigrate() function if we make it
use the owner pointer.

I guess we should think about the long term and design
the API to encourage the behaviour we want for new code,
rather than to catch as much of possible of existing
usage, though?

thanks
-- PMM
