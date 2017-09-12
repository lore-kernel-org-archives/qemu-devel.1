Received: from eggs.gnu.org ([2001:4830:134:3::10]:52464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkbP-0000wx-1T
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkbL-0008Dx-4f
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:47:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkbK-0008Dc-Qd
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:47:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3845356E6
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 12:47:37 +0000 (UTC)
Date: Tue, 12 Sep 2017 13:47:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170912124731.GF17633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<20170912123744.14730-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170912123744.14730-6-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/12] input: convert virtio-input-hid
 device to keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Sep 12, 2017 at 01:37:37PM +0100, Daniel P. Berrange wrote:
> Replace the keymap_qcode table with automatically generated
> tables.
> 
> Missing entries in keymap_qcode now fixed:
> 
>   Q_KEY_CODE_ASTERISK -> KEY_KPASTERISK
>   Q_KEY_CODE_KP_MULTIPLY -> KEY_KPASTERISK
>   Q_KEY_CODE_STOP -> KEY_STOP
>   Q_KEY_CODE_AGAIN -> KEY_AGAIN
>   Q_KEY_CODE_PROPS -> KEY_PROPS
>   Q_KEY_CODE_UNDO -> KEY_UNDO
>   Q_KEY_CODE_FRONT -> KEY_FRONT
>   Q_KEY_CODE_COPY -> KEY_COPY
>   Q_KEY_CODE_OPEN -> KEY_OPEN
>   Q_KEY_CODE_PASTE -> KEY_PASTE
>   Q_KEY_CODE_FIND -> KEY_FIND
>   Q_KEY_CODE_CUT -> KEY_CUT
>   Q_KEY_CODE_LF -> KEY_LINEFEED
>   Q_KEY_CODE_HELP -> KEY_HELP
>   Q_KEY_CODE_COMPOSE -> KEY_COMPOSE
>   Q_KEY_CODE_RO -> KEY_RO
>   Q_KEY_CODE_HIRAGANA -> KEY_HIRAGANA
>   Q_KEY_CODE_HENKAN -> KEY_HENKAN
>   Q_KEY_CODE_YEN -> KEY_YEN
>   Q_KEY_CODE_KP_COMMA -> KEY_KPCOMMA
>   Q_KEY_CODE_KP_EQUALS -> KEY_KPEQUAL
>   Q_KEY_CODE_POWER -> KEY_POWER
>   Q_KEY_CODE_SLEEP -> KEY_SLEEP
>   Q_KEY_CODE_WAKE -> KEY_WAKEUP
>   Q_KEY_CODE_AUDIONEXT -> KEY_NEXTSONG
>   Q_KEY_CODE_AUDIOPREV -> KEY_PREVIOUSSONG
>   Q_KEY_CODE_AUDIOSTOP -> KEY_STOPCD
>   Q_KEY_CODE_AUDIOPLAY -> KEY_PLAYPAUSE
>   Q_KEY_CODE_AUDIOMUTE -> KEY_MUTE
>   Q_KEY_CODE_VOLUMEUP -> KEY_VOLUMEUP
>   Q_KEY_CODE_VOLUMEDOWN -> KEY_VOLUMEDOWN
>   Q_KEY_CODE_MEDIASELECT -> KEY_MEDIA
>   Q_KEY_CODE_MAIL -> KEY_MAIL
>   Q_KEY_CODE_CALCULATOR -> KEY_CALC
>   Q_KEY_CODE_COMPUTER -> KEY_COMPUTER
>   Q_KEY_CODE_AC_HOME -> KEY_HOMEPAGE
>   Q_KEY_CODE_AC_BACK -> KEY_BACK
>   Q_KEY_CODE_AC_FORWARD -> KEY_FORWARD
>   Q_KEY_CODE_AC_REFRESH -> KEY_REFRESH
>   Q_KEY_CODE_AC_BOOKMARKS -> KEY_BOOKMARKS
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/input/virtio-input-hid.c      | 136 +++-------------------------------
>  include/ui/input.h               |   3 +
>  ui/Makefile.objs                 |   1 +
>  ui/input-keymap-qcode-to-linux.c | 156 +++++++++++++++++++++++++++++++++++++++
>  ui/input-keymap.c                |   1 +
>  5 files changed, 170 insertions(+), 127 deletions(-)
>  create mode 100644 ui/input-keymap-qcode-to-linux.c
> 

> @@ -162,7 +43,7 @@ static const unsigned int axismap_abs[INPUT_AXIS__MAX] = {
>  /* ----------------------------------------------------------------- */
>  
>  static void virtio_input_key_config(VirtIOInput *vinput,
> -                                    const unsigned int *keymap,
> +                                    const unsigned short *keymap,
>                                      size_t mapsize)
>  {
>      virtio_input_config keys;

[snip]

> @@ -387,8 +269,8 @@ static void virtio_keyboard_init(Object *obj)
>  
>      vhid->handler = &virtio_keyboard_handler;
>      virtio_input_init_config(vinput, virtio_keyboard_config);
> -    virtio_input_key_config(vinput, keymap_qcode,
> -                            ARRAY_SIZE(keymap_qcode));
> +    virtio_input_key_config(vinput, qemu_input_map_qcode_to_linux,
> +                            qemu_input_map_qcode_to_linux_len);
>  }

Revisiting Gerd's comment on an earlier posting of this patch. Gerd
mentioned that this change affects guest ABI, but I'm wondering
whether we actually need to care about that or not.

IIUC, the array we pass in here is used to populate a bitmap that is
passed to the guest OS. The bitmap has one bit set for each Linux
keycode that the input driver is capable of sending.

>From what I can see the guest OS will read this bitmap when it first
probes the virtio device, and never updates it.  If so, then is it
actually a problem if we don't preserve the same map across save/
restore/migrate ?

If we removed a key from the bitmap in newer QEMU, that does not
appear a problem as we'd never send an event to the guest with
that key code.

If we added a key to the bitmap, we would potentially be sending
a key to the guest that we hadn't previously declared support for.
Either the guest OS will handle this normally, despite it not
being in the declared bitmap, or it will silently drop the event.
Neither behaviour seems problematic.

If we did need to preserve ABI for this bitmap, then it seems we're
going to create alot of work for ourselves, having to maintain
many historical copies of the keycode maps tables, adding a new
copy every time support for a new key is added in QEMU. I'd
rather we avoided that complexity & burden unless there's clear
bad behaviour by not maintaining stable keycode bitmap data across
QEMU releases.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
