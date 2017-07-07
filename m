Received: from eggs.gnu.org ([2001:4830:134:3::10]:42338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTQvN-0000Dv-7V
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTQvK-0006nw-6V
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:55:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dTQvJ-0006ne-Ks
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:55:46 -0400
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
	<CAFEAcA-VGRYZ7+Osa8J1Ew+P=wf42uOtVvmV9mmGBTwC-f++8w@mail.gmail.com>
	<6861810e-0546-d1e4-4573-7cdb18696c03@redhat.com>
	<CAFEAcA9pWLRnLVez5syRVrQLRmcEdO5o8mApTfyzZr-Szu3LjQ@mail.gmail.com>
	<CAFEAcA-gKqHaW+abQ3YRVPt7Mb=mthx2+5AhQ4Ewth6sB2g23A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1bc8544-8a3e-aaa9-2a8f-8a169a10d8ca@redhat.com>
Date: Fri, 7 Jul 2017 12:55:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-gKqHaW+abQ3YRVPt7Mb=mthx2+5AhQ4Ewth6sB2g23A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>



On 07/07/2017 12:43, Peter Maydell wrote:
> On 6 July 2017 at 18:47, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>> On 6 July 2017 at 18:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> Maybe, for memory_region_init_ram only, the owner argument can be mad=
e a
>>> DeviceState (or NULL)?
>>
>> Something that might influence things here -- of the twelve
>> callers of vmstate_register_ram(), only 6 use an 'owner'
>> pointer that's the same as the one they use for initializing
>> the memory region (and 3 of those are using _init_rom or
>> _init_rom_device rather than init_ram directly).
>=20
> Conversely there are 14 or so places that init a RAM MR
> with a non-NULL owner but then use vmstate_register_ram_global
> rather than vmstate_register_ram, and so which would be
> stuck using the old _nomigrate() function if we make it
> use the owner pointer.

I think whenever feasible we should pay the price of breaking migration.
 I found these:

- aspeed_soc_realize

- integratorcm_init

- onenand_initfn (nseries)

- cg3_initfn (one init_ram in there is not using owner, might be changed
as well)

- sm501_init

- tcx_initfn

- milkymist_softusb_init

- milkymist_minimac2_init

- raven_realize

- idreg_init1

- afx_init1

- prom_init1 (two functions with the same name in two files)

- ram_realize

- lx60_net_init

The only problematic one for backwards compatibility is rom_set_mr.

> I guess we should think about the long term and design
> the API to encourage the behaviour we want for new code,
> rather than to catch as much of possible of existing
> usage, though?

Yes, though that leaves the possibility of people copying from the wrong
code, so if we can break migration compatibility that would be better in
the long term.

Paolo
