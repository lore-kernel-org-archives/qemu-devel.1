Received: from eggs.gnu.org ([2001:4830:134:3::10]:50557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gHXqN-0002Pc-QQ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gHXqI-0003SJ-A9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:30:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1gHXqH-0003Rd-Rj
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:30:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9UHTgXH080653
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 13:30:11 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2neufe8uhk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 13:30:11 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Tue, 30 Oct 2018 13:30:10 -0400
Date: Tue, 30 Oct 2018 14:30:02 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030111348.14713-2-kraxel@redhat.com>
Message-Id: <20181030173002.GA4914@kermit-br-ibm-com.br.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hi, Gerd.

On Tue, Oct 30, 2018 at 12:13:45PM +0100, Gerd Hoffmann wrote:
> Indicates support state for somerhing (device, backend, subsystem, ...)
> in qemu.  Modeled roughly after the "S:" states we have in MAINTANERS.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/qemu/support-state.h | 17 +++++++++++++++++
>  util/support-state.c         | 23 +++++++++++++++++++++++
>  qapi/common.json             | 16 ++++++++++++++++
>  util/Makefile.objs           |  1 +
>  4 files changed, 57 insertions(+)
>  create mode 100644 include/qemu/support-state.h
>  create mode 100644 util/support-state.c
> 
> diff --git a/include/qemu/support-state.h b/include/qemu/support-state.h
> new file mode 100644
> index 0000000000..5fd3c83eee
> --- /dev/null
> +++ b/include/qemu/support-state.h
> @@ -0,0 +1,17 @@
> +#ifndef QEMU_SUPPORT_STATE_H
> +#define QEMU_SUPPORT_STATE_H
> +
> +#include "qapi/qapi-types-common.h"
> +
> +typedef struct QemuSupportState {
> +    SupportState state;
> +    const char *reason;
> +} QemuSupportState;
> +
> +void qemu_warn_support_state(const char *type, const char *name,
> +                             QemuSupportState *state);
> +
> +bool qemu_is_deprecated(QemuSupportState *state);
> +bool qemu_is_obsolete(QemuSupportState *state);
> +
> +#endif /* QEMU_SUPPORT_STATE_H */
> diff --git a/util/support-state.c b/util/support-state.c
> new file mode 100644
> index 0000000000..7966fa0fc7
> --- /dev/null
> +++ b/util/support-state.c
> @@ -0,0 +1,23 @@
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/support-state.h"
> +
> +void qemu_warn_support_state(const char *type, const char *name,
> +                             QemuSupportState *state)
> +{
> +    warn_report("%s %s is %s%s%s%s", type, name,
> +                SupportState_str(state->state),
> +                state->reason ? " ("          : "",
> +                state->reason ? state->reason : "",
> +                state->reason ? ")"           : "");
> +}
> +
> +bool qemu_is_deprecated(QemuSupportState *state)
> +{
> +    return state->state == SUPPORT_STATE_DEPRECATED;
> +}
> +
> +bool qemu_is_obsolete(QemuSupportState *state)
> +{
> +    return state->state == SUPPORT_STATE_OBSOLETE;
> +}
> diff --git a/qapi/common.json b/qapi/common.json
> index 021174f04e..78176151af 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -151,3 +151,19 @@
>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> +
> +##
> +# @SupportState:
> +#
> +# Indicate Support level of qemu devices, backends, subsystems, ...
> +#
> +# Since: 3.2
> +##
> +{ 'enum': 'SupportState',
> +  'data': [ 'unknown',
> +            'supported',
> +            'maintained',
> +            'odd-fixes',
> +            'orphan',
> +            'obsolete',
> +            'deprecated' ] }

Regardless how fine-grained we decide to be here, is it possible that
you describe in the documentation comment where each state shall be
used?

-- 
Murilo
