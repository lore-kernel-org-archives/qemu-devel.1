Received: from eggs.gnu.org ([2001:4830:134:3::10]:43764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIE7W-0005eE-Ro
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIDwA-0007jQ-4c
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:27:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIDw9-0007ig-T1
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:27:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so1562681wma.4
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 07:27:05 -0700 (PDT)
References: <1541069086-167036-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6cdf543e-77b2-ea7f-f0b8-f9da4384bd94@redhat.com>
Date: Thu, 1 Nov 2018 15:27:02 +0100
MIME-Version: 1.0
In-Reply-To: <1541069086-167036-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ivshmem: fix memory backend leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, marcandre.lureau@redhat.com

On 1/11/18 11:44, Igor Mammedov wrote:
> object_new() returns a new backend with refcount == 1 and
> then later object_property_add_child() increases refcount to 2
> So when ivshmem is desroyed, the backend it has created isn't

                      ^ "destroyed"

> destroyed along with it as children cleanup will bring
> backend's refcount only to 1, which leaks backend including
> resources it is using.
> 
> Drop the original reference from object_new() once backend
> is attached to its parent.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/misc/ivshmem.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index f88910e..ecfd10a 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -1279,6 +1279,7 @@ static void desugar_shm(IVShmemState *s)
>       object_property_set_bool(obj, true, "share", &error_abort);
>       object_property_add_child(OBJECT(s), "internal-shm-backend", obj,
>                                 &error_abort);
> +    object_unref(obj);
>       user_creatable_complete(obj, &error_abort);
>       s->hostmem = MEMORY_BACKEND(obj);
>   }
> 
