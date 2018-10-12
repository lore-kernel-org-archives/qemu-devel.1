Received: from eggs.gnu.org ([2001:4830:134:3::10]:53904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAwub-0005y4-8b
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gAwuX-0003fj-8u
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:51:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gAwuW-0003ds-Ui
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:51:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so12204448wma.4
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 05:51:20 -0700 (PDT)
Message-ID: <1539348678.16655.167.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Fri, 12 Oct 2018 14:51:18 +0200
In-Reply-To: <20181012114551.28809-1-kraxel@redhat.com>
References: <20181012114551.28809-1-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Spice-devel] [PATCH] spice: prepare for upcoming
 spice-server change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: spice-devel@lists.freedesktop.org

On Fri, 2018-10-12 at 13:45 +0200, Gerd Hoffmann wrote:
> Future spice-server versions will call the client_monitors_config
> callback with the monitors list filtered to only include the monitors
> of the given display channel (aka QXLInstance).  Luckily this is easily
> detectable at runtime, so we can prepare for that in advance and also
> make qemu compatible with both old and new spice-server versions.
> 
> While being at it also use the console index instead of head number as
> array index.  The later doesn't work correctly in case multiple display
> devices are present.
> 
> Cc: spice-devel@lists.freedesktop.org
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

FWIW LGTM :)

With a small note below.

Reviewed-by: Lukáš Hrázký <lhrazky@redhat.com>

> ---
>  ui/spice-display.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 2f8adb6b9f..52f8cb5ae1 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -674,10 +674,28 @@ static int interface_client_monitors_config(QXLInstance *sin,
>  
>      memset(&info, 0, sizeof(info));
>  
> -    head = qemu_console_get_head(ssd->dcl.con);
> -    if (mc->num_of_monitors > head) {
> -        info.width  = mc->monitors[head].width;
> -        info.height = mc->monitors[head].height;
> +    if (mc->num_of_monitors == 1) {
> +        /*
> +         * New spice-server version which filters the list of monitors
> +         * to only include those that belong to our display channel.
> +         *
> +         * single-head configuration (where filtering doesn't matter)
> +         * takes this code path too.
> +         */
> +        info.width  = mc->monitors[0].width;
> +        info.height = mc->monitors[0].height;
> +    } else {
> +        /*
> +         * Old spice-server which gives us all monitors, so we have to
> +         * figure ourself which entry we need.  Array index is the
> +         * channel_id, which is the qemu console index, see
> +         * qemu_spice_add_display_interface().
> +         */
> +        head = qemu_console_get_index(ssd->dcl.con);
> +        if (mc->num_of_monitors > head) {

I consider it a convention to put the variable index (head) on the left
of the condition and the fixed size (mc->num_of_monitors) on the right.
So maybe swap those while touching the code.

Cheers,
Lukas

> +            info.width  = mc->monitors[head].width;
> +            info.height = mc->monitors[head].height;
> +        }
>      }
>  
>      trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
