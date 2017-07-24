Received: from eggs.gnu.org ([2001:4830:134:3::10]:53666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dZmPS-0007aR-0m
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 19:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dZmPO-0008Lv-Rl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 19:05:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dZmPO-0008KQ-LO
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 19:05:02 -0400
Date: Mon, 24 Jul 2017 20:04:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170724230458.GK2757@localhost.localdomain>
References: <20170712162058.10538-1-ehabkost@redhat.com>
	<20170712162058.10538-2-ehabkost@redhat.com>
	<20170717140343.0026e05d@nial.brq.redhat.com>
	<20170717171827.GR6020@localhost.localdomain>
	<20170718132955.455aaccd@nial.brq.redhat.com>
	<4c8330a1-8ba8-ff9e-bea2-8670df744e90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c8330a1-8ba8-ff9e-bea2-8670df744e90@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] target/i386: Use simple static
 property for "model-id"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Jul 24, 2017 at 11:11:34PM +0200, Paolo Bonzini wrote:
> On 18/07/2017 13:29, Igor Mammedov wrote:
> >> It may add a few additional CPU cycles, but I really doubt we can
> >> find a workload where CPUID speed has measurable impact.  See,
> >> for example, how expensive the kernel KVM CPUID code
> >> (kvm_cpuid(), kvm_find_cpuid_entry()) is.
> > 
> > I don't expect that it would affect KVM, but for TCG any instruction
> > execution is 'fast' path, so I'd leave current cpu_x86_cpuid()
> > not to loose those few cycles, it's not worth sacrifice for the sake of cleanup.
> 
> It's not like this does a QOM property lookup or anything.  I think the
> patch is a good idea.
> 
> Even simpler way to write the cpuid code:
> 
>             int base = (index - 0x80000002) * 16;
>             char model[16];
> 
>             if (strnlen(env->model_id, base) < base) {
>                 memset(model, 0, sizeof(model));
>             } else {
>                 strncpy(model, env->model_id + base, sizeof(model));
>             }
>             *eax = ldl_le_p(&model[0]);
>             *ebx = ldl_le_p(&model[4]);
>             *ecx = ldl_le_p(&model[8]);
>             *edx = ldl_le_p(&model[12]);

Neat.  I will use it in v2.  Thanks!

-- 
Eduardo
