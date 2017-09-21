Received: from eggs.gnu.org ([2001:4830:134:3::10]:60462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1duw82-0004TA-Vt
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1duw7z-00049r-SV
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:42:35 -0400
Date: Thu, 21 Sep 2017 09:42:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170921094226.0e4c4ac6@nial.brq.redhat.com>
In-Reply-To: <a59b2c71-fe1d-1ef6-e885-703c3f33893c@kaod.org>
References: <20170915085115.GN5250@umbus.fritz.box>
	<87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170919082421.GU27153@umbus>
	<871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a59b2c71-fe1d-1ef6-e885-703c3f33893c@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On Thu, 21 Sep 2017 08:04:55 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 09/21/2017 05:54 AM, Nikunj A Dadhania wrote:
> > David Gibson <david@gibson.dropbear.id.au> writes:
> >  =20
> >> On Wed, Sep 20, 2017 at 12:48:55PM +0530, Nikunj A Dadhania wrote: =20
> >>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>> =20
> >>>> On Wed, Sep 20, 2017 at 12:10:48PM +0530, Nikunj A Dadhania wrote: =
=20
> >>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>> =20
> >>>>>> On Wed, Sep 20, 2017 at 10:43:19AM +0530, Nikunj A Dadhania wrote:=
 =20
> >>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>>>> =20
> >>>>>>>> On Wed, Sep 20, 2017 at 09:50:24AM +0530, Nikunj A Dadhania wrot=
e: =20
> >>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>>>>>> =20
> >>>>>>>>>> On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania wr=
ote: =20
> >>>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>>>>>>>> =20
> >>>>>>>>>>>> On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania =
wrote: =20
> >>>>>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>>>>>>>>>> =20
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I thought, I am doing the same here for PowerNV, number o=
f online cores
> >>>>>>>>>>>>>>> is equal to initial online vcpus / threads per core
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>    int boot_cores_nr =3D smp_cpus / smp_threads;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Only difference that I see in PowerNV is that we have mul=
tiple chips
> >>>>>>>>>>>>>>> (max 2, at the moment)
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>         cores_per_chip =3D smp_cpus / (smp_threads * pnv-=
>num_chips); =20
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> This doesn't make sense to me.  Cores per chip should *alw=
ays* equal
> >>>>>>>>>>>>>> smp_cores, you shouldn't need another calculation for it.
> >>>>>>>>>>>>>> =20
> >>>>>>>>>>>>>>> And in case user has provided sane smp_cores, we use it. =
=20
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> If smp_cores isn't sane, you should simply reject it, not =
try to fix
> >>>>>>>>>>>>>> it.  That's just asking for confusion. =20
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> This is the case where the user does not provide a topology=
(which is a
> >>>>>>>>>>>>> valid scenario), not sure we should reject it. So qemu defa=
ults
> >>>>>>>>>>>>> smp_cores/smt_threads to 1. I think it makes sense to over-=
ride. =20
> >>>>>>>>>>>>
> >>>>>>>>>>>> If you can find a way to override it by altering smp_cores w=
hen it's
> >>>>>>>>>>>> not explicitly specified, then ok. =20
> >>>>>>>>>>>
> >>>>>>>>>>> Should I change the global smp_cores here as well ? =20
> >>>>>>>>>>
> >>>>>>>>>> I'm pretty uneasy with that option. =20
> >>>>>>>>>
> >>>>>>>>> Me too.
> >>>>>>>>> =20
> >>>>>>>>>> It would take a fair bit of checking to ensure that changing s=
mp_cores
> >>>>>>>>>> is safe here. An easier to verify option would be to make the =
generic
> >>>>>>>>>> logic which splits up an unspecified -smp N into cores and soc=
kets
> >>>>>>>>>> more flexible, possibly based on machine options for max value=
s.
> >>>>>>>>>>
> >>>>>>>>>> That might still be more trouble than its worth. =20
> >>>>>>>>>
> >>>>>>>>> I think the current approach is the simplest and less intrusive=
, as we
> >>>>>>>>> are handling a case where user has not bothered to provide a de=
tailed
> >>>>>>>>> topology, the best we can do is create single threaded cores eq=
ual to
> >>>>>>>>> number of cores. =20
> >>>>>>>>
> >>>>>>>> No, sorry.  Having smp_cores not correspond to the number of cor=
es per
> >>>>>>>> chip in all cases is just not ok.  Add an error message if the
> >>>>>>>> topology isn't workable for powernv by all means.  But users hav=
ing to
> >>>>>>>> use a longer command line is better than breaking basic assumpti=
ons
> >>>>>>>> about what numbers reflect what topology. =20
> >>>>>>>
> >>>>>>> Sorry to ask again, as I am still not convinced, we do similar
> >>>>>>> adjustment in spapr where the user did not provide the number of =
cores,
> >>>>>>> but qemu assumes them as single threaded cores and created
> >>>>>>> cores(boot_cores_nr) that were not same as smp_cores ? =20
> >>>>>>
> >>>>>> What?  boot_cores_nr has absolutely nothing to do with adjusting t=
he
> >>>>>> topology, and it certainly doesn't assume they're single threaded.=
 =20
> >>>>>
> >>>>> When we start a TCG guest and user provides following commandline, =
e.g.
> >>>>> "-smp 4", smt_threads is set to 1 by default in vl.c. So the guest =
boots
> >>>>> with 4 cores, each having 1 thread. =20
> >>>>
> >>>> Ok.. and what's the problem with that behaviour on powernv? =20
> >>>
> >>> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has the
> >>> default value of 1 in vl.c. In powernv, we were setting nr-cores like
> >>> this:
> >>>
> >>>         object_property_set_int(chip, smp_cores, "nr-cores", &error_f=
atal);
> >>>
> >>> Even when there were multiple cpus (-smp 4), when the guest boots up,=
 we
> >>> just get one core (i.e. smp_cores was 1) with single thread(smp_threa=
ds
> >>> was 1), which is wrong as per the command-line that was provided. =20
> >>
> >> Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
> >> thread.  If you can't supply 4 sockets you should error, but you
> >> shouldn't go and change the number of cores per socket. =20
> >=20
> > OK, that makes sense now. And I do see that smp_cpus is 4 in the above
> > case. Now looking more into it, i see that powernv has something called
> > "num_chips", isnt this same as sockets ? Do we need num_chips separatel=
y? =20
>=20
> yes that would do for cpus, but how do we retrieve the number of=20
> sockets ? I don't see a smp_sockets.=20
I'd suggest to rewrite QEMU again :)

more exactly, -smp parsing is global and sometimes doesn't suite
target device model/machine.
Idea was to make it's options machine properties to get rid of globals
and then let leaf machine redefine parsing behaviour.
here is Drew's take on it:

[Qemu-devel] [PATCH RFC 00/16] Rework SMP parameters
https://www.mail-archive.com/qemu-devel@nongnu.org/msg376961.html

considering there weren't pressing need, the series has been pushed
to the end of TODO list. Maybe you can revive it and make work for
pnv and other machines.


> If we start looking at such issues, we should also take into account=20
> memory distribution :
>=20
>       -numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]
it's interface based on cpu_index, which internal qemu number for
an 1 cpu execution context.

It would be better if one would use new interface with new machines
 -numa cpu,node-id=3D0,socket-id=3D0 ...

>=20
> would allow us to define a set of cpus per node, cpus should be evenly=20
> distributed on the nodes though, and also define memory per node, but=20
> some nodes could be without memory.  =20
>=20
> C.=20
>=20
