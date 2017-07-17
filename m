Received: from eggs.gnu.org ([2001:4830:134:3::10]:56108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dX2rP-0003QC-Kf
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dX2rM-0008J1-FV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:02:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dX2rM-0008Ii-6Z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:02:36 -0400
Date: Mon, 17 Jul 2017 11:02:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170717100230.GE2106@work-vm>
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499925175-21218-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<174a3db3-6a14-edbb-641a-e93746c51861@redhat.com>
	<7ac18343-fc01-8029-2264-617fdde6d6b2@cn.fujitsu.com>
	<20170717085505.GD2106@work-vm>
	<9acbc01a-e3a5-40ff-5059-bea5569680ba@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9acbc01a-e3a5-40ff-5059-bea5569680ba@cn.fujitsu.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 2/4] net/colo-compare.c: Compare the tcp
 packets that has the same sequence number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

* Zhang Chen (zhangchen.fnst@cn.fujitsu.com) wrote:
>=20
>=20
> On 07/17/2017 04:55 PM, Dr. David Alan Gilbert wrote:
> > * Zhang Chen (zhangchen.fnst@cn.fujitsu.com) wrote:
> > >=20
> > > On 07/14/2017 11:25 AM, Jason Wang wrote:
> > > >=20
> > > > On 2017=E5=B9=B407=E6=9C=8813=E6=97=A5 13:52, Zhang Chen wrote:
> > > > > If primary packet's sequence number not same with secondary pac=
ket's
> > > > > sequence number, no need to compare the packet other field.
> > > > >=20
> > > > > Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> > > > > ---
> > > > >    net/colo-compare.c | 6 ++++++
> > > > >    1 file changed, 6 insertions(+)
> > > > >=20
> > > > > diff --git a/net/colo-compare.c b/net/colo-compare.c
> > > > > index 0f8e198..2caeb80 100644
> > > > > --- a/net/colo-compare.c
> > > > > +++ b/net/colo-compare.c
> > > > > @@ -222,6 +222,12 @@ static int colo_packet_compare_tcp(Packet
> > > > > *spkt, Packet *ppkt)
> > > > >        ptcp =3D (struct tcphdr *)ppkt->transport_header;
> > > > >        stcp =3D (struct tcphdr *)spkt->transport_header;
> > > > >    +    if ((ptcp->th_flags & TH_SYN) !=3D TH_SYN &&
> > > > > +        ptcp->th_seq !=3D stcp->th_seq) {
> > > > > +        trace_colo_compare_main("colo_packet_compare_tcp seq n=
ot
> > > > > same");
> > > > > +        return -1;
> > > > > +    }
> > > > > +
> > > > >        /*
> > > > >         * The 'identification' field in the IP header is *very*=
 random
> > > > >         * it almost never matches.  Fudge this by ignoring diff=
erences in
> > > > Do we have any statistics numbers for this?
> > > Rethink about this patch, I will remove it in next version and send=
 a
> > > independent
> > > patch in the future.
> > > Because in FTP get test, primary guest send lots of packet differ t=
o
> > > secondary guest's,
> > > the packet payload are not same, but the total payload are same.
> > Do you mean that the TCP stream is the same but the packet sizes are
> > different due to different fragmentation?
>=20
> Yes, like that:
> We send this payload: "1234567890".
>=20
> primary:
> pkt1 payload:"123"
> pkt2 payload:"4567890"
>=20
> secondary:
> pkt1 payload:"1234567890"

Yes; I think it comes down to very fine grain timing and interaction
with nagling; if the guest is that bit slower in generating the output,
the network code will decide to send it.

> >=20
> > > I think I have to buffer some packet's payload depend on sequence n=
umber for
> > > comparison?
> > > Any idea about this?
> > The original COLO discussions ~2-3 years ago talked about performing =
TCP
> > reassembly and comparing the TCP stream; not a simple task.
> >=20
> > But the version I worked with also had the rewrite of the sequence
> > numbers on the secondary to cause them to match even with the same
> > fragmentation - but that doesn't seem to be upstream yet.
>=20
> In current qemu upstream we use filter-rewriter to rewrite the sequence
> numbers on the secondary, but we can not avoid different fragmentation =
in
> two side.
> Any comments about guarantee the primary side and the secondary side ha=
ve
> the same fragmentation?

I don't think you can; the only choice is to perform the comparison
after de-fragmentation - or to do the same thing by building your own
reassembly.

Dave

> Thanks
> Zhang Chen
>=20
> >=20
> > Dave
> >=20
> > > Thanks
> > > Zhang Chen
> > >=20
> > > > Thanks
> > > >=20
> > > >=20
> > > >=20
> > > --=20
> > > Thanks
> > > Zhang Chen
> > >=20
> > >=20
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
> >=20
> > .
> >=20
>=20
> --=20
> Thanks
> Zhang Chen
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
