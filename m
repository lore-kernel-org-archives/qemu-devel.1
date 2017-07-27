Received: from eggs.gnu.org ([2001:4830:134:3::10]:54135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dahNP-0007bL-OJ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dahNL-0004HZ-Ip
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:54:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dahNL-0004Gu-9x
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:54:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6RBsKQC031145
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:54:41 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2byevxt8y8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:54:40 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Jul 2017 05:54:40 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170727105348.GG7970@umbus.fritz.box>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<CAFEAcA_t8EDNnWTeRzuHEcdfq3DJFTN3ug=DHnGvWef3=wyFzA@mail.gmail.com>
	<20170727105348.GG7970@umbus.fritz.box>
Date: Thu, 27 Jul 2017 06:54:31 -0500
Message-Id: <150115647192.26979.11826694975373187220@loki>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL
 to avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>

Quoting David Gibson (2017-07-27 05:53:48)
> On Thu, Jul 27, 2017 at 10:11:48AM +0100, Peter Maydell wrote:
> > On 27 July 2017 at 02:30, Michael Roth <mdroth@linux.vnet.ibm.com> wrot=
e:
> > > In particular, Mellanox CX4 adapters on PowerNV hosts might not be fu=
lly
> > > quiesced by vfio-pci's finalize() routine until up to 6s after the
> > > DEVICE_DELETED was emitted, leading to detach-device on the libvirt s=
ide pretty
> > > much always crashing the host.
> > =

> > My initial naive thought is that if the host kernel can crash then
> > this is a host kernel bug... shouldn't the host kernel refuse
> > the subsequent libvirt rebind if it would cause a crash ?
> =

> I think so too, but I haven't been able to convince Alex.  Nor
> find time to fix it in the kernel myself.

In the thread I linked to Alex had mentioned he was pursuing something on t=
he
kernel side, but my understanding what that we'd simply have the kernel fail
more gracefully when attempting to rebind in this situation.

But that still leaves the matter of libvirt failing to rebind the device to
the host. This series addresses that aspect of it, so I think the 2 approac=
hes
are complementary.

> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
