Received: from eggs.gnu.org ([2001:4830:134:3::10]:48797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyONx-00059U-B7
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 17:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyONw-0007XJ-3k
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 17:01:33 -0400
MIME-Version: 1.0
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-9-git-send-email-alindsay@codeaurora.org>
	<9c99641e-af00-e229-02a1-7d396b5132d1@amsat.org>
	<20180320204523.GE24561@codeaurora.org>
In-Reply-To: <20180320204523.GE24561@codeaurora.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 20 Mar 2018 21:01:14 +0000
Message-ID: <CAAdtpL5L7BNv4VpLQbebjEsMsSO7uiyLPHxziJ=4Vyafh+StPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

Le 20 mars 2018 9:45 PM, "Aaron Lindsay" <alindsay@codeaurora.org> a =C3=A9=
crit :

On Mar 18 23:41, Philippe Mathieu-Daud=C3=A9 wrote:
> On 03/16/2018 09:31 PM, Aaron Lindsay wrote:
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/cpu.c       | 15 ++++++++++-----
> >  target/arm/cpu.h       | 23 ++++++++++++-----------
> >  target/arm/internals.h |  7 ++++---
> >  3 files changed, 26 insertions(+), 19 deletions(-)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 072cbbf..5f782bf 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -55,13 +55,16 @@ static bool arm_cpu_has_work(CPUState *cs)
> >           | CPU_INTERRUPT_EXITTB);
> >  }
> >
> > -void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHook *hook,
> > +void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
> >                                   void *opaque)
> >  {
> > -    /* We currently only support registering a single hook function */
> > -    assert(!cpu->el_change_hook);
> > -    cpu->el_change_hook =3D hook;
> > -    cpu->el_change_hook_opaque =3D opaque;
> > +    ARMELChangeHook *entry;
> > +    entry =3D g_malloc0(sizeof (*entry));
>
> imho g_malloc() is enough.

It seems like the only difference is between initializing it to zero
(g_malloc0) and making it as uninitialized (g_malloc) for coverity. Are
there coding standards for when we should choose which?


Since you initialize all members, bzero is not necessary; until someone add
another member to the structure. So your way is correct and safer, with a
ridiculous performance penalty.



>
> > +
> > +    entry->hook =3D hook;
> > +    entry->opaque =3D opaque;
> > +
> > +    QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
> >  }
> >
> >  static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque=
)
> > @@ -744,6 +747,8 @@ static void arm_cpu_realizefn(DeviceState *dev,
Error **errp)
> >          return;
> >      }
> >
> > +    QLIST_INIT(&cpu->el_change_hooks);
> > +
>
> You missed to fill arm_cpu_unrealizefn() with:
>
>     QLIST_FOREACH(...) {
>         QLIST_REMOVE(...);
>         g_free(...);
>     }

Do you mean arm_cpu_finalizefn()?


Yes :)



-Aaron


--
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies,
Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
