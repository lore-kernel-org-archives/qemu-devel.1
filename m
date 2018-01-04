Received: from eggs.gnu.org ([2001:4830:134:3::10]:50479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX9nx-0007Ze-QA
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX9nt-0008Tq-Rk
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:59:49 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:42607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eX9nt-0008TC-KP
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:59:45 -0500
Received: by mail-wm0-f51.google.com with SMTP id b141so5009928wme.1
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:59:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20180104175609.9085-1-pbonzini@redhat.com>
Message-ID: <eaa0ee88-b3c3-9b12-dcd5-100fc6983c8a@redhat.com>
Date: Thu, 4 Jan 2018 18:59:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180104175609.9085-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] add a blog post about "Spectre"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

On 04/01/2018 18:56, Paolo Bonzini wrote:
> ---
>  _posts/2018-01-04-spectre.md | 60 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 _posts/2018-01-04-spectre.md

Something on TCG ("it is not considered a security boundary, so it's
vulnerable to the CVE and no fix is planned") may be worth adding too.
It can be updated later.

Paolo

> diff --git a/_posts/2018-01-04-spectre.md b/_posts/2018-01-04-spectre.md
> new file mode 100644
> index 0000000..1be86d0
> --- /dev/null
> +++ b/_posts/2018-01-04-spectre.md
> @@ -0,0 +1,60 @@
> +---
> +layout: post
> +title:  "QEMU and the Spectre and Meltdown attacks"
> +date:   2018-01-04 18:00:00 +0000
> +author: Paolo Bonzini and Eduardo Habkost
> +categories: [meltdown, spectre, security, x86]
> +---
> +As you probably know by now, three critical architectural flaws in CPUs have
> +been recently disclosed that allow user processes to read kernel or hypervisor
> +memory through cache side-channel attacks.  These flaws, collectively
> +named _Meltdown_ and _Spectre_, affect in one way or another almost
> +all processors that perform out-of-order execution, including x86 (from
> +Intel and AMD), POWER, s390 and ARM processors.
> +
> +No microcode updates are required to block the _Meltdown_ attack; it is
> +enough to update the guest operating system to a version that separates
> +the user and kernel address spaces (known as _page table isolation_ for
> +the Linux kernel).  Therefore, this post will focus on _Spectre_, and
> +especially on [CVE-2017-5715](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-5715).
> +
> +Fixing or mitigating _Spectre_ in general, and CVE-2017-5715 in particular,
> +requires cooperation between the processor and the operating system kernel or
> +hypervisor; the processor can be updated through microcode or millicode
> +patches to provide the required functionality.  CVE-2017-5715 allows guests
> +to read potentially sensitive data from hypervisor memory; however, __patching
> +the host kernel is sufficient to block this attack__.
> +
> +On the other hand, in order to protect the guest kernel from a malicious
> +userspace, updates are also needed to the guest kernel and, depending on
> +the processor architecture, to QEMU.  Just like on bare-metal, the guest
> +kernel will use the new functionality provided by the microcode or millicode
> +updates.  When running under a hypervisor, processor emulation is mostly out of
> +QEMU's scope, so QEMU's role in the fix is small, but nevertheless important.
> +In the case of KVM:
> +
> +* QEMU configures the hypervisor to emulate a specific processor model.
> +For x86, QEMU has to be aware of new CPUID bits introduced by the microcode
> +update, and it must provide them to guests depending on how the guest is
> +configured.
> +
> +* upon virtual machine migration, QEMU reads the CPU state on the source
> +and transmits it to the destination.  For x86, QEMU has to be aware of new
> +model specific registers (MSRs).
> +
> +Right now, there are no public patches to KVM that expose the new CPUID bits
> +and MSRs to the virtual machines, therefore there is no urgent need to update
> +QEMU; remember that __updating the host kernel is enough to protect the
> +host from malicious guests__.  Nevertheless, updates will be posted to the
> +qemu-devel mailing list in the next few days, and a 2.11.1 patch release
> +will be released with the fix.
> +
> +As of today, the QEMU project is not aware of whether similar changes will
> +be required for non-x86 processors.  If so, they will also posted to the
> +mailing list and backported to recent stable releases.
> +
> +For more information on the vulnerabilities, please refer to the [Google Security
> +Blog](https://security.googleblog.com/2018/01/todays-cpu-vulnerability-what-you-need.html)
> +and [Google Project
> +Zero](https://googleprojectzero.blogspot.it/2018/01/reading-privileged-memory-with-side.html)
> +posts on the topic, as well as the [Spectre and Meltdown FAQ](https://meltdownattack.com/#faq).
> 
