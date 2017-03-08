Received: from eggs.gnu.org ([2001:4830:134:3::10]:33261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cldrp-0000W5-1e
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cldrm-000627-2Z
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:51:09 -0500
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170303145807.GC11509@thinpad.lan.raisama.net>
	<CAFEAcA8VV-UW7M+W=KcN=XycPUS=FmFJmVhd0DpruzaoKEVjuQ@mail.gmail.com>
	<20170308145038.GF4694@thinpad.lan.raisama.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <56f4b053-9104-265f-5aec-67c78ae9d7e0@redhat.com>
Date: Wed, 8 Mar 2017 16:50:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170308145038.GF4694@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've
 registered the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 08.03.2017 15:50, Eduardo Habkost wrote:
> On Wed, Mar 08, 2017 at 03:31:01PM +0100, Peter Maydell wrote:
>> On 3 March 2017 at 15:58, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>> On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
>>>> When running with KVM on POWER, we register some CPU types during
>>>> the initialization function of the ppc64 KVM code (which unfortunately
>>>> also can not be done via a type_init() like it is done on x86).
>>>
>>> Can you elaborate why it can't be done via type_init()? If the
>>> QOM type hierarchy depends on any runtime data unavailable at
>>> type_init(), we should fix that.
>>
>> On ARM we (currently) have the KVM-only 'host' CPU type be
>> added to the type hierarchy only at runtime in kvm_init(),
>> but we deal with the '-help' problem by having arm_cpu_list() do
>>
>> #ifdef CONFIG_KVM
>>     /* The 'host' CPU type is dynamically registered only if KVM is
>>      * enabled, so we have to special-case it here:
>>      */
>>     (*cpu_fprintf)(f, "  host (only available in KVM mode)\n");
>> #endif
>>
> 
> We already have similar code at ppc_cpu_list():
> 
> #ifdef CONFIG_KVM
>     cpu_fprintf(f, "\n");
>     cpu_fprintf(f, "PowerPC %-16s\n", "host");
> #endif
> 
> If I understood it correctly, the current problem is just
> inaccurate alias information being printed because the alias
> table is modified by the accelerator.

Yes.

> My current suggestion is to avoid printing anything that depends
> on the current machine/accelerator at the help output.

I'll have a look at that...

 Thomas
