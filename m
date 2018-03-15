Received: from eggs.gnu.org ([2001:4830:134:3::10]:43550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewRAP-0005or-Nn
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewRAK-0008OZ-C5
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:35:29 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewRAJ-0008N9-JV
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:35:23 -0400
Received: by mail-wr0-x243.google.com with SMTP id d10so7946433wrf.3
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 04:35:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180314080439.4229-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6d70d198-62d7-fd48-cef5-7b470c249de4@amsat.org>
Date: Thu, 15 Mar 2018 12:35:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180314080439.4229-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] gtk: drop pointless code from
 gd_window_close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org

On 03/14/2018 09:04 AM, Gerd Hoffmann wrote:
> Unregistering the display change listener looks like a pointless
> excercise given we'll exit in a moment.  When exiting qemu via

exercise

> menu/file/quit this will not happen either.  Just drop the code.
> 
> Also return TRUE unconditionally.  This will tell gtk to ignore the
> close request, so gtk will not start destroying widgets and causing
> warnings due to UI code trying to talk to widgets which are gone.
> Just depend on qmp_quit() doing it's job instead.
> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Looks fine to me.
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Mark, is your issue resolved? (you might add your Tested-by).

> ---
>  ui/gtk.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index ef5bc42094..2925c66e0b 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -786,21 +786,13 @@ static gboolean gd_window_close(GtkWidget *widget, GdkEvent *event,
>  {
>      GtkDisplayState *s = opaque;
>      bool allow_close = true;
> -    int i;
>  
>      if (s->opts->has_window_close && !s->opts->window_close) {
>          allow_close = false;
>      }
>  
>      if (allow_close) {
> -        for (i = 0; i < s->nb_vcs; i++) {
> -            if (s->vc[i].type != GD_VC_GFX) {
> -                continue;
> -            }
> -            unregister_displaychangelistener(&s->vc[i].gfx.dcl);
> -        }
>          qmp_quit(NULL);
> -        return FALSE;
>      }
>  
>      return TRUE;
> 
