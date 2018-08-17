Received: from eggs.gnu.org ([2001:4830:134:3::10]:58783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqbGA-0002te-TO
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 05:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqbG6-0001nu-Ib
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 05:41:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37320 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqbG4-0001jp-Sn
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 05:41:29 -0400
Date: Fri, 17 Aug 2018 10:41:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817094123.GD11124@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <56f721bc-6e1d-05de-2f6b-c410f4dee711@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56f721bc-6e1d-05de-2f6b-c410f4dee711@profihost.ag>
Subject: Re: [Qemu-devel] Qemu and Spectre_V4 + l1tf + IBRS_FW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Aug 17, 2018 at 08:44:38AM +0200, Stefan Priebe - Profihost AG wrote:
> Hello,
> 
> i haven't found anything on the web regarding qemu and mentioned variants.
> 
> While my host says:
> l1tf:Mitigation: PTE Inversion; VMX: SMT vulnerable, L1D conditional
> cache flushes
> meltdown:Mitigation: PTI
> spec_store_bypass:Mitigation: Speculative Store Bypass disabled via
> prctl and seccomp
> spectre_v1:Mitigation: __user pointer sanitization
> spectre_v2:Mitigation: Full generic retpoline, IBPB, IBRS_FW
> 
> My guests bootet with pcid and spec-ctrl only say:
> l1tf:Mitigation: PTE Inversion
> meltdown:Mitigation: PTI
> spec_store_bypass:Vulnerable
> spectre_v1:Mitigation: __user pointer sanitization
> spectre_v2:Mitigation: Full generic retpoline, IBPB
> 
> * What is about spec_store_bypass in Qemu?

The guest needs an 'ssbd' feature for Intel CPU models and either a
'virt-ssbd' or 'amd-ssbd' feature for AMD CPU models.

> * What is about IBRS_FW feature?

I'm not sure what IBRS_FW is referring to, but don't worry about it.
The fact the the guest kernel says "Mitigation" instead of "Vulnerable"
means you are protected with your current config.

For Intel CPU models Spectre v2 needs the guest to have the 'spec-ctrl'
feature. On AMD models Spectre v2 the guest needs 'ibpb' feature.

> * What is about L1TF?

No extra CPU flags are required for QEMU guests for L1TF. The new CPU
feature is merely an perf optimization for the host hypervisor fixes.

Note that with L1TF there are extra steps you need to consider wrt
hyperthreading, that won't be reflected in the 'vulnerabilities'
data published by the kernel.

You can read more about the procedure for dealing with L1TF in
virt hosts in the "Resolve" tab of this article:

  https://access.redhat.com/security/vulnerabilities/L1TF

> Or are those just irrelevant to Qemu guests? Would be great to have some
> informations.

We have some QEMU docs providing guidance on guest CPU model/feature config
but they are not yet published. In the meantime this blog post of mine gives
the same info, covering what's needed for Spectre v2, Meltdown and SSBD and
guidance in general for CPU config:

  https://www.berrange.com/posts/2018/06/29/cpu-model-configuration-for-qemu-kvm-on-x86-hosts/


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
