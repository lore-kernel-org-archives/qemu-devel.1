Received: from eggs.gnu.org ([2001:4830:134:3::10]:55275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeSnN-0000iK-Ry
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 16:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeSnJ-00025X-Tl
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 16:41:25 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeSnJ-000258-NT
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 16:41:21 -0500
Received: by mail-qt0-x244.google.com with SMTP id i1so14256011qtj.8
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 13:41:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<6408e418-c2b5-61fe-be3d-137ba9fab113@amsat.org>
	<201801232242.31243.pisa@cmp.felk.cvut.cz>
	<201801242122.31033.pisa@cmp.felk.cvut.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <abe89c1b-b6fa-3021-fad1-469d2eb2060a@amsat.org>
Date: Wed, 24 Jan 2018 18:41:16 -0300
MIME-Version: 1.0
In-Reply-To: <201801242122.31033.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 0/7] CAN bus support for QEMU (SJA1000
 PCI so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

Hi Pavel,

On 01/24/2018 05:22 PM, Pavel Pisa wrote:
> Hello everybody,
> 
> On Tuesday 23 of January 2018 22:42:31 Pavel Pisa wrote:
>> When Linux specific object file is linked in then some local
>> function needs to be called before QOM instances population.
>> I know how to do that GCC specific/non-portable way
>>
>> static void __attribute__((constructor)) can_socketcan_setup_variant(void)
>> {
>>
>> }
>>
>> but I expect that something like
>>
>> module_init()
>>
>> in can_socketcan.c should be used.
> 
> 
> I have experimented with code changes to get rid of stub for
> non Linux systems. type_init() is used because it is more
> portable than constructor attribute.
> 
> I have seen that a few other type_init-s do more
> than simple sequence of type_register_static().
> Is it acceptable to use type_init for registration
> to CAN core by function call for now? Conversion simplifies
> makefiles and unnecessary stub file is removed.
> 
> But I would use attribute if that solution is preferred because
> it is allways present on Linux where SocketCAN is used anyway
> and it is used in other Qemu subsystems as well.

using stubs/monitor.c as a template for stubs/can_host_variant.c doesn't
work?

> 
> ----------------------------------------------------------------
> Solution with attribute
> 
> #ifdef TOOLCHAIN_SUPPORTS_ATTRIBUTE_CONSTRUCTOR
> static void __attribute__((constructor))
> can_bus_socketcan_setup(void)
> {
>     can_bus_set_connect_to_host(can_bus_connect_to_host_socketcan);
> }
> #endif
> 
> ----------------------------------------------------------------
> Solution with type_init
> branch https://gitlab.fel.cvut.cz/canbus/qemu-canbus/tree/can-pci-socketcan-init
> 
> diff --git a/hw/can/can_socketcan.c b/hw/can/can_socketcan.c
> index 42099fb696..fb41853c2b 100644
> --- a/hw/can/can_socketcan.c
> +++ b/hw/can/can_socketcan.c
> @@ -309,5 +309,14 @@ static int can_bus_connect_to_host_socketcan(CanBusState *bus,
>      return 0;
>  }
>  
> -int (*can_bus_connect_to_host_variant)(CanBusState *bus, const char *name) =
> -        can_bus_connect_to_host_socketcan;
> +static void can_bus_socketcan_type_init(void)
> +{
> +    /*
> +     * There should be object registration when CanBusSocketcanConnectState
> +     * is converted into QOM object. Use for registration of host
> +     * can bus access for now.
> +     */
> +    can_bus_set_connect_to_host(can_bus_connect_to_host_socketcan);
> +}
> +
> +type_init(can_bus_socketcan_type_init);
> 
> 
> diff --git a/hw/can/Makefile.objs b/hw/can/Makefile.objs
> index 1ce9950de0..14c2369718 100644
> --- a/hw/can/Makefile.objs
> +++ b/hw/can/Makefile.objs
> @@ -2,11 +2,7 @@
>  
>  ifeq ($(CONFIG_CAN_BUS),y)
>  common-obj-y += can_core.o
> -ifeq ($(CONFIG_LINUX),y)
> -common-obj-y += can_socketcan.o
> -else
> -common-obj-y += can_host_stub.o
> -endif
> +common-obj-$(CONFIG_LINUX) += can_socketcan.o
>  common-obj-$(CONFIG_CAN_SJA1000) += can_sja1000.o
>  common-obj-$(CONFIG_CAN_PCI) += can_kvaser_pci.o
>  common-obj-$(CONFIG_CAN_PCI) += can_pcm3680_pci.o
> diff --git a/hw/can/can_core.c b/hw/can/can_core.c
> index 41c458c792..c14807b188 100644
> --- a/hw/can/can_core.c
> +++ b/hw/can/can_core.c
> @@ -34,6 +34,8 @@
>  static QTAILQ_HEAD(, CanBusState) can_buses =
>      QTAILQ_HEAD_INITIALIZER(can_buses);
>  
> +static can_bus_connect_to_host_t can_bus_connect_to_host_fnc;
> +
>  CanBusState *can_bus_find_by_name(const char *name, bool create_missing)
>  {
>      CanBusState *bus;
> @@ -127,10 +129,15 @@ int can_bus_client_set_filters(CanBusClientState *client,
>  
>  int can_bus_connect_to_host_device(CanBusState *bus, const char *name)
>  {
> -    if (can_bus_connect_to_host_variant == NULL) {
> +    if (can_bus_connect_to_host_fnc == NULL) {
>          error_report("CAN bus connect to host device is not "
>                       "supported on this system");
>          exit(1);
>      }
> -    return can_bus_connect_to_host_variant(bus, name);
> +    return can_bus_connect_to_host_fnc(bus, name);
> +}
> +
> +void can_bus_set_connect_to_host(can_bus_connect_to_host_t connect_fnc)
> +{
> +    can_bus_connect_to_host_fnc = connect_fnc;
>  }
> diff --git a/hw/can/can_host_stub.c b/hw/can/can_host_stub.c
> deleted file mode 100644
> index 748d25f995..0000000000
> --- a/hw/can/can_host_stub.c
> +++ /dev/null
> @@ -1,36 +0,0 @@
> ....
> ....
> ....
> -
> -
> -int (*can_bus_connect_to_host_variant)(CanBusState *bus, const char *name) =
> -        NULL;
> 
> diff --git a/include/can/can_emu.h b/include/can/can_emu.h
> index 85237ee3c9..7f0705e49f 100644
> --- a/include/can/can_emu.h
> +++ b/include/can/can_emu.h
> @@ -107,8 +107,9 @@ struct CanBusState {
>      QTAILQ_ENTRY(CanBusState) next;
>  };
>  
> -extern int (*can_bus_connect_to_host_variant)(CanBusState *bus,
> -                                              const char *name);
> +typedef int (*can_bus_connect_to_host_t)(CanBusState *bus, const char *name);
> +
> +void can_bus_set_connect_to_host(can_bus_connect_to_host_t connect_fnc);
>  
>  int can_bus_filter_match(struct qemu_can_filter *filter, qemu_canid_t can_id);
> ----------------------------------------------------------------
> 
> Best wishes,
> 
> Pavel
> 
