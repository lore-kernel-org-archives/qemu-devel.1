Received: from eggs.gnu.org ([209.51.188.92]:59756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhIX-0005Wr-Ny
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhIW-00008X-CH
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIhIW-00007p-1w
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so16118068wmc.3
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 15:20:23 -0700 (PDT)
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1058eb0f-2842-85dc-4896-c5937352783b@redhat.com>
Date: Tue, 23 Apr 2019 00:20:21 +0200
MIME-Version: 1.0
In-Reply-To: <20190422210448.2488-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qtest: Don't compile qtest accel on
 non-POSIX systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 4/22/19 11:04 PM, Eduardo Habkost wrote:
> qtest_available() will always return 0 on non-POSIX systems.
> It's simpler to just not compile the accelerator code on those
> systems instead of relying on the AccelClass::available function.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
mingw64:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/sysemu/qtest.h | 9 ---------
>  accel/qtest.c          | 1 -
>  accel/Makefile.objs    | 2 +-
>  3 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
> index 70aa40aa72..096ddfc20c 100644
> --- a/include/sysemu/qtest.h
> +++ b/include/sysemu/qtest.h
> @@ -27,13 +27,4 @@ bool qtest_driver(void);
>  
>  void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
>  
> -static inline int qtest_available(void)
> -{
> -#ifdef CONFIG_POSIX
> -    return 1;
> -#else
> -    return 0;
> -#endif
> -}
> -
>  #endif
> diff --git a/accel/qtest.c b/accel/qtest.c
> index a02b3c26c7..5b88f55921 100644
> --- a/accel/qtest.c
> +++ b/accel/qtest.c
> @@ -34,7 +34,6 @@ static void qtest_accel_class_init(ObjectClass *oc, void *data)
>  {
>      AccelClass *ac = ACCEL_CLASS(oc);
>      ac->name = "QTest";
> -    ac->available = qtest_available;
>      ac->init_machine = qtest_init_accel;
>      ac->allowed = &qtest_allowed;
>  }
> diff --git a/accel/Makefile.objs b/accel/Makefile.objs
> index 2a5ed46940..8b498d39d8 100644
> --- a/accel/Makefile.objs
> +++ b/accel/Makefile.objs
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_SOFTMMU) += accel.o
> -obj-$(CONFIG_SOFTMMU) += qtest.o
> +obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest.o
>  obj-$(CONFIG_KVM) += kvm/
>  obj-$(CONFIG_TCG) += tcg/
>  obj-y += stubs/
> 
