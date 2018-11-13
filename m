Received: from eggs.gnu.org ([2001:4830:134:3::10]:57515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1gMMFW-00012B-9P
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 19:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jmattson@google.com>) id 1gMMFU-0006ys-KL
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 19:08:10 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jmattson@google.com>) id 1gMMFU-0006cP-0O
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 19:08:08 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so9405394otk.8
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 16:07:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <04AB82C1-F0AC-4BDB-A132-D39A49EA0A9A@oracle.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<20181102165409.GF21191@redhat.com>
	<f58da4e8-aa40-2659-8db6-42c2b47f5b2f@redhat.com>
	<20181112161829.GU3602@redhat.com> <20181112165053.GF2293@work-vm>
	<20181112165437.GW3602@redhat.com>
	<04AB82C1-F0AC-4BDB-A132-D39A49EA0A9A@oracle.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 12 Nov 2018 16:07:33 -0800
Message-ID: <CALMp9eQEJfh=yiwmiUGawPKu1kSwLbLadHh0a=X+4p1Q6vAtHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm list <kvm@vger.kernel.org>, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On Mon, Nov 12, 2018 at 4:00 PM, Liran Alon <liran.alon@oracle.com> wrote:
>
>
>> On 12 Nov 2018, at 18:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>>
>> On Mon, Nov 12, 2018 at 04:50:54PM +0000, Dr. David Alan Gilbert wrote:
>>> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>>>> On Sun, Nov 04, 2018 at 11:19:57PM +0100, Paolo Bonzini wrote:
>>>>> On 02/11/2018 17:54, Daniel P. Berrang=C3=A9 wrote:
>>>>>> We have usually followed a rule that new machine types must not
>>>>>> affect runability of a VM on a host. IOW new machine types should
>>>>>> not introduce dependancies on specific kernels, or hardware features
>>>>>> such as CPU flags.
>>>>>
>>>>>> Anything that requires a new kernel feature thus ought to be an
>>>>>> opt-in config tunable on the CLI, separate from machine type
>>>>>> choice.
>>>>>
>>>>> Unless someone tinkered with the module parameters, they could not ev=
en
>>>>> use nested virtualization before 4.20.  So for everyone else, "-cpu
>>>>> ...,+vmx" does count as an "opt-in config tunable on the CLI" that
>>>>> requires 4.20.
>>>>>
>>>>> For those that did tinker with module parameters, we can grandfather =
in
>>>>> the old machine types, so that they can use nested virtualization wit=
h
>>>>> no live migration support.  For those that did not, however, I don't
>>>>> think it makes sense to say "oh by the way I really want to be able t=
o
>>>>> migrate this VM" on the command line, or even worse on the monitor.
>>>>
>>>> IIUC, 4.20 is only required from POV of migration state. Is it thus
>>>> possible to just register a migration blocker if QEMU is launched
>>>> on a host with kernel < 4.20.
>>>>
>>>> Migration has always been busted historically, so those people using
>>>> nested VMX already won't be hurt by not having ability to live migrate
>>>> their VM, but could otherwise continue using them without being forced
>>>> to upgrade their kernel to fix a feature they're not even using.
>>>
>>> Yes, although I am a bit worried we might have a population of users
>>> that:
>>>   a) Have enabled nesting
>>>   b) Run VMs with vmx enabled
>>
>>
>>>   c) Don't normally actually run nested guests
>>>   d) Currently happily migrate.
>>
>> True, and (b) would include anyone using libvirt's  host-model CPU. So i=
f
>> you enabled nesting, have host-model for all guests, but only use nestin=
g
>> in one of the guests, you'd be doomed.
>>
>> Is it possible for QEMU to determine if there are nested guests running =
or
>> not and conditionally block migration appropriately to ensure safety ?
>
>
> Only if kernel supports KVM_CAP_NESTED_STATE.
> See my reply to Dave in this thread.

You could still allow migration if CR4.VMXE is clear.
