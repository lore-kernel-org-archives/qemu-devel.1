Received: from eggs.gnu.org ([2001:4830:134:3::10]:37973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceNyr-0006Ys-BY
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceNyq-00060H-Dz
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:28:25 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceNyq-0005zl-7E
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:28:24 -0500
Received: by mail-wr0-x233.google.com with SMTP id c4so14055382wrd.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:28:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486645277-4724-6-git-send-email-kraxel@redhat.com>
References: <1486645277-4724-1-git-send-email-kraxel@redhat.com>
	<1486645277-4724-6-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 15:28:02 +0000
Message-ID: <CAFEAcA8XRGyugmFzJ4PxRpcpHidfBD=1PX1NX8k7mAg3X+vCdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 05/10] ui: refactor VncDisplay to allow
 multiple listening sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 9 February 2017 at 13:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>
> Currently there is only a single listener for plain VNC and
> a single listener for websockets VNC. This means that if
> getaddrinfo() returns multiple IP addresses, for a hostname,
> the VNC server can only listen on one of them. This is
> just bearable if listening on wildcard interface, or if
> the host only has a single network interface to listen on,
> but if there are multiple NICs and the VNC server needs
> to listen on 2 or more specific IP addresses, it can't be
> done.
>
> This refactors the VncDisplay state so that it holds an
> array of listening sockets, but still only listens on
> one socket.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> Message-id: 20170203120649.15637-4-berrange@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

> @@ -3153,24 +3166,33 @@ void vnc_display_init(const char *id)
>
>  static void vnc_display_close(VncDisplay *vd)
>  {
> +    size_t i;
>      if (!vd) {
>          return;
>      }
>      vd->is_unix = false;
> -    if (vd->lsock != NULL) {
> -        if (vd->lsock_tag) {
> -            g_source_remove(vd->lsock_tag);
> +    for (i = 0; i < vd->nlsock; i++) {
> +        if (vd->lsock_tag[i]) {
> +            g_source_remove(vd->lsock_tag[i]);
>          }
> -        object_unref(OBJECT(vd->lsock));
> -        vd->lsock = NULL;
> +        object_unref(OBJECT(vd->lsock[i]));
>      }
> -    if (vd->lwebsock != NULL) {
> -        if (vd->lwebsock_tag) {
> -            g_source_remove(vd->lwebsock_tag);
> +    g_free(vd->lsock);
> +    g_free(vd->lsock_tag);
> +    vd->lsock = NULL;
> +    vd->nlsock = 0;

Coverity points out that this results in a double-free,
because vnc_display_open() has code paths which result in
calling vnc_display_close() twice on the same VncDisplay*,
and this code frees vd->lsock_tag without then setting it
to NULL.

Similarly for vd->lwebsock_tag and vd->led.

(Coverity issues CID 1371242, 1371243, 1371244.)

thanks
-- PMM
