Received: from eggs.gnu.org ([2001:4830:134:3::10]:51191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g1Hsk-0006eE-Ly
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 17:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g1Hdm-000668-QT
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 16:58:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1g1Hdm-00065S-Gn
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 16:58:06 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <6F9299DE-58CA-4CC9-8779-2FE2C4B7C2CE@oracle.com>
Date: Sat, 15 Sep 2018 23:57:52 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <F16E888D-8C0D-4758-A605-040C12CBB05C@oracle.com>
References: <CF1FBDB7-62D3-4743-8FE8-0F0CB78938C6@oracle.com>
	<3122370e-7f41-5aed-b26e-2aba32ce3889@redhat.com>
	<B8ABB04A-A6F5-4409-8E05-9E8D7CE124F5@oracle.com>
	<e15704bf-cd9f-30d6-7371-4adc546b0d96@redhat.com>
	<6F9299DE-58CA-4CC9-8779-2FE2C4B7C2CE@oracle.com>
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



> On 15 Sep 2018, at 23:48, Liran Alon <liran.alon@oracle.com> wrote:
>=20
>=20
>=20
>> On 14 Sep 2018, at 18:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>=20
>> On 14/09/2018 16:31, Liran Alon wrote:
>>>> There is still a problem, however, in that the same input stream =
would
>>>> be parsed differently depending on the kernel version.  In =
particular,
>>>> if in the future the maximum nested state size grows, you break all
>>>> existing save files.
>>>=20
>>> I=E2=80=99m not sure I agree with this.
>>> 1) Newer kernels should change struct only by utilizing unused =
fields in current struct
>>> or enlarging it with extra fields. It should not change the meaning =
of existing fields.
>>=20
>> Newer kernels will return a larger size, which is stored in
>> env->nested_state_len, and the file format depends on it:
>>=20
>>> +        VMSTATE_VBUFFER_UINT32(env.nested_state, X86CPU,=20
>>> +                               0, NULL,=20
>>> +                               env.nested_state_len),=20
>>=20
>=20
> Oh. I thought that QEMU will just receive to dest buffer only what was =
sent from source buffer.
> I didn=E2=80=99t know that it also enforces that the sizes of the =
source and dest buffer are equal.
> (I thought that dest_buffer_size only needed to be >=3D =
src_buffer_size).
>=20
> Anyway, my intention here was that QEMU will only enforce =
(dest_buffer_size >=3D source_buffer_size)
> and if so, receive source buffer into destination buffer.
> Is there a simple way to do this in QEMU=E2=80=99s VMSTATE framework =
without implementing custom save/load callbacks?
>=20

One possible, but not so elegant, way to do so is to put =
env.nested_state_len as part of VMState
and change env.nested_state to be declared in VMState as =
VMSTATE_VBUFFER_ALLOC_UINT32().
Then, make nested_state_post_load() to realloc env.nested_state in size =
specified by kvm_nested_state_length().
To guarantee that env.nested_state is always at max size that local =
kernel supports.

-Liran
