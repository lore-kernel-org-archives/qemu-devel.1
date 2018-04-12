Received: from eggs.gnu.org ([2001:4830:134:3::10]:32982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6ceB-0000cF-Sg
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6ceA-0004ld-Ry
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:52:19 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:35883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6ceA-0004lP-KQ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:52:18 -0400
Received: by mail-ot0-x22d.google.com with SMTP id n40-v6so6061671otd.3
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 06:52:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3432d654-c562-505e-e341-afe9d8fdf6cb@kaod.org>
References: <20180412101858.21304-1-clg@kaod.org>
	<CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
	<20180412115326.GF2704@work-vm>
	<CAFEAcA9-LzsfBpnYJUVc7j6j4ePUyiQYqGv3EaGjvAgw-3nyKw@mail.gmail.com>
	<3432d654-c562-505e-e341-afe9d8fdf6cb@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 14:51:57 +0100
Message-ID: <CAFEAcA9G_ZwrZ1HkuvUPzOHadYbq7fKu819K=kFieMccDwt1AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: discard RAMBlocks of type
 ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 12 April 2018 at 14:41, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 04/12/2018 02:08 PM, Peter Maydell wrote:
>> On 12 April 2018 at 12:53, Dr. David Alan Gilbert <dgilbert@redhat.com> =
wrote:
>>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>>> David suggested on IRC that we would want a flag on the ramblock
>>>> for "not migratable", because there are other uses for "don't
>>>> migrate this" than just "is this a ram device".
>>>
>>> My original suggestion to your series was with a flag, but I'd forgotte=
n
>>> about that by the time I'd made the suggestion to C=C3=A9dric.
>>> In your case would just adding an extra term to the
>>> ram_block_is_migratable function work, or do you really need a flag?
>>
>> I don't see how else you would identify the ram block that needs
>> to be skipped. Also I think it's just better design to decouple
>> the decision about "should we migrate this ram block" from the
>> migration code itself, and push it up to the code layer that knows
>> it's creating ram blocks that shouldn't be migrated.
>
> Do you mean adding a new RAMBlock flag RAM_NON_MIGRATABLE
> in exec.c ? That would require to add an extra bool to the
> following functions :
>
>         memory_region_init_ram_ptr()
>         qemu_ram_alloc_from_ptr()
>         qemu_ram_alloc_internal()
>
> Would that be ok ?

Paolo may have an opinion what the API here should be, but
at the MemoryRegion level we already have a mix of functions
memory_region_init_foo_nomigrate() and memory_region_init_foo(),
which at the moment just control whether we call
vmstate_register_ram() or not. Is it possible to hook into that,
so that we default to marking RAMBlocks as not-migrated, and
when vmstate_register_ram() is called we set the flag to
"migrated"?

NB: this probably requires careful thought to make sure we
don't accidentally break migration compat, but it seems like
the cleaner approach. At the moment we do weird things if you
migrate a RAM block that hasn't had its ID string set, IIRC,
so just not migrating those RAM blocks seems like a better
plan than mishandling them. It would also mean that the
vmstate_register/unregister_ram() functions did what they
claim to do based on the function name, I think.

thanks
-- PMM
