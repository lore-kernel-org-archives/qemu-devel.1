Received: from eggs.gnu.org ([2001:4830:134:3::10]:60550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05Oh-0001tz-0a
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05Od-0002VC-T3
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:37:03 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05Od-0002Uv-N7
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:36:59 -0400
Received: by mail-qk0-x244.google.com with SMTP id z12so6726210qkb.0
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 05:36:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
	<1507111682-66171-1-git-send-email-imammedo@redhat.com>
	<1507111682-66171-4-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <37509916-dfea-8f85-d57d-5e8d310d513a@amsat.org>
Date: Thu, 5 Oct 2017 09:36:55 -0300
MIME-Version: 1.0
In-Reply-To: <1507111682-66171-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qom: add helper macro DEFINE_TYPES()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com

On 10/04/2017 07:08 AM, Igor Mammedov wrote:
> DEFINE_TYPES() will help to simplify following routine patterns:
> 
>  static void foo_register_types(void)
>  {
>     type_register_static(&foo1_type_info);
>     type_register_static(&foo2_type_info);
>     ...
>  }
> 
>  type_init(foo_register_types)
> 
> or
> 
>  static void foo_register_types(void)
>  {
>     int i;
> 
>     for (i = 0; i < ARRAY_SIZE(type_infos); i++) {
>         type_register_static(&type_infos[i]);
>     }
>  }
> 
>  type_init(foo_register_types)
> 
> with a single line
> 
>  DEFINE_TYPES(type_infos)
> 
> where types have static definition which could be consolidated in
> a single array of TypeInfo structures.
> It saves us ~6-10LOC per use case and would help to replace
> imperative foo_register_types() there with declarative style of
> type registration.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/qom/object.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index ce25567..a615066 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -79,6 +79,28 @@ typedef struct InterfaceInfo InterfaceInfo;
>   * #TypeInfo describes information about the type including what it inherits
>   * from, the instance and class size, and constructor/destructor hooks.
>   *
> + * Alternatively several static types could be registered using helper macro
> + * DEFINE_TYPES()
> + *
> + * <example>
> + *   <programlisting>
> + * static const TypeInfo device_types_info[] = {
> + *     {
> + *         .name = TYPE_MY_DEVICE_A,
> + *         .parent = TYPE_DEVICE,
> + *         .instance_size = sizeof(MyDeviceA),
> + *     },
> + *     {
> + *         .name = TYPE_MY_DEVICE_B,
> + *         .parent = TYPE_DEVICE,
> + *         .instance_size = sizeof(MyDeviceB),
> + *     },
> + * };
> + *
> + * DEFINE_TYPES(device_types_info)
> + *   </programlisting>
> + * </example>
> + *
>   * Every type has an #ObjectClass associated with it.  #ObjectClass derivatives
>   * are instantiated dynamically but there is only ever one instance for any
>   * given type.  The #ObjectClass typically holds a table of function pointers
> @@ -799,6 +821,20 @@ Type type_register(const TypeInfo *info);
>  void type_register_static_array(const TypeInfo *infos, int nr_infos);
>  
>  /**
> + * DEFINE_TYPES:
> + * @type_array: The array containing #TypeInfo structures to register
> + *
> + * @type_array should be static constant that exists for the life time
> + * that the type is registered.
> + */
> +#define DEFINE_TYPES(type_array)                                            \
> +static void do_qemu_init_ ## type_array(void)                               \
> +{                                                                           \
> +    type_register_static_array(type_array, ARRAY_SIZE(type_array));         \
> +}                                                                           \
> +type_init(do_qemu_init_ ## type_array)
> +
> +/**
>   * object_class_dynamic_cast_assert:
>   * @klass: The #ObjectClass to attempt to cast.
>   * @typename: The QOM typename of the class to cast to.
> 
