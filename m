Received: from eggs.gnu.org ([209.51.188.92]:49641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk2a5-0006c9-Pp
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk2a3-0003UN-Tg
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:59:17 -0500
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:33920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gk2a3-0003Mj-M7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:59:15 -0500
Received: from player698.ha.ovh.net (unknown [10.109.159.222])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id DA1983ADFD
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 08:59:06 +0100 (CET)
Date: Thu, 17 Jan 2019 08:58:54 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190117085854.76229ec2@bahia.lan>
In-Reply-To: <0a108f6c-8c9b-1b1e-463d-c3af171c2f19@redhat.com>
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-3-git-send-email-thuth@redhat.com>
	<7d949380-e8e5-c5bd-1fd4-e87f3106e7f2@kaod.org>
	<186ccbfa-0797-25bb-453c-74c9ace0e4d5@redhat.com>
	<35b8b6d4-953a-d5ef-ceb5-5fa4a93c6c0e@kaod.org>
	<0a108f6c-8c9b-1b1e-463d-c3af171c2f19@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 2/3] ppc: Fix duplicated
 typedefs to be able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, "Daniel P.
	=?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 17 Jan 2019 08:01:25 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 2019-01-16 14:29, C=C3=A9dric Le Goater wrote:
> > On 1/16/19 12:47 PM, Thomas Huth wrote: =20
> >> On 2019-01-16 12:43, C=C3=A9dric Le Goater wrote: =20
> >>> On 1/11/19 9:17 AM, Thomas Huth wrote: =20
> >>>> When compiling the ppc code with clang and -std=3Dgnu99, there are a
> >>>> couple of warnings/errors like this one:
> >>>>
> >>>>   CC      ppc64-softmmu/hw/intc/xics.o
> >>>> In file included from hw/intc/xics.c:35:
> >>>> include/hw/ppc/xics.h:43:25: error: redefinition of typedef 'ICPStat=
e' is a C11 feature
> >>>>       [-Werror,-Wtypedef-redefinition]
> >>>> typedef struct ICPState ICPState;
> >>>>                         ^
> >>>> target/ppc/cpu.h:1181:25: note: previous definition is here
> >>>> typedef struct ICPState ICPState;
> >>>>                         ^
> >>>> Work around the problems by including the proper headers instead. =20
> >>>
> >>> Thomas,
> >>>
> >>>
> >>> After a closer look, I think we should use 'void *' under PowerPCCPU=
=20
> >>> as it was the case before I introduced the second interrupt presenter=
. =20
> >>
> >> If you don't like the #includes, why not simply do anonymous struct
> >> forward declarations here? I think that would be better than "void *".=
 =20
> >=20
> > yes.
> >   =20
> >>> That's a bigger change reverting bits of already merged patches. I can
> >>> take care of it if you prefer.  =20
> >>
> >> Could I keep the current patch in my series so that I can get the
> >> patches finally merged? You could then do any clean up that you like on
> >> top of it, ok? =20
> >=20
> > OK.=20
> >=20
> > See below the patch I would propose. Compiled tested with clang -std=3D=
gnu99. =20
> [...]
> > @@ -1204,8 +1199,8 @@ struct PowerPCCPU {
> >      int32_t node_id; /* NUMA node this CPU belongs to */
> >      PPCHash64Options *hash64_opts;
> >  #ifndef CONFIG_USER_ONLY
> > -    ICPState *icp;
> > -    XiveTCTX *tctx;
> > +    struct ICPState *icp;
> > +    struct XiveTCTX *tctx;
> >  #endif =20
>=20
> That's pretty much what I had in an earlier version of my patch:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01810.html
>=20
> But Greg did not like it:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01893.html
>=20

Yeah I didn't but the #includes bring even more troubles so I won't object
if we go for struct :) For the long term, I still think that icp and tctx
should be hidden behind void *machine_data in a per-machine struct.

>  Thomas
