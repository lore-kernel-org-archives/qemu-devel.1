Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25257C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7610206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvyZCPjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7610206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT38V-0005HJ-1B
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iT37q-0004or-HX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iT37n-0007Gt-Tx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:12:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46534
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iT37n-0007DD-BJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573215142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ceIARZThEEPLFjMSs4jgXIDGcaNsRfs0vsliYEtwPk=;
 b=WvyZCPjOmFmpfJE8e9nxuJ0Zknvpx4PTZ5yuqgQQtGntLQVNlgPnmUXQrRZowdHwoM/Vv1
 EWZ1LnF+jG1DkatDi9L66HMF5T46Cx+k9leyQh3FEdpB/GAq4jFyq6QekI0HKlMwZeoHys
 3l2jZ1vY0/UO7dqL+ZNQN5hVEennodI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-lifbCqORM7qT0X4zdtwkHQ-1; Fri, 08 Nov 2019 07:12:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8E131005502;
 Fri,  8 Nov 2019 12:12:16 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 910E51001902;
 Fri,  8 Nov 2019 12:12:11 +0000 (UTC)
Date: Fri, 8 Nov 2019 13:12:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v15 07/12] numa: Calculate hmat latency and bandwidth
 entry list
Message-ID: <20191108131210.64096a99@redhat.com>
In-Reply-To: <20191107074511.14304-8-tao3.xu@intel.com>
References: <20191107074511.14304-1-tao3.xu@intel.com>
 <20191107074511.14304-8-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: lifbCqORM7qT0X4zdtwkHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, jingqi.liu@intel.com, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  7 Nov 2019 15:45:06 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> Compress HMAT latency and bandwidth raw data into uint16_t data,
> which can be stored in HMAT table.
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> No changes in v15.
>=20
> Changes in v14:
>     - Convert latency from ns to ps, because ACPI 6.3 HMAT table use
>       ps as minimum unit
> ---
>  hw/core/numa.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index f391760c20..523dd80822 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -483,6 +483,47 @@ static void complete_init_numa_distance(MachineState=
 *ms)
>      }
>  }
> =20
> +static void calculate_hmat_entry_list(HMAT_LB_Info *hmat_lb, int num_nod=
es)
I'd call it verify_hmat_entry_list()
and I'd only do checks here without post-processing data
into something else, provided there is checks that requires
all hmat-lb option parsed first.

> +{
> +    int i, index;
> +    uint16_t *entry_list;
> +    uint64_t base;
> +    GArray *lb_data_list;
> +    HMAT_LB_Data *lb_data;
> +
> +    if (hmat_lb->data_type <=3D HMAT_LB_DATA_WRITE_LATENCY) {
> +        base =3D hmat_lb->base_latency;
> +        lb_data_list =3D hmat_lb->latency;
> +    } else {
> +        base =3D hmat_lb->base_bandwidth;
> +        lb_data_list =3D hmat_lb->bandwidth;
> +    }
> +
> +    entry_list =3D g_malloc0(lb_data_list->len * sizeof(uint16_t));
> +    for (i =3D 0; i < lb_data_list->len; i++) {
> +        lb_data =3D &g_array_index(lb_data_list, HMAT_LB_Data, i);
> +        index =3D lb_data->initiator * num_nodes + lb_data->target;
> +        if (entry_list[index]) {
> +            error_report("Duplicate configuration of the latency for "
> +                "initiator=3D%d and target=3D%d.", lb_data->initiator,
> +                lb_data->target);
Is it possible to detect duplicate during hamt-lb option parsing?


> +            exit(1);
> +        }

> +        entry_list[index] =3D (uint16_t)(lb_data->rawdata / base);
> +    }
> +    if (hmat_lb->data_type <=3D HMAT_LB_DATA_WRITE_LATENCY) {
> +        /* Convert latency base from nanoseconds to picosecond */
> +        hmat_lb->base_latency =3D base * 1000;
> +        hmat_lb->entry_latency =3D entry_list;
> +    } else {
> +        /* Convert bandwidth base from Byte to Megabyte */
> +        hmat_lb->base_bandwidth =3D base / MiB;
> +        hmat_lb->entry_bandwidth =3D entry_list;
> +    }
I suggest to move this hunk to 10/12 and drop entry_foo fields
as build_hmat_lb() can walk over lb_data_list and normalize values
put in ACPI table on its own.

In generic numa code is to check that user provided values won't
(under|over-flow) ACPI table values once dived/multiplied,
but leave actual data packing into table to ACPI code.

> +}
> +
>  void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>                                   int nb_nodes, ram_addr_t size)
>  {
> @@ -521,9 +562,10 @@ void numa_default_auto_assign_ram(MachineClass *mc, =
NodeInfo *nodes,
> =20
>  void numa_complete_configuration(MachineState *ms)
>  {
> -    int i;
> +    int i, hierarchy, type;
>      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>      NodeInfo *numa_info =3D ms->numa_state->nodes;
> +    HMAT_LB_Info *numa_hmat_lb;
> =20
>      /*
>       * If memory hotplug is enabled (slots > 0) but without '-numa'
> @@ -620,6 +662,21 @@ void numa_complete_configuration(MachineState *ms)
>              /* Validation succeeded, now fill in any missing distances. =
*/
>              complete_init_numa_distance(ms);
>          }
> +
> +        if (ms->numa_state->hmat_enabled) {
> +            for (hierarchy =3D HMAT_LB_MEM_MEMORY;
> +                 hierarchy <=3D HMAT_LB_MEM_CACHE_3RD_LEVEL; hierarchy++=
) {
> +                for (type =3D HMAT_LB_DATA_ACCESS_LATENCY;
> +                    type <=3D HMAT_LB_DATA_WRITE_BANDWIDTH; type++) {
> +                    numa_hmat_lb =3D ms->numa_state->hmat_lb[hierarchy][=
type];
> +
> +                    if (numa_hmat_lb) {
> +                        calculate_hmat_entry_list(numa_hmat_lb,
> +                                                  ms->numa_state->num_no=
des);
> +                    }
> +                }
> +            }
> +        }
>      }
>  }
> =20


