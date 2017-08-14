Received: from eggs.gnu.org ([2001:4830:134:3::10]:48829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhAOR-0001av-Di
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhAOO-0004Bk-8a
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dhAON-0004AG-Vy
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:06:32 -0400
Date: Mon, 14 Aug 2017 10:00:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170814100036.28160651@nial.brq.redhat.com>
In-Reply-To: <20170717172322.54bd6888@nial.brq.redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-15-git-send-email-imammedo@redhat.com>
	<5bec6275-8e15-16c7-8d23-2975a563c78f@twiddle.net>
	<20170717124146.5ae39d2b@nial.brq.redhat.com>
	<f32dbe33-4a99-cf79-e41c-4a1accacda64@suse.de>
	<20170717172322.54bd6888@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/28] m68k: replace cpu_m68k_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, 17 Jul 2017 17:23:22 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 17 Jul 2017 17:05:15 +0200
> Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>=20
> > Am 17.07.2017 um 12:41 schrieb Igor Mammedov: =20
> > > On Sat, 15 Jul 2017 08:08:58 -1000
> > > Richard Henderson <rth@twiddle.net> wrote:
> > >    =20
> > >> On 07/14/2017 03:52 AM, Igor Mammedov wrote:   =20
> > >>> @@ -230,6 +230,8 @@ static void m68k_cpu_realizefn(DeviceState *dev=
, Error **errp)
> > >>>       M68kCPUClass *mcc =3D M68K_CPU_GET_CLASS(dev);
> > >>>       Error *local_err =3D NULL;
> > >>>  =20
> > >>> +    register_m68k_insns(&cpu->env);
> > >>> +     =20
> > >>
> > >> I think it would make more sense to do this during m68k_tcg_init.
> > >>   =20
> > > it seems that m68k_cpu_initfn accesses 'env' via some global,
> > > while cpu_mk68k_init() used to access concrete pointer of just create=
d cpu,
> > >=20
> > > how about moving register_m68k_insns() to m68k_cpu_initfn(), instead?
> > > it should be equivalent to what cpu_mk68k_init() used to do.   =20
> >=20
> > As a general note, realize should be re-entrant. Can't tell from the
> > above diff whether that is the case here. =20
> Looking at
>=20
> void register_m68k_insns (CPUM68KState *env)                             =
       =20
> {                                                                        =
       =20
>     /* Build the opcode table only once to avoid                         =
       =20
>        multithreading issues. */                                         =
       =20
>     if (opcode_table[0] !=3D NULL) {                                     =
         =20
>         return;                                                          =
       =20
>     }
>=20
> it is save to use multiple times,
>=20
> also looking further in it:
>=20
> #define BASE(name, opcode, mask) \                                       =
       =20
>     register_opcode(disas_##name, 0x##opcode, 0x##mask)                  =
       =20
> #define INSN(name, opcode, mask, feature) do { \                         =
       =20
>     if (m68k_feature(env, M68K_FEATURE_##feature)) \                     =
       =20
>         BASE(name, opcode, mask); \                                      =
       =20
>     } while(0)                                                           =
       =20
>     BASE(undef,     0000, 0000);                                         =
       =20
>     INSN(arith_im,  0080, fff8, CF_ISA_A);
>=20
> INSN macro depends on enabled features, it might work with current code t=
hat
> has no user settable features but it will break once that is available.
>=20
> So I retract my suggestion to move register_m68k_insns() into m68k_cpu_in=
itfn()
> and keep it as it's in this patch (in m68k_cpu_realizefn()),
> that way features theoretically set between initfn(and m68k_tcg_init) and=
 realize() will
> have effect on created cpu and we won't have to fix it in future.

Richard, Laurent,

Do you agree with keeping register_m68k_insns() in realize()?
