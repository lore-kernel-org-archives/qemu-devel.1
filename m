Received: from eggs.gnu.org ([209.51.188.92]:42701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hCSKE-0006Nj-5A
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hCSKC-0002Hm-QO
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:08:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hCSJl-0001BY-Py
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:08:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so8864425wrn.6
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 10:07:41 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <20190405150659.GC20411@rkaganb.sw.ru>
References: <20190329141832.22882-1-vkuznets@redhat.com>
	<20190329141832.22882-5-vkuznets@redhat.com>
	<20190405150659.GC20411@rkaganb.sw.ru>
Date: Fri, 05 Apr 2019 19:00:02 +0200
Message-ID: <87pnq0ie0d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/8] i386/kvm: implement 'hv-all'
 pass-through mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Dr
	. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Mar 29, 2019 at 03:18:28PM +0100, Vitaly Kuznetsov wrote:
>> In many case we just want to give Windows guests all currently supported
>> Hyper-V enlightenments and that's where this new mode may come handy. We
>> pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.
>
> The only one out of those "many cases" I can think of is when you've
> developed a new hyperv feature in the kernel and you want to test it
> with a version of QEMU that's not aware of it.  Are there any others?
>

I can recall the following case I had: benchmark Windows guest
performance with different kernels like try to get the best number. As
these kernels were supporting different set of hv-* enlightenments I had
to do non-trivial work to figure out what's supported and adjust QEMU
command line accordingly.

Would've been much easier with 'hv-all'

>> 
>> hv_cpuid_check_and_set() is modified to also set cpu->hyperv_* flags as
>> we may want to check them later (and we actually do for hv_runtime,
>> hv_synic,...).
>> 
>> 'hv-all' is a development only feature, a migration blocker is added to
>> prevent issues while migrating between hosts with different feature sets.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  docs/hyperv.txt   |  10 ++++
>>  target/i386/cpu.c |   1 +
>>  target/i386/cpu.h |   1 +
>>  target/i386/kvm.c | 148 +++++++++++++++++++++++++++++++++++++---------
>>  4 files changed, 132 insertions(+), 28 deletions(-)
>> 
>> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
>> index 397f2517b8..d1299aba81 100644
>> --- a/docs/hyperv.txt
>> +++ b/docs/hyperv.txt
>> @@ -174,6 +174,16 @@ without the feature to find out if enabling it is beneficial.
>>  Requires: hv-vapic
>>  
>>  
>> +4. Development features
>> +========================
>> +In some cases (e.g. during development) it may make sense to use QEMU in
>> +'pass-through' mode and give Windows guests all enlightenments currently
>> +supported by KVM. This pass-through mode is enabled by "hv-all" CPU flag.
>> +Note: enabling this flag effectively prevents migration as supported features
>> +may differ between target and destination.
>
> I find 'hv-passthrough' a more adequate name for this.

Sure, will adjust.

>
>> +Note: "hv-all" doesn't include 'hv-evmcs', it needs to be enabled explicitly.
>
> This is extremely confusing, when some features are more equal than
> others.  I think it'd make more sense instead to support filtering out
> some features, like in "hv-passthrough,hv-evmcs=off".

hv-evmcs is probably the only enlightenment which is not an obvious
'win': when enabled, some features (e.g. posted interrupts) are getting
disabled. But as 'hv-all' is now a developer-only feature I see no
problem with enabling evmcs too.

-- 
Vitaly
