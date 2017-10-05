Received: from eggs.gnu.org ([2001:4830:134:3::10]:33964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05Ti-0005Lw-BI
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05Th-0007rC-3c
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:42:14 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05Tg-0007qR-Uz
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:42:13 -0400
Received: by mail-qk0-x243.google.com with SMTP id a12so7216046qka.4
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 05:42:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-22-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a958db6c-9908-154a-ab08-55d2dc5e1be0@amsat.org>
Date: Thu, 5 Oct 2017 09:42:08 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-22-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 21/38] sh4: remove SuperHCPUClass::name
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> the field contains upper-cased cpu model name and is used
> for printing supported cpu model names for '-cpu help'.
> 
> Considering that cpu model lookup in superh_cpu_class_by_name()
> is case-insensitive, we can drop upper-casing when
> printing supported cpus list and use cpu type directly
> to do the same by cutting out SUPERH_CPU_TYPE_SUFFIX from
> typename.
> 
> It allows to remove SuperHCPUClass::name, which practically
> duplicates names defined by TYPE_SH*_CPU definitions and
> simplify sh*_class_init()/SuperHCPUClass a bit.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: aurelien@aurel32.net
> ---
>  target/sh4/cpu-qom.h |  2 --
>  target/sh4/cpu.c     | 10 +++-------
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
> index 17deeb6..0f9fb4d 100644
> --- a/target/sh4/cpu-qom.h
> +++ b/target/sh4/cpu-qom.h
> @@ -39,7 +39,6 @@
>   * SuperHCPUClass:
>   * @parent_realize: The parent class' realize handler.
>   * @parent_reset: The parent class' reset handler.
> - * @name: The name.
>   * @pvr: Processor Version Register
>   * @prr: Processor Revision Register
>   * @cvr: Cache Version Register
> @@ -54,7 +53,6 @@ typedef struct SuperHCPUClass {
>      DeviceRealize parent_realize;
>      void (*parent_reset)(CPUState *cpu);
>  
> -    const char *name;
>      uint32_t pvr;
>      uint32_t prr;
>      uint32_t cvr;
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index b71ff01..8dfbdeb 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -98,12 +98,11 @@ static gint superh_cpu_list_compare(gconstpointer a, gconstpointer b)
>  
>  static void superh_cpu_list_entry(gpointer data, gpointer user_data)
>  {
> -    ObjectClass *oc = data;
> -    SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
>      SuperHCPUListState *s = user_data;
> +    const char *typename = object_class_get_name(OBJECT_CLASS(data));
> +    int len = strlen(typename) - strlen(SUPERH_CPU_TYPE_SUFFIX);
>  
> -    (*s->cpu_fprintf)(s->file, "%s\n",
> -                      scc->name);
> +    (*s->cpu_fprintf)(s->file, "%.*s\n", len, typename);
>  }
>  
>  void sh4_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> @@ -156,7 +155,6 @@ static void sh7750r_class_init(ObjectClass *oc, void *data)
>  {
>      SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
>  
> -    scc->name = "SH7750R";
>      scc->pvr = 0x00050000;
>      scc->prr = 0x00000100;
>      scc->cvr = 0x00110000;
> @@ -175,7 +173,6 @@ static void sh7751r_class_init(ObjectClass *oc, void *data)
>  {
>      SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
>  
> -    scc->name = "SH7751R";
>      scc->pvr = 0x04050005;
>      scc->prr = 0x00000113;
>      scc->cvr = 0x00110000; /* Neutered caches, should be 0x20480000 */
> @@ -194,7 +191,6 @@ static void sh7785_class_init(ObjectClass *oc, void *data)
>  {
>      SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
>  
> -    scc->name = "SH7785";
>      scc->pvr = 0x10300700;
>      scc->prr = 0x00000200;
>      scc->cvr = 0x71440211;
> 
