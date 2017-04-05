Received: from eggs.gnu.org ([2001:4830:134:3::10]:45050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cvkPf-0007VG-GJ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cvkPb-0004lu-Jb
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:51:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cvkPb-0004jY-DM
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:51:47 -0400
Date: Wed, 5 Apr 2017 14:51:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170405145142.0a417119@nial.brq.redhat.com>
In-Reply-To: <87h9294yba.fsf@linaro.org>
References: <20170330164657.50c75e8c@nial.brq.redhat.com>
	<87k2764xex.fsf@linaro.org>
	<20170331102125.52405cd2@nial.brq.redhat.com>
	<87h9294yba.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-2.9 crashes in tcg_handle_interrupt() during
 winx64 boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>, KONRAD Frederic <fred.konrad@greensocs.com>, Richard Henderson <rth@twiddle.net>

On Fri, 31 Mar 2017 09:58:49 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
>=20
> > On Thu, 30 Mar 2017 16:05:58 +0100
> > Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> > =20
> >> Igor Mammedov <imammedo@redhat.com> writes:
> >> =20
> >> > (PS: resend due to wrong qemu-devel mail list address in original
> >> > email) =20
> >>
> >> Le *sigh* another way of x86 generating IRQs ;-)
> >>
> >> Could you test this please?
> >>
> >> target/i386/misc_helper: wrap BQL around another IRQ generator
> >>
> >> Anything that calls into HW emulation must be protected by the BQL.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org> =20
> > it doesn't help,
> > it asserts in the same place anyway =20
>=20
> That's weird. If the lock was already held I could see it failing higher
> up but this seems to imply we are dropping a lock as we descend into
> hardware emulation.
I'm sorry,
when testing it I've misplaced locking into helper_read_crN(),
left write path untouched and went hunting for weird behavior.

Anyway,
I've tested you patch again and windows guest boots fine with it.

> How often does this leg of the helper get called?
>=20
> > =20
> >>
> >> 1 file changed, 2 insertions(+)
> >> target/i386/misc_helper.c | 2 ++
> >>
> >> modified   target/i386/misc_helper.c
> >> @@ -156,7 +156,9 @@ void helper_write_crN(CPUX86State *env, int reg, t=
arget_ulong t0)
> >>          break;
> >>      case 8:
> >>          if (!(env->hflags2 & HF2_VINTR_MASK)) {
> >> +            qemu_mutex_lock_iothread();
> >>              cpu_set_apic_tpr(x86_env_get_cpu(env)->apic_state, t0);
> >> +            qemu_mutex_unlock_iothread();
> >>          }
> >>          env->v_tpr =3D t0 & 0x0f;
> >>          break;
> >> --
> >> Alex Benn=C3=A9e
> >> =20
>=20
>=20
> --
> Alex Benn=C3=A9e
