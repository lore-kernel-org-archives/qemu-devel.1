Received: from eggs.gnu.org ([2001:4830:134:3::10]:49035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ek78I-000338-60
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ek78F-0002Ie-4D
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:46:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ek78E-0002IK-T7
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:46:19 -0500
Date: Fri, 9 Feb 2018 09:46:15 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180209114615.GG13981@localhost.localdomain>
References: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
	<20180208181207.GB13981@localhost.localdomain>
	<fcb084ce-1615-f100-4137-e0fa46098d7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb084ce-1615-f100-4137-e0fa46098d7b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_DEDICATED hint CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Fri, Feb 09, 2018 at 09:41:41AM +0100, Paolo Bonzini wrote:
> On 08/02/2018 19:12, Eduardo Habkost wrote:
> > On Thu, Feb 08, 2018 at 05:44:20PM +0800, Wanpeng Li wrote:
> >> From: Wanpeng Li <wanpengli@tencent.com>
> >>
> >> Add PV_DEDICATED hint cpuid feature bit.
> >>
> > [...]
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index d70954b..cf48931 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -4076,6 +4076,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
> >>              x86_cpu_get_supported_feature_word(w, false);
> >>          uint32_t requested_features = env->features[w];
> >>          env->features[w] &= host_feat;
> >> +        if (cpu->pv_dedicated && (w == FEAT_KVM)) {
> >> +            env->features[w] |= CPUID_PV_DEDICATED;
> >> +        }
> > 
> > Why do this trick here instead of just adding "pv-dedicated" to
> > feature_word_info[FEAT_KVM].feat_names?
> 
> I think because it can be added independent of KVM_GET_SUPPORTED_CPUID.

If QEMU knows it can be enabled if outside GET_SUPPORTED_CPUID,
kvm_arch_get_supported_cpuid() can return it as supported.

-- 
Eduardo
