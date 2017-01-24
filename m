Received: from eggs.gnu.org ([2001:4830:134:3::10]:35105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cW7TK-00074H-4N
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cW7TG-0006Ot-4w
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:13:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60205
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cW7TG-0006Oj-0V
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:13:38 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0OJx2K1086042
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 15:13:37 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28681y8pxk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 15:13:36 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 24 Jan 2017 13:13:36 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170124173619.GB28745@redhat.com>
References: <1485272673-5877-1-git-send-email-zdai@linux.vnet.ibm.com>
	<20170124173619.GB28745@redhat.com>
Date: Tue, 24 Jan 2017 14:13:26 -0600
Message-Id: <148528880653.9117.349083961199603729@loki>
Subject: Re: [Qemu-devel] [PATCH 1/1] Migration: libvirt live migration over
 RDMA of ipv6 addr failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, David Dai <zdai@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, zdai@us.ibm.com, quintela@redhat.com

Quoting Daniel P. Berrange (2017-01-24 11:36:19)
> On Tue, Jan 24, 2017 at 09:44:33AM -0600, David Dai wrote:
> > Using libvirt to do live migration over RDMA via ip v6 address failed. =

> > For example:
> > # virsh migrate  --live --migrateuri rdma://[deba::2222]:49152  \
> >               rhel73_host1_guest1 qemu+ssh://[deba::2222]/system --verb=
ose
> > root@deba::2222's password:
> > error: internal error: unable to execute QEMU command 'migrate': RDMA E=
RROR:  =

> >                   could not rdma_getaddrinfo address deba
> > =

> > As we can see, the ip v6 address used by rdma_getaddrinfo() has only "d=
eba" =

> > part. It should be "deba::2222".
> > =

> > 1) According to rfc 3986, a literal ip v6 address should be enclosed =

> > in '[' and ']'.
> > When using virsh command to do live migration via ip v6 addresss, user
> > will input the ip v6 address with brackets (i.e. rdma://[deba::2222]:49=
152).
> > libvirt will parse command line option by calling virURIParse(). =

> > Inside it calls virStringStripIPv6Brackets() to strip off the brackets.
> > The uri passed in to virURIParse()  is:
> >    "uri =3D rdma://[deba::2222]:49152"
> > Inside virURIParse() routine, it will strip off the bracket '[' and ']'=
 if
> > it's ip v6 address. Then save the ip v6 address in this format "deba::2=
222" =

> > in the virURI->server field, and to be passed to qemu.
> > =

> > 2) At the beginning of migration, in qemu's qemu_rdma_data_init(host_po=
rt) =

> > routine, it calls inet_parse(host_port) routine to parse the ip v6 addr=
ess and =

> > port string obtained from libvirt.
> > The input string host_port passed to qemu_rdma_data_init() can be:
> >     "hostname:port", or
> >     "ipv4address:port", or
> >     "[ipv6address]:port" (i.e "[deba::2222]:49152"), or
> >     "ipv6address:port" (i.e "deba::2222:49152").
> > Existing qemu api inet_parse() can handle the above first 3 cases prope=
rly,  =

> > but didn't handle the last case ("ipv6address:port") correctly.
> > In this live migration over rdma via ip v6 address case, the server ip =
v6 =

> > address obtained from libvirt doesn't contain the brackets '[' and ']' =

> > (i.e. "deba::2222:49152"). It caused inet_parse() to parse only "deba" =
part, =

> > and stopped at the 1st colon ':'. As the result, the subsequent =

> > rdma_getaddrinfo() with ip address "deba" will fail.
> > =

> > If we don't strip off brackets '[' and ']' for an ip v6 address in libv=
irt's =

> > virURIParse(), it will cause libvirt ipv6 ssh authentication failure.
> > =

> > NOTE:
> > If using libvirt to do live migration over TCP via ip v6 address:
> > # virsh migrate  --live --migrateuri tcp://[deba::2222]:49152  \
> >               rhel73_host1_guest1 qemu+ssh://[deba::2222]/system --verb=
ose
> > It works fine.
> > In migrateuri of tcp case, libvirt will call virNetSocketNewConnectTCP()
> > directly to connect to remote "deba::2222:49152" after it strips off
> > the bracket '[' and ']' for an ip v6 address. =

> > On qemu side, fd_start_outgoing_migration() will be called to do migrat=
ion.
> > It doesn't call inet_parse(). So we don't see issue in tcp case.
> > =

> > Solution:
> > I choose to fix the code in qemu's inet_parse() routine to parse the
> > ip v6 addresss w/o brackets properly (i.e. "deba::2222:49152" format).
> =

> That is not right - "deba::222:49152" is *not* a valid address. It
> is mandatory to use [] when providing a numeric IPv6 address. So
> there's nothing broken in QEMU here - libvirt needs fixing to pass
> correct data to QEMU

It's worth noting that inet_parse() is still somewhat broken in that
instead of rejecting "deba::2222:49152" it erroneously treats it as
an ipv4 address and passes it up the stack as host/port deba/<null>.

> =

> Regards,
> Daniel
> -- =

> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
> |: http://libvirt.org              -o-             http://virt-manager.or=
g :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
>=20
