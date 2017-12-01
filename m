Received: from eggs.gnu.org ([2001:4830:134:3::10]:49680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKqC0-0007gw-SZ
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKqBx-0007MZ-Ge
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:37:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eKqBx-0007M2-A9
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:37:41 -0500
References: <D1BD20B5DB34024DA951CEEE6C4C5998B1B8CC82@DGGEMA501-MBX.china.huawei.com>
	<33183CC9F5247A488A2544077AF19020DA4ADB8C@DGGEMA505-MBS.china.huawei.com>
	<d4d9a0a9-b136-7320-d1e1-36a4c3cffccc@redhat.com>
	<etPan.5a219554.1a0113f4.4983@localhost>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <425502fd-5f04-88a1-4f2a-d9ac3a3c0580@redhat.com>
Date: Fri, 1 Dec 2017 19:37:28 +0100
MIME-Version: 1.0
In-Reply-To: <etPan.5a219554.1a0113f4.4983@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>

On 01/12/2017 18:45, Gonglei (Arei) wrote:
> I also think it's windows bug, the problem is that it doesn't occur on
> xen platform.

It's a race, it may just be that RTC PIO is faster in Xen because it's
implemented in the hypervisor.

I will try reporting it to Microsoft.

Thanks,

Paolo

> Thanks,
> Gonglei
> *=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A*Paolo Bonzini
> *=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A*=E9=BE=9A=E7=A3=8A,=E5=BC=A0=E6=B5=
=B7=E4=BA=AE,qemu-devel,Michael S. Tsirkin
> *=E6=8A=84=E9=80=81=EF=BC=9A*=E9=BB=84=E4=BC=9F=E6=A0=8B,=E7=8E=8B=E6=AC=
=A3,=E8=B0=A2=E7=A5=A5=E6=9C=89
> *=E6=97=B6=E9=97=B4=EF=BC=9A*2017-12-02 01:10:08
> *=E4=B8=BB=E9=A2=98:*Re: [BUG] Windows 7 got stuck easily while run PCM=
ark10 application
>=20
> On 01/12/2017 08:08, Gonglei (Arei) wrote:
>> First write to 0x70, cmos_index =3D 0xc & 0x7f =3D 0xc
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU 0/KVM-15566 kvm_pio: pio_writ=
e at 0x70 size 1 count 1 val 0xc> Second write to 0x70, cmos_index =3D 0x=
86 & 0x7f =3D 0x6> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU 1/KVM-15567 k=
vm_pio: pio_write at 0x70 size 1 count 1 val 0x86> vcpu0 read 0x6 because=
 cmos_index is 0x6 now:> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU 0/KVM-1=
5566 kvm_pio: pio_read at 0x71 size 1 count 1 val 0x6> vcpu1
> read 0x6:> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU 1/KVM-15567 kvm_pio=
: pio_read at 0x71 size 1 count
> 1 val 0x6
> This seems to be a Windows bug.=C2=A0 The easiest workaround that I
> can think of is to clear the interrupts already when 0xc is written,
> without waiting for the read (because REG_C can only be read).
>=20
> What do you think?
>=20
> Thanks,
>=20
> Paolo
