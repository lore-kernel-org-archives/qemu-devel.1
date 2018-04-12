Received: from eggs.gnu.org ([2001:4830:134:3::10]:47174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6cx1-00030K-B3
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6cwx-0000Tk-9O
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:11:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f6cwx-0000TV-4X
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:11:43 -0400
References: <20180412101858.21304-1-clg@kaod.org>
	<CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
	<20180412115326.GF2704@work-vm>
	<CAFEAcA9-LzsfBpnYJUVc7j6j4ePUyiQYqGv3EaGjvAgw-3nyKw@mail.gmail.com>
	<3432d654-c562-505e-e341-afe9d8fdf6cb@kaod.org>
	<CAFEAcA9G_ZwrZ1HkuvUPzOHadYbq7fKu819K=kFieMccDwt1AQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a2a27461-c792-9204-849d-9c7c0ffbd0c6@redhat.com>
Date: Thu, 12 Apr 2018 16:11:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9G_ZwrZ1HkuvUPzOHadYbq7fKu819K=kFieMccDwt1AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Eric Blake <eblake@redhat.com>

On 12/04/2018 15:51, Peter Maydell wrote:
> Paolo may have an opinion what the API here should be, but
> at the MemoryRegion level we already have a mix of functions
> memory_region_init_foo_nomigrate() and memory_region_init_foo(),
> which at the moment just control whether we call
> vmstate_register_ram() or not. Is it possible to hook into that,
> so that we default to marking RAMBlocks as not-migrated, and
> when vmstate_register_ram() is called we set the flag to
> "migrated"?

Yes, that sounds pretty.

Paolo

> NB: this probably requires careful thought to make sure we
> don't accidentally break migration compat, but it seems like
> the cleaner approach. At the moment we do weird things if you
> migrate a RAM block that hasn't had its ID string set, IIRC,
> so just not migrating those RAM blocks seems like a better
> plan than mishandling them. It would also mean that the
> vmstate_register/unregister_ram() functions did what they
> claim to do based on the function name, I think.
