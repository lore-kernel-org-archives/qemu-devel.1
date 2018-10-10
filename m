Received: from eggs.gnu.org ([2001:4830:134:3::10]:55694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAIo0-0002tI-Rk
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAInx-0003hN-97
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:01:56 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gAInw-0003h0-W7
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 14:01:53 -0400
Received: by mail-pf1-x442.google.com with SMTP id m77-v6so3010708pfi.8
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 11:01:52 -0700 (PDT)
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<3F86795E-6F41-4C86-91C6-21E8312F5E4B@eideticom.com>
	<a9cf5e6c09eed752b123d5de842bdc3264e37117.camel@redhat.com>
	<5A5F4A2B-2DAF-4D70-BF1D-7ABC8461FDC8@raithlin.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <63b741e2-b3e5-283a-4dfc-9c1db757c575@gmail.com>
Date: Wed, 10 Oct 2018 11:01:48 -0700
MIME-Version: 1.0
In-Reply-To: <5A5F4A2B-2DAF-4D70-BF1D-7ABC8461FDC8@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Bates <sbates@raithlin.com>, Andrea Bolognani <abologna@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Keith Busch <keith.busch@intel.com>, "palmer@sifive.com" <palmer@sifive.com>, "Richard W.M. Jones" <rjones@redhat.com>

On 10/10/2018 10:32 AM, Stephen  Bates wrote:
>>> I plan to also try with a e1000 network interface model tomorrow and see how that behaves....
>>    
>>     Please do :)
>      
> I added e1000 and e1000e support to my kernel and changed the QEMU command to:
> 
> $QEMU -nographic \
>        -machine virt \
>        -smp 1 -m 8G \
>        -append "console=hvc0 ro root=/dev/vda nvme.admin_timeout=1" \
>        -kernel $KERNEL \
>        -drive file=${ROOTFS},format=raw,id=hd0 \
>        -device virtio-blk-device,drive=hd0 \
>        -device virtio-net-device,netdev=net0 \
>        -netdev user,id=net0 \
>        -device e1000,netdev=net1 \
>        -netdev user,id=net1

Why do you need two networking options?

> 
> And the kernel ooops:
> 
> [    0.224000] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [    0.224000] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    0.224000] e1000 0000:00:01.0: enabling device (0000 -> 0002)
> [    0.244000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    0.244000] Oops [#1]
> [    0.244000] Modules linked in:
> [    0.244000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc6-eideticom-riscv-00038-gc2b45b2fe26a-dirty #41
> [    0.244000] sepc: ffffffd20040cc18 ra : ffffffd20040e912 sp : ffffffd3f7a77b60
> [    0.244000]  gp : ffffffd2007e5960 tp : ffffffd3f7ac0000 t0 : ffffffd3f754b4c0
> [    0.244000]  t1 : 0000000000000000 t2 : 00000000000003af s0 : ffffffd3f7a77b70
> [    0.244000]  s1 : ffffffd3f7554b20 a0 : ffffffd3f7554b20 a1 : 0000000000000000
> [    0.244000]  a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000002
> [    0.244000]  a5 : 0000000000000002 a6 : 00000000eac0c6e6 a7 : 0000000000000000
> [    0.244000]  s2 : 0000000004140240 s3 : 0000000000000000 s4 : ffffffd3f7554f08
> [    0.244000]  s5 : ffffffd3f7554000 s6 : ffffffd2007e7794 s7 : ffffffd3f7555000
> [    0.244000]  s8 : ffffffd3f75546c0 s9 : ffffffd3f7554b20 s10: 0000000000001000
> [    0.244000]  s11: 0000000000000000 t3 : ffffffd20078e918 t4 : ffffffd20078e920
> [    0.244000]  t5 : 0000000000000007 t6 : 0000000000000006
> [    0.244000] sstatus: 0000000000000120 sbadaddr: 0000000000000000 scause: 000000000000000f
> [    0.252000] ---[ end trace 371f7702831e633b ]---

Strange. Is there any reason you need to use the e1000? The VirtIO 
networking device works for me.

Alistair

>      
> 
