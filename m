Received: from eggs.gnu.org ([209.51.188.92]:37280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkTiZ-0003sP-9h
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkTiW-0002la-T8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:57:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gkTiT-0002DM-0n
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:57:47 -0500
References: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
	<20190118100159.GA2483@work-vm>
	<8f0f7339-5f47-46d0-20a9-343badad4d0f@redhat.com>
	<20190118101633.GC2146@work-vm> <20190118102102.GH20660@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <328f912c-e332-3bdc-d333-55c4af1a1fa1@redhat.com>
Date: Fri, 18 Jan 2019 13:57:31 +0100
MIME-Version: 1.0
In-Reply-To: <20190118102102.GH20660@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Live migration from Qemu 2.12 hosts to Qemu 3.2
 hosts, with VMX flag enabled in the guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Mark Mielke <mark.mielke@gmail.com>, qemu-devel@nongnu.org, christian.ehrhardt@canonical.com

On 18/01/19 11:21, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jan 18, 2019 at 10:16:34AM +0000, Dr. David Alan Gilbert wrote:
>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>>> On 18/01/19 11:02, Dr. David Alan Gilbert wrote:
>>>>>
>>>>> It fails if the flag is set, rather than if any nested virtualizati=
on has
>>>>> been used before.
>>>>>
>>>>> I'm concerned I will end up with a requirement for *all* guests to =
be
>>>>> restarted in order to migrate them to the new hosts, rather than ju=
st the
>>>>> ones that would have a problem.
>>>> I think you should be able to migrate from 2.12->3.1 like this, but
>>>> you'd hit the problem when you then try and migrate again between yo=
ur
>>>> new QEMUs.
>>>>
>>>> I guess we could modify it to wire it to machine type, so that
>>>> older machine types didn't block.
>>>
>>> That would also be wrong.  The old machine types _could_ be using KVM
>>> and they have no way to block the live migration.
>>>
>>> The solution is to restart the VM using "-cpu host,-vmx".
>>
>> The problem as Christian explained in that thread is that it was commo=
n
>> for them to start VMs with vmx enabled but for people not to use it
>> on most of the VMs, so we break migration for most VMs even though mos=
t
>> don't use it.
>>
>> It might not be robust, but it worked for a lot of people most of the
>> time.

It's not "not robust" (like, it usually works but sometimes fails
mysteriously).  It's entirely broken, you just don't notice that it is
if you're not using the feature.

> Yes, this is exactly why I said we should make the migration blocker
> be conditional on any L2 guest having been started. I vaguely recall
> someone saying there wasn't any way to detect this situation from
> QEMU though ?

You can check that and give a warning (check that CR4.VMXE=3D1 but no
other live migration state was transferred).  However, without live
migration support in the kernel and in QEMU you cannot start VMs *for
the entire future life of the VM* after a live migration.  So even if we
implemented that kind of blocker, it would fail even if no VM has been
started, as long as the kvm_intel module is loaded on migration.  That
would be no different in practice from what we have now.

It might work to unload the kvm_intel module and run live migration with
the CPU configured differently ("-cpu host,-vmx") on the destination.

Paolo
