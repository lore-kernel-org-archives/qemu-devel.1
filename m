Received: from eggs.gnu.org ([2001:4830:134:3::10]:48666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cjZQH-0003v6-GF
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cjZQC-0003Vj-I8
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:42:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cjZQC-0003VD-Br
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:42:04 -0500
References: <20170302213650.86211-1-ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c3be0fc2-e01f-8b0c-e303-324b4776af7b@redhat.com>
Date: Thu, 2 Mar 2017 23:41:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170302213650.86211-1-ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Bugfix: Handle error if VM Generation ID
 device not present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, armbru@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, pbonzini@redhat.com

On 03/02/17 22:36, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This was crashing due to NULL-pointer dereference
> 
> QMP Test case:
> ==============
> 
> (QEMU) query-vm-generation-id
> {"error": {"class": "GenericError", "desc": "VM Generation ID device not
> found"}}
> 
> HMP Test case:
> ==============
> virsh # qemu-monitor-command --hmp 3 info vm-generation-id
> VM Generation ID device not found
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  hmp.c             | 4 +++-
>  hw/acpi/vmgenid.c | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 261843f..edb8970 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2608,9 +2608,11 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
>  
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
>  {
> -    GuidInfo *info = qmp_query_vm_generation_id(NULL);
> +    Error *err = NULL;
> +    GuidInfo *info = qmp_query_vm_generation_id(&err);
>      if (info) {
>          monitor_printf(mon, "%s\n", info->guid);
>      }
> +    hmp_handle_error(mon, &err);
>      qapi_free_GuidInfo(info);
>  }
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index 744f284..7a3ad17 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -248,6 +248,7 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
>      Object *obj = find_vmgenid_dev();
>  
>      if (!obj) {
> +        error_setg(errp, "VM Generation ID device not found");
>          return NULL;
>      }
>      vms = VMGENID(obj);
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
