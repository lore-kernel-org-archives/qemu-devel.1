Received: from eggs.gnu.org ([2001:4830:134:3::10]:38850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dCihG-000093-1b
	for qemu-devel@nongnu.org; Mon, 22 May 2017 04:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dCihB-0003Hk-4d
	for qemu-devel@nongnu.org; Mon, 22 May 2017 04:28:10 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dCihA-0003HL-RX
	for qemu-devel@nongnu.org; Mon, 22 May 2017 04:28:05 -0400
Received: by mail-wm0-x234.google.com with SMTP id b84so290093000wmh.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 01:28:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <33183CC9F5247A488A2544077AF19020DA2AF6CA@DGGEMA505-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f88ad61-06d8-57bb-3228-9b2dde993c70@redhat.com>
Date: Mon, 22 May 2017 10:27:59 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA2AF6CA@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC] memory consumption of Qemu is twice as much
 as the previous version in KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>



On 22/05/2017 09:04, Gonglei (Arei) wrote:
> Hi Paolo,
> 
> I found that the latest Qemu eat 2 time memory in KVM since Qemu-2.3.0.
> 
> Replication Steps:
> 
> 1. I created a CentOS 7 with 4U8G using Qemu-2.3.0, 
> 
> # grep kvm_kvzalloc /proc/vmallocinfo | awk '{total+=$2}; END {print total}'
> 16932864
> # grep kvm_kvzalloc /proc/vmallocinfo
> 0xffffc900205c7000-0xffffc90020fc8000 10489856 kvm_kvzalloc+0x3c/0x40 [kvm] pages=2560 vmalloc vpages N1=2560
> 0xffffc90020fc8000-0xffffc90020fce000   24576 kvm_kvzalloc+0x3c/0x40 [kvm] pages=5 vmalloc N1=5
> 0xffffc90020fce000-0xffffc90020fd4000   24576 kvm_kvzalloc+0x3c/0x40 [kvm] pages=5 vmalloc N1=5
> 0xffffc90020fd4000-0xffffc90020fd8000   16384 kvm_kvzalloc+0x3c/0x40 [kvm] pages=3 vmalloc N1=3
> 0xffffc9002438b000-0xffffc9002498c000 6295552 kvm_kvzalloc+0x3c/0x40 [kvm] pages=1536 vmalloc vpages N1=1536
> 0xffffc9002498c000-0xffffc90024990000   16384 kvm_kvzalloc+0x3c/0x40 [kvm] pages=3 vmalloc N1=3
> 0xffffc90024990000-0xffffc90024994000   16384 kvm_kvzalloc+0x3c/0x40 [kvm] pages=3 vmalloc N1=3
> 0xffffc90024994000-0xffffc90024997000   12288 kvm_kvzalloc+0x3c/0x40 [kvm] pages=2 vmalloc N1=2
> 0xffffc90024a75000-0xffffc90024a7e000   36864 kvm_kvzalloc+0x3c/0x40 [kvm] pages=8 vmalloc N1=8
> 
> PS: There is only this VM in my host.
> 
> 2. Do the same test using the latest Qemu:
> 
> # grep kvm_kvzalloc /proc/vmallocinfo | awk '{total+=$2}; END {print total}'
> 33865728
> linux-PsHdkO:~ # grep kvm_kvzalloc /proc/vmallocinfo 
> 0xffffc9001f181000-0xffffc9001fb82000 10489856 kvm_kvzalloc+0x25/0x30 [kvm] pages=2560 vmalloc vpages N1=2560
> 0xffffc9001fb82000-0xffffc9001fb88000   24576 kvm_kvzalloc+0x25/0x30 [kvm] pages=5 vmalloc N1=5
> 0xffffc9001fb88000-0xffffc9001fb8e000   24576 kvm_kvzalloc+0x25/0x30 [kvm] pages=5 vmalloc N1=5
> 0xffffc9001fb8e000-0xffffc9001fb92000   16384 kvm_kvzalloc+0x25/0x30 [kvm] pages=3 vmalloc N1=3
> 0xffffc90020854000-0xffffc90021255000 10489856 kvm_kvzalloc+0x25/0x30 [kvm] pages=2560 vmalloc vpages N1=2560
> 0xffffc90021255000-0xffffc9002125b000   24576 kvm_kvzalloc+0x25/0x30 [kvm] pages=5 vmalloc N1=5
> 0xffffc9002125b000-0xffffc90021261000   24576 kvm_kvzalloc+0x25/0x30 [kvm] pages=5 vmalloc N1=5
> 0xffffc90021261000-0xffffc90021265000   16384 kvm_kvzalloc+0x25/0x30 [kvm] pages=3 vmalloc N1=3
> 0xffffc9002616e000-0xffffc90026172000   16384 kvm_kvzalloc+0x25/0x30 [kvm] pages=3 vmalloc N1=3
> 0xffffc90026172000-0xffffc90026176000   16384 kvm_kvzalloc+0x25/0x30 [kvm] pages=3 vmalloc N1=3
> 0xffffc90026176000-0xffffc90026179000   12288 kvm_kvzalloc+0x25/0x30 [kvm] pages=2 vmalloc N1=2
> 0xffffc900261a9000-0xffffc900261ad000   16384 kvm_kvzalloc+0x25/0x30 [kvm] pages=3 vmalloc N1=3
> 0xffffc900261ad000-0xffffc900261b1000   16384 kvm_kvzalloc+0x25/0x30 [kvm] pages=3 vmalloc N1=3
> 0xffffc900261b1000-0xffffc900261b4000   12288 kvm_kvzalloc+0x25/0x30 [kvm] pages=2 vmalloc N1=2
> 0xffffc900280fe000-0xffffc900286ff000 6295552 kvm_kvzalloc+0x25/0x30 [kvm] pages=1536 vmalloc vpages N1=1536
> 0xffffc900286ff000-0xffffc90028d00000 6295552 kvm_kvzalloc+0x25/0x30 [kvm] pages=1536 vmalloc vpages N1=1536
> 0xffffc90028d87000-0xffffc90028d90000   36864 kvm_kvzalloc+0x25/0x30 [kvm] pages=8 vmalloc N1=8
> 0xffffc90028d9c000-0xffffc90028da5000   36864 kvm_kvzalloc+0x25/0x30 [kvm] pages=8 vmalloc N1=8
> 
> 
> 3. I found the first bad commit by 'git biscet'
> 
> linux-arei:/mnt/sdb/gonglei/opensource/qemu # git bisect bad
> 6410848bec38089424d54a6a8f10d4cf77182b5d is the first bad commit
> commit 6410848bec38089424d54a6a8f10d4cf77182b5d
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Thu Jun 18 18:30:16 2015 +0200
> 
>     target-i386: register a separate KVM address space including SMRAM regions
>     
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> :040000 040000 b2435d7cd0829e6416b316f1ae2856e6f7b0023d 1acb81aecaf50f2d313b33f2b61a24f7f0bd6f07 M      target-i386
> linux-PsHdkO:/mnt/sdb/gonglei/opensource/qemu #
> 
> 
> Any ideas about this change? Do we really need to trigger two times memory region allocation?

We are registering two memory maps, so yes as long as "-machine smm=on"
is set.  We can skip the second address space if SMM is disabled.

Paolo
