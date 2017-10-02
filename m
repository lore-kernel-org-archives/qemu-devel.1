Received: from eggs.gnu.org ([2001:4830:134:3::10]:44897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1Vm-0000a2-Cx
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1Vj-0005Ck-MP
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:15:58 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:53578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1Vj-0005CA-He
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:15:55 -0400
Received: by mail-qt0-x243.google.com with SMTP id 47so7371217qts.10
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:15:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-2-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <39052520-05bf-5e6f-fcc6-46026bd8a6f2@amsat.org>
Date: Mon, 2 Oct 2017 11:15:51 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/38] qom: add helper
 type_init_from_array()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> it will help to remove code duplication in places
> that currently open code registration of several
> types.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> I'm going to use it for CPU types in followup patches
> 
> CC: ehabkost@redhat.com
> ---
>   include/qemu/module.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 56dd218..29f9089 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -52,6 +52,16 @@ typedef enum {
>   #define type_init(function) module_init(function, MODULE_INIT_QOM)
>   #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
>   
> +#define type_init_from_array(array)                                        \
> +static void do_qemu_init_ ## array(void)                                   \
> +{                                                                          \
> +    int i;                                                                 \
> +    for (i = 0; i < ARRAY_SIZE(array); i++) {                              \
> +        type_register_static(&array[i]);                                   \
> +    }                                                                      \
> +}                                                                          \
> +module_init(do_qemu_init_ ## array, MODULE_INIT_QOM)
> +
>   #define block_module_load_one(lib) module_load_one("block-", lib)
>   
>   void register_module_init(void (*fn)(void), module_init_type type);
> 
