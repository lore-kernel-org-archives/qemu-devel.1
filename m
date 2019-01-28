Received: from eggs.gnu.org ([209.51.188.92]:34400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1go7NL-0008Cf-P2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1go7NJ-00031d-VY
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:54:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1go7NJ-0002zi-Od
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:54:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so14102258wmj.1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 05:54:55 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <20190128113017.GA2435@rkaganb.sw.ru>
References: <20190125114155.32062-1-vkuznets@redhat.com>
	<20190125114155.32062-5-vkuznets@redhat.com>
	<20190125124738.GB30730@rkaganb.sw.ru>
	<87bm44onnh.fsf@vitty.brq.redhat.com>
	<20190128113017.GA2435@rkaganb.sw.ru>
Date: Mon, 28 Jan 2019 14:54:52 +0100
Message-ID: <87lg34zy37.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 4/8] i386/kvm: Implement 'hv-all'
 pass-through mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Jan 25, 2019 at 02:46:42PM +0100, Vitaly Kuznetsov wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>> 
>> > On Fri, Jan 25, 2019 at 12:41:51PM +0100, Vitaly Kuznetsov wrote:
>> >> In many case we just want to give Windows guests all currently supported
>> >> Hyper-V enlightenments and that's where this new mode may come handy. We
>> >> pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.
>> >
>> > How is the compatibility ensured on migration between kernels reporting
>> > different feature sets?
>> 
>> AFAIU we don't change anything in this regard (or, my intention was to
>> not change anything): hv-all is converted to the individual hv-*
>> properties (hv_cpuid_check_and_set()) actually sets cpu->hyperv_* flags
>> according to what's supported by kernel so when we migrate we will
>> require all these features supported.
>
> Migration relies on the upper layer to run the destination QEMU with the
> identical command line (except for -incoming) as the source, and QEMU is
> then supposed to set up identical environment in the target VM as was in
> the source, or refuse to start if that's impossible.  (If I'm
> misunderstanding this Dave (cc-d) may want to correct me.)
>
> AFAICS this hv-all attribute will enable different feature sets
> depending on the kernel it's run on, so the migration between different
> kernels will appear to succeed, but the guest may suddenly encounter an
> incompatible change in the environment.

With 'hv-all' I'm trying to achieve behavior similar to '-cpu host' and
AFAIK these VMs are migratable 'at your own risk' (if you do it directly
from qemu). Libvirt (or whatever upper layer), however, would do CPU
feature comparison and in case you have less features on the destination
host than you had on the source code it will forbid the migration. I
think if this also works for Hyper-V features than were fine.

Dave, feel free to tell me I'm completely wrong with my assumptions)

-- 
Vitaly
