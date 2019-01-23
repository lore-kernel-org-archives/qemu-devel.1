Received: from eggs.gnu.org ([209.51.188.92]:49944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmOjS-00079o-Hu
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmObB-0001Cm-BX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:54:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmOb7-0000vL-Hr
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:54:06 -0500
Date: Wed, 23 Jan 2019 19:53:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190123195345.GI2193@work-vm>
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] test-filter-mirror hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhang Chen <zhangckid@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>

* Jason Wang (jasowang@redhat.com) wrote:
>=20
> On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
> > On Thu, 17 Jan 2019 at 09:46, Jason Wang <jasowang@redhat.com> wrote:
> > >=20
> > > On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
> > > >=20
> > > > On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
> > > > <dgilbert@redhat.com <mailto:dgilbert@redhat.com>> wrote:
> > > >=20
> > > >      * Peter Maydell (peter.maydell@linaro.org
> > > >      <mailto:peter.maydell@linaro.org>) wrote:
> > > >      > Recently I've noticed that test-filter-mirror has been han=
ging
> > > >      > intermittently, typically when run on some other TCG archi=
tecture.
> > > >      > In the instance I've just looked at, this was with s390x g=
uest on
> > > >      > x86-64 host, though I've also seen it on other host archs =
and
> > > >      > perhaps with other guests.
> > > >=20
> > > >      Watch out to see if you really do see it for other guests;
> > > >      it carefully avoids using virtio-net to avoid vhost; but on =
s390x it
> > > >      uses virtio-net-ccw - could that hit the vhost it was trying=
 to avoid?
> > > >=20
> > > >      > Below is a backtrace, though it seems to be pretty unhelpf=
ul.
> > > >      > Anybody got any theories ? Does the mirror test rely on di=
rty
> > > >      > memory bitmaps like the migration test (which also hangs
> > > >      > occasionally with TCG due to some bug I'm sure we've inves=
tigated
> > > >      > in the past) ?
> > > >=20
> > > >      I don't think it relies on the CPU at all.
> > > >   I have no idea about this currently, but Jason and I designed t=
he
> > > > test case.
> > > > Add Jason: Have any comments about this ?
> > >=20
> > > I can't reproduce this locally with s390x-softmmu. It looks to me t=
he
> > > test should be independent to any kinds of emulation. It should pas=
s
> > > when mainloop work.
> > I've just seen a hang with ppc64 guest on s390x host, so it is
> > indeed not specific to s390x guest (and so not specific to
> > virtio-net either, since the ppc64 guest setup uses e1000).
> >=20
> > thanks
> > -- PMM
>=20
>=20
> Finally reproduced locally after hundreds (sometimes thousands) times o=
f
> running.
>=20
> Bisection points to OOB monitor[1].
>=20
> It looks to me after OOB is used unconditionally we lose a barrier to m=
ake
> sure socket is connected before sending packets in test-filter-mirror.c=
. Is
> there any other similar and simple thing that we could do to kick the
> mainloop?

Do you mean the:

    /* send a qmp command to guarantee that 'connected' is setting to tru=
e. */
    qmp_discard_response(qts, "{ 'execute' : 'query-status'}");

why was that ever sufficient to know the socket was ready?

Dave

> Thanks
>=20
> [1]
>=20
> commit 8258292e18c39480b64eba9f3551ab772ce29b5d (HEAD, refs/bisect/bad)
> Author: Peter Xu <peterx@redhat.com>
> Date:=C2=A0=C2=A0 Tue Oct 9 14:27:15 2018 +0800
>=20
> =C2=A0=C2=A0=C2=A0 monitor: Remove "x-oob", offer capability "oob" unco=
nditionally
>=20
> =C2=A0=C2=A0=C2=A0 Out-of-band command execution was introduced in comm=
it cf869d53172.
> =C2=A0=C2=A0=C2=A0 Unfortunately, we ran into a regression, and had to =
turn it into an
> =C2=A0=C2=A0=C2=A0 experimental option for 2.12 (commit be933ffc23).
>=20
> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
>=20
> =C2=A0=C2=A0=C2=A0 The regression has since been fixed (commit 951702f3=
9c7 "monitor: bind
> =C2=A0=C2=A0=C2=A0 dispatch bh to iohandler context").=C2=A0 A thorough=
 re-review of OOB
> =C2=A0=C2=A0=C2=A0 commands led to a few more issues, which have also b=
een addressed.
>=20
> =C2=A0=C2=A0=C2=A0 This patch partly reverts be933ffc23 (monitor: new p=
arameter "x-oob"),
> =C2=A0=C2=A0=C2=A0 and makes QMP monitors again offer capability "oob" =
whenever they can
> =C2=A0=C2=A0=C2=A0 provide it, i.e. when the monitor's character device=
 is capable of
> =C2=A0=C2=A0=C2=A0 running in an I/O thread.
>=20
> =C2=A0=C2=A0=C2=A0 Some trivial touch-up in the test code is required t=
o make sure qmp-test
> =C2=A0=C2=A0=C2=A0 won't break.
>=20
> =C2=A0=C2=A0=C2=A0 Reviewed-by: Markus Armbruster <armbru@redhat.com>
> =C2=A0=C2=A0=C2=A0 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lurea=
u@redhat.com>
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Peter Xu <peterx@redhat.com>
> =C2=A0=C2=A0=C2=A0 Message-Id: <20181009062718.1914-4-peterx@redhat.com=
>
> =C2=A0=C2=A0=C2=A0 [Conflict with "monitor: check if chardev can switch=
 gcontext for OOB"
> =C2=A0=C2=A0=C2=A0 resolved, commit message updated]
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Markus Armbruster <armbru@redhat.com>
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
