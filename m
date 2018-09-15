Received: from eggs.gnu.org ([2001:4830:134:3::10]:46849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g1HUh-0003Yi-UV
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 16:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g1HUe-0002E8-P9
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 16:48:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1g1HUe-000294-Ge
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 16:48:40 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <e15704bf-cd9f-30d6-7371-4adc546b0d96@redhat.com>
Date: Sat, 15 Sep 2018 23:48:19 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F9299DE-58CA-4CC9-8779-2FE2C4B7C2CE@oracle.com>
References: <CF1FBDB7-62D3-4743-8FE8-0F0CB78938C6@oracle.com>
	<3122370e-7f41-5aed-b26e-2aba32ce3889@redhat.com>
	<B8ABB04A-A6F5-4409-8E05-9E8D7CE124F5@oracle.com>
	<e15704bf-cd9f-30d6-7371-4adc546b0d96@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] KVM: i386: Add support for save and
 restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, kvm list <kvm@vger.kernel.org>, Jim Mattson <jmattson@google.com>, Idan Brown <idan.brown@oracle.com>



> On 14 Sep 2018, at 18:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 14/09/2018 16:31, Liran Alon wrote:
>>> There is still a problem, however, in that the same input stream =
would
>>> be parsed differently depending on the kernel version.  In =
particular,
>>> if in the future the maximum nested state size grows, you break all
>>> existing save files.
>>=20
>> I=E2=80=99m not sure I agree with this.
>> 1) Newer kernels should change struct only by utilizing unused fields =
in current struct
>> or enlarging it with extra fields. It should not change the meaning =
of existing fields.
>=20
> Newer kernels will return a larger size, which is stored in
> env->nested_state_len, and the file format depends on it:
>=20
>> +        VMSTATE_VBUFFER_UINT32(env.nested_state, X86CPU,=20
>> +                               0, NULL,=20
>> +                               env.nested_state_len),=20
>=20

Oh. I thought that QEMU will just receive to dest buffer only what was =
sent from source buffer.
I didn=E2=80=99t know that it also enforces that the sizes of the source =
and dest buffer are equal.
(I thought that dest_buffer_size only needed to be >=3D =
src_buffer_size).

Anyway, my intention here was that QEMU will only enforce =
(dest_buffer_size >=3D source_buffer_size)
and if so, receive source buffer into destination buffer.
Is there a simple way to do this in QEMU=E2=80=99s VMSTATE framework =
without implementing custom save/load callbacks?

>>>=20
>>> By defining more HF flags.  I'd rather avoid having multiple ways to
>>> store the same thing, in case for example in the future HVF =
implements
>>> nested virt.
>>=20
>> I agree it is possible to define more hflags and to translate =
kvm_nested_flags->flags to flags in hflags and vice-versa.
>> However, I am not sure I understand the extra value provided by doing =
so.
>> I think it makes more sense to rename struct kvm_nested_state to =
struct nested_state and
>> use this as a generic interface to get/set nested_state for all =
hypervisors.
>> If a given hypervisor, such as HVF, needs to store different blob =
than KVM VMX, it can just add another struct field to
>> the union-part of struct kvm_nested_state.
>> This way, the code that handles the save/restore of nested_state can =
remain generic for all hypervisors.
>=20
> I agree that the value is small, but it's there.  For example, the
> debugging commands support AMD nested paging, and sharing the flags
> means that it works for KVM too, not just TCG.  So I'd prefer to do it
> the same way for Intel too.

Can you explain this example? I=E2=80=99m not sure I follow.
In the solution I proposed above, the nested_state fixed-size header is =
also shared between hypervisors.
Thus, flags here are shared exactly the same as hflags are shared.
Only the blob union-part is not necessarely shared between hypervisors =
(Which makes sense as it may differ).=20
Am I missing something trivial?

-Liran

>=20
> Paolo
