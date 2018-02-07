Received: from eggs.gnu.org ([2001:4830:134:3::10]:34230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNRQ-0008Tq-Pi
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNRN-00079r-PO
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:59:04 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:51663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNRN-00079Z-Iu
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:59:01 -0500
Received: by mail-wm0-f54.google.com with SMTP id r71so2353369wmd.1
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 02:59:01 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-13-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac191902-8f59-8064-f5cf-39bf79f4d035@redhat.com>
Date: Wed, 7 Feb 2018 11:58:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-13-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 12/34] hyperv: add synic event flag
 signaling
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
> +/*
> + * Set given event flag for a given sint on a given vcpu, and signal the sint.
> + */
> +int hyperv_set_evt_flag(HvSintRoute *sint_route, unsigned evtno)

Any reason (e.g. something from the spec) not to spell "event" and
"eventno" in full?

Thanks,

Paolo


> +{
> +    int ret;
> +    SynICState *synic = sint_route->synic;
> +    unsigned long *flags, set_mask;
> +    unsigned set_idx;
> +
> +    if (evtno > HV_EVENT_FLAGS_COUNT) {
> +        return -EINVAL;
> +    }
> +    if (!synic->enabled || !synic->evt_page_addr) {
