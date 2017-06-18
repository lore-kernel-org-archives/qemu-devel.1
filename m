Received: from eggs.gnu.org ([2001:4830:134:3::10]:33721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMc96-00064r-EH
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 11:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMc91-00039C-HC
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 11:29:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dMc91-00037w-Ar
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 11:29:43 -0400
Date: Sun, 18 Jun 2017 12:29:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170618152936.GO22043@thinpad.lan.raisama.net>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-6-rkagan@virtuozzo.com>
	<20170613185752.GZ5016@thinpad.lan.raisama.net>
	<20170614112506.GI2004@rkaganb.sw.ru>
	<6bb8f5e3-b6bf-c62a-93f3-9fe338d43881@redhat.com>
	<20170614150027.12e5626e@nial.brq.redhat.com>
	<20170615124106.GA2046@rkaganb.sw.ru>
	<20170615152728.54ffa55c@nial.brq.redhat.com>
	<20170615160527.GA2008@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615160527.GA2008@rkaganb.sw.ru>
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
To: Roman Kagan <rkagan@virtuozzo.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Thu, Jun 15, 2017 at 07:05:29PM +0300, Roman Kagan wrote:
> On Thu, Jun 15, 2017 at 03:27:28PM +0200, Igor Mammedov wrote:
[...]
> > > > > future.  But the APIC id is also the KVM vcpu_id, so there's no need to
> > > > > have VP_INDEX maintained by QEMU.  
> > > > agreed it'd be better to reuse vcpu_id/apic id as interface between
> > > > qemu/kvm/guest instead of adding additional cpu_index concept in ABI  
> > > 
> > > Having consulted the spec, I'm not so confident any more this is the
> > > right move.
> > > 
> > > > 7.8.1 Virtual Processor Index
> > > > 
> > > > Virtual processors are identified by using an index (VP index). The
> > > > maximum number of virtual processors per partition supported by the
> > > > current implementation of the hypervisor can be obtained through CPUID
> > > > leaf 0x40000005. A virtual processor index must be less than the
> > > > maximum number of virtual processors per partition.
> > > 
> > > This seems to imply that VP index should be dense.  As if they use it
> > > directly as an index into an array whose length is equal to the max
> > > number of vcpus.  (BTW the value we report for it is currently hardcoded
> > > to 0x40 which probably needs fixing, too.)
> > the question here is where "maximum number of virtual processors" comes from
> 
> We provide it in a corresponding cpuid leaf.
> 
> > if it's possible to tell guest value explicitly,
> > we can use pcms->apic_id_limit for it.
> 
> But, depending on the apic_id encoding scheme, this can be arbitrarily
> bigger than the actual maximum number of vcpus.  Which can result in
> guest confusion or inefficiency.

Note that it will be bigger only if threads-per-core or
cores-per-thread are not powers of 2.  If your use case don't
require configuration of a virtual thread/core topology, the APIC
IDs can be always contiguous.

-- 
Eduardo
