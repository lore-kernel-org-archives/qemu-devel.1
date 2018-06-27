Received: from eggs.gnu.org ([2001:4830:134:3::10]:48076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY9wn-0007NA-Pt
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY9wj-0007W3-TV
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:53:21 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fY9wj-0007V8-M6
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:53:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so1943321wrs.5
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 05:53:17 -0700 (PDT)
References: <1526384258-3581-1-git-send-email-lpetrut@cloudbasesolutions.com>
	<b1f9836f-96ee-d782-1882-51c97e21d252@redhat.com>
	<9ED401B4-3DF6-4BC8-9D38-14C78C9D1A66@cloudbasesolutions.com>
	<a7f0b9ab-3c8b-87d1-9f63-e82b13f66029@redhat.com>
	<DM5PR21MB01706DBB47ABA7A6EEB6AE9FB6920@DM5PR21MB0170.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a9c21dd6-413d-14a3-17af-0ad3fc88b5ca@redhat.com>
Date: Wed, 27 Jun 2018 14:53:14 +0200
MIME-Version: 1.0
In-Reply-To: <DM5PR21MB01706DBB47ABA7A6EEB6AE9FB6920@DM5PR21MB0170.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] WHPX Add signature CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, apilotti <apilotti@cloudbasesolutions.com>
Cc: "petrutlucian94@gmail.com" <petrutlucian94@gmail.com>, Richard Henderson <rth@twiddle.net>, Lucian Petrut <lpetrut@cloudbasesolutions.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 16/05/2018 16:18, Justin Terry (VM) via Qemu-devel wrote:
> Hey Paolo,
> 
> I agree that in the future it would be great if the Windows
> Hypervisor Platform supported that and if that happens there is no
> reason to differentiate the two.
> 
> However, today WHPX actually doesn’t support any of the synthetic
> enlightenments that Hyper-V does. We are really trying to make the
> Windows Hypervisor Platform a generic hypervisor where as Hyper-V is
> a specific implementation on top of that hypervisor (and QEMU is
> another such implementation). For example, VMBus was mentioned but as
> it stands today, VMBus is not supported in WHPX due to lack of
> support for hypercalls. Additionally, timer enlightenments that you
> mentioned would not be supported through synthetic paths and instead
> run emulated as devices (hpet etc.).

Sorry I missed this email.  Note that I didn't mention timer
enlightenments, I mentioned relaxed timing, CPUID[0x40000004].EAX[bit
5].  These are the main reason to implement Hyper-V interfaces in
non-Hyper-V hypervisors, otherwise Windows will bugcheck with STOP 0x101
under load.

The question is why you need to implement a CPUID signature.  The guest
OS should not care about the hypervisor that hosts it, and indeed
Windows works well without detecting Xen, KVM, etc.  It only detects the
Hyper-V interface that is presented by those hypervisors.  Implementing
and documenting a QEMU-specific hypervisor interface has a potentially
large future cost, and it would be preferrable to implement an existing
hypervisor interface for QEMU with WHPX.

> I hope this adds some clarity here for why WHPX doesn’t implement
> hyperv-proto.h as Hyper-V != Windows Hypervisor Platform in many
> aspects. Please let me know if there is anything else I can explain
> to help clarify the two.

Non-Hyper-V hypervisors can provide the Hyper-V interfaces with no
hypercalls and the three synthetic MSRs HV_X64_MSR_GUEST_OS_ID,
HV_X64_MSR_HYPERCALL and HV_X64_MSR_VP_INDEX.

This should not be hard.  For example at least KVM and Xen don't make
the hypercall page an overlay; they just replace the old contents with a
vmcall+ret sequence, which simplifies noticeably the implementation.

Does WHPX allow trapping hypercalls?  If not, a stopgap implementation
could be to put something like this in the hypercall page

    xor eax, eax
    // The next byte sets eax=1 and zf=0 in 32-bit mode
    // In 64-bit mode it is decoded together with the JZ
    db 0x40
    jz is_64_bit
    // Zero edx in 32-bit mode
    cdq
is_64_bit:
    // HV_STATUS_INVALID_HYPERCALL_CODE
    mov al,2
    ret

It would not satisfy the requirement of trapping in real mode or at
CPL=3, and it would clobber the zero flag, but perhaps it's better than
nothing.

Paolo

> 
>> -----Original Message----- From: Paolo Bonzini
>> <pbonzini@redhat.com> Sent: Wednesday, May 16, 2018 12:35 AM To:
>> apilotti <apilotti@cloudbasesolutions.com> Cc:
>> petrutlucian94@gmail.com; Lucian Petrut 
>> <lpetrut@cloudbasesolutions.com>; Eduardo Habkost 
>> <ehabkost@redhat.com>; open list:All patches CC here <qemu- 
>> devel@nongnu.org>; Justin Terry (VM) <juterry@microsoft.com>;
>> Richard Henderson <rth@twiddle.net> Subject: Re: [Qemu-devel]
>> [PATCH] WHPX Add signature CPUID
>> 
>> On 16/05/2018 01:55, Alessandro Pilotti wrote:
>>> Hi Paolo,
>>> 
>>> The main reason for different signatures is to allow guest
>>> workloads to be aware of the differences between the two
>>> platforms (eg VirtIO vs VMBus).
>> 
>> Why does it matter?  CPUID tells you about the enlightenments that
>> the hypervisor provides, not the availability of the VMBus.
>> 
>> VMBus requires some of the enlightenments, mostly related to the
>> synthetic interrupt controllers, but the opposite is not true---you
>> can have enlightenments without VMBus, and in fact you probably
>> want WHPX to enable the relaxed timing enlightenment.
>> 
>> Thanks,
>> 
>> Paolo
