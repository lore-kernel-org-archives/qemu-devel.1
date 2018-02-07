Received: from eggs.gnu.org ([2001:4830:134:3::10]:38272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejUbk-00045W-PE
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejUbf-00086e-5w
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:38:12 -0500
Received: from mail-db5eur01hn0307.outbound.protection.outlook.com
	([2a01:111:f400:fe02::307]:45926
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejUbe-00084l-GX
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:38:07 -0500
Date: Wed, 7 Feb 2018 21:37:51 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207183751.GA18247@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-9-rkagan@virtuozzo.com>
	<5b5586d3-649d-272c-c63d-b0ae2bdb466d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5586d3-649d-272c-c63d-b0ae2bdb466d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 08/34] hyperv: qom-ify SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On Wed, Feb 07, 2018 at 11:45:28AM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
> > +static SynICState *get_synic(X86CPU *cpu)
> > +{
> > +    SynICState *synic =
> > +        SYNIC(object_resolve_path_component(OBJECT(cpu), "synic"));
> > +    assert(synic);
> > +    return synic;
> > +}
> > +
> 
> This is somewhat slow, maybe add the pointer to X86CPU?

It is, but it's only used on slow paths.  I was reluctant to clutter
X86CPU with this stuff.

> > +void hyperv_synic_add(X86CPU *cpu)
> > +{
> > +    Object *obj;
> > +
> > +    obj = object_new(TYPE_SYNIC);
> > +    object_property_add_child(OBJECT(cpu), "synic", obj, &error_abort);
> > +    object_unref(obj);
> > +    object_property_set_bool(obj, true, "realized", &error_abort);
> > +}
> > +
> > +void hyperv_synic_reset(X86CPU *cpu)
> > +{
> > +    device_reset(DEVICE(get_synic(cpu)));
> > +}
> > +
> > +void hyperv_synic_update(X86CPU *cpu)
> > +{
> > +    synic_update(get_synic(cpu));
> > +}
> > +
> 
> Maybe rename to x86_cpu_hyperv_{add,get,reset,update}_synic?

I don't mind, can do.

Thanks,
Roman.
