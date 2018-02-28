Received: from eggs.gnu.org ([2001:4830:134:3::10]:46165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1er3J1-0002tL-RH
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1er3Iz-0004Q8-HL
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:06:07 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:55219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1er3Iz-0004Ph-4C
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:06:05 -0500
Received: by mail-wm0-x22d.google.com with SMTP id z81so5576783wmb.4
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 07:06:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228133613.21037-1-idgar@virtualoco.com>
References: <20180228133613.21037-1-idgar@virtualoco.com>
From: Benjamin Warren <ben@skyportsystems.com>
Date: Wed, 28 Feb 2018 07:06:03 -0800
Message-ID: <CAFtH1GVAs2M6=qvR-OwHAeSxCN0-WcOZB00KXvKoEMSs8691FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vmgenid: allow VM Generation ID
 modification via QMP/HMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Or Idgar <idgar@virtualoco.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, imammendo@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, oidgar@redhat.com, Gal Hammer <ghammer@redhat.com>

On Wed, Feb 28, 2018 at 5:36 AM, Or Idgar <idgar@virtualoco.com> wrote:

> From: Or Idgar <oidgar@redhat.com>
>
> This patch allow changing the Virtual Machine Generation
> ID through QMP/HMP while the vm guest is running.
> As the definition block of VMGENID in ACPI includes the
> "Notify" method, we can use it to notify the guest about
> ID changes.
>
> Ditto what Eric says.  What is your use case?  Setting was intentionally
left out in order to keep things simple.  There were other concerns (I
believe about migration) that will need to be revisited, but only if this
feature extension is really needed.


> QMP command example:
>     { "execute": "set-vm-generation-id",
>           "arguments": {
>               "guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>           }
>     }
>
> HMP command example:
>     set-vm-generation-id 324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87
>
> This patch is based off an earlier version by
> Igor Mammedov (imammedo@redhat.com)
>
> Signed-off-by: Or Idgar <oidgar@redhat.com>
> Reviewed-by: Gal Hammer <ghammer@redhat.com>
> ---
>  docs/specs/vmgenid.txt |  7 ++++---
>  hmp-commands.hx        | 13 +++++++++++++
>  hmp.c                  | 10 ++++++++++
>  hmp.h                  |  1 +
>  hw/acpi/vmgenid.c      | 10 ++++++++++
>  qapi-schema.json       | 11 +++++++++++
>  tests/vmgenid-test.c   | 31 +++++++++++++++++++++++++++++++
>  7 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
> index aa9f518..04443de 100644
> --- a/docs/specs/vmgenid.txt
> +++ b/docs/specs/vmgenid.txt
> @@ -240,6 +240,7 @@ The property may be queried via QMP/HMP:
>    (QEMU) query-vm-generation-id
>    {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
>
> -Setting of this parameter is intentionally left out from the QMP/HMP
> -interfaces.  There are no known use cases for changing the GUID once QEMU
> is
> -running, and adding this capability would greatly increase the complexity.
> +Also, the property may be set via QMP/HMP:
> +
> +  (QEMU) set-vm-generation-id guid=ee6726ce-73b4-4a8b-863c-708f26515847
> +  {"return": {}}
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 4afd57c..4524669 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1871,5 +1871,18 @@ ETEXI
>      },
>
>  STEXI
> +@item set-vm-generation-id @var{uuid}
> +Set Virtual Machine Generation ID counter to @var{guid}
> +ETEXI
> +
> +    {
> +        .name       = "set-vm-generation-id",
> +        .args_type  = "guid:s",
> +        .params     = "guid",
> +        .help       = "Set Virtual Machine Generation ID counter",
> +        .cmd        = hmp_set_vm_generation_id,
> +    },
> +
> +STEXI
>  @end table
>  ETEXI
> diff --git a/hmp.c b/hmp.c
> index 35a7041..73f9b00 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2901,6 +2901,16 @@ void hmp_info_vm_generation_id(Monitor *mon, const
> QDict *qdict)
>      qapi_free_GuidInfo(info);
>  }
>
> +void hmp_set_vm_generation_id(Monitor *mon, const QDict *qdict)
> +{
> +    Error *errp = NULL;
> +    const char *guid = qdict_get_str(qdict, "guid");
> +
> +    qmp_set_vm_generation_id(guid, &errp);
> +    if (errp)
> +        hmp_handle_error(mon, &errp);
> +}
> +
>  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
> diff --git a/hmp.h b/hmp.h
> index a6f56b1..8cc74d5 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -147,5 +147,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict
> *qdict);
>  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
> +void hmp_set_vm_generation_id(Monitor *mon, const QDict *qdict);
>
>  #endif
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index 105044f..5319d70 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -129,6 +129,16 @@ void vmgenid_add_fw_cfg(VmGenIdState *vms,
> FWCfgState *s, GArray *guid)
>                               ARRAY_SIZE(vms->vmgenid_addr_le), false);
>  }
>
> +void qmp_set_vm_generation_id(const char *guid, Error **errp)
> +{
> +    Object *obj = find_vmgenid_dev();
> +
> +    if (!obj) {
> +        return;
> +    }
> +    object_property_set_str(obj, guid, VMGENID_GUID, errp);
> +}
> +
>  static void vmgenid_update_guest(VmGenIdState *vms)
>  {
>      Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 1845795..c2ab733 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3193,6 +3193,17 @@
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>
>  ##
> +# @set-vm-generation-id:
> +#
> +# Set Virtual Machine Generation ID
> +#
> +# @guid: new GUID to set as Virtual Machine Generation ID
> +#
> +# Since 2.12
> +##
> +{ 'command': 'set-vm-generation-id', 'data': { 'guid': 'str' } }
> +
> +##
>  # @watchdog-set-action:
>  #
>  # Set watchdog action
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index 5a86b40..544cf0f 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -130,6 +130,24 @@ static void read_guid_from_monitor(QemuUUID *guid)
>      QDECREF(rsp);
>  }
>
> +static void set_guid_via_monitor(QemuUUID *guid)
> +{
> +    QDict *rsp, *rsp_ret;
> +    char command[256];
> +    char *guid_str;
> +
> +    guid_str = qemu_uuid_unparse_strdup(guid);
> +    sprintf(command, "{ 'execute': 'set-vm-generation-id', 'arguments': \
> +                      { 'guid': '%s' } }",
> +            guid_str);
> +    free(guid_str);
> +    rsp = qmp(command);
> +    if (qdict_haskey(rsp, "return")) {
> +        rsp_ret = qdict_get_qdict(rsp, "return");
> +        g_assert(qdict_size(rsp_ret) == 0);
> +    }
> +}
> +
>  static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
>
>  #define GUID_CMD(guid)                          \
> @@ -182,6 +200,17 @@ static void vmgenid_query_monitor_test(void)
>      qtest_quit(global_qtest);
>  }
>
> +static void vmgenid_set_monitor_test(void)
> +{
> +    QemuUUID expected, measured;
> +
> +    global_qtest = qtest_startf(GUID_CMD(VGID_GUID));
> +    qemu_uuid_generate(&expected);
> +    set_guid_via_monitor(&expected);
> +    read_guid_from_monitor(&measured);
> +    g_assert(memcmp(measured.data, expected.data, sizeof(measured.data))
> == 0);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      int ret;
> @@ -199,6 +228,8 @@ int main(int argc, char **argv)
>                     vmgenid_set_guid_auto_test);
>      qtest_add_func("/vmgenid/vmgenid/query-monitor",
>                     vmgenid_query_monitor_test);
> +    qtest_add_func("/vmgenid/vmgenid/set-guid-qmp",
> +                   vmgenid_set_monitor_test);
>      ret = g_test_run();
>      boot_sector_cleanup(disk);
>
> --
> 2.9.5
>
>
>
