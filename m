Received: from eggs.gnu.org ([209.51.188.92]:58320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glgDJ-00015h-HB
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glgDI-0006n1-Ol
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:30:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glgDH-0006k2-BQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:30:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so24825346wrt.13
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:30:30 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <679001ca-1217-5ffd-d9bc-54bff58ca3bc@redhat.com>
Date: Mon, 21 Jan 2019 21:30:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/23] armv7m: Make cpu object a child of
 the armv7m container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 1/21/19 7:50 PM, Peter Maydell wrote:
> Rather than just creating the CPUs with object_new, make them child
> objects of the armv7m container. This will allow the cluster code to
> find the CPUs if an armv7m object is made a child of a cluster object.
> object_new_with_props() will do the parenting for us.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/armv7m.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index f9aa83d20ef..0f2c8e066cf 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -158,7 +158,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>  
>      memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
>  
> -    s->cpu = ARM_CPU(object_new(s->cpu_type));
> +    s->cpu = ARM_CPU(object_new_with_props(s->cpu_type, OBJECT(s), "cpu",
> +                                           &err, NULL));
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>  
>      object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
>                               &error_abort);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
