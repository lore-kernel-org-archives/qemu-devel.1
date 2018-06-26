Received: from eggs.gnu.org ([2001:4830:134:3::10]:47115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXqy4-0006zN-Pw
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXqxz-0004TQ-RB
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:37:24 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:58186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fXqxz-0004T5-Jv
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:37:19 -0400
Received: from player789.ha.ovh.net (unknown [10.109.122.66])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id E6FC1D47F8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 18:37:17 +0200 (CEST)
References: <20180625091718.18544-1-clg@kaod.org>
	<20180626152733.5050d9e3@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <120947ab-6846-aded-b946-59908ca8c4ae@kaod.org>
Date: Tue, 26 Jun 2018 18:37:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180626152733.5050d9e3@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/26/2018 03:27 PM, Greg Kurz wrote:
> On Mon, 25 Jun 2018 11:17:13 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Hello,
>>
>=20
> Hello,
>=20
> Sorry I didn't manage to look at this before it got merged :)
>=20
>> It makes the class hierarchy much cleaner and removes duplicated
>> code. As we are touching the location of the objects states, migration
>> compatibility was checked and the following tests were performed under
>> KVM :
>>
>>   qemu-3.0 (pseries-3.0)   -> qemu-3.0  (pseries-3.0)   OK
>>   qemu-3.0 (pseries-2.12)  -> qemu-2.12 (pseries-2.12)  OK
>>   qemu-3.0 (pseries-2.11)  -> qemu-2.11 (pseries-2.11)  OK
>>   qemu-3.0 (pseries-2.10)  -> qemu-2.10 (pseries-2.10)  OK
>>   qemu-3.0 (pseries-2.9)   -> qemu-2.9  (pseries-2.9)   OK
>>   qemu-3.0 (pseries-2.8)   -> qemu-2.8  (pseries-2.8)   OK
>>   qemu-3.0 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>=20
> What's the failure ?

qemu-system-ppc64: error while loading state for instance 0x0 of device '=
cpu'
qemu-system-ppc64: load of migration failed: Invalid argument

and to be more precise :

   qemu-3.0  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
   qemu-2.12 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
   qemu-2.11 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
   qemu-2.10 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
   qemu-2.9  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
   qemu-2.8  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
   qemu-2.7  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   OK


So it has been a while.

C.=20


>=20
>>
>> and back :
>>
>>   qemu-3.0 (pseries-3.0)  <-  qemu-3.0  (pseries-3.0)   OK
>>   qemu-3.0 (pseries-2.12) <-  qemu-2.12 (pseries-2.12)  OK
>>   qemu-3.0 (pseries-2.11) <-  qemu-2.11 (pseries-2.11)  OK
>>   qemu-3.0 (pseries-2.10) <-  qemu-2.10 (pseries-2.10)  OK
>>   qemu-3.0 (pseries-2.9)  <-  qemu-2.9  (pseries-2.9)   OK
>>   qemu-3.0 (pseries-2.8)  <-  qemu-2.8  (pseries-2.8)   OK
>>   qemu-3.0 (pseries-2.7)  <-  qemu-2.7  (pseries-2.7)   OK
>>
>> under TCG, same scenarios were run but up to 2.10 only, in which case
>> the migration fails for other reasons.
>>
>> I wouldn't mind some extra cross checking from someone else.
>>
>> Thanks,
>>
>> C.
>>
>> Changes since v2:
>>
>>  - split the patch in smaller units. The migration tests were not
>>    rerun because the code is very much the same. make check was run on
>>    each patch.
>>
>>
>> C=C3=A9dric Le Goater (5):
>>   ppc/xics: introduce a parent_realize in ICSStateClass
>>   ppc/xics: move the instance_init handler under the ics-base class
>>   ppx/xics: introduce a parent_reset in ICSStateClass
>>   ppc/xics: move the vmstate structures under the ics-base class
>>   ppc/xics: rework the ICS classes inheritance tree
>>
>>  include/hw/ppc/xics.h |   4 +-
>>  hw/intc/xics.c        | 164 ++++++++++++++++++++++++++++-------------=
---------
>>  hw/intc/xics_kvm.c    |  46 +++++++-------
>>  hw/ppc/spapr.c        |   2 +-
>>  4 files changed, 121 insertions(+), 95 deletions(-)
>>
>=20
