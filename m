Received: from eggs.gnu.org ([2001:4830:134:3::10]:40264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1da6np-0004nF-3b
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1da6nl-00028m-RF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:51:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1da6nl-00027m-HS
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 16:51:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6PKml7R036923
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 16:51:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxavfpwt8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 16:51:31 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Jul 2017 16:51:30 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <150100572350.27487.14857589060586322098.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100572350.27487.14857589060586322098.stgit@bahia>
Date: Tue, 25 Jul 2017 15:51:21 -0500
Message-Id: <150101588183.26979.18259704887837340588@loki>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 19/26] spapr: populate PHB DRC
 entries for root DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Quoting Greg Kurz (2017-07-25 13:02:03)
> From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> =

> This add entries to the root OF node to advertise our PHBs as being
> DR-capable in accordance with PAPR specification.
> =

> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> Changes since RFC:
> - rebased against ppc-for-2.10
> - use error_report
> ---
>  hw/ppc/spapr.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> =

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5950c009ab7e..632040f35ecc 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1151,6 +1151,16 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
>          exit(1);
>      }
> =

> +    if (smc->dr_phb_enabled) {
> +        int offset =3D fdt_path_offset(fdt, "/");
> +        ret =3D spapr_drc_populate_dt(fdt, offset, NULL,
> +                                    SPAPR_DR_CONNECTOR_TYPE_PHB);

This might actually clobber LMB/MEM entries added earlier since they both
try to create the /ibm,drc* entries in / from scratch.
  =

If that's the case, we can arrange the code something like:
  =

  uint32_t root_drc_types =3D 0;
  =

  if (smc->dr_lmb_enabled) {
      root_drc_types |=3D SPAPR_DR_CONNECTOR_TYPE_LMB;
  }
  =

  if (smc->dr_phb_enabled) {
      root_drc_types |=3D SPAPR_DR_CONNECTOR_TYPE_PHB;
  }
  =

  ...
  =

  if (root_drc_types) {
    int offset =3D fdt_path_offset(fdt, "/");
    ret =3D spapr_drc_populate_dt(fdt, offset, NULL, root_drc_types);
  }


> +        if (ret < 0) {
> +            error_report("Couldn't set up PHB DR device tree properties"=
);
> +            exit(1);
> +        }
> +    }
> +
>      return fdt;
>  }
> =

>=20
