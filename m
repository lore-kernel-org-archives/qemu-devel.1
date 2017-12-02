Received: from eggs.gnu.org ([2001:4830:134:3::10]:48086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1eKzF5-00065t-2H
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 23:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1eKzF0-00088k-4W
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 23:17:31 -0500
Received: from [45.249.212.32] (port=58123 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
	id 1eKzEz-00084y-ON
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 23:17:26 -0500
References: <D1BD20B5DB34024DA951CEEE6C4C5998B1B8CC82@DGGEMA501-MBX.china.huawei.com>
	<33183CC9F5247A488A2544077AF19020DA4ADB8C@DGGEMA505-MBS.china.huawei.com>
	<d4d9a0a9-b136-7320-d1e1-36a4c3cffccc@redhat.com>
	<etPan.5a219554.1a0113f4.4983@localhost>
	<425502fd-5f04-88a1-4f2a-d9ac3a3c0580@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <5A221E36.3050900@huawei.com>
Date: Sat, 2 Dec 2017 11:29:58 +0800
MIME-Version: 1.0
In-Reply-To: <425502fd-5f04-88a1-4f2a-d9ac3a3c0580@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBbQlVHXSBXaW5kb3dzIDcgZ290IHN0?=
 =?utf-8?q?uck_easily_while_run_PCMark10_application?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-devel <qemu-devel@nongnu.org>, "Michael S.
	Tsirkin" <mst@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>

On 2017/12/2 2:37, Paolo Bonzini wrote:
> On 01/12/2017 18:45, Gonglei (Arei) wrote:
>> I also think it's windows bug, the problem is that it doesn't occur on
>> xen platform.
> It's a race, it may just be that RTC PIO is faster in Xen because it's
> implemented in the hypervisor.

No, In Xen, it does not has such problem because it injects the RTC irq w=
ithout
checking whether its previous irq been cleared or not, which we do has su=
ch checking
in KVM.

static int ioapic_set_irq(struct kvm_ioapic *ioapic, unsigned int irq,
         int irq_level, bool line_status)
{
    ... ...
     if (!irq_level) {
         ioapic->irr &=3D ~mask; -->clear the RTC irq in irr, Or we will =
can not inject RTC irq.
         ret =3D 1;
         goto out;
     }

I agree that we move the operation of clearing RTC irq from cmos_ioport_r=
ead() to
cmos_ioport_write() to ensure the action been done.

Thanks,
Hailiang

> I will try reporting it to Microsoft.
>
> Thanks,
>
> Paolo
>
>> Thanks,
>> Gonglei
>> *=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A*Paolo Bonzini
>> *=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A*=E9=BE=9A=E7=A3=8A,=E5=BC=A0=E6=B5=
=B7=E4=BA=AE,qemu-devel,Michael S. Tsirkin
>> *=E6=8A=84=E9=80=81=EF=BC=9A*=E9=BB=84=E4=BC=9F=E6=A0=8B,=E7=8E=8B=E6=AC=
=A3,=E8=B0=A2=E7=A5=A5=E6=9C=89
>> *=E6=97=B6=E9=97=B4=EF=BC=9A*2017-12-02 01:10:08
>> *=E4=B8=BB=E9=A2=98:*Re: [BUG] Windows 7 got stuck easily while run PC=
Mark10 application
>>
>> On 01/12/2017 08:08, Gonglei (Arei) wrote:
>>> First write to 0x70, cmos_index =3D 0xc & 0x7f =3D 0xc
>>>         CPU 0/KVM-15566 kvm_pio: pio_write at 0x70 size 1 count 1 val=
 0xc> Second write to 0x70, cmos_index =3D 0x86 & 0x7f =3D 0x6>        CP=
U 1/KVM-15567 kvm_pio: pio_write at 0x70 size 1 count 1 val 0x86> vcpu0 r=
ead 0x6 because cmos_index is 0x6 now:>        CPU 0/KVM-15566 kvm_pio: p=
io_read at 0x71 size 1 count 1 val 0x6> vcpu1
>> read 0x6:>        CPU 1/KVM-15567 kvm_pio: pio_read at 0x71 size 1 cou=
nt
>> 1 val 0x6
>> This seems to be a Windows bug.  The easiest workaround that I
>> can think of is to clear the interrupts already when 0xc is written,
>> without waiting for the read (because REG_C can only be read).
>>
>> What do you think?
>>
>> Thanks,
>>
>> Paolo
>
> .
>
