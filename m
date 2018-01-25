Received: from eggs.gnu.org ([2001:4830:134:3::10]:39697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eei3G-0007bH-Lm
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eei3B-00065Q-Qp
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:58:50 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:46263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eei3B-00064y-IR
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:58:45 -0500
Received: by mail-wm0-f51.google.com with SMTP id 143so14751136wma.5
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 05:58:45 -0800 (PST)
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<6408e418-c2b5-61fe-be3d-137ba9fab113@amsat.org>
	<201801232242.31243.pisa@cmp.felk.cvut.cz>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca52867f-08bf-e79f-db63-0698ccd1a106@redhat.com>
Date: Thu, 25 Jan 2018 14:58:41 +0100
MIME-Version: 1.0
In-Reply-To: <201801232242.31243.pisa@cmp.felk.cvut.cz>
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
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Marek Vasut <marex@denx.de>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, qemu-devel@nongnu.org, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 23/01/2018 22:42, Pavel Pisa wrote:
> Do you think QOM based? I would like it to be implemented
> that way but I need some assistance where to look how this
> object kind should be implemented and from which base object
> inherit from. But I prefer to left that for later work.
> 
> I would definitely like to use some mechanism which allows
> to get rid of externally visible pointer and need to assign
> it in the stub. It has been my initial idea and your review
> sumbled across this hack as well. But I need suggestion what
> is the preferred way for QEMU.

The best way would be a QOM object.  That is, you would do

   -object can-bus,id=canbus0
   -object can-host-socketcan,id=can0-host,canbus=canbus0,if=can0
   -device kvaser_pci,canbus=canbus0

In the current version, it's not clear to me:

* what it means if multiple controllers have the same canbus

* what it means if multiple controllers with the same canbus have
different host interfaces

Separating the QOM objects is a bit more work, but it makes the
semantics clearer.  The classes would be:

- can-bus and an abstract class can-host, which would inherit directly
from TYPE_OBJECT and implement TYPE_USER_CREATABLE

- can-host-socketcan, which would inherit from can-host (and take the
TYPE_USER_CREATABLE implementation from there)

while CanBusClientState and CanBusClientInfo need not be QOMified.

can-host's class structure would define a function pointer corresponding
to what you have now for the function pointer, more or less---except
that allocation is handled by QOM and the method only has to do the
connection.  You would have something like this:

static void can_host_disconnect(CANHost *ch, Error **errp)
{
    CANHostClass *chc = CAN_HOST_GET_CLASS(ch);

    chc->disconnect(ch);
}

static void can_host_connect(CANHost *ch, Error **errp)
{
    CANHostClass *chc = CAN_HOST_GET_CLASS(ch);
    Error *local_err = NULL;

    chc->connect(ch, &local_err);
    if (local_err) {
        error_propagate(errp, local_err);
        return;
    }

    can_bus_insert_client(ch->bus, &ch->bus_client, local_err);
    if (local_err) {
        can_host_disconnect(ch);
        error_propagate(errp, local_err);
        return;
    }
}

and TYPE_USER_CREATABLE's "complete" method would simply invoke
can_host_connect.  For can-host-socketcan, chc->connect would be
assigned something like this:

static void can_host_socketcan_connect(CANHost *ch, Error **errp)
{
    CANHostSocketCAN *chs = CAN_HOST_SOCKETCAN(ch);

    s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
    if (s < 0) {
        error_setg_errno(errp, errno "CAN_RAW socket create failed");
        return;
    }

    addr.can_family = AF_CAN;
    memset(&ifr.ifr_name, 0, sizeof(ifr.ifr_name));
    strcpy(ifr.ifr_name, chs->host_dev_name);
    if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
        error_setg_errno(errp, "host interface %s not available",
                         chs->host_dev_name);
        goto fail;
    }
    addr.can_ifindex = ifr.ifr_ifindex;
    ....
}

In particular, note the difference in error reporting with
error_report/exit vs. error_setg/error_propagate.  Any call to "exit" is
probably grounds for instant rejection of your patch. :)  This also
means that you have to check for leaks in the failure paths, such as
forgetting to close the PF_CAN socket.

Thanks,

Paolo

> When Linux specific object file is linked in then some local
> function needs to be called before QOM instances population.
> I know how to do that GCC specific/non-portable way
> 
> static void __attribute__((constructor)) can_socketcan_setup_variant(void)
> {
> 
> }
> 
> but I expect that something like
> 
> module_init()
> 
> in can_socketcan.c should be used.
> 
> Problem is that there is not module_init
> type for plain function in include/qemu/module.h
> 
>     MODULE_INIT_BLOCK,
>     MODULE_INIT_OPTS,
>     MODULE_INIT_QOM,
>     MODULE_INIT_TRACE,
>     MODULE_INIT_MAX
> 
> I expect that QOM object would solve that in future
> but I would be happy to left it simple for now.
> 
> What is preferred solution there?
> 
>> I'd still avoid using directly the socket() syscall and use the QEMU
>> socket API instead (also suggested by Daniel).
> 
> I have already switched to qemu_socket(), implementation
> looks fine and I have tested that it works.
> I have tested functionality and updated can-pci branch.
> 
>> I have been thinking a bit about how to test some frame operations
>> (rather than the PCI devices) and the Linux vcan driver might be a good
>> option (Virtual Local CAN Interface). This is also useful to test this
>> series without having CAN hardware. How to use vcan might be worth his
>> own paragraph in docs/can.txt.
>>
>> Do you think some of your tests can be added in the QEMU test suite
>> (qtests)?
> 
> I have added some more infomation into docs file
> 
> + The CAN interface of the host system has to be configured for proper
> + bitrate and set up. Configuration is not propagated from emulated
> + devices through bus to the physical host device. Example configuration
> + for 1 Mbit/s
> +
> +   ip link set can0 type can bitrate 1000000
> +   ip link set can0 up
> +
> + Virtual (host local only) can interface can be used on the host
> + side instead of physical interface
> +
> +   ip link add dev can0 type vcan
> +
> + The CAN interface on the host side can be used to analyze CAN
> + traffic with "candump" command which is included in "can-utils".
> +
> +   candump can0
> 
> As for the automatic testing, iproute2 tools are required
> on host and guest side (considering use of Linux)
> and kernel with CAN drivers support.
> Root access is required on the host side to setup CAN
> interface. Some simple tool is required. It can be based
> on can-utils code or our older canping code for example.
> 
> Best wishes,
> 
> Pavel
> 
