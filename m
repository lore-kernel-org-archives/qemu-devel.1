Received: from eggs.gnu.org ([2001:4830:134:3::10]:41318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csWYu-0006za-W5
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csWYr-0001P4-TM
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:28:05 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csWYr-0001Ow-OZ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:28:01 -0400
Received: by mail-qt0-x241.google.com with SMTP id r45so8070290qte.0
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 08:28:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170326095349.8571-1-jcelaya@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d58fef44-88c7-9e84-0c80-39b2fdf1f82e@amsat.org>
Date: Mon, 27 Mar 2017 12:27:58 -0300
MIME-Version: 1.0
In-Reply-To: <20170326095349.8571-1-jcelaya@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Fix input-linux reading from device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Javier Celaya <jcelaya@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

Hi Javier,

can you add a line to explain what did you change between v1/v2?

Thank,

Phil.

On 03/26/2017 06:53 AM, Javier Celaya wrote:
> The evdev devices in input-linux.c are read in blocks of one whole
> event. If there are not enough bytes available, they are discarded,
> instead of being kept for the next read operation. This results in
> lost events, of even non-working devices.
>
> This patch keeps track of the number of bytes to be read to fill up
> a whole event, and then handle it.
>
> Signed-off-by: Javier Celaya <jcelaya@gmail.com>
> ---
>  ui/input-linux.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/ui/input-linux.c b/ui/input-linux.c
> index ac31f47719..02b0d4b2fe 100644
> --- a/ui/input-linux.c
> +++ b/ui/input-linux.c
> @@ -169,6 +169,8 @@ struct InputLinux {
>      bool        has_abs_x;
>      int         num_keys;
>      int         num_btns;
> +    struct input_event event;
> +    int         to_be_read;
>
>      QTAILQ_ENTRY(InputLinux) next;
>  };
> @@ -327,25 +329,30 @@ static void input_linux_handle_mouse(InputLinux *il, struct input_event *event)
>  static void input_linux_event(void *opaque)
>  {
>      InputLinux *il = opaque;
> -    struct input_event event;
>      int rc;
> +    int offset;
> +    uint8_t *p = (uint8_t *)&il->event;
>
>      for (;;) {
> -        rc = read(il->fd, &event, sizeof(event));
> -        if (rc != sizeof(event)) {
> +        offset = sizeof(il->event) - il->to_be_read;
> +        rc = read(il->fd, &p[offset], il->to_be_read);
> +        if (rc != il->to_be_read) {
>              if (rc < 0 && errno != EAGAIN) {
>                  fprintf(stderr, "%s: read: %s\n", __func__, strerror(errno));
>                  qemu_set_fd_handler(il->fd, NULL, NULL, NULL);
>                  close(il->fd);
> +            } else if (rc > 0){
> +                il->to_be_read -= rc;
>              }
>              break;
>          }
> +        il->to_be_read = sizeof(il->event);
>
>          if (il->num_keys) {
> -            input_linux_handle_keyboard(il, &event);
> +            input_linux_handle_keyboard(il, &il->event);
>          }
>          if (il->has_rel_x && il->num_btns) {
> -            input_linux_handle_mouse(il, &event);
> +            input_linux_handle_mouse(il, &il->event);
>          }
>      }
>  }
> @@ -417,6 +424,7 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
>          }
>      }
>
> +    il->to_be_read = sizeof(il->event);
>      qemu_set_fd_handler(il->fd, input_linux_event, NULL, il);
>      if (il->keycount) {
>          /* delay grab until all keys are released */
>
