Received: from eggs.gnu.org ([2001:4830:134:3::10]:45522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1gKYRe-0008OI-PB
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 19:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1gKYRe-00031S-2B
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 19:45:14 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jmattson@google.com>) id 1gKYRd-0002zw-SE
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 19:45:13 -0500
Received: by mail-ot1-x343.google.com with SMTP id z33so16497439otz.11
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 16:45:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DF5EC0F1-BA8D-4B85-BB1A-B22234235FBA@oracle.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<CALMp9eRk=a1FEyr78NRGBBZ2iFCo5s2n5N=bM4zR=YF56oob3A@mail.gmail.com>
	<1C803EF0-9E1B-4E1B-A4DD-4BE788A7A1FF@oracle.com>
	<DF5EC0F1-BA8D-4B85-BB1A-B22234235FBA@oracle.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 7 Nov 2018 16:45:11 -0800
Message-ID: <CALMp9eQSptO+S1NZjQQUa=HQCXFOevHwTDS9i0KXHCGSfKzEkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org

On Wed, Nov 7, 2018 at 4:13 PM, Liran Alon <liran.alon@oracle.com> wrote:
> Ping on my last reply.
> I would like to reach to an agreement on how v3 should look like before just implementing what I think is right.
>
> Thanks,
> -Liran

I have no attachments to the current design. I had used a data[] blob,
because I didn't think userspace would have any need to know what was
in there. However, I am now seeing the error of my ways. For example,
the userspace instruction emulator needs to know the contents of the
vmcs12 to emulate instructions when in guest mode.

I had been in favor of KVM_CAPs, because they are one way to ensure
that the guest doesn't dynamically enter a state that isn't backwards
compatible. But other gates are also possible. If you have to support
destination kernels that don't know about the shadow vmcs12 component
of the nested state, userspace can just clear bit 46 of L1's
IA32_VMX_PROCBASED_CTLS2 MSR. For the VMX preemption timer, clear bit
38 of L1's IA32_VMX_PINBASED_CTLS MSR. KVM_CAPs can be reserved for
incompatible changes due to bug-fixes, like KVM_CAP_EXCEPTION_PAYLOAD,
where there isn't another gate available. If, for example, we hadn't
realized ahead of time that migration of the VMX preemption timer
isn't yet supported, some userspace implementation may not have
cleared bit 38 of L1's IA32_VMX_PINBASED_CTLS MSR, and then we would
have to gate the new nested state component behind a KVM_CAP.

As long as userspace can ensure that the kernel will only produce
backwards compatible save-state when it has to, my basic requirements
are met.
