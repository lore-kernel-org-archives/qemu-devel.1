Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0A5C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96D82075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mi47W6vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96D82075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvcl-00054x-PD
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuvbp-0004AR-En
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuvbn-0003ri-Qt
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:50:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuvbn-0003pi-MI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579859435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/YdpDzSfvfu3py0OzOOkBSLOOGYzv0wLlQ8AgA1nk/Y=;
 b=Mi47W6vjONWi0neeVQfeUQ0H0LP8X2rG1jS+ty7CIXP1AgJAy2/JrC5CcJ7zy0WXQFfbUf
 Nx2a8Hnyvvdru4esETLf4+HviYmnCv5Xhm9dMFZyaXKqhNP/1yD6VD/KtWO9f08gAFFcm5
 Cwp+gqRzoSmHVwRjJXHfRKrO0h1HuPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-zHqNg0kZOEuNbDGCvoC6MQ-1; Fri, 24 Jan 2020 04:50:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D0D610102B8;
 Fri, 24 Jan 2020 09:50:32 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E70B194B2;
 Fri, 24 Jan 2020 09:50:31 +0000 (UTC)
Date: Fri, 24 Jan 2020 10:50:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH REPOST v3 77/80] hostmem: introduce "prealloc-threads"
 property
Message-ID: <20200124105030.00dab6bc@redhat.com>
In-Reply-To: <1579779525-20065-78-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-78-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: zHqNg0kZOEuNbDGCvoC6MQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jitendra.kolhe@hpe.com, pbonzini@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 12:38:42 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> the property will allow user to specify number of threads to use
> in pre-allocation stage. It also will allow to reduce implicit
> hostmem dependency on current_machine.
> On object creation it will default to 1, but via machine
> compat property it will be updated to MachineState::smp::cpus
> to keep current behavior for hostmem and main RAM (which is
> now also hostmem based).
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Jitendra,

As the one who introduced smp_cpus in backend

(1e356fc14be mem-prealloc: reduce large guest start-up and migration time.)

could you review this patch please?

> ---
> v3:
>   - use object_register_sugar_prop() instead of directly hacking
>     compat_props (Paolo Bonzini <pbonzini@redhat.com>)
>   - fix TODO description
> 
> CC: pbonzini@redhat.com
> CC: ehabkost@redhat.com
> ---
>  include/sysemu/hostmem.h |  2 ++
>  backends/hostmem.c       | 43 +++++++++++++++++++++++++++++++++++++++----
>  vl.c                     | 14 ++++++++++----
>  3 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index 5db0d66..bdf8666 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -61,6 +61,7 @@ struct HostMemoryBackendClass {
>   * @parent: opaque parent object container
>   * @size: amount of memory backend provides
>   * @mr: MemoryRegion representing host memory belonging to backend
> + * @prealloc_threads: number of threads to be used for preallocatining RAM
>   */
>  struct HostMemoryBackend {
>      /* private */
> @@ -70,6 +71,7 @@ struct HostMemoryBackend {
>      uint64_t size;
>      bool merge, dump, use_canonical_path;
>      bool prealloc, force_prealloc, is_mapped, share;
> +    uint32_t prealloc_threads;
>      DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
>      HostMemPolicy policy;
>  
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index e773bdf..0988986 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -223,7 +223,6 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
>  {
>      Error *local_err = NULL;
>      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> -    MachineState *ms = MACHINE(qdev_get_machine());
>  
>      if (backend->force_prealloc) {
>          if (value) {
> @@ -243,7 +242,7 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
>          void *ptr = memory_region_get_ram_ptr(&backend->mr);
>          uint64_t sz = memory_region_size(&backend->mr);
>  
> -        os_mem_prealloc(fd, ptr, sz, ms->smp.cpus, &local_err);
> +        os_mem_prealloc(fd, ptr, sz, backend->prealloc_threads, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
> @@ -252,14 +251,45 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
>      }
>  }
>  
> +static void host_memory_backend_get_prealloc_threads(Object *obj, Visitor *v,
> +    const char *name, void *opaque, Error **errp)
> +{
> +    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> +    visit_type_uint32(v, name, &backend->prealloc_threads, errp);
> +}
> +
> +static void host_memory_backend_set_prealloc_threads(Object *obj, Visitor *v,
> +    const char *name, void *opaque, Error **errp)
> +{
> +    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> +    Error *local_err = NULL;
> +    uint32_t value;
> +
> +    visit_type_uint32(v, name, &value, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +    if (value <= 0) {
> +        error_setg(&local_err,
> +                   "property '%s' of %s doesn't take value '%d'",
> +                   name, object_get_typename(obj), value);
> +        goto out;
> +    }
> +    backend->prealloc_threads = value;
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
>  static void host_memory_backend_init(Object *obj)
>  {
>      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
>      MachineState *machine = MACHINE(qdev_get_machine());
>  
> +    /* TODO: convert access to globals to compat properties */
>      backend->merge = machine_mem_merge(machine);
>      backend->dump = machine_dump_guest_core(machine);
>      backend->prealloc = mem_prealloc;
> +    backend->prealloc_threads = 1;
>  }
>  
>  static void host_memory_backend_post_init(Object *obj)
> @@ -313,7 +343,6 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>  {
>      HostMemoryBackend *backend = MEMORY_BACKEND(uc);
>      HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
> -    MachineState *ms = MACHINE(qdev_get_machine());
>      Error *local_err = NULL;
>      void *ptr;
>      uint64_t sz;
> @@ -378,7 +407,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>           */
>          if (backend->prealloc) {
>              os_mem_prealloc(memory_region_get_fd(&backend->mr), ptr, sz,
> -                            ms->smp.cpus, &local_err);
> +                            backend->prealloc_threads, &local_err);
>              if (local_err) {
>                  goto out;
>              }
> @@ -456,6 +485,12 @@ host_memory_backend_class_init(ObjectClass *oc, void *data)
>          host_memory_backend_set_prealloc, &error_abort);
>      object_class_property_set_description(oc, "prealloc",
>          "Preallocate memory", &error_abort);
> +    object_class_property_add(oc, "prealloc-threads", "int",
> +        host_memory_backend_get_prealloc_threads,
> +        host_memory_backend_set_prealloc_threads,
> +        NULL, NULL, &error_abort);
> +    object_class_property_set_description(oc, "prealloc-threads",
> +        "Number of CPU threads to use for prealloc", &error_abort);
>      object_class_property_add(oc, "size", "int",
>          host_memory_backend_get_size,
>          host_memory_backend_set_size,
> diff --git a/vl.c b/vl.c
> index d825a34..21e3262 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2822,8 +2822,7 @@ static void configure_accelerators(const char *progname)
>      }
>  }
>  
> -static void create_default_memdev(MachineState *ms, const char *path,
> -                                  bool prealloc)
> +static void create_default_memdev(MachineState *ms, const char *path)
>  {
>      Object *obj;
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> @@ -2832,7 +2831,6 @@ static void create_default_memdev(MachineState *ms, const char *path,
>      if (path) {
>          object_property_set_str(obj, path, "mem-path", &error_fatal);
>      }
> -    object_property_set_bool(obj, prealloc, "prealloc", &error_fatal);
>      object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
>      object_property_add_child(object_get_objects_root(), mc->default_ram_id,
>                                obj, &error_fatal);
> @@ -3975,6 +3973,14 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      }
>  
> +    if (mem_prealloc) {
> +        char *val;
> +
> +        val = g_strdup_printf("%d", current_machine->smp.cpus);
> +        object_register_sugar_prop("memory-backend", "prealloc-threads", val);
> +        g_free(val);
> +    }
> +
>      /*
>       * Get the default machine options from the machine if it is not already
>       * specified either by the configuration file or by the command line.
> @@ -4309,7 +4315,7 @@ int main(int argc, char **argv, char **envp)
>          machine_class->default_ram_size &&
>          machine_class->default_ram_id &&
>          !current_machine->ram_memdev) {
> -        create_default_memdev(current_machine, mem_path, mem_prealloc);
> +        create_default_memdev(current_machine, mem_path);
>      }
>      /* do monitor/qmp handling at preconfig state if requested */
>      main_loop();


