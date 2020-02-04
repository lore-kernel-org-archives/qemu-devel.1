Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98959C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 03:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612C420732
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 03:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6khUZ6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612C420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iypGN-00005U-IG
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 22:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1iypFo-00088D-Qh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 22:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1iypFm-0002c6-5J
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 22:51:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1iypFl-0002aK-Te
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 22:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580788317;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LGinM4sj6tofFxQDV7iYehZejHqxF9ANKDkmx/KmVA=;
 b=U6khUZ6DDwLBY99FqB7fXQ3xsOFEbC8WhyfnsltwojRYyXQPCwxVmqJ/akJHCP7w3LvWfY
 nUFCdSKMAEQEYyeyrD8uZ/C/82DDz8ZApD//BUpz2bKc9b8Na+MM8moAaDUcB2FFiPxHSh
 DkbrjYpeQIk+yebY8Kvw5ID5imzaick=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-5sWPAH8qORuAOoeyXzY2UQ-1; Mon, 03 Feb 2020 22:51:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 719B71857344;
 Tue,  4 Feb 2020 03:51:50 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-57.bne.redhat.com [10.64.54.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8CB519C69;
 Tue,  4 Feb 2020 03:51:43 +0000 (UTC)
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Marc Zyngier <maz@kernel.org>
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <7f6e29e6-1df9-4513-79ba-b53873b0735e@ozlabs.ru>
 <544f261e4b9c97f1d3a5fb64cef42ba5@kernel.org>
 <ff584722-1b51-e538-7c45-c71cdc40105f@redhat.com>
 <c61c95c434dbcf97a0c946f0993d4843@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <8a286e1c-c3f3-3052-e497-d44a90667451@redhat.com>
Date: Tue, 4 Feb 2020 14:51:39 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <c61c95c434dbcf97a0c946f0993d4843@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5sWPAH8qORuAOoeyXzY2UQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 8:39 PM, Marc Zyngier wrote:
> On 2020-01-31 06:59, Gavin Shan wrote:
>> On 1/29/20 8:04 PM, Marc Zyngier wrote:
>>> On 2020-01-29 02:44, Alexey Kardashevskiy wrote:
>>>> On 28/01/2020 17:48, Gavin Shan wrote:
>>>>> but a NMI is injected
>>>>> through LAPIC on x86. So I'm not sure what architect (system reset on
>>>>> ppc or injecting NMI on x86) aarch64 should follow.
>>>>
>>>> I'd say whatever triggers in-kernel debugger or kdump but I am not
>>>> familiar with ARM at all :)
>>>
>>> All that is completely OS specific, and has no relation to the architec=
ture.
>>> As I mentioned in another part of the thread, the closest thing to this
>>> would be to implement SDEI together with an IMPDEF mechanism to enter i=
t
>>> (or even generate a RAS error).
>>>
>>> On the other hand, SDEI is pretty horrible, and means either KVM or QEM=
U
>>> acting like a firmware for the guest. To say that I'm not keen is a mas=
sive
>>> understatement.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M.
>>
>> Marc, could you please explain a bit about "IMPDEF mechanism"? I'm not s=
ure if
>> it means a non-standard SDEI event should be used, corresponding to the =
HMP/QMP
>> "nmi" command.
>=20
> SDEI doesn't quite describe *why* and *how* you enter it. You just get th=
ere by
> some mean (SError, Group-0 interrupt, or IMPlementation DEFined mechanism=
).
> It is then for the SDEI implementation to sort it out and enter the OS us=
ing the
> registered entry point.
>=20

Thanks for the explanation, which make things much clearer.

>> Also, If I'm correct, you agree that a crash dump should be triggered on=
 arm64
>> guest once HMP/QMP "nmi" command is issued?
>=20
> No, I don't agree. QEMU and KVM are OS agnostic, and there is nothing in =
the ARMv8
> architecture that talks about "crash dumps".=C2=A0 If your "nmi" command =
generates
> a SDEI event and that event gets dispatched to the guest, it is entirely =
the guest's
> responsibility to do whatever it wants. We should stay clear of assuming =
behaviours.
>=20

Ok. Thank you for your clarification.

>> I also dig into SDEI a bit. It seems the SDEI support in QEMU isn't upst=
ream yet:
>>
>> https://patchew.org/QEMU/20191105091056.9541-1-guoheyi@huawei.com/
>=20
> And I'm glad. SDEI, as I said, is absolutely horrible. I'm also very fort=
unate
> to have been CC'd on this series on an email address I cannot read.
> This would have huge impacts on both QEMU and KVM, and this needs more th=
an
> a knee jerk reaction to support a QEMU command.
>=20
> And to be honest, if what you require is the guest kernel to panic, why d=
on't
> you just implement a QEMU-specific driver in Linux that does just that?
> Some kind of watchdog driver, maybe?
>=20

Marc, sorry for the delay and didn't come to you in time because I wanted t=
o figure
out the mechanism, which helps to get similar output as x86/ppc: NMI (or re=
set exception)
is received as indication to errors, possibly panic and restart the guest k=
ernel.

The mechanism I figured out is to inject SError to guest, as below snippet =
shows. It
helps to get a panic and guest rebooting, which looks similar to what x86/p=
pc have.
I can post the patch as RFC if it's right direction to go :)

Note: I'm still investigating the code to see how SError can be injected wh=
en TCG
is used. I think we need same function when TCG is enabled, or it's somethi=
ng for
future.

static void do_inject_nmi_kvm(CPUState *cpu, Error **errp)
{
     struct kvm_vcpu_events events;
     int ret;

      :
     memset(&events, 0, sizeof(events));
     events.exception.serror_pending =3D 1;
     ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
      :
}

# echo 1 > /proc/sys/kernel/panic
# (qemu) nmi
[  812.510613] SError Interrupt on CPU0, code 0xbf000000 -- SError
[  812.510617] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc2-00187-gf=
72202430e30 #2
[  812.510617] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/20=
15
[  812.510618] pstate: 40400085 (nZcv daIf +PAN -UAO)
[  812.510619] pc : cpu_do_idle+0x48/0x58
[  812.510619] lr : arch_cpu_idle+0x30/0x238
[  812.510620] sp : ffff8000112c3e80
[  812.510620] pmr_save: 000000f0
[  812.510621] x29: ffff8000112c3e80 x28: 0000000040e10018
[  812.510622] x27: 000000033e50d340 x26: 0000000000000000
[  812.510623] x25: 0000000000000000 x24: ffff8000112ca21c
[  812.510624] x23: ffff800010f98cb8 x22: ffff8000112c98c8
[  812.510625] x21: ffff8000112ca1f8 x20: 0000000000000001
[  812.510626] x19: ffff800010f86018 x18: 0000000000000000
[  812.510627] x17: 0000000000000000 x16: 0000000000000000
[  812.510628] x15: 0000000000000000 x14: 0000000000000000
[  812.510629] x13: 0000000000000000 x12: ffff0002fe640100
[  812.510630] x11: ffffffffffffffff x10: 00000000000009f0
[  812.510631] x9 : ffff800010088928 x8 : ffff8000112d28d0
[  812.510632] x7 : ffff8002ed63a000 x6 : 0000002fe2092876
[  812.510633] x5 : 00ffffffffffffff x4 : ffff8002ed63a000
[  812.510634] x3 : 0000000000001bce x2 : 00000000000000f0
[  812.510635] x1 : 0000000000000000 x0 : 0000000000000060
[  812.510636] Kernel panic - not syncing: Asynchronous SError Interrupt
[  812.510637] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc2-00187-gf=
72202430e30 #2
[  812.510638] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/20=
15
[  812.510638] Call trace:
[  812.510639]  dump_backtrace+0x0/0x1a8
[  812.510639]  show_stack+0x1c/0x28
[  812.510640]  dump_stack+0xbc/0x100
[  812.510640]  panic+0x168/0x370
[  812.510640]  nmi_panic+0x68/0x98
[  812.510641]  arm64_serror_panic+0x84/0x90
[  812.510641]  do_serror+0x88/0x140
[  812.510642]  el1_error+0x8c/0x108
[  812.510642]  cpu_do_idle+0x48/0x58
[  812.510643]  default_idle_call+0x44/0x4c
[  812.510643]  do_idle+0x228/0x2d0
[  812.510644]  cpu_startup_entry+0x28/0x48
[  812.510644]  rest_init+0xdc/0xe8
[  812.510645]  arch_call_rest_init+0x14/0x1c
[  812.510645]  start_kernel+0x494/0x4c0
[  812.510675] SMP: stopping secondary CPUs
[  812.510676] Kernel Offset: disabled
[  812.510676] CPU features: 0x04402,22000438
[  812.510677] Memory Limit: none
        :
<guest is rebooted>

Thanks,
Gavin


