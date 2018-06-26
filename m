Received: from eggs.gnu.org ([2001:4830:134:3::10]:57826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXo0h-0003Y5-Pf
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXo0c-0003g7-Nx
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:27:55 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:48763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXo0c-0003RX-6O
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:27:50 -0400
Received: from player771.ha.ovh.net (unknown [10.109.120.94])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id EA378B7CD1
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 15:27:41 +0200 (CEST)
Date: Tue, 26 Jun 2018 15:27:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180626152733.5050d9e3@bahia.lan>
In-Reply-To: <20180625091718.18544-1-clg@kaod.org>
References: <20180625091718.18544-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/5] rework the ICS classes
 inheritance tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 25 Jun 2018 11:17:13 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Hello,
>=20

Hello,

Sorry I didn't manage to look at this before it got merged :)

> It makes the class hierarchy much cleaner and removes duplicated
> code. As we are touching the location of the objects states, migration
> compatibility was checked and the following tests were performed under
> KVM :
>=20
>   qemu-3.0 (pseries-3.0)   -> qemu-3.0  (pseries-3.0)   OK
>   qemu-3.0 (pseries-2.12)  -> qemu-2.12 (pseries-2.12)  OK
>   qemu-3.0 (pseries-2.11)  -> qemu-2.11 (pseries-2.11)  OK
>   qemu-3.0 (pseries-2.10)  -> qemu-2.10 (pseries-2.10)  OK
>   qemu-3.0 (pseries-2.9)   -> qemu-2.9  (pseries-2.9)   OK
>   qemu-3.0 (pseries-2.8)   -> qemu-2.8  (pseries-2.8)   OK
>   qemu-3.0 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL

What's the failure ?

>=20
> and back :
>=20
>   qemu-3.0 (pseries-3.0)  <-  qemu-3.0  (pseries-3.0)   OK
>   qemu-3.0 (pseries-2.12) <-  qemu-2.12 (pseries-2.12)  OK
>   qemu-3.0 (pseries-2.11) <-  qemu-2.11 (pseries-2.11)  OK
>   qemu-3.0 (pseries-2.10) <-  qemu-2.10 (pseries-2.10)  OK
>   qemu-3.0 (pseries-2.9)  <-  qemu-2.9  (pseries-2.9)   OK
>   qemu-3.0 (pseries-2.8)  <-  qemu-2.8  (pseries-2.8)   OK
>   qemu-3.0 (pseries-2.7)  <-  qemu-2.7  (pseries-2.7)   OK
>=20
> under TCG, same scenarios were run but up to 2.10 only, in which case
> the migration fails for other reasons.
>=20
> I wouldn't mind some extra cross checking from someone else.
>=20
> Thanks,
>=20
> C.
>=20
> Changes since v2:
>=20
>  - split the patch in smaller units. The migration tests were not
>    rerun because the code is very much the same. make check was run on
>    each patch.
>=20
>=20
> C=C3=A9dric Le Goater (5):
>   ppc/xics: introduce a parent_realize in ICSStateClass
>   ppc/xics: move the instance_init handler under the ics-base class
>   ppx/xics: introduce a parent_reset in ICSStateClass
>   ppc/xics: move the vmstate structures under the ics-base class
>   ppc/xics: rework the ICS classes inheritance tree
>=20
>  include/hw/ppc/xics.h |   4 +-
>  hw/intc/xics.c        | 164 ++++++++++++++++++++++++++++----------------=
------
>  hw/intc/xics_kvm.c    |  46 +++++++-------
>  hw/ppc/spapr.c        |   2 +-
>  4 files changed, 121 insertions(+), 95 deletions(-)
>=20
