Received: from eggs.gnu.org ([2001:4830:134:3::10]:56674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9l99-0001Rz-UP
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9l94-0001Cg-Uf
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:05:31 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:37701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9l93-00016k-2t
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:05:25 -0400
Received: by mail-wm1-f43.google.com with SMTP id 185-v6so537202wmt.2
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 23:05:12 -0700 (PDT)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-24-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a956f58c-107d-f3e4-06db-1ec207fbed4f@redhat.com>
Date: Tue, 9 Oct 2018 08:05:09 +0200
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-24-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 23/31] vl: Clean up error reporting in
 device_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 08/10/2018 19:31, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  device_init_func() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index a3a39ec06b..86eee4c798 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2222,12 +2222,10 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
>  
>  static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
>  {
> -    Error *err = NULL;
>      DeviceState *dev;
>  
> -    dev = qdev_device_add(opts, &err);
> +    dev = qdev_device_add(opts, errp);
>      if (!dev) {
> -        error_report_err(err);
>          return -1;
>      }
>      object_unref(OBJECT(dev));
> @@ -4444,10 +4442,8 @@ int main(int argc, char **argv, char **envp)
>  
>      /* init generic devices */
>      rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
> -    if (qemu_opts_foreach(qemu_find_opts("device"),
> -                          device_init_func, NULL, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("device"),
> +                      device_init_func, NULL, &error_fatal);
>  
>      cpu_synchronize_all_post_init();
>  
> 
