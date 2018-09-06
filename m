Received: from eggs.gnu.org ([2001:4830:134:3::10]:41768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxq9l-0006FK-56
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxq9g-0003KL-S4
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:00:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1fxq9g-0003Jr-Fe
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:00:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A3E87A7E6
	for <qemu-devel@nongnu.org>; Thu,  6 Sep 2018 09:00:48 +0000 (UTC)
Date: Thu, 6 Sep 2018 11:00:41 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180906090041.GI3803@andariel.pipo.sk>
References: <1535630903-146863-1-git-send-email-imammedo@redhat.com>
	<38b3347b-8923-26e9-82a4-f69002262767@redhat.com>
	<20180831100046.3467d1fd@redhat.com>
	<cf8ce5d5-c336-9b45-4960-a36a2e72eaa3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline
In-Reply-To: <cf8ce5d5-c336-9b45-4960-a36a2e72eaa3@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH] qga: ignore non present cpus
 when handling qmp_guest_get_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, libvir-list@redhat.com, Drew Jones <drjones@redhat.com>, qemu-devel@nongnu.org


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 12:19:12 +0200, Laszlo Ersek wrote:
> On 08/31/18 10:00, Igor Mammedov wrote:
> > On Thu, 30 Aug 2018 17:51:13 +0200
> > Laszlo Ersek <lersek@redhat.com> wrote:
> >=20
> >> +Drew
> >>
> >> On 08/30/18 14:08, Igor Mammedov wrote:
> >>> If VM has VCPUs plugged sparselly (for example a VM started with
> >>> 3 VCPUs (cpu0, cpu1 and cpu2) and then cpu1 was hotunplugged so
> >>> only cpu0 and cpu2 are present), QGA will rise a error
> >>>   error: internal error: unable to execute QEMU agent command 'guest-=
get-vcpus':
> >>>   open("/sys/devices/system/cpu/cpu1/"): No such file or directory
> >>> when
> >>>   virsh vcpucount FOO --guest
> >>> is executed.
> >>> Fix it by ignoring non present CPUs when fetching CPUs status from sy=
sfs.
> >>>
> >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>> ---
> >>>  qga/commands-posix.c | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> >>> index 37e8a2d..2929872 100644
> >>> --- a/qga/commands-posix.c
> >>> +++ b/qga/commands-posix.c
> >>> @@ -2044,7 +2044,9 @@ static void transfer_vcpu(GuestLogicalProcessor=
 *vcpu, bool sys2vcpu,
> >>>                                vcpu->logical_id);
> >>>      dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);
> >>>      if (dirfd =3D=3D -1) {
> >>> -        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> >>> +        if (!(sys2vcpu && errno =3D=3D ENOENT)) {
> >>> +            error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> >>> +        }
> >>>      } else {
> >>>          static const char fn[] =3D "online";
> >>>          int fd;
> >>>  =20
> >>
> >> Originally these guest agent commands (both getting and setting) were
> >> meant to be used in the absence of real VCPU hot[un]plug, as a fallback
> >> / place-holder.
> >>
> >> If the latter (=3D real VCPU hot(un)plug) works, then these guest agent
> >> commands shouldn't be used at all.
> > Technically there isn't reasons for "get" not to work in sparse  usecase
> > hence the patch.
> >=20
> >> Drew, do I remember correctly? ... The related RHBZ is
> >> <https://bugzilla.redhat.com/show_bug.cgi?id=3D924684>. (It's a private
> >> one, and I'm not at liberty to open it up, so my apologies to non-RH f=
olks.)
> >>
> >> Anyway, given that "set" should be a subset of the "get" return value
> >> (as documented in the command schema), if we fix up "get" to work with
> >> sparse topologies, then "set" should work at once.
> >>
> >> However... as far as I understand, this change will allow
> >> qmp_guest_get_vcpus() to produce a GuestLogicalProcessor object for the
> >> missing (hot-unplugged) VCPU, with the following contents:
> >> - @logical-id: populated by the loop,
> >> - @online: false (from g_malloc0()),
> >> - @can-offline: present (from the loop), and false (from g_malloc0()).
> >>
> >> The smaller problem with this might be that "online=3D=3Dfalse &&
> >> can-offline=3D=3Dfalse" is nonsensical and has never been returned bef=
ore. I
> >> don't know how higher level apps will react.
> >>
> >> The larger problem might be that a higher level app could simply copy
> >> this output structure into the next "set" call unchanged, and then that
> >> "set" call will fail.

We do that. Not the unchanged part, but we request the structure, modify
some bits and pass it to the 'set' API.

> > Libvirt it seems that survives such outrageous output

Depending on the API. The old API which only allows to set a target vCPU
count has a check for it:

1630         /* This shouldn't happen, but we can't trust the guest agent */
1631         if (!cpuinfo[i].online && !cpuinfo[i].offlinable) {
1632             virReportError(VIR_ERR_INTERNAL_ERROR, "%s",
1633                            _("Invalid data provided by guest agent"));
1634             return -1;
1635         }

The new API does not need such a check for all cases, but only for those
where the user requests a change. We don't check that the vCPU cannot be
onlined though in that case.

> >> I wonder if, instead of this patch, we should rework
> >> qmp_guest_get_vcpus(), to silently skip processors for which this
> >> dirpath ENOENT condition arises (i.e., return a shorter list of
> >> GuestLogicalProcessor objects).

I think that is the correct idea.

> >=20
> >> But, again, I wouldn't mix this guest agent command with real VCPU
> >> hot(un)plug in the first place. The latter is much-much better, so if
> >> it's available, use that exclusively?
> > Agreed,
> >=20
> > Maybe we can block invalid usecase on libvirt side with a more clear
> > error message as libvirt sort of knows that sparse cpus are supported.
>=20
> OK -- I see libvir-list is CC'd, so let's hear what they prefer :)

I don't see a reason to disallow it since it is technically possible.

While it makes slightly less sense to use rather than real unplug since
the changes can be undone by the system administrator, but nevertheless
there are few advantages for trusted VMs e.g. boot cpu(s) are not
unpluggable by the new API and this approach allows to control them.

Additionally we don't know which approach the user wishes to use in most
cases so there's no magic point where we can disable the guest-agent
based API.

Note that the new API also reports the presence of the structure for the
given vCPU so there should not be any usability problem.

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAluQ7LYACgkQHGwCByjY
1Go8gQ//S8ho41ApbdAl0QgVI+OQq+jCu2jwYgySr3Elf3Sv1RzrWvAyZwHAE1Zp
kogDFHavwUi6xMs15QEnfm+JL7pJHiH+IFD/x4O+vTsh1NyGWfTTTVJChdEkKIKt
FMrOvrQNfFRRX6dCXmCFSqxfY5sODWpZz2hyS4g+8EaadyWyBJHko501MoL3W9Qz
2NcuC5liBYsZHbHODo4G5criH9FMdE8n4bhkU6t2SeF8LkNBafTb3yp2PByr1MIN
qnRZk2HQAfvRIJbd9xRQNjFp6Xgv/XzpHDEruYuPp/LNrfmsdtaTrCWbY8PFSmGZ
bNVcTA5pO6ucJqdQXEvMNU14YAmsNnQ/LCjUoiJ88NZZg0P/PpEyi30i7Hek4/n4
NOXkBqddzbZRLDEgVlRqrmLBTOrmHV5bP5q+NQS2hicw7O9ndoltfxcAI1dyTRcO
xA7FFEspeecPCWC1BWplLXJ9yzizxznj9QOybcEhrexm3e7F/HlHE+FmNIJhX1J6
zoqBebnx7Wnc0I2xZrN1NB8tnKxoqVX8u/YM9R2qGpFpuu0OdZKdzm0nuToO2hwv
BsqBrrAm2fD+zLy6k62x0pLjfVhzrg6YH++ryJqGQXyosOImM/Rxs2HouB4cu5Qx
g/BMpz90uht5VqEs/vL7948ttV/Gf6776aBSQ8uh2w4E4PWsvgE=
=RY1Y
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
