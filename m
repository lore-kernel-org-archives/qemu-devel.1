Received: from eggs.gnu.org ([2001:4830:134:3::10]:58934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVHpv-00088V-3P
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVHpt-0004uZ-SI
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:37:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVHpt-0004tp-Io
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:37:49 -0400
Date: Wed, 12 Jul 2017 14:37:41 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170712133741.GG5237@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499863425-103133-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499863425-103133-1-git-send-email-agraf@suse.de>
Subject: Re: [Qemu-devel] [PATCH v2] vnc: Set default kbd delay to 10ms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Jul 12, 2017 at 02:43:45PM +0200, Alexander Graf wrote:
> The current VNC default keyboard delay is 1ms. With that we're constantly
> typing faster than the guest receives keyboard events from an XHCI attached
> USB HID device.
> 
> The default keyboard delay time in the input layer however is 10ms. I don't know
> how that number came to be, but empirical tests on some OpenQA driven ARM
> systems show that 10ms really is a reasonable default number for the delay.
> 
> This patch moves the VNC delay also to 10ms. That way our default is much
> safer (good!) and also consistent with the input layer default (also good!).

And that still allows 100 keys to be sent in 1 second. If people are needing
to send more than this, they should be using a paravirt channel like the
SPICE agent which support high volume text cut + paste to the guest OS.

> 
> Signed-off-by: Alexander Graf <agraf@suse.de>

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


> ---
>  qemu-options.hx | 2 +-
>  ui/vnc.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 76b1c67..6909285 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1753,7 +1753,7 @@ spec but is traditional QEMU behavior.
>  @item key-delay-ms
>  
>  Set keyboard delay, for key down and key up events, in milliseconds.
> -Default is 1.  Keyboards are low-bandwidth devices, so this slowdown
> +Default is 10.  Keyboards are low-bandwidth devices, so this slowdown
>  can help the device and guest to keep up and not lose events in case
>  events are arriving in bulk.  Possible causes for the latter are flaky
>  network connections, or scripts for automated testing.
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 26136f5..eb91559 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3808,7 +3808,7 @@ void vnc_display_open(const char *id, Error **errp)
>      }
>  
>      lock_key_sync = qemu_opt_get_bool(opts, "lock-key-sync", true);
> -    key_delay_ms = qemu_opt_get_number(opts, "key-delay-ms", 1);
> +    key_delay_ms = qemu_opt_get_number(opts, "key-delay-ms", 10);
>      sasl = qemu_opt_get_bool(opts, "sasl", false);
>  #ifndef CONFIG_VNC_SASL
>      if (sasl) {
> -- 
> 1.8.5.6
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
