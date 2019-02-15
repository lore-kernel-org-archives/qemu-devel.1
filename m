Received: from eggs.gnu.org ([209.51.188.92]:35732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guZ7m-0002le-8J
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guZ7i-0006PL-Rx
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:45:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:54432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1guZ7c-00068r-8R
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:45:28 -0500
Date: Fri, 15 Feb 2019 16:44:51 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190215084451.GA5456@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190214201939.494-1-philmd@redhat.com>
	<20190214201939.494-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190214201939.494-2-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/9] ccid-card-passthru: Move assertion
 in read() to can_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Feb 14, 2019 at 09:19:31PM +0100, Philippe Mathieu-Daudé wrote:
>chardev::read() depends of what chardev::can_read() returns, move the
>assertion to can_read().
>
>Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>---
> hw/usb/ccid-card-passthru.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
>index 0a6c657228..8bb1314f49 100644
>--- a/hw/usb/ccid-card-passthru.c
>+++ b/hw/usb/ccid-card-passthru.c
>@@ -116,8 +116,8 @@ static int ccid_card_vscard_can_read(void *opaque)
> {
>     PassthruState *card = opaque;
> 
>-    return VSCARD_IN_SIZE >= card->vscard_in_pos ?
>-           VSCARD_IN_SIZE - card->vscard_in_pos : 0;
>+    assert(card->vscard_in_pos <= VSCARD_IN_SIZE);

Do you have special reason change "<" to "<="?

>+    return VSCARD_IN_SIZE - card->vscard_in_pos;
> }
> 
> static void ccid_card_vscard_handle_init(
>@@ -282,7 +282,6 @@ static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int size)
>         ccid_card_vscard_drop_connection(card);
>         return;
>     }
>-    assert(card->vscard_in_pos < VSCARD_IN_SIZE);
>     assert(card->vscard_in_hdr < VSCARD_IN_SIZE);
>     memcpy(card->vscard_in_data + card->vscard_in_pos, buf, size);
>     card->vscard_in_pos += size;
>-- 
>2.20.1
>

-- 
Wei Yang
Help you, Help me
