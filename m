Received: from eggs.gnu.org ([209.51.188.92]:51066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmb31-000218-MX
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmb30-0007Nx-N5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:11:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmb2w-0006rn-IY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:11:40 -0500
Date: Thu, 24 Jan 2019 09:11:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190124091113.GA2101@work-vm>
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
	<20190123195345.GI2193@work-vm>
	<a0c711c1-17d4-9fbe-b78c-4cd4a2419633@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0c711c1-17d4-9fbe-b78c-4cd4a2419633@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

* Jason Wang (jasowang@redhat.com) wrote:
>=20
> On 2019/1/24 =E4=B8=8A=E5=8D=883:53, Dr. David Alan Gilbert wrote:
> > * Jason Wang (jasowang@redhat.com) wrote:
> > > On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
> > > > On Thu, 17 Jan 2019 at 09:46, Jason Wang<jasowang@redhat.com>  wr=
ote:
> > > > > On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
> > > > > > On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
> > > > > > <dgilbert@redhat.com  <mailto:dgilbert@redhat.com>> wrote:
> > > > > >=20
> > > > > >       * Peter Maydell (peter.maydell@linaro.org
> > > > > >       <mailto:peter.maydell@linaro.org>) wrote:
> > > > > >       > Recently I've noticed that test-filter-mirror has bee=
n hanging
> > > > > >       > intermittently, typically when run on some other TCG =
architecture.
> > > > > >       > In the instance I've just looked at, this was with s3=
90x guest on
> > > > > >       > x86-64 host, though I've also seen it on other host a=
rchs and
> > > > > >       > perhaps with other guests.
> > > > > >=20
> > > > > >       Watch out to see if you really do see it for other gues=
ts;
> > > > > >       it carefully avoids using virtio-net to avoid vhost; bu=
t on s390x it
> > > > > >       uses virtio-net-ccw - could that hit the vhost it was t=
rying to avoid?
> > > > > >=20
> > > > > >       > Below is a backtrace, though it seems to be pretty un=
helpful.
> > > > > >       > Anybody got any theories ? Does the mirror test rely =
on dirty
> > > > > >       > memory bitmaps like the migration test (which also ha=
ngs
> > > > > >       > occasionally with TCG due to some bug I'm sure we've =
investigated
> > > > > >       > in the past) ?
> > > > > >=20
> > > > > >       I don't think it relies on the CPU at all.
> > > > > >    I have no idea about this currently, but Jason and I desig=
ned the
> > > > > > test case.
> > > > > > Add Jason: Have any comments about this ?
> > > > > I can't reproduce this locally with s390x-softmmu. It looks to =
me the
> > > > > test should be independent to any kinds of emulation. It should=
 pass
> > > > > when mainloop work.
> > > > I've just seen a hang with ppc64 guest on s390x host, so it is
> > > > indeed not specific to s390x guest (and so not specific to
> > > > virtio-net either, since the ppc64 guest setup uses e1000).
> > > >=20
> > > > thanks
> > > > -- PMM
> > > Finally reproduced locally after hundreds (sometimes thousands) tim=
es of
> > > running.
> > >=20
> > > Bisection points to OOB monitor[1].
> > >=20
> > > It looks to me after OOB is used unconditionally we lose a barrier =
to make
> > > sure socket is connected before sending packets in test-filter-mirr=
or.c. Is
> > > there any other similar and simple thing that we could do to kick t=
he
> > > mainloop?
> > Do you mean the:
> >=20
> >      /* send a qmp command to guarantee that 'connected' is setting t=
o true. */
> >      qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
>=20
>=20
> Yes.
>=20
>=20
> >=20
> > why was that ever sufficient to know the socket was ready?
>=20
>=20
> It was suggested by Fam, I don't remember the details. Can we make sure=
 all
> pending events has been processed (UNIX socket was set to connected) af=
ter
> query-status is returned with an non OOB monitor?

I'm not sure - it doesn't sound like a 'query-status' should ensure
anything else.
How about something like a 'query-chardev' - can that tell you what you
need and loop until it's ready?

Dave

> Thanks
>=20
>=20
> >=20
> > Dave
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
