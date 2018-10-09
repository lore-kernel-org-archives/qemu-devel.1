Received: from eggs.gnu.org ([2001:4830:134:3::10]:55119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9l7A-0000Nn-HI
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9l6j-0007hz-RL
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:03:27 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9l6i-0007YC-S5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:03:01 -0400
Received: by mail-wr1-f48.google.com with SMTP id e4-v6so390573wrs.0
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 23:02:58 -0700 (PDT)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-22-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cb348568-e865-c4d0-aa87-bb0c8c8b7769@redhat.com>
Date: Tue, 9 Oct 2018 08:02:56 +0200
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-22-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 21/31] vl: Clean up error reporting in
 mon_init_func()
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
> is suspicious.  mon_init_func() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 3adc9dbe4f..1009d708a0 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2270,8 +2270,8 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      } else if (strcmp(mode, "control") == 0) {
>          flags = MONITOR_USE_CONTROL;
>      } else {
> -        error_report("unknown monitor mode \"%s\"", mode);
> -        exit(1);
> +        error_setg(errp, "unknown monitor mode \"%s\"", mode);
> +        return -1;
>      }
>  
>      if (qemu_opt_get_bool(opts, "pretty", 0))
> @@ -2285,8 +2285,8 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      chardev = qemu_opt_get(opts, "chardev");
>      chr = qemu_chr_find(chardev);
>      if (chr == NULL) {
> -        error_report("chardev \"%s\" not found", chardev);
> -        exit(1);
> +        error_setg(errp, "chardev \"%s\" not found", chardev);
> +        return -1;
>      }
>  
>      monitor_init(chr, flags);
> @@ -4365,10 +4365,8 @@ int main(int argc, char **argv, char **envp)
>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>  
> -    if (qemu_opts_foreach(qemu_find_opts("mon"),
> -                          mon_init_func, NULL, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("mon"),
> +                      mon_init_func, NULL, &error_fatal);
>  
>      if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
>          exit(1);
> 
