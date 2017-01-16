Received: from eggs.gnu.org ([2001:4830:134:3::10]:48239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cTC8J-00040o-SV
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cTC8G-0003OP-Qj
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:35:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cTC8G-0003O2-KT
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:35:52 -0500
References: <20170116181212.31565-1-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9e1b4c00-357b-e9da-1474-4d9cd66ab9a7@redhat.com>
Date: Mon, 16 Jan 2017 19:35:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170116181212.31565-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Return migration-safe field on
 query-cpu-definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

Am 16.01.2017 um 19:12 schrieb Eduardo Habkost:
> Return the migration-safe field on query-cpu-definitions. All CPU
> models in x86 are migration-safe except "host".
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/cpu-qom.h | 2 ++
>  target/i386/cpu.c     | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
> index 7c9a07ae65..8cd607e9a2 100644
> --- a/target/i386/cpu-qom.h
> +++ b/target/i386/cpu-qom.h
> @@ -48,6 +48,7 @@ typedef struct X86CPUDefinition X86CPUDefinition;
>   * X86CPUClass:
>   * @cpu_def: CPU model definition
>   * @kvm_required: Whether CPU model requires KVM to be enabled.
> + * @migration_safe: See CpuDefinitionInfo::migration_safe
>   * @parent_realize: The parent class' realize handler.
>   * @parent_reset: The parent class' reset handler.
>   *
> @@ -62,6 +63,7 @@ typedef struct X86CPUClass {
>      X86CPUDefinition *cpu_def;
>
>      bool kvm_required;
> +    bool migration_safe;
>
>      /* Optional description of CPU model.
>       * If unavailable, cpu_def->model_id is used */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 337636a96a..ec6eaf215c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2209,6 +2209,8 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>      x86_cpu_class_check_missing_features(cc, &info->unavailable_features);
>      info->has_unavailable_features = true;
>      info->q_typename = g_strdup(object_class_get_name(oc));
> +    info->migration_safe = cc->migration_safe;
> +    info->has_migration_safe = true;
>
>      entry = g_malloc0(sizeof(*entry));
>      entry->value = info;
> @@ -2356,6 +2358,7 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
>      X86CPUClass *xcc = X86_CPU_CLASS(oc);
>
>      xcc->cpu_def = cpudef;
> +    xcc->migration_safe = true;
>  }
>
>  static void x86_register_cpudef_type(X86CPUDefinition *def)
>

Acked-by: David Hildenbrand <david@redhat.com>

-- 

David
