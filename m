Received: from eggs.gnu.org ([2001:4830:134:3::10]:58570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIhA-0003ka-Iy
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIh1-0001gc-Lr
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:48:52 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIh1-0001gE-Gi
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:48:43 -0400
Received: by mail-qk0-x244.google.com with SMTP id c131-v6so321638qkb.0
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 07:48:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <684de99e-c9d6-7286-0c8d-80137e22e77e@amsat.org>
Date: Fri, 8 Jun 2018 11:48:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180601162749.27406-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v2 02/12] libvhost-user: exit by default on
 VHOST_USER_NONE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 06/01/2018 01:27 PM, Marc-André Lureau wrote:
> Since commit 2566378d6d13bf4d28c7770bdbda5f7682594bbe, libvhost-user
> no longer panics on disconnect (rc == 0), and instead silently ignores
> an invalid VHOST_USER_NONE message.
> 
> Without extra work from the API user, this will simply busy-loop on
> HUP events. The obvious thing to do is to exit(0) instead, while
> additional or different work can be done by overriding
> iface->process_msg().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 54e643d871..ebe30c7dab 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1220,6 +1220,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>      case VHOST_USER_SET_CONFIG:
>          return vu_set_config(dev, vmsg);
>      case VHOST_USER_NONE:
> +        /* if you need processing before exit, override iface->process_msg */
> +        exit(0);
>          break;

Remove the 'break'?

>      case VHOST_USER_POSTCOPY_ADVISE:
>          return vu_set_postcopy_advise(dev, vmsg);
> 
