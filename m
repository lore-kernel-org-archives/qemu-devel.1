Received: from eggs.gnu.org ([209.51.188.92]:41776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gyi91-0005hV-Tg
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gyi8z-0005hc-UY
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:11:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1gyi8y-0005bM-2F
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:11:57 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1QJ8xtV011529
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 14:11:46 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qwaxpsn3y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 14:11:45 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Tue, 26 Feb 2019 19:11:44 -0000
Date: Tue, 26 Feb 2019 16:11:40 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20190225162325.24008-1-maxiwell@linux.ibm.com>
	<20190225232009.GB30778@kermit.br.ibm.com>
	<20190226032103.GJ6872@umbus.fritz.box>
	<20190226142126.jxosththzad6h6dd@maxibm>
	<20190226170830.GA16569@kermit.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226170830.GA16569@kermit.br.ibm.com>
Message-Id: <20190226191140.GA25467@kermit.br.ibm.com>
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
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, Feb 26, 2019 at 02:08:30PM -0300, Murilo Opsfelder Araujo wrote:
> Hi, Maxiwell.
>
> On Tue, Feb 26, 2019 at 11:21:26AM -0300, Maxiwell S. Garcia wrote:
> > On Tue, Feb 26, 2019 at 02:21:03PM +1100, David Gibson wrote:
> > > On Mon, Feb 25, 2019 at 08:20:09PM -0300, Murilo Opsfelder Araujo w=
rote:
> > > > Hi, Maxiwell.
> > > >
> > > > On Mon, Feb 25, 2019 at 01:23:25PM -0300, Maxiwell S. Garcia wrot=
e:
> > > > > This adds a handler for ibm,get-vpd RTAS calls, allowing pserie=
s
> > > > > guest to collect host information. It is disabled by default to
> > > > > avoid unwanted information leakage. To enable it, use:
> > > > > =E2=80=98-M pseries,vpd-export=3Don=E2=80=99
> > > >
> > > > The patch for setting host-serial and host-model already landed G=
ibson's
> > > > ppc-for-4.0 branch:
> > > >
> > > >   commit 9e584f45868f6945c1282c938278038cba0e4af2
> > > >   Author: Prasad J Pandit <pjp@fedoraproject.org>
> > > >   Date:   Mon Feb 18 23:43:49 2019 +0530
> > > >
> > > >       ppc: add host-serial and host-model machine attributes (CVE=
-2019-8934)
> > > >
> > > >
> > > > QEMU should only return host-serial and host-model from the host =
if the
> > > > following combination of parameters are provided:
> > > >
> > > >   -M host-serial=3Dpassthrough,host-model=3Dpassthrough,vpd-expor=
t=3Don
> > > >
> > > > If host-serial or host-model are set with a user-string, ibm,get-=
vpd should
> > > > honor these values and return them, not exposing host information=
 by accident.
> > > >
> > > > I'm not even sure if we need vpd-export=3D<bool> setting. Its log=
ic could be
> > > > derived from the presence of host-serial=3Dpassthrough and host-m=
odel=3Dpassthrough
> > > > options.
> > > >
> > > > What do you think?
> > >
> > > That's an excellent point - I hadn't thought through the fact that
> > > this is the same information exposed by those properties.  I do ind=
eed
> > > think that exposing the same information set in those properties - =
and
> > > thereby avoiding the new machine option - would be a better plan.
> > >
> >
> > I saw that the patch was applied. So I will work in another patch
> > to use these properties and remove the export-vpd option.
> >
> > Another thing that I thought the fact that 'host-serial' and 'host-mo=
del'
> > nodes in Device Tree are not in accordance with LoPAPR document. What
> > you think in use only get-vpd to get these information and remove
> > nodes from device tree?
>
> Both "system-id" and "model" properties are described in the section "3=
.3.2.1
> Root Node Properties" of the "Device Tree Bindings: Linux on Power Arch=
itecture
> Reference" document:
>
>   https://members.openpowerfoundation.org/wg/SYSSW/document/1455

I replied too early. As Maxiwell explained to me (thanks Max!), guest can=
 end up
having the following entries under /proc/device-tree/ (among other entrie=
s):

  $ cat host-serial
  12A3B4C

  $ cat host-model
  1234-56A

  $ cat system-id
  c7b62da9-3d0c-44f9-8edb-2318271f3c1a

  $ cat model
  IBM pSeries (emulated by qemu)

Where:

  - host-serial/host-model: depend on "-M host-serial" and "-M host-model=
"
    machine options.

  - system-id: created when "-uuid <val>" exists in qemu command line opt=
ions.

  - model: hard-coded.

With this patch, RTAS ibm,get-vpd call will return "system-id" and "model=
" from
the host, not from the guest. I found this confusing.

Perhaps we can trick ibm,get-vpd call to return "host-serial" and "host-m=
odel"
values from the guest, which will hold safe values after commit
9e584f45868f6945c1282c938278038cba0e4af2 "ppc: add host-serial and host-m=
odel
machine attributes (CVE-2019-8934)".

What do you think?

As to removing "host-serial" and "host-model", I am not entirely sure for=
 what
they are used. There should be a reason for them to exist.

--
Murilo
