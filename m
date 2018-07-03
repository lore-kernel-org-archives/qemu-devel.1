Received: from eggs.gnu.org ([2001:4830:134:3::10]:55401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bergwolf@gmail.com>) id 1faMwu-0000eU-II
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bergwolf@gmail.com>) id 1faMwt-0003vz-39
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:10:36 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bergwolf@gmail.com>) id 1faMws-0003t5-AO
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:10:34 -0400
Received: by mail-wr0-x243.google.com with SMTP id h10-v6so2344186wrq.8
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:10:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703100555.GG16791@stefanha-x1.localdomain>
References: <20180331084500.33313-1-jiangshanlai@gmail.com>
	<20180702131054.GE2155@stefanha-x1.localdomain>
	<CA+a=Yy72YN1DAczTnb47b4ZW_vummOVuK3M=F2CF5KF3mRD2Zw@mail.gmail.com>
	<20180703100555.GG16791@stefanha-x1.localdomain>
From: Peng Tao <bergwolf@gmail.com>
Date: Tue, 3 Jul 2018 23:10:12 +0800
Message-ID: <CA+a=Yy6NFKky=rBetZp1x7-vn4mRkoPLfCUqpp8L31CJegYTeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Xu Wang <gnawux@gmail.com>, qemu-devel@nongnu.org, "James O . D . Hunt" <james.o.hunt@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kata-dev@lists.katacontainers.io

On Tue, Jul 3, 2018 at 6:05 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jul 02, 2018 at 09:52:08PM +0800, Peng Tao wrote:
>> On Mon, Jul 2, 2018 at 9:10 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> > On Sat, Mar 31, 2018 at 04:45:00PM +0800, Lai Jiangshan wrote:
>> > Risks:
>> > 1. If one cloned VM is exploited then all other VMs are more likely to
>> >    be exploitable (e.g. kernel address space layout randomization).
>> w.r.t. KASLR, any memory duplication technology would expose it. I
>> remember there are CVEs (e.g., CVE-2015-2877) specific to this kind
>> attack against KSM and it was stated that "Basically if you care about
>> this attack vector, disable deduplication.". Share-until-written
>> approaches for memory conservation among mutually untrusting tenants
>> are inherently detectable for information disclosure, and can be
>> classified as potentially misunderstood behaviors rather than
>> vulnerabilities. [1]
>>
>> I think the same applies to vm templating as well. Actually VM
>> templating is more useful (than KSM) in this regard since we can
>> create a template for each trusted tenant where as with KSM all VMs on
>> a host are treated equally.
>>
>> [1] https://access.redhat.com/security/cve/cve-2015-2877
>
> That solves the problem between untrusted users but a breach in one
> clone may reveal secrets of all other clones belonging to the same
> tenant.  As a user, I would be uncomfortable knowing that if one of my
> machines is breached then secrets used by all of my machines might be
> exposed.
>
Secrets are really point 2 in your list and I'll answer it below :)

>> > 2. If you give VMs cloned from the same template to untrusted users,
>> >    they may be able to determine the secrets other users' VMs.
>> In kata and runv, vm templating is used carefully so that we do not
>> use or save any secret keys before creating the template VM. IOW, the
>> feature is not supposed to be used generally to create any template
>> VMs at any stage.
>
> At what point are templates captured to avoid these problems?  Is there
> code that shows how to do this?
>
Both runv and kata pauses the VM right after the agent inside guest is
up and running, which, in the initramfs case, translates into the
point that kernel boots and the init process starts. If you are
interested in seeing the actual code, you can look at
https://github.com/hyperhq/hyperstart/ and
https://github.com/kata-containers/agent for what is done in the guest
at that point. If you see any secrets being saved there, I'll be more
than happy to fix it. :)

>> >  Security is a
>> > major factor for using Kata, so it's important not to leak secrets
>> > between cloned VMs.
>> >
>> Yes, indeed! And it is all about trade-offs, VM templating or KSM. If
>> we want security above anything, we should just disable all the
>> sharing. But there is actually no ceiling (think about physical
>> isolation!). So it's more about trade-offs. With Kata, VM templating
>> and KSM give users options to achieve better performance and lower
>> memory footprint with little sacrifice. The security advantage of
>> running VM-based containers is still there.
>
> Adding options to enable/disable features leads to confusion among
> users, makes performance comparisons harder, and increases support
> overhead.
>
> Technical solutions to the security problems are possible.  I'm
> interested in progress in this area because it means users don't need to
> make a choice, they can benefit from the feature without sacrificing
> security.
>
Well, that is really beyond the scope of the reviewing of this
particular QEMU patch. But as a Kata developer, I can answer it
anyway.

For one thing, Kata already has quite a few configuration options that
let users choose different features. For another thing, Kata already
ships with KSM support by default and VM templating in Kata is better
off than KSM in many aspects (e.g., by providing similar level of
memory conservation w/o affecting host and guest performance). So from
Kata containers point of view, it makes sense to have VM templating
support and let users decide which one they want to use.

PS: CCing kata-dev since the discussion starts to concern about Kata
specific usage.

Cheers,
Tao
