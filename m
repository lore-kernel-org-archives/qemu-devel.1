Received: from eggs.gnu.org ([2001:4830:134:3::10]:44732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dpFex-0002e8-MH
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dpFep-0005p7-VA
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:21:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dpFep-0005n5-MQ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:20:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85FJHUV086924
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 11:20:52 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csx6d0y1g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 11:20:48 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 09:20:31 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170905162425.3a202a87@bahia>
References: <150451194093.7046.18254446012958612468.stgit@bahia>
	<1d5efdef-21b8-9b7b-6939-339b97fd9bce@redhat.com>
	<20170905162425.3a202a87@bahia>
Date: Tue, 05 Sep 2017 10:20:22 -0500
Message-Id: <150462482278.16876.9815938798442180307@loki>
Subject: Re: [Qemu-devel] [PATCH] virtfs: error out gracefully when
 mandatory suboptions are missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

Quoting Greg Kurz (2017-09-05 09:24:25)
> On Tue, 5 Sep 2017 15:35:34 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> =

> > On 04.09.2017 09:59, Greg Kurz wrote:
> > > We internally convert -virtfs to -fsdev/-device. If the user doesn't
> > > provide the path or security_model suboptions, and the fsdev backend
> > > requires them, we hit an assertion when populating the internal -fsdev
> > > option:
> > > =

> > > util/qemu-option.c:547: opt_set: Assertion `opt->str' failed.
> > > Aborted (core dumped)
> > > =

> > > Let's test the suboption presence on the command line before trying
> > > to set it in the internal -fsdev option, and let the backend code
> > > error out gracefully (ie, like it already does when the user passes
> > > -fsdev on the command line).
> > > =

> > > Reported-by: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  vl.c |   16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > > =

> > > diff --git a/vl.c b/vl.c
> > > index 8e247cc2a239..d63269332fed 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -3557,7 +3557,7 @@ int main(int argc, char **argv, char **envp)
> > >              case QEMU_OPTION_virtfs: {
> > >                  QemuOpts *fsdev;
> > >                  QemuOpts *device;
> > > -                const char *writeout, *sock_fd, *socket;
> > > +                const char *writeout, *sock_fd, *socket, *path, *sec=
urity_model;
> > >  =

> > >                  olist =3D qemu_find_opts("virtfs");
> > >                  if (!olist) {
> > > @@ -3596,11 +3596,15 @@ int main(int argc, char **argv, char **envp)
> > >                  }
> > >                  qemu_opt_set(fsdev, "fsdriver",
> > >                               qemu_opt_get(opts, "fsdriver"), &error_=
abort);
> > > -                qemu_opt_set(fsdev, "path", qemu_opt_get(opts, "path=
"),
> > > -                             &error_abort);
> > > -                qemu_opt_set(fsdev, "security_model",
> > > -                             qemu_opt_get(opts, "security_model"),
> > > -                             &error_abort);
> > > +                path =3D qemu_opt_get(opts, "path");
> > > +                if (path) {
> > > +                    qemu_opt_set(fsdev, "path", path, &error_abort);
> > > +                }
> > > +                security_model =3D qemu_opt_get(opts, "security_mode=
l");
> > > +                if (security_model) {
> > > +                    qemu_opt_set(fsdev, "security_model", security_m=
odel,
> > > +                                 &error_abort);
> > > +                }
> > >                  socket =3D qemu_opt_get(opts, "socket");
> > >                  if (socket) {
> > >                      qemu_opt_set(fsdev, "socket", socket, &error_abo=
rt);  =

> > =

> > By the way, I think this should be CC:-ed to stable, too.
> > =

> =

> Well, it's been there forever and it isn't a critical fix... but the
> thread on qemu-discuss the other day showed that it was confusing
> people, and the fix is trivial. So I guess it doesn't hurt to have
> this in stable. :)
> =

> Michael,
> =

> I'll send a pull req later today. If it's not too late, maybe you can add
> this patch to 2.9.1 when it's merged in master?

We're in freeze as of yesterday with release set for Thursday, so it's a
bit late. OTOH I don't have test coverage for virtfs and the patch seems
isolated enough that I don't see any harm in slipping it in if it
lands in master by tomorrow. Otherwise it'll have to wait for 2.10.1,
which I'm hoping to get out this month.

> =

> Cheers,
> =

> --
> Greg
> =

> >  Thomas
