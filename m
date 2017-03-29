Received: from eggs.gnu.org ([2001:4830:134:3::10]:60959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctD4u-0002Yh-7F
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 08:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctD4q-0005pB-Al
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 08:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ctD4q-0005or-4j
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 08:51:52 -0400
Date: Wed, 29 Mar 2017 15:51:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170329154539-mutt-send-email-mst@kernel.org>
References: <58D17AF0.2010802@arm.com> <20170321193933.GB31111@cbox>
	<58DA3F68.6090901@arm.com> <20170328112328.GA31156@cbox>
	<20170328115413.GJ23682@e104320-lin>
	<b1c6e747-2fa7-b7a1-60d5-4a9c480b9dc9@huawei.com>
	<58DA67BA.8070404@arm.com>
	<5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
	<20170329103658.GQ23682@e104320-lin>
	<2a427164-9b37-6711-3a56-906634ba7f12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a427164-9b37-6711-3a56-906634ba7f12@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] kvm: pass the virtual SEI syndrome to
 guest OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Achin Gupta <achin.gupta@arm.com>, gengdongjiu <gengdongjiu@huawei.com>, ard.biesheuvel@linaro.org, edk2-devel@lists.01.org, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, James Morse <james.morse@arm.com>, Christoffer Dall <cdall@linaro.org>, xiexiuqi@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, suzuki.poulose@arm.com, andre.przywara@arm.com, mark.rutland@arm.com, vladimir.murzin@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, Leif.Lindholm@linaro.comnd@arm.com, Igor Mammedov <imammedo@redhat.com>

On Wed, Mar 29, 2017 at 01:58:29PM +0200, Laszlo Ersek wrote:
> (8) When QEMU gets SIGBUS from the kernel -- I hope that's going to come
> through a signalfd -- QEMU can format the CPER right into guest memory,
> and then inject whatever interrupt (or assert whatever GPIO line) is
> necessary for notifying the guest.

I think I see a race condition potential - what if guest accesses
CPER in guest memory while it's being written?

We can probably use another level of indirection to fix this:

allocate twice the space, add a pointer to where the valid
table is located and update that after writing CPER completely.
The pointer can be written atomically but also needs to
be read atomically, so I suspect it should be a single byte
as we don't know how are OSPMs implementing this.

-- 
MST
