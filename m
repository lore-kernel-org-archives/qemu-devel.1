Received: from eggs.gnu.org ([2001:4830:134:3::10]:53186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gTp2E-0004U3-4e
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gTp27-0006wp-Sk
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:17:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gTp27-0006tj-Ht
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:17:11 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <20181130183608.GQ18284@habkost.net>
References: <20181126135958.20956-1-vkuznets@redhat.com>
	<c30c335e-ca21-1179-670b-d4506ce14571@redhat.com>
	<878t1chzj8.fsf@vitty.brq.redhat.com>
	<20181130183608.GQ18284@habkost.net>
Date: Mon, 03 Dec 2018 15:17:06 +0100
Message-ID: <871s6yy9st.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: expose
 HV_CPUID_ENLIGHTMENT_INFO.EAX and HV_CPUID_NESTED_FEATURES.EAX as feature
 words
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Thu, Nov 29, 2018 at 12:51:55PM +0100, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>> > On 26/11/18 14:59, Vitaly Kuznetsov wrote:
>> >> It was found that QMP users of QEMU (e.g. libvirt) may need
>> >> HV_CPUID_ENLIGHTMENT_INFO.EAX/HV_CPUID_NESTED_FEATURES.EAX information. In
>> >> particular, 'hv_tlbflush' and 'hv_evmcs' enlightenments are only exposed in
>> >> HV_CPUID_ENLIGHTMENT_INFO.EAX.
>> >> 
>> >> HV_CPUID_NESTED_FEATURES.EAX is exposed for two reasons: convenience
>> >> (we don't need to export it from hyperv_handle_properties() and as
>> >> future-proof for Enlightened MSR-Bitmap, PV EPT invalidation and
>> >> direct virtual flush features.
>> >> 
>> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> >
>> > Can you add a comment to feature_word_info, explaining why the
>> > feat_names are not set?
>> 
>> I had to do some code archeology to make sure I understand, I think it
>> goes back to
>> 
>> http://lists.gnu.org/archive/html/qemu-devel/2016-06/msg06579.html
>> 
>> So the comment (probably added before FEAT_HYPERV_EAX definition) would
>> be
>> 
>> ".feat_names are commented out for Hyper-V enlightenments because we
>> don't want to have two different ways for enabling them on QEMU command
>> line. Some features (e.g. "hyperv_time", "hyperv_vapic", ...) require
>> enabling several feature bits simultaneously, exposing these bits
>> individually may just confuse guests."
>> 
>> Would do?
>
> That's an accurate description.
>

Thanks, I'll send v2 out with it.

> But note that we might still be able to move the existing
> "hyperv_*" features to feature_word_info[].feat_names.  We just
> need to keep the same semantics (e.g. enable
> HV_HYPERCALL_AVAILABLE automatically when some features are set).
>
> Maybe we can make some of the feature properties read-only.  This
> way we can give them meaningful names for debugging and error
> messages, even if we don't want to make them configurable
> directly.

I'd suggest (if there are no objections of course) we do this separately
from this patch. Some time ago when merging direct mode stimers for KVM
Paolo suggested we stop adding capabilities to KVM for each individulat
feature and replace them with something like KVM_GET_SUPPORTED_HV_CPUID
ioctl returning all Hyper-V related feature words. When this is done we
can reconsider how Qemu discoveres Hyper-V related KVM features and as
part of this work we can take a closer look at feature words and
feat_names.

-- 
Vitaly
