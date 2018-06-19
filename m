Received: from eggs.gnu.org ([2001:4830:134:3::10]:50898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVG2y-0001bq-8r
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVG2v-0002jz-5E
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:47:44 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:56539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVG2u-0002ji-V1
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:47:41 -0400
Received: from player693.ha.ovh.net (unknown [10.109.105.16])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 4E250D2D5D
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 14:47:39 +0200 (CEST)
References: <20180619085631.2859-1-aik@ozlabs.ru>
	<87sh5jvw3r.fsf@dusky.pond.sub.org> <20180619144138.4ccbe186@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1eba481f-f824-08ef-3cdc-3502c594c0bb@kaod.org>
Date: Tue, 19 Jun 2018 14:47:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180619144138.4ccbe186@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] xics-kvm: Fix compile
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/19/2018 02:41 PM, Greg Kurz wrote:
> On Tue, 19 Jun 2018 13:44:56 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>=20
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>
>>> This fixes uninitialized variable warning:
>>>
>>> /home/aik/p/qemu/hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm=
_state=E2=80=99:
>>> /home/aik/p/qemu/hw/intc/xics_kvm.c:281:20: warning: =E2=80=98ret=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>              return ret;
>>>                     ^~~
>>>
>>> Discovered with gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0 from Ubuntu 18.04.
>>>
>>> Fixes: bf358b541b8 "xics_kvm: use KVM helpers"
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>  hw/intc/xics_kvm.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
>>> index 8bdf6af..48efbce 100644
>>> --- a/hw/intc/xics_kvm.c
>>> +++ b/hw/intc/xics_kvm.c
>>> @@ -273,8 +273,8 @@ static int ics_set_kvm_state(ICSState *ics, int v=
ersion_id)
>>>                  state |=3D KVM_XICS_QUEUED;
>>>          }
>>> =20
>>> -        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>>> -                          i + ics->offset, &state, true, &local_err)=
;
>>> +        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_S=
OURCES,
>>> +                                i + ics->offset, &state, true, &loca=
l_err);
>>>          if (local_err) {
>>>              error_report("Unable to restore KVM interrupt controller=
 state"
>>>                      " for IRQs %d: %s", i + ics->offset, strerror(er=
rno)); =20
>>                return ret;
>>            }
>>
>> Unless all callers effectively ignore the return value, this fixes a
>> bug, not just a compiler warning.  Recommend to check callers to find
>> the bug's impact, and document it in your commit message.
>>
>=20
> This function has two users:
> 1) ics_kvm_reset() which ignores it's return value (ie, not impacted)
> 2) ics_simple_dispatch_post_load() which propagates the return value to
>   vmstate_load_state()
>=20
> If ret is < 0, migration will fail as expected, possibly with an
> 'Unknow error' message.
>=20
> If ret >=3D 0, it will creep up to:
>=20
> static int
> qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis=
)
> {
> [...]
>     ret =3D vmstate_load(f, se);
>     if (ret < 0) {
>         error_report("error while loading state for instance 0x%x of"
>                      " device '%s'", instance_id, idstr);
>         return ret;
>     }
>     if (!check_section_footer(f, se)) {
>         return -EINVAL;
>     }
>=20
>     return 0;
> }
>=20
> and migration would likely succeed but leave the guest in an undefined
> state.
>=20
>> Messed up in commit bf358b541b8.  Would be nice to mention that in you=
r
>> commit message.
>>
>> Also messed up there: leaks local_err.  Please fix that, too.
>>
>=20
> Both the missing 'ret =3D' and local_err leak are addressed by:
>=20
> https://lists.nongnu.org/archive/html/qemu-ppc/2018-06/msg00682.html
>=20
> It doesn't mention the offending commit though...
=20
It's available on master now.=20

C.
