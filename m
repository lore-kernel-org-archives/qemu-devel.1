Received: from eggs.gnu.org ([2001:4830:134:3::10]:34971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dFY4e-00009Z-2u
	for qemu-devel@nongnu.org; Mon, 29 May 2017 23:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhlcindy@gmail.com>) id 1dFY4b-0001GZ-0N
	for qemu-devel@nongnu.org; Mon, 29 May 2017 23:44:00 -0400
References: <1495790468-23862-1-git-send-email-zhlcindy@gmail.com>
	<20170526132114.6edc006e@nial.brq.redhat.com>
	<CAD8of+pw5Nh4oSkTuYX4fbJvA8=-CTmn6dgdXHPLERAcQM+Oyw@mail.gmail.com>
	<20170529124339.43eea1c5@nial.brq.redhat.com>
In-Reply-To: <20170529124339.43eea1c5@nial.brq.redhat.com>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=gb2312
Message-Id: <1B0ED5FF-7254-41AD-B53F-B7EE201C2A15@gmail.com>
From: Li Zhang <zhlcindy@gmail.com>
Date: Tue, 30 May 2017 11:43:54 +0800
Subject: Re: [Qemu-devel] [PATCH 0/3] arm/virt: refine virt.c code and
 implement hot_add_cpu interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Li Zhang <li.zhang@hxt-semitech.com>



> =D4=DA 2017=C4=EA5=D4=C229=C8=D5=A3=AC=CF=C2=CE=E76:43=A3=ACIgor Mammedov <=
imammedo@redhat.com> =D0=B4=B5=C0=A3=BA
>=20
> On Sat, 27 May 2017 10:32:33 +0800
> Li Zhang <zhlcindy@gmail.com> wrote:
>=20
>>> On Fri, May 26, 2017 at 7:21 PM, Igor Mammedov <imammedo@redhat.com> wro=
te:
>>> On Fri, 26 May 2017 17:21:05 +0800
>>> Li Zhang <zhlcindy@gmail.com> wrote:
>>>=20
>>>> From: Li Zhang <li.zhang@hxt-semitech.com>
>>>>=20
>>>> virt machine doesn't support hot_add_cpu interface. This patchset is to=
 implement
>>>> hot_add_cpu interface. A CPU can be added by QMP command with QEMU moni=
tor.
>>>>=20
>>>> Here is command to add a CPU with QMP command.
>>>>=20
>>>> * qemu-system-aarch64 -machine virt -cpu cortex-a15 -smp 1,maxcpus=3D4 \=

>>>>    -monitor telnet:127.0.0.1:4444,server,nowait -nographic
>>>> * connect monitor:      telnet 127.0.0.1 4444
>>>> * execute qmp command:  cpu-add 1 =20
>>> cpu-add command shouldn't be used for new cpu hotplug,
>>> pls use generic device_add for that. =20
>>=20
>> Ok,  I will drop this command and look at device_add.
>>=20
>>>=20
>>> The last time I looked at it, virt machine needed quite a bit of
>>> re-factoring of the way it creates/wires up CPUs. =20
>>=20
>> Yes, I am looking into it and see if I can do something:)
>>=20
>>>=20
>>> Pls see usage of following callbacks for example on how to implement
>>> device_add based cpu hotplug:
>>>=20
>>>  get_hotplug_handler
>>>  pc_cpu_pre_plug
>>>  pc_cpu_plug
>>>  pc_possible_cpu_arch_ids
>>>=20
>>> and pc_cpus_init() for initial cpu creation with above callbacks in use
>>>=20
>> Thanks, I will see it. :)
>>=20
>>>>=20
>>>> Currently, when KVM is enabled and add a CPU with QMP command, QEMU
>>>> reports error "kvm_init_vcpu failed: Device or resourc busy". KVM can't=

>>>> create a new CPU when vgic has been initialized and irqchip_in_kernel i=
n
>>>> function kvm_arch_vcpu_create. It needs to change KVM code in the futur=
e. =20
>>> if KVM isn't capable do it yet, then qemu should refuse cpu hotplug if r=
unning
>>> with KVM accelarator and allow it only in TCG mode. =20
>>=20
>> OK, I will add an assertion to allow hotplug only in TCG mode.
> instead of assert which will crash guest on hotplug,
> just disable hotplug gracefully (for example set error in pre_plug handler=
)

OK, got it.

>=20
>>=20
>>>=20
>>>>=20
>>>> Li Zhang (3):
>>>>  arm/virt: Refine fdt_add_cpu_nodes code
>>>>  arm/virt: Refine code of machvirt_init
>>>>  arm/virt: Implement hot_add_cpu interface
>>>>=20
>>>> hw/arm/virt.c | 344 ++++++++++++++++++++++++++++++++++-----------------=
-------
>>>> 1 file changed, 202 insertions(+), 142 deletions(-)
>>>>=20
>>>=20
>>=20
>>=20
>>=20
>=20
