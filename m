Received: from eggs.gnu.org ([2001:4830:134:3::10]:59851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0piK-0001u6-8V
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0piF-0003k5-Va
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:08:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0piF-0003jg-Nh
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:08:51 -0400
References: <CF1FBDB7-62D3-4743-8FE8-0F0CB78938C6@oracle.com>
	<3122370e-7f41-5aed-b26e-2aba32ce3889@redhat.com>
	<B8ABB04A-A6F5-4409-8E05-9E8D7CE124F5@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e15704bf-cd9f-30d6-7371-4adc546b0d96@redhat.com>
Date: Fri, 14 Sep 2018 17:08:46 +0200
MIME-Version: 1.0
In-Reply-To: <B8ABB04A-A6F5-4409-8E05-9E8D7CE124F5@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, kvm list <kvm@vger.kernel.org>, Jim Mattson <jmattson@google.com>, Idan Brown <idan.brown@oracle.com>

On 14/09/2018 16:31, Liran Alon wrote:
>> There is still a problem, however, in that the same input stream would
>> be parsed differently depending on the kernel version.  In particular,
>> if in the future the maximum nested state size grows, you break all
>> existing save files.
>=20
> I=E2=80=99m not sure I agree with this.
> 1) Newer kernels should change struct only by utilizing unused fields i=
n current struct
> or enlarging it with extra fields. It should not change the meaning of =
existing fields.

Newer kernels will return a larger size, which is stored in
env->nested_state_len, and the file format depends on it:

> +        VMSTATE_VBUFFER_UINT32(env.nested_state, X86CPU,=20
> +                               0, NULL,=20
> +                               env.nested_state_len),=20

>>
>> By defining more HF flags.  I'd rather avoid having multiple ways to
>> store the same thing, in case for example in the future HVF implements
>> nested virt.
>=20
> I agree it is possible to define more hflags and to translate kvm_neste=
d_flags->flags to flags in hflags and vice-versa.
> However, I am not sure I understand the extra value provided by doing s=
o.
> I think it makes more sense to rename struct kvm_nested_state to struct=
 nested_state and
> use this as a generic interface to get/set nested_state for all hypervi=
sors.
> If a given hypervisor, such as HVF, needs to store different blob than =
KVM VMX, it can just add another struct field to
> the union-part of struct kvm_nested_state.
> This way, the code that handles the save/restore of nested_state can re=
main generic for all hypervisors.

I agree that the value is small, but it's there.  For example, the
debugging commands support AMD nested paging, and sharing the flags
means that it works for KVM too, not just TCG.  So I'd prefer to do it
the same way for Intel too.

Paolo
