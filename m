Received: from eggs.gnu.org ([209.51.188.92]:60585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwU7y-0004DZ-0V
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwU7w-0005Z8-1M
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gwU7u-0005T6-WB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88C61A062F
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 13:52:07 +0000 (UTC)
References: <20190220100235.20914-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <baca0af4-5807-499a-748d-8a13e744a7c9@redhat.com>
Date: Wed, 20 Feb 2019 07:52:03 -0600
MIME-Version: 1.0
In-Reply-To: <20190220100235.20914-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] kbd-state: don't block auto-repeat events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 2/20/19 4:02 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/kbd-state.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/ui/kbd-state.c b/ui/kbd-state.c
> index ac14add70e..09e3cfedfc 100644
> --- a/ui/kbd-state.c
> +++ b/ui/kbd-state.c
> @@ -42,14 +42,18 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down)
>  {
>      bool state = test_bit(qcode, kbd->keys);
>  
> -    if (state == down) {
> +    if (down == false  /* got key-up event   */ &&
> +        state == false /* key is not pressed */) {
>          /*
> -         * Filter out events which don't change the keyboard state.
> +         * Filter out suspious key-up events.

s/suspious/suspicious/

>           *
> -         * Most notably this allows to simply send along all key-up
> -         * events, and this function will filter out everything where
> -         * the corresponding key-down event wasn't send to the guest,
> -         * for example due to being a host hotkey.
> +         * This allows to simply send along all key-up events, and

"allows to ${VERB}" is not idiomatic; it should either be "allows
${SUBJECT} to ${VERB}" or "allows ${VERB}ing".  In this case, I'd go with:

Most notably, this allows simply sneding along all key-up events

> +         * this function will filter out everything where the
> +         * corresponding key-down event wasn't send to the guest, for

s/send/sent/

> +         * example due to being a host hotkey.
> +         *
> +         * Note that key-down events on already pressed keys are *not*
> +         * suspious, those are keyboard autorepeat events.

s/suspious/suspicious/

>           */
>          return;
>      }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
