Received: from eggs.gnu.org ([2001:4830:134:3::10]:52520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dufac-0000M3-61
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dufaV-0000Ep-U3
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:02:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dufaV-0000E3-Kw
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:02:51 -0400
References: <1503013010-11500-1-git-send-email-zuban32s@gmail.com>
	<1503013010-11500-2-git-send-email-zuban32s@gmail.com>
	<20170919203449.GG21016@localhost.localdomain>
	<436365c9-43fc-95be-9bb2-7974f12e84df@redhat.com>
	<CAKSfGUAS8EfYF179pjQ=svmAL2x-VR_iMTh=cZZjQmz77mO8fQ@mail.gmail.com>
	<20170920135719.GM3030@localhost.localdomain>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <e2835ffc-44fa-dff6-ed62-7b295beaa7ab@redhat.com>
Date: Wed, 20 Sep 2017 17:02:44 +0300
MIME-Version: 1.0
In-Reply-To: <20170920135719.GM3030@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 1/4] hw/pci: introduce pcie-pci-bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: lersek@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, seabios@seabios.org

On 20/09/2017 16:57, Eduardo Habkost wrote:
> On Wed, Sep 20, 2017 at 09:52:01AM +0000, Aleksandr Bezzubikov wrote:
>> =D1=81=D1=80, 20 =D1=81=D0=B5=D0=BD=D1=82. 2017 =D0=B3. =D0=B2 10:13, =
Marcel Apfelbaum <marcel@redhat.com>:
>>
>>> On 19/09/2017 23:34, Eduardo Habkost wrote:
>>>> On Fri, Aug 18, 2017 at 02:36:47AM +0300, Aleksandr Bezzubikov wrote=
:
>>>>> Introduce a new PCIExpress-to-PCI Bridge device,
>>>>> which is a hot-pluggable PCI Express device and
>>>>> supports devices hot-plug with SHPC.
>>>>>
>>>>> This device is intended to replace the DMI-to-PCI Bridge.
>>>>>
>>>>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>>>>> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>>>>
>>>> It's possible to crash QEMU by instantiating this device, with;
>>>>
>>>>     $ qemu-system-ppc64 -machine prep -device pcie-pci-bridge
>>>>     qemu-system-ppc64: qemu/memory.c:1533: memory_region_finalize:
>>> Assertion `!mr->container' failed.
>>>>     Aborted
>>>
>>> Hi Edurado,
>>>
>>>>
>>>> I didn't investigate the root cause.
>>>>
>>>
>>> Thanks for reporting it!
>>> Aleksandr, can you have a look? Maybe we should not compile
>>> the device for ppc arch. (x86 and arm is enough)
>>
>>
>> I will see what can we do. Is x86 and arm really enough?
>=20
> I would investigate the original cause before disabling the device on o=
ther
> architectures, as we could be hiding a bug that's also present in x86.

Agreed, it worth finding out the reason. But the restriction
still makes sense.


Thanks,
Marcel

   The
> backtrace looks like broken error handling logic somewhere:
>=20
> #0  0x00007fffea9ff1f7 in __GI_raise (sig=3Dsig@entry=3D6) at ../nptl/s=
ysdeps/unix/sysv/linux/raise.c:56
> #1  0x00007fffeaa008e8 in __GI_abort () at abort.c:90
> #2  0x00007fffea9f8266 in __assert_fail_base (fmt=3D0x7fffeab4ae68 "%s%=
s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=3Dassertion@entry=3D0x=
555555be4ac1 "!mr->container", file=3Dfile@entry=3D0x555555be49c4 "/root/=
qemu/memory.c", line=3Dline@entry=3D1533, function=3Dfunction@entry=3D0x5=
55555be5100 <__PRETTY_FUNCTION__.28908> "memory_region_finalize") at asse=
rt.c:92
> #3  0x00007fffea9f8312 in __GI___assert_fail (assertion=3Dassertion@ent=
ry=3D0x555555be4ac1 "!mr->container", file=3Dfile@entry=3D0x555555be49c4 =
"/root/qemu/memory.c", line=3Dline@entry=3D1533, function=3Dfunction@entr=
y=3D0x555555be5100 <__PRETTY_FUNCTION__.28908> "memory_region_finalize") =
at assert.c:101
> #4  0x00005555557ff2df in memory_region_finalize (obj=3D<optimized out>=
) at /root/qemu/memory.c:1533
> #5  0x0000555555ae77a2 in object_unref (type=3D<optimized out>, obj=3D0=
x555557c00d80) at /root/qemu/qom/object.c:453
> #6  0x0000555555ae77a2 in object_unref (data=3D0x555557c00d80) at /root=
/qemu/qom/object.c:467
> #7  0x0000555555ae77a2 in object_unref (obj=3D0x555557c00d80) at /root/=
qemu/qom/object.c:902
> #8  0x0000555555ae67d7 in object_property_del_child (obj=3D0x555557ab65=
00, child=3Dchild@entry=3D0x555557c00d80, errp=3D0x0) at /root/qemu/qom/o=
bject.c:427
> #9  0x0000555555ae6ff4 in object_unparent (obj=3Dobj@entry=3D0x555557c0=
0d80) at /root/qemu/qom/object.c:446
> #10 0x0000555555a1c94e in shpc_free (d=3Dd@entry=3D0x555557ab6500) at /=
root/qemu/hw/pci/shpc.c:676
> #11 0x0000555555a12560 in pcie_pci_bridge_realize (d=3D0x555557ab6500, =
errp=3D0x7fffffffd530) at /root/qemu/hw/pci-bridge/pcie_pci_bridge.c:84
> #12 0x0000555555a18d07 in pci_qdev_realize (qdev=3D0x555557ab6500, errp=
=3D0x7fffffffd5d0) at /root/qemu/hw/pci/pci.c:2024
> #13 0x00005555559b53aa in device_set_realized (obj=3D<optimized out>, v=
alue=3D<optimized out>, errp=3D0x7fffffffd708) at /root/qemu/hw/core/qdev=
.c:914
> #14 0x0000555555ae62fe in property_set_bool (obj=3D0x555557ab6500, v=3D=
<optimized out>, name=3D<optimized out>, opaque=3D0x555557ab7b30, errp=3D=
0x7fffffffd708) at /root/qemu/qom/object.c:1886
> #15 0x0000555555aea3ef in object_property_set_qobject (obj=3Dobj@entry=3D=
0x555557ab6500, value=3Dvalue@entry=3D0x555557ab86b0, name=3Dname@entry=3D=
0x555555c4f217 "realized", errp=3Derrp@entry=3D0x7fffffffd708) at /root/q=
emu/qom/qom-qobject.c:27
> #16 0x0000555555ae80a0 in object_property_set_bool (obj=3D0x555557ab650=
0, value=3D<optimized out>, name=3D0x555555c4f217 "realized", errp=3D0x7f=
ffffffd708) at /root/qemu/qom/object.c:1162
> #17 0x0000555555949824 in qdev_device_add (opts=3D0x5555567795b0, errp=3D=
errp@entry=3D0x7fffffffd7e0) at /root/qemu/qdev-monitor.c:630
> #18 0x000055555594be87 in device_init_func (opaque=3D<optimized out>, o=
pts=3D<optimized out>, errp=3D<optimized out>) at /root/qemu/vl.c:2418
> #19 0x0000555555bc85ba in qemu_opts_foreach (list=3D<optimized out>, fu=
nc=3Dfunc@entry=3D0x55555594be60 <device_init_func>, opaque=3Dopaque@entr=
y=3D0x0, errp=3Derrp@entry=3D0x0) at /root/qemu/util/qemu-option.c:1104
> #20 0x000055555579f497 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at /root/qemu/vl.c:4745
> (gdb) fr 11
> #11 0x0000555555a12560 in pcie_pci_bridge_realize (d=3D0x555557ab6500, =
errp=3D0x7fffffffd530) at /root/qemu/hw/pci-bridge/pcie_pci_bridge.c:84
> 84          shpc_free(d);
> (gdb) l
> 79          pcie_aer_exit(d);
> 80      aer_error:
> 81      pm_error:
> 82          pcie_cap_exit(d);
> 83      cap_error:
> 84          shpc_free(d);
> 85      error:
> 86          pci_bridge_exitfn(d);
> 87      }
> 88
> (gdb)
>=20
>=20
