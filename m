Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D860BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8C2206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8C2206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLN8-0004tn-Ty
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iBL6a-0007zY-6l
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iBL6W-0003VL-7F
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:45:55 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:60361)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iBL6W-0003SR-1C
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:45:52 -0400
Received: from player694.ha.ovh.net (unknown [10.109.160.153])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3A7E924F59E
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 17:45:49 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id C3C669FC0D11;
 Fri, 20 Sep 2019 15:45:35 +0000 (UTC)
Subject: Re: [PATCH 01/15] ipmi: Fix watchdog NMI handling
To: minyard@acm.org, Peter Maydell <peter.maydell@linaro.org>
References: <20190919213924.31852-1-minyard@acm.org>
 <20190919213924.31852-2-minyard@acm.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f2d62bba-8e46-7359-2340-d07e4424f53e@kaod.org>
Date: Fri, 20 Sep 2019 17:45:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919213924.31852-2-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 17594437847848946616
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddvgdelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.51.82
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/2019 23:39, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> The wrong logic was used for detection (so it wouldn't work at all)
> and the wrong interface was used to inject the NMI if the detection
> logic was correct.
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.

> ---
>  hw/ipmi/ipmi.c         | 6 +++---
>  hw/ipmi/ipmi_bmc_sim.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> index 136c86b7a7..cbe158f815 100644
> --- a/hw/ipmi/ipmi.c
> +++ b/hw/ipmi/ipmi.c
> @@ -28,9 +28,8 @@
>  #include "qom/object_interfaces.h"
>  #include "sysemu/runstate.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc.h"
> -#include "qapi/visitor.h"
>  #include "qemu/module.h"
> +#include "hw/nmi.h"
> =20
>  static uint32_t ipmi_current_uuid =3D 1;
> =20
> @@ -60,7 +59,8 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_=
op op, int checkonly)
>          if (checkonly) {
>              return 0;
>          }
> -        qmp_inject_nmi(NULL);
> +        /* We don't care what CPU we use. */
> +        nmi_monitor_handle(0, NULL);
>          return 0;
> =20
>      case IPMI_SHUTDOWN_VIA_ACPI_OVERTEMP:
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 246a6d390c..8f63bb7181 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -1194,7 +1194,7 @@ static void set_watchdog_timer(IPMIBmcSim *ibs,
>          break;
> =20
>      case IPMI_BMC_WATCHDOG_PRE_NMI:
> -        if (!k->do_hw_op(s, IPMI_SEND_NMI, 1)) {
> +        if (k->do_hw_op(s, IPMI_SEND_NMI, 1)) {
>              /* NMI not supported. */
>              rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
>              return;
>=20


