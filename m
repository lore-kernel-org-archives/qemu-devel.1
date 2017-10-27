Received: from eggs.gnu.org ([2001:4830:134:3::10]:55858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7z5O-00045c-Ec
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7z5L-0000mv-53
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:29:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7z5K-0000kx-Rs
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:29:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AED282027A
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 07:29:40 +0000 (UTC)
Date: Fri, 27 Oct 2017 08:29:34 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171027072934.GA30999@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171023091947.20771-1-kraxel@redhat.com>
	<20171023091947.20771-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171023091947.20771-5-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 4/9] ps2: fix scancodes sent for Alt-Print
 key combination (aka SysRq)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Oct 23, 2017 at 11:19:42AM +0200, Gerd Hoffmann wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
> 
> The 'Print' key is special in the AT set 1 / set 2 scancode definitions.
> 
> An unmodified 'Print' key is supposed to send
> 
>  AT Set 1:  e0 2a e0 37 (Down)  e0 b7 e0 aa (Up)
>  AT Set 2:  e0 12 e0 7c (Down)  e0 f0 7c e0 f0 12 (Up)
> 
> which QEMU gets right. When pressed in combination with the 'Alt_L' or 'Alt_R'
> keys (which signify SysRq), the scancodes are required to follow a different
> scheme. With Alt_L, the expected sequences are
> 
>  AT set 1:  38, 54 (Down) d4, b8 (Up)
>  AT set 2:  11, 84 (Down) f0 84, f0 11 (Up)
> 
> And with Alt_R
> 
>  AT set 1:  e0 38, 54 (Down) d4, e0 b8 (Up)
>  AT set 2:  e0 11, 84 (Down) f0 84, f0 e0 11 (Up)
> 
> It is actually slightly more complicated than that, because (according results
> of 'showkey -s', keyboards will in fact first release the currently pressed
> modifier before sending the sequence above (which effectively re-presses &
> then releases the modifier) and finally re-press the original modifier
> afterwards. IOW, with Alt_L we need to send
> 
>  AT set 1:  b8, 38, 54 (Down) d4, b8, 38 (Up)
>  AT set 2:  f0 11, 11, 84 (Down) f0 84, f0 11, 11 (Up)
> 
> And with Alt_R
> 
>  AT set 1:  e0 b8, e0 38, 54 (Down) d4, e0 b8, e0 38 (Up)
>  AT set 2:  e0 f0 11, e0 11, 84 (Down) f0 84, e0 f0 11, e0 11 (Up)
> 
> The AT set 3 scancodes have no special handling for Alt-Print.
> 
> Rather than fixing the handling of the 'print' key in the ps2 driver to consider
> the Alt modifiers, way back, a patch was commited that defined an extra 'sysrq'
> key name:
> 
>   commit f2289cb6924afc97b2a75d21bfc9217024d11741
>   Author: balrog <balrog@c046a42c-6fe2-441c-8c8c-71466251a162>
>   Date:   Wed Jun 4 10:14:16 2008 +0000
> 
>     Add sysrq to key names known by "sendkey".
> 
>     Adding sysrq keycode to the table enabling running sysrq debugging in
>     the guest via the monitor sendkey command, like:
> 
>     (qemu) sendkey alt-sysrq-t
> 
>     Tested on x86-64 target and Linux guest.
> 
>     Signed-off-by: Ryan Harper <ryanh@us.ibm.com>
> 
> With this patch QEMU would send
> 
>  AT set 1:  38, 54 (Down) d4, b8 (Up)
>  AT set 2:  11, 84 (Down) f0 84, f0 11 (Up)
> 
> but this doesn't match what actual real keyboards send, as it is not releasing
> the original modifier & pressing it again afterwards. In addition the original
> problem remains, and a new problem was added:
> 
>   - The sequence 'alt-print-t' is still broken, acting as if 'print-t' was
>     requested
>   - The sequence 'sysrq-t' is broken, injecting an undefine scancode sequence
>     tot he guest os (bare 0x54)
> 
> To deal with this mess we make these changes to the ps2 code, so that we track
> the state of modifier keys (Alt, Shift, Ctrl - both left & right). Then we can
> vary what scancodes are sent for Q_KEY_CODE_PRINT according to the Alt key
> modifier state
> 
> Interestingly, it appears that of operating systems I've checked (Linux, FreeBSD
> and OpenSolaris), none of them actually bother to validate the full sequences
> for a unmodified 'Print' key. They all just ignore the leading "e0 2a" and
> trigger based off "e0 37" alone. The latter two byte sequence is what keyboards
> send with 'Print' is combined with 'Shift' or 'Ctrl' modifiers.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> Message-id: 20171019142848.572-5-berrange@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/input/ps2.c        | 137 ++++++++++++++++++++++++++++++++++++++++++--------
>  hw/input/trace-events |   1 +
>  2 files changed, 118 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index dff3f1e024..1e6f6ae9b6 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -78,6 +78,14 @@
>  
>  #define PS2_QUEUE_SIZE 16  /* Buffer size required by PS/2 protocol */
>  
> +/* Bits for 'modifiers' field in PS2KbdState */
> +#define MOD_CTRL_L  (1 << 0)
> +#define MOD_SHIFT_L (1 << 1)
> +#define MOD_ALT_L   (1 << 2)
> +#define MOD_CTRL_R  (1 << 3)
> +#define MOD_SHIFT_R (1 << 4)
> +#define MOD_ALT_R   (1 << 5)
> +
>  typedef struct {
>      /* Keep the data array 256 bytes long, which compatibility
>       with older qemu versions. */
> @@ -99,6 +107,7 @@ typedef struct {
>      int scancode_set; /* 1=XT, 2=AT, 3=PS/2 */
>      int ledstate;
>      bool need_high_bit;
> +    unsigned int modifiers; /* bitmask of MOD_* constants above */
>  } PS2KbdState;

No one confirmed whether or not this new field needs to be added to the
VMSTATE sections, and if so, how todo this in a back compatible manner....


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
