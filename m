Received: from eggs.gnu.org ([2001:4830:134:3::10]:53056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <justin.gatzen@gmail.com>) id 1epugY-0007VQ-Sq
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 06:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <justin.gatzen@gmail.com>) id 1epugX-0007em-RW
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 06:41:42 -0500
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:46122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <justin.gatzen@gmail.com>)
	id 1epugX-0007dZ-L5
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 06:41:41 -0500
Received: by mail-qk0-x236.google.com with SMTP id 130so11143305qkd.13
	for <qemu-devel@nongnu.org>; Sun, 25 Feb 2018 03:41:41 -0800 (PST)
Date: Sun, 25 Feb 2018 06:41:38 -0500
From: Justin Gatzen <justin.gatzen@gmail.com>
Message-ID: <20180225114138.GB21248@north>
References: <CAOCGu7mjmpvre4y5KhTwm6paD5Enr8NHj=qPh-Vb7MoqE6E13w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCGu7mjmpvre4y5KhTwm6paD5Enr8NHj=qPh-Vb7MoqE6E13w@mail.gmail.com>
Subject: Re: [Qemu-devel] Windows vioinput guest driver tablet input bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>

The last email's diff got mangled due to long lines. The original
source has long lines still but it shouldnt get cut off his time.

Justin,


diff --git a/vioinput/sys/HidMouse.c b/vioinput/sys/HidMouse.c
index 69dac235..528bd3d6 100644
--- a/vioinput/sys/HidMouse.c
+++ b/vioinput/sys/HidMouse.c
@@ -325,7 +325,12 @@ HIDMouseProbe(
     DynamicArrayReserve(&AxisMap, AXIS_MAP_INITIAL_LENGTH * 2 * sizeof(ULONG));
 
     // Windows won't drive a mouse without at least the X and Y relative axes
-    if (InputCfgDataHasBit(pRelAxes, REL_X) && InputCfgDataHasBit(pRelAxes, REL_Y))
+    if (InputCfgDataHasBit(pRelAxes, REL_X) && InputCfgDataHasBit(pRelAxes, REL_Y)
+#ifdef EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
+        || (pMouseDesc->uNumOfButtons > 0 && InputCfgDataHasBit(pAbsAxes, ABS_X)
+            && InputCfgDataHasBit(pAbsAxes, ABS_Y))
+#endif // EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
+        )
     {
         for (i = 0; i < pRelAxes->size; i++)
         {
@@ -391,7 +396,8 @@ HIDMouseProbe(
     }
 
 #ifdef EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
-    if (uNumOfRelAxes == 0 &&
+    if ((!InputCfgDataHasBit(pRelAxes, REL_X) ||
+         !InputCfgDataHasBit(pRelAxes, REL_Y)) &&
         pMouseDesc->uNumOfButtons > 0 &&
         InputCfgDataHasBit(pAbsAxes, ABS_X) && InputCfgDataHasBit(pAbsAxes, ABS_Y))
     {


On Sun, Feb 25, 2018 at 05:21:29AM -0500, Justin Gatzen wrote:
> Hi,
> 
> The vioinput Windows guest driver does not seem to work with mouse wheel or
> side buttons for virtio-tablet-pci devices, while virtio-mouse-pci works as
> expected. Linux guest drivers are unaffected. Tablets are being categorized as
> mice due to the EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE compile flag. But when
> there are no relative REL_X or REL_Y input axes the driver ignores all other
> relative axis entries. Mouse wheel is one such relative axis. I've attached a
> proof of concept fix for the guest driver that seems to fix both the mouse
> wheel and side buttons but I believe this needs a more robust fix and deeper
> look at the HIDMouseProbe function.
> 
> Thanks,
> Justin
> 
> 
> diff --git a/vioinput/sys/HidMouse.c b/vioinput/sys/HidMouse.c
> index 69dac235..ea188991 100644
> --- a/vioinput/sys/HidMouse.c
> +++ b/vioinput/sys/HidMouse.c
> @@ -325,7 +325,11 @@ HIDMouseProbe(
>      DynamicArrayReserve(&AxisMap, AXIS_MAP_INITIAL_LENGTH * 2 * sizeof(ULONG));
> 
>      // Windows won't drive a mouse without at least the X and Y relative axes
> -    if (InputCfgDataHasBit(pRelAxes, REL_X) &&
> InputCfgDataHasBit(pRelAxes, REL_Y))
> +    if (InputCfgDataHasBit(pRelAxes, REL_X) &&
> InputCfgDataHasBit(pRelAxes, REL_Y)
> +#ifdef EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
> +        || (pMouseDesc->uNumOfButtons > 0 &&
> InputCfgDataHasBit(pAbsAxes, ABS_X) && InputCfgDataHasBit(pAbsAxes,
> ABS_Y))
> +#endif // EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
> +        )
>      {
>          for (i = 0; i < pRelAxes->size; i++)
>          {
> @@ -391,7 +395,7 @@ HIDMouseProbe(
>      }
> 
>  #ifdef EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
> -    if (uNumOfRelAxes == 0 &&
> +    if ((!InputCfgDataHasBit(pRelAxes, REL_X) ||
> !InputCfgDataHasBit(pRelAxes, REL_Y)) &&
>          pMouseDesc->uNumOfButtons > 0 &&
>          InputCfgDataHasBit(pAbsAxes, ABS_X) &&
> InputCfgDataHasBit(pAbsAxes, ABS_Y))
>      {
