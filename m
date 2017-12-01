Received: from eggs.gnu.org ([2001:4830:134:3::10]:55434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKopB-0001vq-62
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKop7-0007fX-NT
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:10:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eKop7-0007eH-Gz
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:10:01 -0500
References: <D1BD20B5DB34024DA951CEEE6C4C5998B1B8CC82@DGGEMA501-MBX.china.huawei.com>
	<33183CC9F5247A488A2544077AF19020DA4ADB8C@DGGEMA505-MBS.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4d9a0a9-b136-7320-d1e1-36a4c3cffccc@redhat.com>
Date: Fri, 1 Dec 2017 18:09:52 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA4ADB8C@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [BUG] Windows 7 got stuck easily while run
 PCMark10 application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>

On 01/12/2017 08:08, Gonglei (Arei) wrote:
> First write to 0x70, cmos_index = 0xc & 0x7f = 0xc
>        CPU 0/KVM-15566 kvm_pio: pio_write at 0x70 size 1 count 1 val 0xc> Second write to 0x70, cmos_index = 0x86 & 0x7f = 0x6>        CPU 1/KVM-15567 kvm_pio: pio_write at 0x70 size 1 count 1 val 0x86> vcpu0 read 0x6 because cmos_index is 0x6 now:>        CPU 0/KVM-15566 kvm_pio: pio_read at 0x71 size 1 count 1 val 0x6> vcpu1 read 0x6:>        CPU 1/KVM-15567 kvm_pio: pio_read at 0x71 size 1 count 1 val 0x6
This seems to be a Windows bug.  The easiest workaround that I
can think of is to clear the interrupts already when 0xc is written,
without waiting for the read (because REG_C can only be read).

What do you think?

Thanks,

Paolo
