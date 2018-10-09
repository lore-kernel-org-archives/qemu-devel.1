Received: from eggs.gnu.org ([2001:4830:134:3::10]:57280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9lB9-0002zh-La
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9lB4-00037L-Og
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:07:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9lB4-00036m-Ht
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:07:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so543912wmf.1
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 23:07:30 -0700 (PDT)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-20-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <22620f6c-86ae-ca8b-1c15-3d06f5209ab6@redhat.com>
Date: Tue, 9 Oct 2018 08:07:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-20-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 19/31] vl: Clean up error reporting in
 parse_add_fd()
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
> is suspicious.  chardev_init_func() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index b8576f8f10..ecb70f87d8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2239,7 +2239,7 @@ static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
>  
>      if (!qemu_chr_new_from_opts(opts, &local_err)) {
>          if (local_err) {
> -            error_report_err(local_err);
> +            error_propagate(errp, local_err);
>              return -1;
>          }
>          exit(0);
> @@ -4185,10 +4185,8 @@ int main(int argc, char **argv, char **envp)
>                        user_creatable_add_opts_foreach,
>                        object_create_initial, &error_fatal);
>  
> -    if (qemu_opts_foreach(qemu_find_opts("chardev"),
> -                          chardev_init_func, NULL, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("chardev"),
> +                      chardev_init_func, NULL, &error_fatal);
>  
>  #ifdef CONFIG_VIRTFS
>      if (qemu_opts_foreach(qemu_find_opts("fsdev"),
> 
