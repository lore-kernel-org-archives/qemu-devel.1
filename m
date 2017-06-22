Received: from eggs.gnu.org ([2001:4830:134:3::10]:44856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1dNrYV-0002GG-Ky
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 22:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1dNrYU-0002FU-Qh
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 22:09:11 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1dNrYU-0002FC-M6
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 22:09:10 -0400
Received: by mail-ot0-x242.google.com with SMTP id p48so320013otc.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 19:09:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170621162833.GA22745@potion>
References: <1498014889-52658-1-git-send-email-wanpeng.li@hotmail.com>
	<20170621162833.GA22745@potion>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 22 Jun 2017 10:09:09 +0800
Message-ID: <CANRm+Cz3BxszRnXEEUC222E6Hb6yEa63CJcHDbP0EFY=EeNDSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] KVM: Add async pf flag to
 KVM_GET/SET_VCPU_EVENTS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpeng.li@hotmail.com>

2017-06-22 0:28 GMT+08:00 Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>:
> 2017-06-20 20:14-0700, Wanpeng Li:
>> From: Wanpeng Li <wanpeng.li@hotmail.com>
>>
>> This patch adds async pf flag to KVM_GET/SET_VCPU_EVENTS interface.
>>
>> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
>> ---
>> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
>> @@ -300,6 +301,7 @@ struct kvm_vcpu_events {
>>               __u8 has_error_code;
>>               __u8 pad;
>>               __u32 error_code;
>> +             bool async_page_fault;
>
> Touching userspace interfaces is always a major fun ...
>
> You must not change the layout of an existing structure.  You can try to
> reuse the pad and hope that some userspace didn't check it for 0.
> (I think it's a decent compromise between safety and sanity.)

Thanks for pointing out. Just fixes it in v2.

Regards,
Wanpeng Li

>
>>       } exception;
>>       struct {
>>               __u8 injected;
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> @@ -2493,6 +2493,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int le=
vel)
>>      events.exception.has_error_code =3D env->has_error_code;
>>      events.exception.error_code =3D env->error_code;
>>      events.exception.pad =3D 0;
>> +    events.exception.async_page_fault =3D env->async_page_fault;
>>
>>      events.interrupt.injected =3D (env->interrupt_injected >=3D 0);
>
> Old QEMUs would break below this point, because interrupt.injected used
> to be where exception.async_page_fault is.
>
>>      events.interrupt.nr =3D env->interrupt_injected;
