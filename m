Received: from eggs.gnu.org ([2001:4830:134:3::10]:54771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@wiesinger.com>) id 1e8VdR-0004Sh-Az
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 14:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@wiesinger.com>) id 1e8VdL-0002aL-92
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 14:15:04 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:46472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lists@wiesinger.com>) id 1e8VdK-000185-Si
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 14:14:59 -0400
References: <35eda6a9-086e-f899-e131-288f2346effe@wiesinger.com>
	<ce477c53-25bc-e6dd-3e05-c74af1f33c2d@wiesinger.com>
	<3e1f41a8-faff-1858-6f0d-154694dff02d@wiesinger.com>
	<CABgObfYzngJPgS9agXMrRENVD_e+3Hm=y+KD5dp9na8jNwuumw@mail.gmail.com>
	<CABgObfZFwJMpU_D8SMkuiEhb0qBokHL0jpwmuzdE73TReHMFkg@mail.gmail.com>
	<0e69cbad-f658-03be-0191-1b6fe588147b@wiesinger.com>
	<CABgObfaw_bMQ=Dpfs=vh_AweaidqCZSBy4bDtsddk5DSKpRP8A@mail.gmail.com>
	<1b37b04c-349f-28f7-fb6c-fbbbe8415b33@wiesinger.com>
	<7757e373-c892-2824-d710-27ca57d479c4@redhat.com>
	<d5006c6b-c7d3-b002-b608-e4e05ee1f15c@wiesinger.com>
	<c0ca5671-790a-2e9b-b1d8-fecd6802ad79@redhat.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <62d3868d-a2dd-d606-f1f1-1c05174c4b57@wiesinger.com>
Date: Sat, 28 Oct 2017 20:13:38 +0200
MIME-Version: 1.0
In-Reply-To: <c0ca5671-790a-2e9b-b1d8-fecd6802ad79@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] kvm_intel fails to load on Conroe CPUs running
 Linux 4.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, qemu-devel@nongnu.org

On 10.10.2017 16:16, Paolo Bonzini wrote:
> On 27/09/2017 21:31, Gerhard Wiesinger wrote:
>> On 15.09.2017 19:07, Paolo Bonzini wrote:
>>> On 15/09/2017 16:43, Gerhard Wiesinger wrote:
>>>> On 27.08.2017 20:55, Paolo Bonzini wrote:
>>>>> Il 27 ago 2017 4:48 PM, "Gerhard Wiesinger" <lists@wiesinger.com
>>>>> <mailto:lists@wiesinger.com>> ha scritto:
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 On 27.08.2017 14 <tel:27.08.2017%2014>:03=
, Paolo Bonzini wrote:
>>>>>
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 We will revert th=
e patch, but 4.13.0 will not have the fix.
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Expect it in late=
r stable kernels (because vacations).
>>>>>
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Thnx. Why will 4.13.0 NOT have the fix?
>>>>>
>>>>>
>>>>> Because maintainers are on vacation! :-)
>>>>>
>>>>>
>>>> Hello Paolo,
>>>>
>>>> Any update on this for 4.12 and 4.13 kernels?
>>> A late fix is better than a wrong fix.=C2=A0 Hope to get to it next w=
eek!
>> Hello Paolo,
>>
>> Any update? Thnx.
> Hey, I have a patch now.  Any volunteers for testing it?
>
> This is on top of 4.13.
>
> Paolo
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index c6ef2940119b..c29bf36485fd 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -200,6 +200,10 @@ struct loaded_vmcs {
>   	int cpu;
>   	bool launched;
>   	bool nmi_known_unmasked;
> +	/* Support for vnmi-less CPUs */
> +	int soft_vnmi_blocked;
> +	ktime_t entry_time;
> +	s64 vnmi_blocked_time;
>   	struct list_head loaded_vmcss_on_cpu_link;
>   };
>  =20

Hello Paolo,

The patch does not apply, 1st hunk FAILED.
cat arch/x86/kvm/vmx.c.rej
--- arch/x86/kvm/vmx.c
+++ arch/x86/kvm/vmx.c
@@ -200,6 +200,10 @@ struct loaded_vmcs {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cpu;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool launched;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool nmi_known_unmasked;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Support for vnmi-less CPUs */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int soft_vnmi_blocked;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_t entry_time;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s64 vnmi_blocked_time;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head loaded_vmcss=
_on_cpu_link;
 =C2=A0};

Tried it to apply against, doesn't look to fit:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/t=
ree/arch/x86/kvm/vmx.c?h=3Dv4.13.10#n197
https://koji.fedoraproject.org/koji/buildinfo?buildID=3D991441

Will then recompile and test.

Thnx.

Ciao,
Gerhard
