Received: from eggs.gnu.org ([2001:4830:134:3::10]:52042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1droz5-0006uR-82
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1droz4-0006fo-CZ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:28:27 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:37352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1droz4-0006fM-62
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:28:26 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k20so24183513wre.4
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 10:28:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170908103558.31632-3-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
	<20170908103558.31632-3-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 18:28:04 +0100
Message-ID: <CAFEAcA_geEmuB5mdTZ2BrvpwOve5w9++eAfRXmNTZh+36__VqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 02/40] hw/ppc: clear pending_events on
 machine reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Igor Mammedov <imammedo@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On 8 September 2017 at 11:35, David Gibson <david@gibson.dropbear.id.au> wrote:
> From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>
> The sPAPR machine isn't clearing up the pending events QTAILQ on
> machine reboot. This allows for unprocessed hotplug/epow events
> to persist in the queue after reset and, when reasserting the IRQs in
> check_exception later on, these will be being processed by the OS.
>
> This patch implements a new function called 'spapr_clear_pending_events'
> that clears up the pending_events QTAILQ. This helper is then called
> inside ppc_spapr_reset to clear up the events queue, preventing
> old/deprecated events from persisting after a reset.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

> +void spapr_clear_pending_events(sPAPRMachineState *spapr)
> +{
> +    sPAPREventLogEntry *entry = NULL;
> +
> +    QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
> +        QTAILQ_REMOVE(&spapr->pending_events, entry, next);
> +        g_free(entry->extended_log);
> +        g_free(entry);
> +    }
> +}

Coverity points out that this is a use-after-free error,
because QTAILQ_FOREACH will access the list pointers of
entry after the loop body has freed it. You want
QTAILQ_FOREACH_SAFE, I think. (CID 1381017)

thanks
-- PMM
