Received: from eggs.gnu.org ([2001:4830:134:3::10]:45362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eygta-0004pj-2j
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eygtX-0008Vk-0q
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:47:26 -0400
Received: from mail-am5eur03hn0207.outbound.protection.outlook.com
	([104.47.8.207]:43392
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eygtU-0008VA-UI
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:47:22 -0400
Date: Wed, 21 Mar 2018 19:47:08 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180321164707.GG14983@rkaganb.sw.ru>
References: <20180320173500.32065-1-vkuznets@redhat.com>
	<20180320173500.32065-3-vkuznets@redhat.com>
	<46c08ea1-27f7-e581-f93f-cf635950062f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c08ea1-27f7-e581-f93f-cf635950062f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] i386/kvm: lower requirements for
 Hyper-V frequency MSRs exposure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 21, 2018 at 04:33:33PM +0100, Paolo Bonzini wrote:
> On 20/03/2018 18:35, Vitaly Kuznetsov wrote:
> > +        if (has_msr_hv_frequencies && env->tsc_khz) {
> >              env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
> >              env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
> >          }
> 
> Since you have added cpu->hyperv_reenlightenment, I'd rather change this
> so that we don't make the "license to change guest ABI across migration"
> apply more.  We can exploit the fact that Windows doesn't even use the
> MSRs unless either invtsc or re-enlightenment is present.

That's not a given.  It reportedly doesn't use these MSRs *now*, but I
see no reason for it not to start using it at some point, say, to avoid
TSC calibration.  E.g. Linux already does so with its hv_get_tsc_khz().

And the bad thing is that it'll kill your guest with #GP when you
migrate from a new KVM to an old one.

Roman.
