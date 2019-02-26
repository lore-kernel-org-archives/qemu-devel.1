Received: from eggs.gnu.org ([209.51.188.92]:55587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1gydc2-0007Mc-Vk
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1gydc1-000356-2o
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:21:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
	id 1gydby-00033x-W7
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:21:37 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1QEIhxv073747
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:21:33 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qw740861b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:21:33 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <maxiwell@linux.ibm.com>;
	Tue, 26 Feb 2019 14:21:32 -0000
Date: Tue, 26 Feb 2019 11:21:26 -0300
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
References: <20190225162325.24008-1-maxiwell@linux.ibm.com>
	<20190225232009.GB30778@kermit.br.ibm.com>
	<20190226032103.GJ6872@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226032103.GJ6872@umbus.fritz.box>
Message-Id: <20190226142126.jxosththzad6h6dd@maxibm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr-rtas: add ibm,
 get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-devel@nongnu.org, "open list:sPAPR" <qemu-ppc@nongnu.org>

On Tue, Feb 26, 2019 at 02:21:03PM +1100, David Gibson wrote:
> On Mon, Feb 25, 2019 at 08:20:09PM -0300, Murilo Opsfelder Araujo wrote=
:
> > Hi, Maxiwell.
> >=20
> > On Mon, Feb 25, 2019 at 01:23:25PM -0300, Maxiwell S. Garcia wrote:
> > > This adds a handler for ibm,get-vpd RTAS calls, allowing pseries
> > > guest to collect host information. It is disabled by default to
> > > avoid unwanted information leakage. To enable it, use:
> > > =E2=80=98-M pseries,vpd-export=3Don=E2=80=99
> >=20
> > The patch for setting host-serial and host-model already landed Gibso=
n's
> > ppc-for-4.0 branch:
> >=20
> >   commit 9e584f45868f6945c1282c938278038cba0e4af2
> >   Author: Prasad J Pandit <pjp@fedoraproject.org>
> >   Date:   Mon Feb 18 23:43:49 2019 +0530
> >=20
> >       ppc: add host-serial and host-model machine attributes (CVE-201=
9-8934)
> >=20
> >=20
> > QEMU should only return host-serial and host-model from the host if t=
he
> > following combination of parameters are provided:
> >=20
> >   -M host-serial=3Dpassthrough,host-model=3Dpassthrough,vpd-export=3D=
on
> >=20
> > If host-serial or host-model are set with a user-string, ibm,get-vpd =
should
> > honor these values and return them, not exposing host information by =
accident.
> >=20
> > I'm not even sure if we need vpd-export=3D<bool> setting. Its logic c=
ould be
> > derived from the presence of host-serial=3Dpassthrough and host-model=
=3Dpassthrough
> > options.
> >=20
> > What do you think?
>=20
> That's an excellent point - I hadn't thought through the fact that
> this is the same information exposed by those properties.  I do indeed
> think that exposing the same information set in those properties - and
> thereby avoiding the new machine option - would be a better plan.
>=20

I saw that the patch was applied. So I will work in another patch
to use these properties and remove the export-vpd option.

Another thing that I thought the fact that 'host-serial' and 'host-model'
nodes in Device Tree are not in accordance with LoPAPR document. What
you think in use only get-vpd to get these information and remove
nodes from device tree?

> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _oth=
er_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
