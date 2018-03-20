Received: from eggs.gnu.org ([2001:4830:134:3::10]:45086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eyO8U-0004Sr-KK
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eyO8T-0005Ao-Jx
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:45:34 -0400
Date: Tue, 20 Mar 2018 16:45:23 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180320204523.GE24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-9-git-send-email-alindsay@codeaurora.org>
	<9c99641e-af00-e229-02a1-7d396b5132d1@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9c99641e-af00-e229-02a1-7d396b5132d1@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 08/22] target/arm: Support
 multiple EL change hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On Mar 18 23:41, Philippe Mathieu-Daud=E9 wrote:
> On 03/16/2018 09:31 PM, Aaron Lindsay wrote:
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/cpu.c       | 15 ++++++++++-----
> >  target/arm/cpu.h       | 23 ++++++++++++-----------
> >  target/arm/internals.h |  7 ++++---
> >  3 files changed, 26 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 072cbbf..5f782bf 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -55,13 +55,16 @@ static bool arm_cpu_has_work(CPUState *cs)
> >           | CPU_INTERRUPT_EXITTB);
> >  }
> > =20
> > -void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHook *hook,
> > +void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hoo=
k,
> >                                   void *opaque)
> >  {
> > -    /* We currently only support registering a single hook function =
*/
> > -    assert(!cpu->el_change_hook);
> > -    cpu->el_change_hook =3D hook;
> > -    cpu->el_change_hook_opaque =3D opaque;
> > +    ARMELChangeHook *entry;
> > +    entry =3D g_malloc0(sizeof (*entry));
>=20
> imho g_malloc() is enough.

It seems like the only difference is between initializing it to zero
(g_malloc0) and making it as uninitialized (g_malloc) for coverity. Are
there coding standards for when we should choose which?

>=20
> > +
> > +    entry->hook =3D hook;
> > +    entry->opaque =3D opaque;
> > +
> > +    QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
> >  }
> > =20
> >  static void cp_reg_reset(gpointer key, gpointer value, gpointer opaq=
ue)
> > @@ -744,6 +747,8 @@ static void arm_cpu_realizefn(DeviceState *dev, E=
rror **errp)
> >          return;
> >      }
> > =20
> > +    QLIST_INIT(&cpu->el_change_hooks);
> > +
>=20
> You missed to fill arm_cpu_unrealizefn() with:
>=20
>     QLIST_FOREACH(...) {
>         QLIST_REMOVE(...);
>         g_free(...);
>     }

Do you mean arm_cpu_finalizefn()?

-Aaron

--=20
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies=
, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
