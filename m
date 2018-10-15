Received: from eggs.gnu.org ([2001:4830:134:3::10]:58675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCBYP-0005Q1-S7
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCBYL-0006jQ-NZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:41:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gCBYC-0006bp-Db
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:41:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so20474028wma.4
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 15:41:20 -0700 (PDT)
References: <20181015115309.17089-1-armbru@redhat.com>
	<20181015115309.17089-28-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c04e0f43-fcb3-8ca4-57c4-ee61d2d71459@redhat.com>
Date: Tue, 16 Oct 2018 00:41:18 +0200
MIME-Version: 1.0
In-Reply-To: <20181015115309.17089-28-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 27/35] vnc: Clean up error reporting in
 vnc_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 15/10/2018 13:53, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  vnc_init_func() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  ui/vnc.c | 9 +++++----
>  vl.c     | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 98e3d3b1d8..fcd2744d52 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -4082,13 +4082,14 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      assert(id);
>      vnc_display_init(id, &local_err);
>      if (local_err) {
> -        error_report_err(local_err);
> -        exit(1);
> +        error_propagate(errp, local_err);
> +        return -1;
>      }
>      vnc_display_open(id, &local_err);
>      if (local_err != NULL) {
> -        error_reportf_err(local_err, "Failed to start VNC server: ");
> -        exit(1);
> +        error_propagate_prepend(errp, local_err,
> +                                "Failed to start VNC server: ");
> +        return -1;
>      }
>      return 0;
>  }
> diff --git a/vl.c b/vl.c
> index c053117028..8e0006d49c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4526,7 +4526,7 @@ int main(int argc, char **argv, char **envp)
>      /* init remote displays */
>  #ifdef CONFIG_VNC
>      qemu_opts_foreach(qemu_find_opts("vnc"),
> -                      vnc_init_func, NULL, NULL);
> +                      vnc_init_func, NULL, &error_fatal);
>  #endif
>  
>      if (using_spice) {
> 
