Received: from eggs.gnu.org ([2001:4830:134:3::10]:37619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6biV-00017V-Gq
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6biS-000795-Dn
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:48:11 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6biS-00078p-8X
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:48:08 -0400
Received: by mail-qt0-x243.google.com with SMTP id r58so417698qtb.2
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 04:48:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170505104101.30589-1-kraxel@redhat.com>
	<20170505104101.30589-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5d41f2ec-6e91-565d-9884-c908f4f38adf@amsat.org>
Date: Fri, 5 May 2017 08:48:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170505104101.30589-5-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/6] egl-helpers: add missing error check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 05/05/2017 07:40 AM, Gerd Hoffmann wrote:
> Code didn't check for qemu_egl_init_dpy_mesa() failures, add it.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  ui/egl-helpers.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index ec2e325e21..b50225158b 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -80,6 +80,7 @@ static int qemu_egl_rendernode_open(const char *rendernode)
>  int egl_rendernode_init(const char *rendernode)
>  {
>      qemu_egl_rn_fd = -1;
> +    int rc;
>
>      qemu_egl_rn_fd = qemu_egl_rendernode_open(rendernode);
>      if (qemu_egl_rn_fd == -1) {
> @@ -93,7 +94,11 @@ int egl_rendernode_init(const char *rendernode)
>          goto err;
>      }
>
> -    qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_dev);
> +    rc = qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_dev);
> +    if (rc != 0) {
> +        /* qemu_egl_init_dpy_mesa reports error */
> +        goto err;
> +    }
>
>      if (!epoxy_has_egl_extension(qemu_egl_display,
>                                   "EGL_KHR_surfaceless_context")) {
>
