Received: from eggs.gnu.org ([2001:4830:134:3::10]:52207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyfkJ-0001X6-8g
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyfkG-0000me-4v
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:33:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyfkG-0000mQ-08
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:33:44 -0400
References: <20180320173500.32065-1-vkuznets@redhat.com>
	<20180320173500.32065-3-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46c08ea1-27f7-e581-f93f-cf635950062f@redhat.com>
Date: Wed, 21 Mar 2018 16:33:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180320173500.32065-3-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>

On 20/03/2018 18:35, Vitaly Kuznetsov wrote:
> +        if (has_msr_hv_frequencies && env->tsc_khz) {
>              env->features[FEAT_HYPERV_EAX] |=3D HV_ACCESS_FREQUENCY_MS=
RS;
>              env->features[FEAT_HYPERV_EDX] |=3D HV_FREQUENCY_MSRS_AVAI=
LABLE;
>          }

Since you have added cpu->hyperv_reenlightenment, I'd rather change this
so that we don't make the "license to change guest ABI across migration"
apply more.  We can exploit the fact that Windows doesn't even use the
MSRs unless either invtsc or re-enlightenment is present.  Something
like this:

       if (has_msr_hv_frequencies && env->tsc_khz &&
	   (tsc_is_stable_and_known(env) ||
            cpu->hyperv_reenlightenment))

will make the MSRs visible in all useful cases, without having to add
yet another knob.

(Don't worry, this backwards-compatibility stuff is the hardest part.
I'm so happy that Eduardo is the one maintaining it :)).

Paolo
