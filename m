Received: from eggs.gnu.org ([2001:4830:134:3::10]:35637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc@brightwise.de>) id 1cpLgw-0007ZQ-2D
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 17:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc@brightwise.de>) id 1cpLgs-0006DF-Sp
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 17:15:14 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::7]:17182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marc@brightwise.de>) id 1cpLgs-0006Ar-GV
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 17:15:10 -0400
Received: from oxapp01-01.back.ox.d0m.de (com4.strato.de [81.169.145.237])
	by smtp-ox.front (RZmta 40.1 AUTH) with ESMTPSA id x0bc30t2ILF7DC9
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (curve X9_62_prime256v1
	with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate) for <qemu-devel@nongnu.org>;
	Sat, 18 Mar 2017 22:15:07 +0100 (CET)
Date: Sat, 18 Mar 2017 22:15:07 +0100 (CET)
From: Marc Bommert <marc@brightwise.de>
Message-ID: <741795585.70221.1489871707491@communicator.strato.de>
In-Reply-To: <5909E3D6-85D8-4B21-9442-CCD312A4717B@inbox.ru>
References: <5909E3D6-85D8-4B21-9442-CCD312A4717B@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Strange behaviour in network device initialization.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello development,

I ran into some behaviour I don't understand and which may be a qemu problem but which may also be my fault, since I haven't investigated much on QOM so far.
I am currently writing a NIC sysbus device based on the structure of hw/net/smc91c111.c

qemu is invoked as:

  $ qemu-system-arm -M mymachine -m 8 -kernel kernel.elf -nographic -net nic,id=myid -netdev tap,ifname=tap0,id=myid,script=no,downscript=no -device mydevice,netdev=myid


The initialization structure is a little special here. A "legacy helper" initialization function is called from the board module mymachine.c:

   for(n = 0; n < nb_nics; n++) {
        nd = &nd_table[n];
        
        if (!nd->model || strcmp(nd->model, "mydevice") == 0) {
            mydevice_init(nd, MYDEVICE_BASE, pic[17]);
            break;
        } else {
        /* We don't know this NIC model */
        }
    }
    
The init function is provided by the device module mydevice.c:

    /* Legacy helper function.  Should go away when machine config files are implemented.  */
    void mydevice_init(NICInfo *nd, uint32_t base, qemu_irq irq)
    {
        DeviceState *dev;
        SysBusDevice *s;
    
        qemu_check_nic_model(nd, "mydevice");
        dev = qdev_create(NULL, TYPE_MYDEVICE);
        s = SYS_BUS_DEVICE(dev);
        mydevice_state *state = MY_DEVICE(dev);
        
        qdev_set_nic_properties(dev, nd);
        qdev_init_nofail(dev);
        sysbus_mmio_map(s, 0, base);
        sysbus_connect_irq(s, 0, irq);
    }
    
and the actual class/instance initializers are:

    static int mydevice_init1(Object *obj)
    {
        DeviceState *dev = DEVICE(obj);
        mydevice_state *s = MY_DEVICE(dev);
        SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
        
        memory_region_init_io(&s->mmio, OBJECT(s), &mydevice_mem_ops, s,
                            "mydevice-mmio", 0x40000);
        sysbus_init_mmio(sbd, &s->mmio);
        sysbus_init_irq(sbd, &s->irq);
        
        qemu_macaddr_default_if_unset(&s->conf.macaddr);
        s->nic = qemu_new_nic(&net_mydevice_info, &s->conf,
                            object_get_typename(OBJECT(dev)), dev->id, s);
        qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
        mydevice_reset(s);
        return 0;
    }

    static void mydevice_class_init(ObjectClass *klass, void *data)
    {
        DeviceClass *dc = DEVICE_CLASS(klass);
        SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);

        k->init = mydevice_init1;
        dc->reset = mydevice_reset;
        dc->vmsd = &vmstate_mydevice;
        dc->props = mydevice_properties;
    }

    static const TypeInfo mydevice_info = {
        .name          = TYPE_MYDEVICE,
        .parent        = TYPE_SYS_BUS_DEVICE,
        .instance_size = sizeof(mydevice_state),
        .class_init    = mydevice_class_init,
    };
    
    
Now, the actual problem is that mydevice_init1() is called twice and the device state is also instantiated twice. Thus, s->irq is initialized twice, but only the first one gets connected. During runtime, the second state instance is passed with a NULL s->irq in the device state to the memops. The IRQ never fires.

Here are the stack traces of the both initialization calls:

#0  mydevice_init1 (obj=0x5555573bb010) at /home/brightwise/qemu-2.8.0/hw/mymachine/mydevice.c:700
#1  0x0000555555a020f5 in sysbus_device_init (dev=0x5555573bb010) at hw/core/sysbus.c:211
#2  0x00005555559fae58 in device_realize (dev=0x5555573bb010, errp=0x7fffffffdbd0) at hw/core/qdev.c:213
#3  0x00005555559fc96f in device_set_realized (obj=0x5555573bb010, value=true, errp=0x7fffffffdd70) at hw/core/qdev.c:918
#4  0x0000555555bd733c in property_set_bool (obj=0x5555573bb010, v=0x5555573bdb20, name=0x5555560bd162 "realized", opaque=0x55555738eca0, errp=0x7fffffffdd70) at qom/object.c:1854
#5  0x0000555555bd5847 in object_property_set (obj=0x5555573bb010, v=0x5555573bdb20, name=0x5555560bd162 "realized", errp=0x7fffffffdd70) at qom/object.c:1088
#6  0x0000555555bd866f in object_property_set_qobject (obj=0x5555573bb010, value=0x5555573bda90, name=0x5555560bd162 "realized", errp=0x7fffffffdd70) at qom/qom-qobject.c:27
#7  0x0000555555bd5aea in object_property_set_bool (obj=0x5555573bbst ask on the mailing list for someone else to do it on your behalf (self-creation is prohibited to cut down on spam accounts).
Start with reading the QEMU wiki.
Contribute to the QEMU wiki by adding new topics or im010, value=true, name=0x5555560bd162 "realized", errp=0x7fffffffdd70) at qom/object.c:1157
#8  0x00005555559fb423 in qdev_init_nofail (dev=0x5555573bb010) at hw/core/qdev.c:358
#9  0x000055555585705e in mydevice_init (nd=0x555556b40280 <nd_table>, base=1310720, irq=0x555557334550) at /home/brightwise/qemu-2.8.0/hw/mymachine/mydevice.c:776
#10 0x000055555585459a in mymachine_init (machine=0x555557038dc0, board_id=256) at /home/brightwise/qemu-2.8.0/hw/mymachine/mymachine.c:341
#11 0x00005555558546ad in _machine_init (machine=0x555557038dc0) at /home/brightwise/qemu-2.8.0/hw/mymachine/mymachine.c:377
#12 0x000055555596ec3d in main (argc=14, argv=0x7fffffffe358, envp=0x7fffffffe3d0) at vl.c:4548

and 

#0  mydevice_init1 (obj=0x5555573eaea0) at /home/brightwise/qemu-2.8.0/hw/mymachine/mydevice.c:700
#1  0x0000555555a020f5 in sysbus_device_init (dev=0x5555573eaea0) at hw/core/sysbus.c:211
#2  0x00005555559fae58 in device_realize (dev=0x5555573eaea0, errp=0x7fffffffdcf0) at hw/core/qdev.c:213
#3  0x00005555559fc96f in device_set_realized (obj=0x5555573eaea0, value=true, errp=0x7fffffffdea0) at hw/core/qdev.c:918
#4  0x0000555555bd733c in property_set_bool (obj=0x5555573eaea0, v=0x5555573eda40, name=0x55555607cce6 "realized", opaque=0x5555573bef50, errp=0x7fffffffdea0) at qom/object.c:1854
#5  0x0000555555bd5847 in object_property_set (obj=0x5555573eaea0, v=0x5555573eda40, name=0x55555607cce6 "realized", errp=0x7fffffffdea0) at qom/object.c:1088
#6  0x0000555555bd866f in object_property_set_qobject (obj=0x5555573eaea0, value=0x5555573ed930, name=0x55555607cce6 "realized", errp=0x7fffffffdea0) at qom/qom-qobject.c:27
#7  0x0000555555bd5aea in object_property_set_bool (obj=0x5555573eaea0, value=true, name=0x55555607cce6 "realized", errp=0x7fffffffdea0) at qom/object.c:1157
#8  0x0000555555957364 in qdev_device_add (opts=0x555556fdbc90, errp=0x7fffffffdf18) at qdev-monitor.c:623
#9  0x0000555555969a13 in device_init_func (opaque=0x0, opts=0x555556fdbc90, errp=0x0) at vl.c:2373
#10 0x0000555555cc801b in qemu_opts_foreach (list=0x55555659e120 <qemu_device_opts>, func=0x5555559699d5 <device_init_func>, opaque=0x0, errp=0x0) at util/qemu-option.c:1116
#11 0x000055555596ecf0 in main (argc=14, argv=0x7fffffffe358, envp=0x7fffffffe3d0) at vl.c:4574


Any help on this is greatly appreciated. Questions are:

- Is this a specific problem of the network device smc91c111.c (and maybe others, too) in the first place and I've cloned that issue when copying the structure of that device module? I haven't tested smc91c111.c. Should I? I guess this stuff is widely used and should work?

- If not, what is the problem here? I would guess it is related to the "realized" property which is not set with the first initialization and eventually, the device is initialized a second time.

Sorry, if this turn out the be a noobish question. I've got it running in a hacked version, but I wanted to figure out what the exact problem is. Any ideas?

TIA
Marc
