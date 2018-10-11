Received: from eggs.gnu.org ([2001:4830:134:3::10]:45420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAf4U-0008VG-8K
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAf4Q-00080l-VM
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAf4Q-00080Y-P9
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:48:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1631630820C0
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 17:48:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-25-armbru@redhat.com>
Date: Thu, 11 Oct 2018 19:48:18 +0200
In-Reply-To: <20181008173125.19678-25-armbru@redhat.com> (Markus Armbruster's
	message of "Mon, 8 Oct 2018 19:31:18 +0200")
Message-ID: <87sh1cxtlp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 24/31] vl: Clean up error reporting in
 vnc_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  vnc_init_func() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  ui/vnc.c | 5 +++--
>  vl.c     | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index cf221c83cc..df6c84b802 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -4082,8 +4082,9 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      vnc_display_init(id);

My patch is incomplete, there's fprintf(stderr, ...); exit(1); hiding
behind vnc_display_init().  See my review of "[PATCH RFC v5 2/7]
ui/vnc.c: polish vnc_init_func"
https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg02238.html
Message-ID: <87h8hs4oe3.fsf@dusky.pond.sub.org>


>      vnc_display_open(id, &local_err);
>      if (local_err != NULL) {
> -        error_reportf_err(local_err, "Failed to start VNC server: ");
> -        exit(1);
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "Failed to start VNC server: ");
> +        return -1;
>      }
>      return 0;
>  }
> diff --git a/vl.c b/vl.c
> index 86eee4c798..5c159ca45c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4479,7 +4479,7 @@ int main(int argc, char **argv, char **envp)
>      /* init remote displays */
>  #ifdef CONFIG_VNC
>      qemu_opts_foreach(qemu_find_opts("vnc"),
> -                      vnc_init_func, NULL, NULL);
> +                      vnc_init_func, NULL, &error_fatal);
>  #endif
>  
>      if (using_spice) {
