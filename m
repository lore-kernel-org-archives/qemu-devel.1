Received: from eggs.gnu.org ([2001:4830:134:3::10]:49861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ctroL-00034S-7q
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ctroI-0003Up-1v
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:21:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ctroH-0003Tz-Sk
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:21:29 -0400
Date: Fri, 31 Mar 2017 10:21:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170331102125.52405cd2@nial.brq.redhat.com>
In-Reply-To: <87k2764xex.fsf@linaro.org>
References: <20170330164657.50c75e8c@nial.brq.redhat.com>
	<87k2764xex.fsf@linaro.org>
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

On Thu, 30 Mar 2017 16:05:58 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
>=20
> > (PS: resend due to wrong qemu-devel mail list address in original
> > email) =20
>=20
> Le *sigh* another way of x86 generating IRQs ;-)
>=20
> Could you test this please?
>=20
> target/i386/misc_helper: wrap BQL around another IRQ generator
>=20
> Anything that calls into HW emulation must be protected by the BQL.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
it doesn't help,
it asserts in the same place anyway

>=20
> 1 file changed, 2 insertions(+)
> target/i386/misc_helper.c | 2 ++
>=20
> modified   target/i386/misc_helper.c
> @@ -156,7 +156,9 @@ void helper_write_crN(CPUX86State *env, int reg, targ=
et_ulong t0)
>          break;
>      case 8:
>          if (!(env->hflags2 & HF2_VINTR_MASK)) {
> +            qemu_mutex_lock_iothread();
>              cpu_set_apic_tpr(x86_env_get_cpu(env)->apic_state, t0);
> +            qemu_mutex_unlock_iothread();
>          }
>          env->v_tpr =3D t0 & 0x0f;
>          break;
> --
> Alex Benn=C3=A9e
>=20
