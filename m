Received: from eggs.gnu.org ([2001:4830:134:3::10]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNEL-0006by-WF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNEI-0006zS-Tx
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:45:34 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:55773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNEI-0006zB-Ms
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:45:30 -0500
Received: by mail-wm0-f51.google.com with SMTP id 143so2237376wma.5
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 02:45:30 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-9-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b5586d3-649d-272c-c63d-b0ae2bdb466d@redhat.com>
Date: Wed, 7 Feb 2018 11:45:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-9-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/34] hyperv: qom-ify SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 06/02/2018 21:30, Roman Kagan wrote:
> +static SynICState *get_synic(X86CPU *cpu)
> +{
> +    SynICState *synic =
> +        SYNIC(object_resolve_path_component(OBJECT(cpu), "synic"));
> +    assert(synic);
> +    return synic;
> +}
> +

This is somewhat slow, maybe add the pointer to X86CPU?

> +void hyperv_synic_add(X86CPU *cpu)
> +{
> +    Object *obj;
> +
> +    obj = object_new(TYPE_SYNIC);
> +    object_property_add_child(OBJECT(cpu), "synic", obj, &error_abort);
> +    object_unref(obj);
> +    object_property_set_bool(obj, true, "realized", &error_abort);
> +}
> +
> +void hyperv_synic_reset(X86CPU *cpu)
> +{
> +    device_reset(DEVICE(get_synic(cpu)));
> +}
> +
> +void hyperv_synic_update(X86CPU *cpu)
> +{
> +    synic_update(get_synic(cpu));
> +}
> +

Maybe rename to x86_cpu_hyperv_{add,get,reset,update}_synic?

Thanks,

Paolo
