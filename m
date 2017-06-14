Received: from eggs.gnu.org ([2001:4830:134:3::10]:41829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dL8uE-0000bx-J9
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dL8u9-00013Z-IT
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:04:22 -0400
References: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
	<149744695027.5507.7049830187351447969.stgit@bahia.lan>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <73052dd1-21df-9f2b-7c7f-ff90860473b8@redhat.com>
Date: Wed, 14 Jun 2017 16:04:12 +0200
MIME-Version: 1.0
In-Reply-To: <149744695027.5507.7049830187351447969.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/3] xics: directly register ICPState
 objects to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 14/06/2017 15:29, Greg Kurz wrote:
> The ICPState objects are currently registered to vmstate as qdev objects.
> Their instance ids are hence computed automatically in the migration code,
> and thus depends on the order the CPU cores were plugged.
> 
> If the destination had its CPU cores plugged in a different order than the
> source, then ICPState objects will have different instance_ids and load
> the wrong state.
> 
> Since CPU objects have a reliable cpu_index which is already used as
> instance_id in vmstate, let's use it for ICPState as well.
> 
> Please note that this doesn't break migration. Older machine types used to
> allocate and realize all ICPState objects at machine init time, for the whole
> lifetime of the machine. The qdev instance ids are thus 0,1,2... nr_servers
> and happen to map to the vCPU indexes.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

CC: dgilbert

> ---
> v5: - explain why it doesn't break migration in the changelog
> ---
>  hw/intc/xics.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 7ccfb53c55a0..faa5c631f655 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -344,10 +344,14 @@ static void icp_realize(DeviceState *dev, Error **errp)
>      }
>  
>      qemu_register_reset(icp_reset, dev);
> +    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
>  }
>  
>  static void icp_unrealize(DeviceState *dev, Error **errp)
>  {
> +    ICPState *icp = ICP(dev);
> +
> +    vmstate_unregister(NULL, &vmstate_icp_server, icp);
>      qemu_unregister_reset(icp_reset, dev);
>  }
>  
> @@ -355,7 +359,6 @@ static void icp_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    dc->vmsd = &vmstate_icp_server;
>      dc->realize = icp_realize;
>      dc->unrealize = icp_unrealize;
>  }
> 
