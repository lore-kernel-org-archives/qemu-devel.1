Received: from eggs.gnu.org ([2001:4830:134:3::10]:46058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaEN3-0006jh-1N
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaEMx-0002Er-Bj
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:33:16 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gaEMx-0002EO-4N
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:33:11 -0500
Received: by mail-wr1-f53.google.com with SMTP id 96so4034528wrb.2
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 22:33:11 -0800 (PST)
References: <130d7419.4ba1.167ce7b9ed6.Coremail.13824125580@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38696e96-5047-b076-40ab-e650bb8e1f02@redhat.com>
Date: Fri, 21 Dec 2018 07:33:08 +0100
MIME-Version: 1.0
In-Reply-To: <130d7419.4ba1.167ce7b9ed6.Coremail.13824125580@163.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] is the "tcg translation" necessary when the "kvm
 acceleration" emulation mode enabled?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tugouxp <13824125580@163.com>, qemu-devel@nongnu.org

> scenario 1:  did the tcg translation need to be done in this case now
> that the host and target arch is the same?  or  let the kvm emulation
> the system wit the original instructions with out the TCG
> translation

TCG is turned off when KVM is enabled.  The code for TCG does not run at
all.

> scenario 2:   the pre condition is same with scenario 1 except the kvm
> is disable£¿ so ,in this scenario, the TCG must be used in order to
> the pure software emulation without acceleration?

Correct.  In this case KVM is turned off.  The capabilities of the
emulated CPU will _not_ be what you have in your host processor, but
rather what QEMU implements.  For example, you will get no AVX.

> scenario 3:  in this scenario, the host and target arch is not the
> same, so how to use the "kvm mechainsim" in this case?  so the
> instructions feed to the kvm module to run must be translated By TCG
> module? right?

KVM cannot be used in this case; KVM is only enabled when the host and
the target are the same.

Paolo

On 21/12/18 02:57, tugouxp wrote:
> hi folks:
>     i am very puzzled about the relationship between "target cpu instruction"  translated to host instructions through TCG module and the "kvm" acceleration" mode.
> 
> 
> think about three scenario of emulation:
> scenario 1, 2 and 3 as follows:
> 
> 1. target cpu: x86_64,
>     host cpu:   x84_64,
>     emulation OS:   ubuntu_desktop_amd64.iso
>     kvm:  enabled.
> 
> 
> 2. target cpu: x86_64,
> 
>     host cpu:   x84_64,
> 
>     emulation OS:   ubuntu_desktop_amd64.iso
>     kvm:  disabled.
> 
> 
> 3. target cpu  x86_64,
>     host cpu:  armv8
>     emulationOS: ubuntu_desktop_amd64.iso
>     kvm:  enabled
