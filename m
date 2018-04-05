Received: from eggs.gnu.org ([2001:4830:134:3::10]:52451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f3vX0-0003Tx-NL
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f3vWw-0007fN-0O
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:25:46 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:34623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1f3vWv-0007f6-MZ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:25:41 -0400
Received: by mail-pl0-x235.google.com with SMTP id u11-v6so17262536plq.1
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 20:25:41 -0700 (PDT)
References: <20180405012241.25714-1-f4bug@amsat.org>
	<20180405012241.25714-5-f4bug@amsat.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4aca99e0-4030-1d55-b03e-57c9e827da67@ozlabs.ru>
Date: Thu, 5 Apr 2018 13:25:34 +1000
MIME-Version: 1.0
In-Reply-To: <20180405012241.25714-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] memory: Add
 memory_region_set_priority()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: qemu-devel@nongnu.org

On 5/4/18 11:22 am, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Sadly I'm missing something, this does not work.

What does not work precisely? memory_region_set_priority() is not called or
visit_type_int32() does not return priority, etc?


> 
>  memory.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/memory.c b/memory.c
> index eaa5fa7f23..ae45ea7779 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1225,6 +1225,22 @@ static void memory_region_get_priority(Object *obj, Visitor *v,
>      visit_type_int32(v, name, &value, errp);
>  }
>  
> +static void memory_region_set_priority(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    MemoryRegion *mr = MEMORY_REGION(obj);
> +    int32_t priority;
> +    Error *local_err = NULL;
> +
> +    visit_type_int32(v, name, &priority, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    mr->priority = priority;
> +}
> +
>  static void memory_region_get_size(Object *obj, Visitor *v, const char *name,
>                                     void *opaque, Error **errp)
>  {
> @@ -1260,7 +1276,7 @@ static void memory_region_initfn(Object *obj)
>                          NULL, NULL, &error_abort);
>      object_property_add(OBJECT(mr), "priority", "int32",
>                          memory_region_get_priority,
> -                        NULL, /* memory_region_set_priority */
> +                        memory_region_set_priority,
>                          NULL, NULL, &error_abort);
>      object_property_add(OBJECT(mr), "size", "uint64",
>                          memory_region_get_size,
> 


-- 
Alexey
