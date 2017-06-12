Received: from eggs.gnu.org ([2001:4830:134:3::10]:35078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dKNOq-0003xN-1u
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dKNOj-0001nd-RO
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:20:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dKNOj-0001nZ-LG
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 07:20:41 -0400
Date: Mon, 12 Jun 2017 13:20:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170612132034.1d15ab04@nial.brq.redhat.com>
In-Reply-To: <1497097821-32754-2-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-2-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] fw_cfg: move initialisation of
 FWCfgState into instance_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

On Sat, 10 Jun 2017 13:30:16 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/nvram/fw_cfg.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 316fca9..144e0c6 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1017,6 +1017,15 @@ FWCfgState *fw_cfg_find(void)
>      return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
>  }
>  
> +static void fw_cfg_init(Object *obj)
> +{
> +    FWCfgState *s = FW_CFG(obj);
> +
> +    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
> +    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
> +    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
it doesn't seem right,

consider,
 object_new(fwcfg)
   1: fw_cfg_init -> g_new0(FWCfgEntry, fw_cfg_max_entry(s) -> FW_CFG_FILE_SLOTS_DFLT);
   2: set property x-file-slots
   3: realize -> fw_cfg_file_slots_allocate()

> @@ -1052,10 +1062,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
>                     file_slots_max);
>          return;
>      }
> -
> -    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
> -    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
> -    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
opps, s->entries doesn't account for new values of x-file-slots

So question is why this patch is needed at all (it needs some reasoning in commit message)?

So for now NACK and I'd suggest to drop this patch.
