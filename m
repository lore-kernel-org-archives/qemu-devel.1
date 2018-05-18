Received: from eggs.gnu.org ([2001:4830:134:3::10]:37400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fJbXl-0007KJ-9l
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fJbXi-0004Kx-R3
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:19:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fJbXi-0004KX-LC
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:19:18 -0400
Date: Fri, 18 May 2018 11:19:16 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180518091916.GA22292@vader>
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader> <20180518075212.GE3416@dnr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518075212.GE3416@dnr>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>
Cc: Yi Min Zhao <zyimin@linux.ibm.com>, fiuczy@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org, jferlan@redhat.com

On 18/05/2018 - 09:52:12, J=C3=A1n Tomko wrote:
> On Thu, May 17, 2018 at 02:41:09PM +0200, Eduardo Otubo wrote:
> > On 15/05/2018 - 19:33:48, Yi Min Zhao wrote:
> > > If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' rema=
ins
> > > compiled. This would make libvirt set the corresponding capability =
and
> > > then trigger the guest startup fails. So this patch excludes the co=
de
> > > regarding seccomp staff if CONFIG_SECCOMP is undefined.
> >=20
> > Just a sugestion for the next patch you send: If it's a single patch,=
 you don't
> > need to format it with a cover-letter. Just put all the description i=
n the body,
> > or if you need to add a text that shouldn't be included in the commit=
 message,
> > just add it after the "---" after Signed-off-by.
> >=20
> > >=20
> > > Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> > > ---
> > >  vl.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >=20
>=20
> > > @@ -4071,10 +4072,12 @@ int main(int argc, char **argv, char **envp=
)
> > >          exit(1);
> > >      }
> > >=20
> > > +#ifdef CONFIG_SECCOMP
> > >      if (qemu_opts_foreach(qemu_find_opts("sandbox"),
> > >                            parse_sandbox, NULL, NULL)) {
> > >          exit(1);
> > >      }
> > > +#endif
> > >=20
> > >      if (qemu_opts_foreach(qemu_find_opts("name"),
> > >                            parse_name, NULL, NULL)) {
> > > --
> > > Yi Min
> > >=20
> >=20
> > I just wanted a review from J=C3=A1n, since he is the author of the o=
riginal libvirt
> > patch. Does this breaks libvirt logic in any way? If not, ACK on this=
 patch.
> >=20
>=20
> Current libvirt logic assumes the -sandbox option is always present.
> (IIRC it was introduced in QEMU 1.1 and when we switched from help
> scraping to capability probing via QMP for QEMU 1.2, there was no
> way to detect it)
>=20
> This patch fixes the usage of QEMU new enough for seccomp blacklist
> (where libvirt enables the sandbox by default),
> but breaks the usage of QEMU with compiled out sandbox and
> setting
>  seccomp_sandbox =3D 0
> in libvirt's qemu.conf:
>=20
> error: internal error: process exited while connecting to monitor:
> qemu-git: -sandbox off: There is no option group 'sandbox'
>=20
>=20
> But now libvirt requires QEMU >=3D 1.5.0 which already supports
> query-command-line-options, so if you want the option gone completely
> --without-seccomp, I can add the code that probes for it and
> make seccomp_sandbox =3D 0 a no-op if it's compiled out.

This looks like a good solution for the libvirt side. Can you add this su=
pport
so we can merge this fix?

Thanks a lot,

--=20
Eduardo Otubo
