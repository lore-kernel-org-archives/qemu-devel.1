Received: from eggs.gnu.org ([2001:4830:134:3::10]:48016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etEWt-0005we-9p
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etEWq-0002RM-Hu
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:29:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1etEWq-0002RB-Bt
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:29:24 -0500
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<48c4af3c240286a89fc5fdbcaa254ea386c979b9.1515960078.git.pisa@cmp.felk.cvut.cz>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a7069bf9-4321-5fa7-69ac-15d88737c5ec@redhat.com>
Date: Tue, 6 Mar 2018 16:29:19 +0100
MIME-Version: 1.0
In-Reply-To: <48c4af3c240286a89fc5fdbcaa254ea386c979b9.1515960078.git.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 4/7] CAN bus Kvaser PCI CAN-S (single
 SJA1000 channel) emulation added.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pisa@cmp.felk.cvut.cz, qemu-devel@nongnu.org
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>

On 14.01.2018 21:14, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  default-configs/pci.mak |   1 +
>  hw/can/Makefile.objs    |   1 +
>  hw/can/can_kvaser_pci.c | 375 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 377 insertions(+)
>  create mode 100644 hw/can/can_kvaser_pci.c

 Hi,

the kvaser_pci device introduced a new way to crash QEMU, e.g.:

mips64el-softmmu/qemu-system-mips64el -M malta,accel=qtest \
                                      -device kvaser_pci

Program received signal SIGSEGV, Segmentation fault.
0x0000555555a6e2ec in can_bus_insert_client (bus=0x0, client=client@entry=0x5555570c4018)
    at /home/thuth/devel/qemu/net/can/can_core.c:50
50	    QTAILQ_INSERT_TAIL(&bus->clients, client, next);
(gdb) bt
#0  0x0000555555a6e2ec in can_bus_insert_client (bus=0x0, client=client@entry=0x5555570c4018)
    at /home/thuth/devel/qemu/net/can/can_core.c:50
#1  0x00005555559d7364 in can_sja_connect_to_bus (s=s@entry=0x5555570c3f80, bus=<optimized out>)
    at /home/thuth/devel/qemu/hw/net/can/can_sja1000.c:869
#2  0x00005555559d75a4 in kvaser_pci_realize (pci_dev=0x5555570c33d0, errp=0x7fffffffd8e0)
    at /home/thuth/devel/qemu/hw/net/can/can_kvaser_pci.c:230
#3  0x00005555559e12f1 in pci_qdev_realize (qdev=0x5555570c33d0, errp=0x7fffffffd980)
    at /home/thuth/devel/qemu/hw/pci/pci.c:2029
#4  0x0000555555963c3a in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffdab8)
    at /home/thuth/devel/qemu/hw/core/qdev.c:852
#5  0x0000555555aa7a7e in property_set_bool (obj=0x5555570c33d0, v=<optimized out>, name=<optimized out>, opaque=0x555556f6d220, errp=0x7fffffffdab8) at /home/thuth/devel/qemu/qom/object.c:1906
#6  0x0000555555aabbef in object_property_set_qobject (obj=obj@entry=0x5555570c33d0, value=value@entry=0x5555570c4a60, name=name@entry=0x555555c7079f "realized", errp=errp@entry=0x7fffffffdab8)
    at /home/thuth/devel/qemu/qom/qom-qobject.c:27
#7  0x0000555555aa9860 in object_property_set_bool (obj=0x5555570c33d0, value=<optimized out>, name=0x555555c7079f "realized", errp=0x7fffffffdab8) at /home/thuth/devel/qemu/qom/object.c:1171
#8  0x00005555558eb1d9 in qdev_device_add (opts=0x55555689ff40, errp=errp@entry=0x7fffffffdb90)
    at /home/thuth/devel/qemu/qdev-monitor.c:634
#9  0x00005555558ed547 in device_init_func (opaque=<optimized out>, opts=<optimized out>, errp=<optimized out>)
    at /home/thuth/devel/qemu/vl.c:2350
#10 0x0000555555b8d75a in qemu_opts_foreach (list=<optimized out>, func=func@entry=
    0x5555558ed520 <device_init_func>, opaque=opaque@entry=0x0, errp=errp@entry=0x0)
    at /home/thuth/devel/qemu/util/qemu-option.c:1073
#11 0x00005555557b8f64 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
    at /home/thuth/devel/qemu/vl.c:4618

Could you please fix this?

 Thanks,
  Thomas
