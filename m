Received: from eggs.gnu.org ([209.51.188.92]:38211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmcHe-0002w9-U8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmcHN-0003GU-AQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:30:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmcHL-00033x-Ad
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:30:37 -0500
Date: Thu, 24 Jan 2019 10:30:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190124103023.GB7953@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
	<20190123195345.GI2193@work-vm> <20190124101155.GA7953@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124101155.GA7953@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 24, 2019 at 10:11:55AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 23, 2019 at 07:53:46PM +0000, Dr. David Alan Gilbert wrote:
> > * Jason Wang (jasowang@redhat.com) wrote:
> > >=20
> > > On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
> > > > On Thu, 17 Jan 2019 at 09:46, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > > >=20
> > > > > On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
> > > > > >=20
> > > > > > On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
> > > > > > <dgilbert@redhat.com <mailto:dgilbert@redhat.com>> wrote:
> > > > > >=20
> > > > > >      * Peter Maydell (peter.maydell@linaro.org
> > > > > >      <mailto:peter.maydell@linaro.org>) wrote:
> > > > > >      > Recently I've noticed that test-filter-mirror has been=
 hanging
> > > > > >      > intermittently, typically when run on some other TCG a=
rchitecture.
> > > > > >      > In the instance I've just looked at, this was with s39=
0x guest on
> > > > > >      > x86-64 host, though I've also seen it on other host ar=
chs and
> > > > > >      > perhaps with other guests.
> > > > > >=20
> > > > > >      Watch out to see if you really do see it for other guest=
s;
> > > > > >      it carefully avoids using virtio-net to avoid vhost; but=
 on s390x it
> > > > > >      uses virtio-net-ccw - could that hit the vhost it was tr=
ying to avoid?
> > > > > >=20
> > > > > >      > Below is a backtrace, though it seems to be pretty unh=
elpful.
> > > > > >      > Anybody got any theories ? Does the mirror test rely o=
n dirty
> > > > > >      > memory bitmaps like the migration test (which also han=
gs
> > > > > >      > occasionally with TCG due to some bug I'm sure we've i=
nvestigated
> > > > > >      > in the past) ?
> > > > > >=20
> > > > > >      I don't think it relies on the CPU at all.
> > > > > >   I have no idea about this currently, but Jason and I design=
ed the
> > > > > > test case.
> > > > > > Add Jason: Have any comments about this ?
> > > > >=20
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
> > >=20
> > >=20
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
> >=20
> > Do you mean the:
> >=20
> >     /* send a qmp command to guarantee that 'connected' is setting to=
 true. */
> >     qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
> >=20
> > why was that ever sufficient to know the socket was ready?
>=20
> This doesn't make any sense to me.
>=20
> There's the netdev socket, which has been passed in as a pre-opened soc=
ket
> FD, so that's guaranteed connected.
>=20
> There's the chardev server socket, to which we've just done a unix_conn=
ect()
> call to establish a connection. If unix_connect() has succeeded, then a=
t least
> the socket is connected & ready for I/O from the test's side. This is a
> reliable stream socket, so even if the test sends data on the socket ri=
ght away
> and QEMU isn't ready, it won't be lost. It'll be buffered and received =
by QEMU
> as soon as QEMU starts to monitor for incoming data on the socket.
>=20
> So I don't get what trying to wait for a "connected" state actually ach=
ieves.
> It feels like a mistaken attempt to paper over some other unknown flaw =
that
> just worked by some lucky side-effect.

Immediately after writing that, I see what's happened.

The  filter_redirector_receive_iov() method is triggered when QEMU reads
from the -netdev socket (which we passed in as an FD and immediately
write to).

This method will discard all data, however, if the chr_out -chardev is
not in a connected state. So we do indeed have a race condition in this
test suite.

In fact I'd say this filter-mirror object is racy by design even when
run in normal usage, if your chardev is a server mode with "nowait" set,
or is a client mode with "reconnect" set. It will simply discard data.

We can fix the test suite by using FD passing for the -chardev
too, so we're guaranteed to be connected immediately.  It might be
possible to remove "nowait" flag, but I'm not sure if that will cause
problems with the qtest handshake as it might block QEMU at startup
preventing qtest handshake from being performed.

If we care about the race in real QEMU execution, then we must either
document that "nowait" or "reconnect" should never be used with
filter-mirror, or perhaps can make use of "qemu_chr_wait_connected"
to synchronize startup fo the filter-mirror object with the chardev
initialization. That could fix the test suite too

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
