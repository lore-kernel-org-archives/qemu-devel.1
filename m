Received: from eggs.gnu.org ([209.51.188.92]:33243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1go57q-0003Zg-EL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1go57m-0005Hw-NR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:30:48 -0500
Received: from mail-ve1eur04hn2017.outbound.protection.outlook.com
	([52.101.139.17]:35638
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1go57m-0005B7-FX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:30:46 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon, 28 Jan 2019 11:30:20 +0000
Message-ID: <20190128113017.GA2435@rkaganb.sw.ru>
References: <20190125114155.32062-1-vkuznets@redhat.com>
	<20190125114155.32062-5-vkuznets@redhat.com>
	<20190125124738.GB30730@rkaganb.sw.ru>
	<87bm44onnh.fsf@vitty.brq.redhat.com>
In-Reply-To: <87bm44onnh.fsf@vitty.brq.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E008EF1662FFED4FA6FE95F0958BDC00@eurprd08.prod.outlook.com>
MIME-Version: 1.0
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jan 25, 2019 at 02:46:42PM +0100, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
> > On Fri, Jan 25, 2019 at 12:41:51PM +0100, Vitaly Kuznetsov wrote:
> >> In many case we just want to give Windows guests all currently supported
> >> Hyper-V enlightenments and that's where this new mode may come handy. We
> >> pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.
> >
> > How is the compatibility ensured on migration between kernels reporting
> > different feature sets?
> 
> AFAIU we don't change anything in this regard (or, my intention was to
> not change anything): hv-all is converted to the individual hv-*
> properties (hv_cpuid_check_and_set()) actually sets cpu->hyperv_* flags
> according to what's supported by kernel so when we migrate we will
> require all these features supported.

Migration relies on the upper layer to run the destination QEMU with the
identical command line (except for -incoming) as the source, and QEMU is
then supposed to set up identical environment in the target VM as was in
the source, or refuse to start if that's impossible.  (If I'm
misunderstanding this Dave (cc-d) may want to correct me.)

AFAICS this hv-all attribute will enable different feature sets
depending on the kernel it's run on, so the migration between different
kernels will appear to succeed, but the guest may suddenly encounter an
incompatible change in the environment.

Roman.
