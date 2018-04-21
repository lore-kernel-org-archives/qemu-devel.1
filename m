Received: from eggs.gnu.org ([2001:4830:134:3::10]:40515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9otn-0004T0-Vs
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9otn-0000rw-6S
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:33:40 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:36347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9otn-0000rV-1U
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:33:39 -0400
Received: by mail-oi0-x233.google.com with SMTP id h11-v6so10141878oic.3
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 02:33:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <550f552e-059c-f611-11d5-4793c733babd@kaod.org>
References: <20180413075200.15217-1-clg@kaod.org>
	<CAFEAcA9SKjBV-eKcSbNXPZexWnLMGT0n-xxOphfo47o1d7hxFA@mail.gmail.com>
	<550f552e-059c-f611-11d5-4793c733babd@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Apr 2018 10:33:17 +0100
Message-ID: <CAFEAcA9XzT=xbCi5M_ooyOqy809PkZmbaQouYdMN6nbp6j3ZOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paolo Bonzini <pbonzini@redhat.com>

On 21 April 2018 at 09:52, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 04/20/2018 02:09 PM, Peter Maydell wrote:
>> Notes:
>>  * any device that registers a ramblock globally is a bit dodgy, because
>> it means you can't have more than one of it (the ramblock names would
>> clash). We should fix those devices for the cases where we're willing
>> to take the migration compat break.
>
> There are quite a few models calling memory_region_init_ram() with
> a NULL owner, see below. Should we fix all these ?

Note that I said "any device". A board model that uses a NULL
owner (or does a register_global) is fine, because by definition
there is only one board. (The "null owner" case is really intended
for this -- traditionally there was no useful owner object available
to board code, though these days MachineState is an object
so it could be used.) Most of the examples you cite are in
board code and are fine. Where they are in devices we should
indeed consider making them pass in the device pointer as
the owner, though.

thanks
-- PMM
