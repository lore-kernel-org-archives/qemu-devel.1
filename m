Received: from eggs.gnu.org ([2001:4830:134:3::10]:50507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3knx-0005Q7-QA
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3knt-0007e1-RV
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:58:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f3knt-0007dg-Lr
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:58:29 -0400
References: <20180328163630.48576-1-dgilbert@redhat.com>
	<20180328163630.48576-6-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86bfefcd-f256-2522-0635-ccb38d34214d@redhat.com>
Date: Wed, 4 Apr 2018 17:58:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180328163630.48576-6-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] e1000: Choose which set of props to
 migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, eswierk@skyportsystems.com, jasowang@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com

On 28/03/2018 18:36, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> When we're using the subsection we migrate both
> the 'props' and 'tso_props' data; when we're not using
> the subsection (to migrate to 2.11 or old machine types) we've
> got to choose what to migrate in the main structure.
> 
> If we're using the subsection migrate 'props' in the main structure.
> If we're not using the subsection then migrate the last one
> that changed, which gives behaviour similar to the old behaviour.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/net/e1000.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 4e606d4b2a..13a9494a8d 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -130,6 +130,7 @@ typedef struct E1000State_st {
>  #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
>      uint32_t compat_flags;
>      bool received_tx_tso;
> +    bool use_tso_for_migration;
>      e1000x_txd_props mig_props;
>  } E1000State;
>  
> @@ -622,9 +623,11 @@ process_tx_desc(E1000State *s, struct e1000_tx_desc *dp)
>      if (dtype == E1000_TXD_CMD_DEXT) {    /* context descriptor */
>          if (le32_to_cpu(xp->cmd_and_length) & E1000_TXD_CMD_TSE) {
>              e1000x_read_tx_ctx_descr(xp, &tp->tso_props);
> +            s->use_tso_for_migration = 1;
>              tp->tso_frames = 0;
>          } else {
>              e1000x_read_tx_ctx_descr(xp, &tp->props);
> +            s->use_tso_for_migration = 0;
>          }
>          return;
>      } else if (dtype == (E1000_TXD_CMD_DEXT | E1000_TXD_DTYP_D)) {
> @@ -1366,7 +1369,20 @@ static int e1000_pre_save(void *opaque)
>          s->phy_reg[PHY_STATUS] |= MII_SR_AUTONEG_COMPLETE;
>      }
>  
> -    s->mig_props = s->tx.props;
> +    /* Decide which set of props to migrate in the main structure */
> +    if (chkflag(TSO) || !s->use_tso_for_migration) {
> +        /* Either we're migrating with the extra subsection, in which
> +         * case the mig_props is always 'props' OR
> +         * we've not got the subsection, but 'props' was the last
> +         * updated.
> +         */
> +        s->mig_props = s->tx.props;
> +    } else {
> +        /* We're not using the subsection, and 'tso_props' was
> +         * the last updated.
> +         */
> +        s->mig_props = s->tx.tso_props;
> +    }
>      return 0;
>  }

Looks good, thanks!

Paolo
