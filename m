Received: from eggs.gnu.org ([2001:4830:134:3::10]:40411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXkJt-0003kd-6S
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXkJo-0005mE-9s
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:31:29 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:52282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fXkJo-0005ho-1s
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:31:24 -0400
Received: from player770.ha.ovh.net (unknown [10.109.122.108])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id B57BC1A9C1
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:31:15 +0200 (CEST)
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
	<CAFEAcA_qv=PEzDOh8FB5F-uhbbtHrr7nRWPjXehyjkmj_cJ-AQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0826a256-5c9d-5b7d-7ec2-fcba748e2124@kaod.org>
Date: Tue, 26 Jun 2018 11:31:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_qv=PEzDOh8FB5F-uhbbtHrr7nRWPjXehyjkmj_cJ-AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/23] ppc/pnv: introduce a new
 intc_create() operation to the chip model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 06/26/2018 11:07 AM, Peter Maydell wrote:
> On 22 June 2018 at 05:24, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> On Power9, the thread interrupt presenter has a different type and is
>> linked to the chip owning the cores.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/ppc/pnv.c         | 21 +++++++++++++++++++--
>>  hw/ppc/pnv_core.c    | 18 +++++++++---------
>>  include/hw/ppc/pnv.h |  1 +
>>  3 files changed, 29 insertions(+), 11 deletions(-)
>=20
> Hi; Coverity points out a bug (CID 1393617) in this patch
> (which is commit d35aefa9ae150a):
>=20
>> @@ -143,13 +144,12 @@ static void pnv_core_realize(DeviceState *dev, E=
rror **errp)
>>      void *obj;
>>      int i, j;
>>      char name[32];
>> -    Object *xi;
>> +    Object *chip;
>>
>> -    xi =3D object_property_get_link(OBJECT(dev), "xics", &local_err);
>> -    if (!xi) {
>> -        error_setg(errp, "%s: required link 'xics' not found: %s",
>> -                   __func__, error_get_pretty(local_err));
>> -        return;
>> +    chip =3D object_property_get_link(OBJECT(dev), "chip", &local_err=
);
>> +    if (!chip) {
>> +        error_propagate(errp, local_err);
>> +        error_prepend(errp, "required link 'chip' not found: ");
>>      }
>=20
> We check for a NULL 'chip' pointer, but forget the 'return', so
> execution will plough on through to the code below and eventually
> dereference the NULL pointer and segfault.

arg. My fault. I will send a fix.

Thanks,

C.=20
