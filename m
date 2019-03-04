Received: from eggs.gnu.org ([209.51.188.92]:40660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0q3y-0000pK-VN
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0q3x-0003yk-NV
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:03:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0q3x-0003xm-GS
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:03:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so2691539wmj.4
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:03:33 -0800 (PST)
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <016722cd-c7fe-fb49-66d2-e745257877ca@redhat.com>
Date: Mon, 4 Mar 2019 17:03:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190225183757.27378-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] sysbus: Fix latent bug with
 onboard devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 2/25/19 7:37 PM, Markus Armbruster wrote:
> The first call of sysbus_get_default() creates the main system bus and
> stores it in QOM as "/machine/unattached/sysbus".  This must not
> happen before main() creates "/machine", or else container_get() would
> "helpfully" create it as "container" object, and the real creation of
> "/machine" would later abort with "attempt to add duplicate property
> 'machine' to object (type 'container')".  Has been that way ever since
> we wired up busses in QOM (commit f968fc6892d, v1.2.0).
> 
> I believe the bug is latent.  I got it to bite by trying to
> qdev_create() a sysbus device from a machine's .instance_init()
> method.
> 
> The fix is obvious: store the main system bus in QOM right after
> creating "/machine".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/sysbus.c | 3 ---
>  vl.c             | 4 ++++
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 9f9edbcab9..307cf90a51 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -357,9 +357,6 @@ static void main_system_bus_create(void)
>      qbus_create_inplace(main_system_bus, system_bus_info.instance_size,
>                          TYPE_SYSTEM_BUS, NULL, "main-system-bus");
>      OBJECT(main_system_bus)->free = g_free;
> -    object_property_add_child(container_get(qdev_get_machine(),
> -                                            "/unattached"),
> -                              "sysbus", OBJECT(main_system_bus), NULL);
>  }
>  
>  BusState *sysbus_get_default(void)
> diff --git a/vl.c b/vl.c
> index e3fdce410f..6ce3d2d448 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3990,6 +3990,10 @@ int main(int argc, char **argv, char **envp)
>      }
>      object_property_add_child(object_get_root(), "machine",
>                                OBJECT(current_machine), &error_abort);
> +    object_property_add_child(container_get(OBJECT(current_machine),
> +                                            "/unattached"),
> +                              "sysbus", OBJECT(sysbus_get_default()),
> +                              NULL);

If SYSTEM_BUS doesn't exist, sysbus_get_default() creates it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>      if (machine_class->minimum_page_bits) {
>          if (!set_preferred_target_page_bits(machine_class->minimum_page_bits)) {
> 
