Received: from eggs.gnu.org ([2001:4830:134:3::10]:50600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKr5l-0005Do-4L
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKr5g-0001TI-90
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:03:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKr5g-0001T6-3O
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:03:00 -0400
Date: Tue, 13 Jun 2017 16:02:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170613190256.GA5016@thinpad.lan.raisama.net>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-12-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606181948.16238-12-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 11/23] hyperv: address HvSintRoute by
 X86CPU pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Tue, Jun 06, 2017 at 09:19:36PM +0300, Roman Kagan wrote:
> Use X86CPU pointer to refer to the respective HvSintRoute instead of
> vp_index.  This is more convenient and also paves the way for future
> enhancements.
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
[...]
> @@ -101,16 +101,18 @@ static void hv_test_dev_control(void *opaque, hwaddr addr, uint64_t data,
>      uint8_t sint = data & 0xFF;
>      uint8_t vcpu_id = (data >> 8ULL) & 0xFF;

vcpu_id risks being confused KVM's vcpu_id (which is the CPU APIC
ID in x86).  If you are already touching this code, this could be
renamed to vp_index to avoid confusion.

>      uint8_t ctl = (data >> 16ULL) & 0xFF;
> +    X86CPU *cpu = hyperv_find_vcpu(vcpu_id);
> +    assert(cpu);
>  
>      switch (ctl) {
>      case HV_TEST_DEV_SINT_ROUTE_CREATE:
> -        sint_route_create(dev, vcpu_id, sint);
> +        sint_route_create(dev, cpu, sint);
>          break;
>      case HV_TEST_DEV_SINT_ROUTE_DESTROY:
> -        sint_route_destroy(dev, vcpu_id, sint);
> +        sint_route_destroy(dev, cpu, sint);
>          break;
>      case HV_TEST_DEV_SINT_ROUTE_SET_SINT:
> -        sint_route_set_sint(dev, vcpu_id, sint);
> +        sint_route_set_sint(dev, cpu, sint);
>          break;
>      default:
>          break;

-- 
Eduardo
