Received: from eggs.gnu.org ([209.51.188.92]:58761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gmbg0-00069h-NI
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gmbfz-0000oK-JL
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:52:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gmbfz-0000ZM-9p
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:51:59 -0500
Date: Thu, 24 Jan 2019 17:51:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190124095152.GM18231@xz-x1>
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
	<20190123195345.GI2193@work-vm>
	<a0c711c1-17d4-9fbe-b78c-4cd4a2419633@redhat.com>
	<20190124091113.GA2101@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124091113.GA2101@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 24, 2019 at 09:11:15AM +0000, Dr. David Alan Gilbert wrote:
> * Jason Wang (jasowang@redhat.com) wrote:
> >=20
> > On 2019/1/24 =E4=B8=8A=E5=8D=883:53, Dr. David Alan Gilbert wrote:
> > > * Jason Wang (jasowang@redhat.com) wrote:
> > > > On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
> > > > > On Thu, 17 Jan 2019 at 09:46, Jason Wang<jasowang@redhat.com>  =
wrote:
> > > > > > On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
> > > > > > > On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
> > > > > > > <dgilbert@redhat.com  <mailto:dgilbert@redhat.com>> wrote:
> > > > > > >=20
> > > > > > >       * Peter Maydell (peter.maydell@linaro.org
> > > > > > >       <mailto:peter.maydell@linaro.org>) wrote:
> > > > > > >       > Recently I've noticed that test-filter-mirror has b=
een hanging
> > > > > > >       > intermittently, typically when run on some other TC=
G architecture.
> > > > > > >       > In the instance I've just looked at, this was with =
s390x guest on
> > > > > > >       > x86-64 host, though I've also seen it on other host=
 archs and
> > > > > > >       > perhaps with other guests.
> > > > > > >=20
> > > > > > >       Watch out to see if you really do see it for other gu=
ests;
> > > > > > >       it carefully avoids using virtio-net to avoid vhost; =
but on s390x it
> > > > > > >       uses virtio-net-ccw - could that hit the vhost it was=
 trying to avoid?
> > > > > > >=20
> > > > > > >       > Below is a backtrace, though it seems to be pretty =
unhelpful.
> > > > > > >       > Anybody got any theories ? Does the mirror test rel=
y on dirty
> > > > > > >       > memory bitmaps like the migration test (which also =
hangs
> > > > > > >       > occasionally with TCG due to some bug I'm sure we'v=
e investigated
> > > > > > >       > in the past) ?
> > > > > > >=20
> > > > > > >       I don't think it relies on the CPU at all.
> > > > > > >    I have no idea about this currently, but Jason and I des=
igned the
> > > > > > > test case.
> > > > > > > Add Jason: Have any comments about this ?
> > > > > > I can't reproduce this locally with s390x-softmmu. It looks t=
o me the
> > > > > > test should be independent to any kinds of emulation. It shou=
ld pass
> > > > > > when mainloop work.
> > > > > I've just seen a hang with ppc64 guest on s390x host, so it is
> > > > > indeed not specific to s390x guest (and so not specific to
> > > > > virtio-net either, since the ppc64 guest setup uses e1000).
> > > > >=20
> > > > > thanks
> > > > > -- PMM
> > > > Finally reproduced locally after hundreds (sometimes thousands) t=
imes of
> > > > running.
> > > >=20
> > > > Bisection points to OOB monitor[1].
> > > >=20
> > > > It looks to me after OOB is used unconditionally we lose a barrie=
r to make
> > > > sure socket is connected before sending packets in test-filter-mi=
rror.c. Is
> > > > there any other similar and simple thing that we could do to kick=
 the
> > > > mainloop?
> > > Do you mean the:
> > >=20
> > >      /* send a qmp command to guarantee that 'connected' is setting=
 to true. */
> > >      qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
> >=20
> >=20
> > Yes.
> >=20
> >=20
> > >=20
> > > why was that ever sufficient to know the socket was ready?
> >=20
> >=20
> > It was suggested by Fam, I don't remember the details. Can we make su=
re all
> > pending events has been processed (UNIX socket was set to connected) =
after
> > query-status is returned with an non OOB monitor?
>=20
> I'm not sure - it doesn't sound like a 'query-status' should ensure
> anything else.
> How about something like a 'query-chardev' - can that tell you what you
> need and loop until it's ready?

Yeah it sounds hacky to use "query status" to make sure a specific
chardev is connected even before the OOB...

I saw that currently the chardev requires "nowait":

    qts =3D qtest_initf(
        "-netdev socket,id=3Dqtest-bn0,fd=3D%d "
        "-device %s,netdev=3Dqtest-bn0,id=3Dqtest-e0 "
        "-chardev socket,id=3Dmirror0,path=3D%s,server,nowait "
        "-object filter-mirror,id=3Dqtest-f0,netdev=3Dqtest-bn0,queue=3Dt=
x,outdev=3Dmirror0 "
        , send_sock[1], devstr, sock_path);

Could it work without "nowait"?  Would that make sure QEMU will wait
until connection established before going on?

Regards,

--=20
Peter Xu
