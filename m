Received: from eggs.gnu.org ([2001:4830:134:3::10]:52985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGMKi-0006bG-08
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGMKe-0000Gy-RQ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:23:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dGMKe-0000Ge-J3
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:23:52 -0400
References: <20170601085604.12980-1-roman.penyaev@profitbricks.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5207d1d7-51f4-592f-4f91-faf6ba84ea3b@redhat.com>
Date: Thu, 1 Jun 2017 11:23:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170601085604.12980-1-roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] i386/kvm: do not zero out segment
 flags if segment is unusable or not present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Mikhail Sennikovskii <mikhail.sennikovskii@profitbricks.com>, =?UTF-8?B?UmRkYWRpbSBLcsSNbcOhxZk=?= <rkrcmar@redhat.com>, Michael Chapman <mike@very.puzzling.org>, qemu-devel@nongnu.org



On 01/06/2017 10:56, Roman Pen wrote:
> This is a fix for the problem [1], where VMCB.CPL was set to 0 and inte=
rrupt
> was taken on userspace stack.  The root cause lies in the specific AMD =
CPU
> behaviour which manifests itself as unusable segment attributes on SYSR=
ET[2].
>=20
> Here in this patch flags are not touched even segment is unusable or is=
 not
> present, therefore CPL (which is stored in DPL field) should not be los=
t and
> will be successfully restored on kvm/svm kernel side.
>=20
> Also current patch should not break desired behavior described in this =
commit:
>=20
> 4cae9c97967a ("target-i386: kvm: clear unusable segments' flags in migr=
ation")
>=20
> since present bit will be dropped if segment is unusable or is not pres=
ent.
>=20
> This is the second part of the whole fix of the corresponding problem [=
1],
> first part is related to kvm/svm kernel side and does exactly the same:
> segment attributes are not zeroed out.
>=20
> [1] Message id: CAJrWOzD6Xq=3D=3Db-zYCDdFLgSRMPM-NkNuTSDFEtX=3D7MreT45i=
7Q@mail.gmail.com
> [2] Message id: 5d120f358612d73fc909f5bfa47e7bd082db0af0.1429841474.git=
.luto@kernel.org
>=20
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Signed-off-by: Mikhail Sennikovskii <mikhail.sennikovskii@profitbricks.=
com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Rddadim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Michael Chapman <mike@very.puzzling.org>
> Cc: qemu-devel@nongnu.org
> ---
>  target/i386/kvm.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

Queued, thanks.

Paolo

> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 011d4a55b136..faee904d9d59 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1300,18 +1300,14 @@ static void get_seg(SegmentCache *lhs, const st=
ruct kvm_segment *rhs)
>      lhs->selector =3D rhs->selector;
>      lhs->base =3D rhs->base;
>      lhs->limit =3D rhs->limit;
> -    if (rhs->unusable) {
> -        lhs->flags =3D 0;
> -    } else {
> -        lhs->flags =3D (rhs->type << DESC_TYPE_SHIFT) |
> -                     (rhs->present * DESC_P_MASK) |
> -                     (rhs->dpl << DESC_DPL_SHIFT) |
> -                     (rhs->db << DESC_B_SHIFT) |
> -                     (rhs->s * DESC_S_MASK) |
> -                     (rhs->l << DESC_L_SHIFT) |
> -                     (rhs->g * DESC_G_MASK) |
> -                     (rhs->avl * DESC_AVL_MASK);
> -    }
> +    lhs->flags =3D (rhs->type << DESC_TYPE_SHIFT) |
> +                 ((rhs->present && !rhs->unusable) * DESC_P_MASK) |
> +                 (rhs->dpl << DESC_DPL_SHIFT) |
> +                 (rhs->db << DESC_B_SHIFT) |
> +                 (rhs->s * DESC_S_MASK) |
> +                 (rhs->l << DESC_L_SHIFT) |
> +                 (rhs->g * DESC_G_MASK) |
> +                 (rhs->avl * DESC_AVL_MASK);
>  }
> =20
>  static void kvm_getput_reg(__u64 *kvm_reg, target_ulong *qemu_reg, int=
 set)
>=20
