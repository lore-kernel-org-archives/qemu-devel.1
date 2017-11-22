Received: from eggs.gnu.org ([2001:4830:134:3::10]:38842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHaf7-0003X3-6f
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHaf3-0004ta-QF
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:26:21 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHaf3-0004t1-JM
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:26:17 -0500
Received: by mail-wr0-f193.google.com with SMTP id k18so10587382wre.1
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 11:26:17 -0800 (PST)
References: <20171122180908.31389-1-rkrcmar@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <adada925-d23d-af1c-8965-f18904f5184d@redhat.com>
Date: Wed, 22 Nov 2017 20:26:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171122180908.31389-1-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] kvm: apic: save and restore x2APIC LDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

On 22/11/2017 19:09, Radim Krčmář wrote:
> QEMU saves only 8 bits of APIC LDR, which means that it does not support
> x2APIC.  The correct way of fixing this would be to save and restore the
> full 32 bit register, but because x2APIC LDR is a function of x2APIC ID,
> we can also compute it and keep the migration format untouched.
> 
> KVM always expected the LDR format to follow the xAPIC/x2APIC standard,
> but pre 4.1 KVMs used non-standard x2APIC ID in case the OS changed
> xAPIC ID before switching to x2APIC, which means that QEMU has to use
> the kvm_x2apic_api feature to derive the x2APIC ID.
> 
> This bug has also been addressed on the KVM side with patch 5849d75a5c9b
> ("KVM: lapic: Fixup LDR on load in x2apic").

> +    if (s->apicbase & MSR_IA32_APICBASE_EXTD) {
> +        kvm_apic_set_reg(kapic, 0xd, kvm_apic_calc_x2apic_ldr(s));

Is this correct if the kernel doesn't support the new-style x2APIC API?

In the end, it seems simpler to just fix it in the kernel.

Paolo

> +    } else {
> +        kvm_apic_set_reg(kapic, 0xd, s->log_dest << 24);
> +    }
