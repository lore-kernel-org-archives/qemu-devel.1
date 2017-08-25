Received: from eggs.gnu.org ([2001:4830:134:3::10]:44428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDPZ-0003TZ-02
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDPV-0004OS-MJ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:08:28 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDPV-0004Na-IE
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:08:25 -0400
Received: by mail-qk0-x242.google.com with SMTP id o63so1863965qkb.5
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 05:08:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170824192315.5897-1-ehabkost@redhat.com>
	<20170824192315.5897-2-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97d315bf-ea9d-c9c3-cec6-58f70492c6ff@amsat.org>
Date: Fri, 25 Aug 2017 09:08:21 -0300
MIME-Version: 1.0
In-Reply-To: <20170824192315.5897-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] vl: Clean up user-creatable objects
 when exiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zack Cornelius <zack.cornelius@kove.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 08/24/2017 04:23 PM, Eduardo Habkost wrote:
> Delete all user-creatable objects in /objects when exiting QEMU, so they
> can perform cleanup actions.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Changes v1 -> v2:
> * (none)
> ---
>   include/qom/object_interfaces.h | 8 ++++++++
>   qom/object_interfaces.c         | 5 +++++
>   vl.c                            | 1 +
>   3 files changed, 14 insertions(+)
> 
> diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
> index fdd7603..3f5f206 100644
> --- a/include/qom/object_interfaces.h
> +++ b/include/qom/object_interfaces.h
> @@ -148,4 +148,12 @@ int user_creatable_add_opts_foreach(void *opaque,
>    */
>   void user_creatable_del(const char *id, Error **errp);
>   
> +/**
> + * user_creatable_cleanup:
> + *
> + * Delete all user-creatable objects and the user-creatable
> + * objects container.
> + */
> +void user_creatable_cleanup(void);
> +
>   #endif
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index ff27e06..dbf8878 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -193,6 +193,11 @@ void user_creatable_del(const char *id, Error **errp)
>       object_unparent(obj);
>   }
>   
> +void user_creatable_cleanup(void)
> +{
> +    object_unparent(object_get_objects_root());
> +}
> +
>   static void register_types(void)
>   {
>       static const TypeInfo uc_interface_info = {
> diff --git a/vl.c b/vl.c
> index 8e247cc..91d0ef0 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4801,6 +4801,7 @@ int main(int argc, char **argv, char **envp)
>       audio_cleanup();
>       monitor_cleanup();
>       qemu_chr_cleanup();
> +    user_creatable_cleanup();
>       /* TODO: unref root container, check all devices are ok */
>   
>       return 0;
> 
