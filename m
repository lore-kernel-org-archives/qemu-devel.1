Received: from eggs.gnu.org ([2001:4830:134:3::10]:35232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVdY7-0007Da-5u
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVdY4-00082j-44
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:53:27 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVdY3-00081W-Rl
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:53:24 -0400
Received: by mail-wm0-f50.google.com with SMTP id n5-v6so7059707wmc.5
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:53:23 -0700 (PDT)
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-3-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9434a209-b2d9-2004-1fc3-4c006efc951b@redhat.com>
Date: Wed, 20 Jun 2018 15:53:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180618161729.334-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/26] chardev: remove
 qemu_chr_fe_write_all() counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 18/06/2018 18:17, Marc-André Lureau wrote:
> There is no obvious reason to have a loop counter. This limits from
> reading several megabytes large buffers in one go, since socket
> read/write usually have a limit.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-fe.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index b1f228e8b5..f158f158f8 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -56,7 +56,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
>  int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
>  {
>      Chardev *s = be->chr;
> -    int offset = 0, counter = 10;
> +    int offset = 0;
>      int res;
>  
>      if (!s || !CHARDEV_GET_CLASS(s)->chr_sync_read) {
> @@ -88,10 +88,6 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
>          }
>  
>          offset += res;
> -
> -        if (!counter--) {
> -            break;
> -        }
>      }
>  
>      if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
