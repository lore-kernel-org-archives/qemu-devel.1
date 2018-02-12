Received: from eggs.gnu.org ([2001:4830:134:3::10]:35854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elGpY-0005bv-Uu
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elGpV-0005UC-CD
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:19:48 -0500
References: <20180212154903.8859-1-dgilbert@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5def95cc-278f-108c-5538-8ba2df37bd5e@redhat.com>
Date: Mon, 12 Feb 2018 17:19:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180212154903.8859-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390/stattrib: Make SaveVMHandlers data
 static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, Cornelia Huck <cohuck@redhat.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

On 12.02.2018 16:49, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> There's no need for this to be dynamic, make it static.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/s390x/s390-stattrib.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index a1d2135a60..adf07ef312 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -365,22 +365,22 @@ static inline void s390_stattrib_set_migration_enabled(Object *obj, bool value,
>      s->migration_enabled = value;
>  }
>  
> +static SaveVMHandlers savevm_s390_stattrib_handlers = {
> +    .save_setup = cmma_save_setup,
> +    .save_live_iterate = cmma_save_iterate,
> +    .save_live_complete_precopy = cmma_save_complete,
> +    .save_live_pending = cmma_save_pending,
> +    .save_cleanup = cmma_save_cleanup,
> +    .load_state = cmma_load,
> +    .is_active = cmma_active,
> +};
> +
>  static void s390_stattrib_instance_init(Object *obj)
>  {
>      S390StAttribState *sas = S390_STATTRIB(obj);
> -    SaveVMHandlers *ops;
> -
> -    /* ops will always be freed by qemu when unregistering */
> -    ops = g_new0(SaveVMHandlers, 1);
> -
> -    ops->save_setup = cmma_save_setup;
> -    ops->save_live_iterate = cmma_save_iterate;
> -    ops->save_live_complete_precopy = cmma_save_complete;
> -    ops->save_live_pending = cmma_save_pending;
> -    ops->save_cleanup = cmma_save_cleanup;
> -    ops->load_state = cmma_load;
> -    ops->is_active = cmma_active;
> -    register_savevm_live(NULL, TYPE_S390_STATTRIB, 0, 0, ops, sas);
> +
> +    register_savevm_live(NULL, TYPE_S390_STATTRIB, 0, 0,
> +                         &savevm_s390_stattrib_handlers, sas);
>  
>      object_property_add_bool(obj, "migration-enabled",
>                               s390_stattrib_get_migration_enabled,
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
