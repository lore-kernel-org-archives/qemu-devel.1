Received: from eggs.gnu.org ([2001:4830:134:3::10]:56949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fsjyf-0006r0-JD
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 03:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fsjyb-0002Ot-Ke
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 03:24:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45726
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fsjyb-0002Od-FV
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 03:24:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7N7NxMx098310
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 03:24:16 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2m1r06h7u5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 03:24:16 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 23 Aug 2018 08:24:14 +0100
References: <153496608036.29987.17320139395542439335.stgit@gimli.home>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 23 Aug 2018 09:24:10 +0200
MIME-Version: 1.0
In-Reply-To: <153496608036.29987.17320139395542439335.stgit@gimli.home>
Content-Language: en-US
Message-Id: <c3cc7022-743c-8e3c-d32f-304450393e80@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] postcopy: Synchronize usage of the balloon
 inhibitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, peter.maydell@linaro.org



On 08/22/2018 09:32 PM, Alex Williamson wrote:
> While the qemu_balloon_inhibit() interface appears rather general purpose,
> postcopy uses it in a last-caller-wins approach with no guarantee of balanced
> inhibits and de-inhibits.  Wrap postcopy's usage of the inhibitor to give it
> one vote overall, using the same last-caller-wins approach as previously
> implemented at the balloon level.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: 01ccbec7bdf6 ("balloon: Allow multiple inhibit users")

This make qemu iotest 169 working again. 

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>


> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> Note that checkpatch.pl doesn't appreciate the initialization of the
> static variable to false, imo it improves the readability of the code
> in this instance, so I've left it.  Shout if you disagree.
> 
> If this gets acks I can include it with a pull request for a couple
> other fixes to the original series.  Thanks
> 
>  migration/postcopy-ram.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 932f18894990..c2e387ed44b4 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -509,6 +509,20 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis)
>      return 0;
>  }
>  
> +/*
> + * Manage a single vote to the QEMU balloon inhibitor for all postcopy usage,
> + * last caller wins.
> + */
> +static void postcopy_balloon_inhibit(bool state)
> +{
> +    static bool cur_state = false;
> +
> +    if (state != cur_state) {
> +        qemu_balloon_inhibit(state);
> +        cur_state = state;
> +    }
> +}
> +
>  /*
>   * At the end of a migration where postcopy_ram_incoming_init was called.
>   */
> @@ -539,7 +553,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>          mis->have_fault_thread = false;
>      }
>  
> -    qemu_balloon_inhibit(false);
> +    postcopy_balloon_inhibit(false);
>  
>      if (enable_mlock) {
>          if (os_mlock() < 0) {
> @@ -1107,7 +1121,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>       * Ballooning can mark pages as absent while we're postcopying
>       * that would cause false userfaults.
>       */
> -    qemu_balloon_inhibit(true);
> +    postcopy_balloon_inhibit(true);
>  
>      trace_postcopy_ram_enable_notify();
>  
> 
