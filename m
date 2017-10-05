Received: from eggs.gnu.org ([2001:4830:134:3::10]:60199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05OH-0001fM-1v
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05OD-0001uE-Mq
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:36:37 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:49423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05OD-0001tN-Hy
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:36:33 -0400
Received: by mail-qt0-x241.google.com with SMTP id o3so24997277qte.6
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 05:36:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
	<1507111682-66171-1-git-send-email-imammedo@redhat.com>
	<1507111682-66171-3-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8f2b09ab-3691-85bc-b4da-88f79c08bd5e@amsat.org>
Date: Thu, 5 Oct 2017 09:36:28 -0300
MIME-Version: 1.0
In-Reply-To: <1507111682-66171-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qom: introduce
 type_register_static_array()
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
> it will help to remove code duplication of registration
> static types in places that have open coded loop to
> perform batch type registering.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/qom/object.h | 10 ++++++++++
>  qom/object.c         |  9 +++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 76a5e3a..ce25567 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -789,6 +789,16 @@ Type type_register_static(const TypeInfo *info);
>  Type type_register(const TypeInfo *info);
>  
>  /**
> + * type_register_static_array:
> + * @infos: The array of the new type #TypeInfo structures.
> + * @nr_infos: number of entries in @infos
> + *
> + * @infos and all of the strings it points to should exist for the life time
> + * that the type is registered.
> + */
> +void type_register_static_array(const TypeInfo *infos, int nr_infos);
> +
> +/**
>   * object_class_dynamic_cast_assert:
>   * @klass: The #ObjectClass to attempt to cast.
>   * @typename: The QOM typename of the class to cast to.
> diff --git a/qom/object.c b/qom/object.c
> index 3e18537..f4c377a 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -151,6 +151,15 @@ TypeImpl *type_register_static(const TypeInfo *info)
>      return type_register(info);
>  }
>  
> +void type_register_static_array(const TypeInfo *infos, int nr_infos)
> +{
> +    int i;
> +
> +    for (i = 0; i < nr_infos; i++) {
> +        type_register_static(&infos[i]);
> +    }
> +}
> +
>  static TypeImpl *type_get_by_name(const char *name)
>  {
>      if (name == NULL) {
> 
