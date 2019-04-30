Received: from eggs.gnu.org ([209.51.188.92]:60059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLbsv-00070S-T2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLbsu-0006sv-V3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:10:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hLbsu-0006sE-Fg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:10:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8449F81DF0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 23:09:58 +0000 (UTC)
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
	<daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
	<20190429082106.4fd59e77@x1.home> <20190430170149.6c82398a@x1.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9de36ff8-78ec-8cb0-6c23-4c8ecc1efad9@redhat.com>
Date: Wed, 1 May 2019 01:09:48 +0200
MIME-Version: 1.0
In-Reply-To: <20190430170149.6c82398a@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] q35: set split kernel irqchip as
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 01/05/19 01:01, Alex Williamson wrote:
> Poking at this a bit, we can add kvm_irqchip_is_split() to the set of
> things we test for in hw/vfio/pci.c:vfio_intx_enable_kvm() to avoid the
> KVM INTx bypass when using split IRQ chip.

Yes, this should be enough.

> The only way I can get the GPU/Windows configuration usable is to
> assert the IRQ, immediately de-assert, and unmask the device all from
> vfio_intx_interrupt().  An interrupt intensive graphics benchmark runs
> at ~80% of KVM irqchip with about 10% more CPU load with this
> experiment (but it actually runs!).

Nice.  If you can do it directly from hw/vfio there may be no need to do
more changes to the IOAPIC, and least not immediately.  But that is not
a good emulation of INTX, isn't it?  IIUC, it relies on the
level-triggered interrupt never being masked in the IOAPIC.

> Any other insights appreciated, and I really would like to understand
> what we've gained with split irqchip and whether it's worth this.

We've gained guest interrupt remapping support, we are not relying on
newer kernel versions, and the attack surface from the guest to the
hypervisor is smaller.

Paolo
