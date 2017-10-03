Received: from eggs.gnu.org ([2001:4830:134:3::10]:37436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNNj-0006Wa-KR
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNNg-0003N7-EY
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:37:07 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNNg-0003Ms-9e
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:37:04 -0400
Received: by mail-qk0-x243.google.com with SMTP id w63so4317746qkd.2
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:37:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-13-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <676d82ff-6917-036b-cc42-42ca670fbb8a@amsat.org>
Date: Tue, 3 Oct 2017 10:37:00 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-13-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/38] moxie: fix qemu-system-moxie failing
 to start with CLI "-cpu MoxieLite"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, green@moxielogic.com
Cc: qemu-devel@nongnu.org

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> It 'works' with default CPU only because of bug in
> moxie_cpu_class_by_name() where it treats cpu_model
> as type name and default cpu_model also happens to be
> type name. But specifying explicitly cpu on CLI,
> ex: '-cpu MoxieLite', makes QEMU fail since
> moxie_cpu_class_by_name() doesn't traslate cpu_model
> to cpu type and fails to find corresponding object class.
> 
> Fix moxie_cpu_class_by_name() to do proper
>    cpu_model -> cpu type
> translation and fix default cpu_model to be cpu_model
> instead of being typename.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: green@moxielogic.com
> ---
>  hw/moxie/moxiesim.c | 2 +-
>  target/moxie/cpu.c  | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
> index 5ea8dd3..01b9f34 100644
> --- a/hw/moxie/moxiesim.c
> +++ b/hw/moxie/moxiesim.c
> @@ -116,7 +116,7 @@ static void moxiesim_init(MachineState *machine)
>  
>      /* Init CPUs. */
>      if (cpu_model == NULL) {
> -        cpu_model = "MoxieLite-moxie-cpu";
> +        cpu_model = "MoxieLite";
>      }
>      cpu = MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
>      env = &cpu->env;
> diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
> index 30bd44f..d4626a1 100644
> --- a/target/moxie/cpu.c
> +++ b/target/moxie/cpu.c
> @@ -89,7 +89,12 @@ static void moxie_cpu_initfn(Object *obj)
>  
>  static ObjectClass *moxie_cpu_class_by_name(const char *cpu_model)
>  {
> -    ObjectClass *oc = object_class_by_name(cpu_model);
> +    ObjectClass *oc;
> +    char *typename;
> +
> +    typename = g_strdup_printf("%s-" TYPE_MOXIE_CPU, cpu_model);
> +    oc = object_class_by_name(typename);
> +    g_free(typename);
>      if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_MOXIE_CPU) ||
>                         object_class_is_abstract(oc))) {
>          return NULL;
> 
