Received: from eggs.gnu.org ([2001:4830:134:3::10]:40926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL7hQ-0008NO-OU
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL7hN-0004Z6-Nv
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL7hN-0004Yo-HM
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:47:01 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-17-rkagan@virtuozzo.com>
	<999e60c5-7ee7-5346-6940-1fcd5d7b4264@redhat.com>
	<20170614115421.GJ2004@rkaganb.sw.ru>
	<c6f8c40b-6038-3b3a-e78e-a3ea6bc6fc2b@redhat.com>
	<20170614124109.GB2044@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7262a2b7-5c3c-39c6-8f2e-f2818ce59c35@redhat.com>
Date: Wed, 14 Jun 2017 14:46:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170614124109.GB2044@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/23] hyperv: map overlay pages after
 updating msrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>



On 14/06/2017 14:41, Roman Kagan wrote:
> On Wed, Jun 14, 2017 at 02:11:56PM +0200, Paolo Bonzini wrote:
>> On 14/06/2017 13:54, Roman Kagan wrote:
>>>> Why not disable the zeroing for host-initiated MSR writes?  This is
>>>> pretty clearly a KVM bug, we can push it to stable kernels too.
>>>
>>> The only problem with this is that QEMU will have no reliable way to
>>> know if the KVM it runs with has this bug fixed or not.  Machines
>>> without vmbus work and even migrate fine with the current KVM despite
>>> this bug (the only user of those pages currently is synic timers which
>>> re-arm themselves and post messages regardless of zeroing).  Now
>>> updating QEMU to a vmbus-enabled version without updating the kernel
>>> will make the migrations cause guest hangs.
>>
>> Return 2 from KVM_CHECK_EXTENSION(KVM_CAP_HYPERV_SYNIC)?  Then you can
>> make new QEMU refuse to enable synic if a new kernel is not available.
> 
> Indeed, that's a possibility.
> 
> I'll probably make it in both directions then: on
> KVM_ENABLE_CAP(KVM_CAP_HYPERV_SYNIC, 2) disable zeroing completely,
> including on guest writes, to better match Hyper-V.  Or does it deserve
> a separate cap number?

Unfortunately kvm_vcpu_ioctl_enable_cap is not checking arguments and
refusing nonzero values, so I'm a bit wary of doing that
unconditionally---and I'm not sure it deserves a separate capability number.

Maybe a flag KVM_ENABLE_CAP_STRICT_ARG_CHECK in cap->flags, but I don't
want you to do too much unrelated work.  Keeping the zeroing on guest
writes doesn't seem too bad.

Or the nuclear option, introduce KVM_CAP_HYPERV_SYNIC2 and drop the
broken KVM_CAP_HYPERV_SYNIC altogether.  Has its charm...

Paolo
