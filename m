Received: from eggs.gnu.org ([2001:4830:134:3::10]:41169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dZjRw-0004yV-6O
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dZjRs-0005ro-9F
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:55:28 -0400
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:37771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1dZjRr-0005ps-Tu
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:55:24 -0400
References: <20170724164601.21063-1-berrange@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <88f8a661-f832-1d03-2736-d7b35c920e32@reactos.org>
Date: Mon, 24 Jul 2017 21:55:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170724164601.21063-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10] ps2: fix sending of PAUSE/BREAK
 scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Le 24/07/2017 à 18:46, Daniel P. Berrange a écrit :
> The processing of the scancodes for PAUSE/BREAK  has been broken since
> the conversion to qcodes in:
>
>   commit 8c10e0baf0260b59a4e984744462a18016662e3e
>   Author: Hervé Poussineau <hpoussin@reactos.org>
>   Date:   Thu Sep 15 22:06:26 2016 +0200
>
>     ps2: use QEMU qcodes instead of scancodes
>
> When using a VNC client, with the raw scancode extension, the client
> will send a scancode of 0xc6 for both PAUSE and BREAK. There is mistakenly
> no entry in the qcode_to_number table for this scancode, so
> ps2_keyboard_event() just generates a log message and discards the
> scancode
>
> When using a SPICE client, it will also send 0xc6 for BREAK, but
> will send 0xe1 0x1d 0x45 0xe1 0x9d 0xc5 for PAUSE. There is no
> entry in the qcode_to_number table for the scancode 0xe1 because
> it is a special XT keyboard prefix not mapping to any QKeyCode.
> Again ps2_keyboard_event() just generates a log message and discards
> the scancode. The following 0x1d, 0x45, 0x9d, 0xc5 scancodes get
> handled correctly. Fixing this just requires special casing 0xe1 so
> it is directly queued for sending to the guest, skipping any conversion
> to QKeyCode.

Your commit message is divided in 2 parts, and you're touching 1 file for each part of the commit message.
Should it be 2 patches instead?

>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/input/ps2.c    | 7 +++++++
>  ui/input-keymap.c | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 3ba05efd06..a132d1ba72 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -607,6 +607,13 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
>      assert(evt->type == INPUT_EVENT_KIND_KEY);
>      qcode = qemu_input_key_value_to_qcode(key->key);
>
> +    if (qcode == 0 &&
> +        key->key->type == KEY_VALUE_KIND_NUMBER &&
> +        key->key->u.number.data == 0x61) {
> +        ps2_put_keycode(s, 0xe1);
> +        return;
> +    }
> +

You're putting some specific code for spice in ps2 emulation.
IMO, the workaround should be moved to spice keyboard handling (ui/spice-input.c), which needs to generate a qcode instead of a scancode.
Here, you're making ps2 emulation work again with spice, but you're missing all other emulations using qcodes. Do you want to also modify them?
I understand that it may be the easiest way to fix the regression for 2.10, but it needs at least a comment.

>      if (s->scancode_set == 1) {
>          if (qcode == Q_KEY_CODE_PAUSE) {
>              if (key->down) {
> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
> index 8a1476fc48..9211f835be 100644
> --- a/ui/input-keymap.c
> +++ b/ui/input-keymap.c
> @@ -98,6 +98,7 @@ static const int qcode_to_number[] = {
>      [Q_KEY_CODE_KP_ENTER] = 0x9c,
>      [Q_KEY_CODE_KP_DECIMAL] = 0x53,
>      [Q_KEY_CODE_SYSRQ] = 0x54,
> +    [Q_KEY_CODE_PAUSE] = 0xc6,

This part: Acked-by: Hervé Poussineau <hpoussin@reactos.org>

>
>      [Q_KEY_CODE_KP_0] = 0x52,
>      [Q_KEY_CODE_KP_1] = 0x4f,
>
