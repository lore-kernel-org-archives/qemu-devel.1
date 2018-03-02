Received: from eggs.gnu.org ([2001:4830:134:3::10]:52046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1erh0K-0001Lj-IC
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:29:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1erh0H-0000Hl-Sf
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:29:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1erh0H-0000HP-LN
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:29:25 -0500
Date: Fri, 2 Mar 2018 09:29:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180302092903.GA3154@work-vm>
References: <20180302083720.25137-1-idgar@virtualoco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302083720.25137-1-idgar@virtualoco.com>
Subject: Re: [Qemu-devel] [PATCH v3] vmgenid: allow VM Generation ID
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
Cc: ben@skyportsystems.com, mst@redhat.com, imammedo@redhat.com, eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, ghammer@redhat.com, Or Idgar <oridgar@gmail.com>

* Or Idgar (idgar@virtualoco.com) wrote:
> From: Or Idgar <oridgar@gmail.com>

Hi Or,

> This patch allow changing the Virtual Machine Generation
> ID through QMP/HMP while the vm guest is running.
> the spec (http://go.microsoft.com/fwlink/?LinkId=260709)
> mentions that "when the generation ID changes, execute an
> ACPI Notify operation on the generation ID device".
> To test it we need the ability to set the generation ID
> online. QMP/HMP allows that.
> 
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


Note the patchew build failures;  hw/acpi/vmgenid.c isn't built
on all builds, and so you're getting link failures on those for
qmp_set_vm_generation_id.  So check builds for aarch64 and a few others
build OK; you'll need to make the hmp (and qapi?) code conditional. See
the ifdef on hmp_info_spice in hmp.c and the corresponding #if in
hmp-commands-info.hx.

Also, does anything need to sanity check the guid string?

> Signed-off-by: Or Idgar <oridgar@gmail.com>
> Reviewed-by: Gal Hammer <ghammer@redhat.com>
> ---
> 
> Changes in v3:
> - Explaining why we need this patch in the commit message.
> 
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
> -interfaces.  There are no known use cases for changing the GUID once QEMU is
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
> @@ -2901,6 +2901,16 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
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

Note qemu style says you need the { }'s on that 'if' even though it's
one line.

Dave

> +}
> +
>  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
> diff --git a/hmp.h b/hmp.h
> index a6f56b1..8cc74d5 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -147,5 +147,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
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
> @@ -129,6 +129,16 @@ void vmgenid_add_fw_cfg(VmGenIdState *vms, FWCfgState *s, GArray *guid)
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
> +    g_assert(memcmp(measured.data, expected.data, sizeof(measured.data)) == 0);
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
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
