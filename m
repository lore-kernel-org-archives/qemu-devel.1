Received: from eggs.gnu.org ([2001:4830:134:3::10]:59192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHBHV-0000oG-GZ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHBHQ-0005uV-FC
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:15:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cHBHQ-0005uC-9P
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:15:40 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76C77C008B1B
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 15:15:39 +0000 (UTC)
Message-ID: <1481728535.8440.48.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Dec 2016 16:15:35 +0100
In-Reply-To: <20161214142518.10504-1-stefanha@redhat.com>
References: <20161214142518.10504-1-stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.8] ui/gtk: fix "Copy" menu item
 segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>

On Mi, 2016-12-14 at 14:25 +0000, Stefan Hajnoczi wrote:
> The "Copy" menu item copies VTE terminal text to the clipboard.  This
> only works with VTE terminals, not with graphics consoles.
>=20
> Disable the menu item when the current notebook page isn't a VTE
> terminal.
>=20
> This patch fixes a segfault.  Reproducer: Start QEMU and click the Copy
> menu item when the guest display is visible.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  ui/gtk.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> Gerd, Michael: if you post Reviewed-by I can merge this directly without
> requiring you to send a pull request.  It's a user interface segfault so =
it
> would be nice to resolve it in QEMU 2.8.
>=20
> diff --git a/ui/gtk.c b/ui/gtk.c
> index e816428..a216216 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1581,6 +1581,9 @@ static void gd_change_page(GtkNotebook *nb, gpointe=
r arg1, guint arg2,
>                                         TRUE);
>      }
>      gtk_widget_set_sensitive(s->grab_item, on_vga);
> +#ifdef CONFIG_VTE
> +    gtk_widget_set_sensitive(s->copy_item, vc->type =3D=3D GD_VC_VTE);
> +#endif
> =20
>      gd_update_windowsize(vc);
>      gd_update_cursor(vc);
> @@ -2246,6 +2249,11 @@ void gtk_display_init(DisplayState *ds, bool full_=
screen, bool grab_on_hover)
>      }
>  #endif
> =20
> +#ifdef CONFIG_VTE
> +    gtk_widget_set_sensitive(s->copy_item,
> +                             gd_vc_find_current(s)->type =3D=3D GD_VC_VT=
E);
> +#endif
> +
>      if (full_screen) {
>          gtk_menu_item_activate(GTK_MENU_ITEM(s->full_screen_item));
>      }
