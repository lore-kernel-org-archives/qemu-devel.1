Received: from eggs.gnu.org ([2001:4830:134:3::10]:58837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7dzF-0005BA-GZ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7dz9-0005Aa-V2
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:02:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7dz9-0005A0-4Z
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:02:27 -0400
References: <20181002212921.30982-1-cota@braap.org>
	<20181002212921.30982-3-cota@braap.org> <87h8i3l75j.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a01a9547-d182-daaf-724a-5a836dd9ff02@redhat.com>
Date: Wed, 3 Oct 2018 12:02:19 +0200
MIME-Version: 1.0
In-Reply-To: <87h8i3l75j.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] cputlb: serialize tlb updates with
 env->tlb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 03/10/2018 11:19, Alex Benn=C3=A9e wrote:
>> Fix it by using tlb_lock, a per-vCPU lock. All updaters of tlb_table
>> and the corresponding victim cache now hold the lock.
>> The readers that do not hold tlb_lock must use atomic reads when
>> reading .addr_write, since this field can be updated by other threads;
>> the conversion to atomic reads is done in the next patch.
> What about the inline TLB lookup code? The original purpose of the
> cmpxchg was to ensure the inline code would either see a valid entry or
> and invalid one, not a potentially torn read.
>=20

atomic_set also ensures that there are no torn reads.  However, here:

static void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
{
#if TCG_OVERSIZED_GUEST
    *d =3D *s;
#else
    if (atomic_set) {
        d->addr_read =3D s->addr_read;
        d->addr_code =3D s->addr_code;
        atomic_set(&d->addend, atomic_read(&s->addend));
        /* Pairs with flag setting in tlb_reset_dirty_range */
        atomic_mb_set(&d->addr_write, atomic_read(&s->addr_write));
    } else {
        d->addr_read =3D s->addr_read;
        d->addr_write =3D atomic_read(&s->addr_write);
        d->addr_code =3D s->addr_code;
        d->addend =3D atomic_read(&s->addend);
    }
#endif
}

it's probably best to do all atomic_set instead of just the memberwise co=
py.

Paolo
