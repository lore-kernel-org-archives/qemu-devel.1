Received: from eggs.gnu.org ([2001:4830:134:3::10]:44721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dL7ua-00080a-Ps
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dL7uV-00014R-WA
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dL7uV-00014D-PP
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:00:35 -0400
Date: Wed, 14 Jun 2017 15:00:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170614150027.12e5626e@nial.brq.redhat.com>
In-Reply-To: <6bb8f5e3-b6bf-c62a-93f3-9fe338d43881@redhat.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-6-rkagan@virtuozzo.com>
	<20170613185752.GZ5016@thinpad.lan.raisama.net>
	<20170614112506.GI2004@rkaganb.sw.ru>
	<6bb8f5e3-b6bf-c62a-93f3-9fe338d43881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/23] hyperv: ensure VP index equal to
 QEMU cpu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, 14 Jun 2017 13:26:44 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 14/06/2017 13:25, Roman Kagan wrote:
> >> The problem with that is that it will break as soon as we create
> >> VCPUs in a different order.  Unsolvable on hosts that don't allow
> >> HV_X64_MSR_VP_INDEX to be set, however.  
> > Right, thanks for putting together a detailed explanation.
> > 
> > This was a thinko back then, not to have HV_X64_MSR_VP_INDEX maintained
> > by QEMU.  I'm going to post a patch to KVM fixing that.
> > 
> > Meanwhile QEMU needs a way to maintain its notion of vp_index that is
> >   1) in sync with kernel's notion
> >   2) also with kernels that don't support setting the msr
> >   3) persistent across migrations
> > 
> > cpu_index looked like a perfect candidate.
> >   
> 
> What you want is the APIC id,

> which _is_ cpu_index but may not be in the
depending on topology cpu_index won't be the same as APIC ID/vcpu_id
/AMDs odd core count/.

> future.  But the APIC id is also the KVM vcpu_id, so there's no need to
> have VP_INDEX maintained by QEMU.
agreed it'd be better to reuse vcpu_id/apic id as interface between
qemu/kvm/guest instead of adding additional cpu_index concept in ABI

> 
> Paolo
