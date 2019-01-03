Received: from eggs.gnu.org ([208.118.235.92]:37378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gfAzh-0006GO-S0
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gfAzd-0002pA-Sy
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:57:37 -0500
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:57370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gfAzd-0002mV-Mi
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:57:33 -0500
Received: from player157.ha.ovh.net (unknown [10.109.159.35])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id AB77FF19A0
	for <qemu-devel@nongnu.org>; Thu,  3 Jan 2019 22:57:31 +0100 (CET)
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
	<20181221054606.22007-36-david@gibson.dropbear.id.au>
	<CAFEAcA9ZV0O7VohX-_S7mgerGU6Y+jAHMRgK9TB8tyBgBxbNOA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1f070fd5-1d27-36c7-6f86-d70be560cf57@kaod.org>
Date: Thu, 3 Jan 2019 22:57:21 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ZV0O7VohX-_S7mgerGU6Y+jAHMRgK9TB8tyBgBxbNOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 35/40] spapr: extend the sPAPR IRQ backend
 for XICS migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, gkurz@redhat.com, Laurent Vivier <lvivier@redhat.com>

On 1/3/19 8:07 PM, Peter Maydell wrote:
> On Fri, 21 Dec 2018 at 05:46, David Gibson <david@gibson.dropbear.id.au=
> wrote:
>>
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> Introduce a new sPAPR IRQ handler to handle resend after migration
>> when the machine is using a KVM XICS interrupt controller model.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
>> @@ -1758,6 +1750,11 @@ static int spapr_post_load(void *opaque, int ve=
rsion_id)
>>          }
>>      }
>>
>> +    err =3D spapr_irq_post_load(spapr, version_id);
>> +    if (err) {
>> +        return err;
>> +    }
>> +
>=20
> Hi; this change causes Coverity to complain (CID 1398591) that
> we're now overwriting the setting of err in the earlier
>  err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
> without ever testing it. (We also do this in the existing
> codepath that calls kvmppc_configure_v3_mmu().)

yes. I suppose we have been missing something like :

@@ -1754,6 +1754,9 @@ static int spapr_post_load(void *opaque,
      * value into the RTC device */
     if (version_id < 3) {
         err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
+        if (err) {
+            return err;
+        }
     }
=20
     if (kvm_enabled() && spapr->patb_entry) {


C.=20

>=20
> Should the call to spapr_rtc_import_offset() have its
> own "if (err) do something" code, or should it simply
> be ignoring its return value entirely, or something
> more complicated ?
>=20
> thanks
> -- PMM
>=20
