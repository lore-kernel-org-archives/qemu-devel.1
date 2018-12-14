Received: from eggs.gnu.org ([2001:4830:134:3::10]:36783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXkza-0005sO-9z
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXkzV-0005Z2-0G
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:46:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXkzU-0005WK-KM
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:46:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so5318878wmh.0
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 02:46:44 -0800 (PST)
References: <20181210140808.26794-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7ed7720f-af5a-966a-221a-b9872bbd257c@redhat.com>
Date: Fri, 14 Dec 2018 11:46:41 +0100
MIME-Version: 1.0
In-Reply-To: <20181210140808.26794-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] input: avoid malloc for mouse events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: felix.yzg@gmail.com

On 12/10/18 3:08 PM, Gerd Hoffmann wrote:
> There is no reason to allocate mouse events using malloc, we can
> allcoate them from stack instead, save a few cpu cycles and make the
> code more readable with c99 initializers.

Good idea.

> 
> Suggested-by: FelixYao <felix.yzg@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/ui/input.h |  3 ---
>  ui/input.c         | 68 +++++++++++++++++++++++++-----------------------------
>  2 files changed, 31 insertions(+), 40 deletions(-)
> 
> diff --git a/include/ui/input.h b/include/ui/input.h
> index 34ebc67c5a..8c8ccb999f 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -49,7 +49,6 @@ int qemu_input_key_value_to_scancode(const KeyValue *value, bool down,
>                                       int *codes);
>  int qemu_input_linux_to_qcode(unsigned int lnx);
>  
> -InputEvent *qemu_input_event_new_btn(InputButton btn, bool down);
>  void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
>  void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
>                                 uint32_t button_old, uint32_t button_new);
> @@ -58,8 +57,6 @@ bool qemu_input_is_absolute(void);
>  int qemu_input_scale_axis(int value,
>                            int min_in, int max_in,
>                            int min_out, int max_out);
> -InputEvent *qemu_input_event_new_move(InputEventKind kind,
> -                                      InputAxis axis, int value);
>  void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value);
>  void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
>                            int min_in, int max_in);
> diff --git a/ui/input.c b/ui/input.c
> index 7c9a4109c4..f9d413fef9 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -458,22 +458,18 @@ void qemu_input_event_send_key_delay(uint32_t delay_ms)
>      }
>  }
>  
> -InputEvent *qemu_input_event_new_btn(InputButton btn, bool down)
> -{
> -    InputEvent *evt = g_new0(InputEvent, 1);
> -    evt->u.btn.data = g_new0(InputBtnEvent, 1);
> -    evt->type = INPUT_EVENT_KIND_BTN;
> -    evt->u.btn.data->button = btn;
> -    evt->u.btn.data->down = down;
> -    return evt;
> -}
> -
>  void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down)
>  {
> -    InputEvent *evt;
> -    evt = qemu_input_event_new_btn(btn, down);
> -    qemu_input_event_send(src, evt);
> -    qapi_free_InputEvent(evt);
> +    InputBtnEvent bevt = {
> +        .button = btn,
> +        .down = down,
> +    };
> +    InputEvent evt = {
> +        .type = INPUT_EVENT_KIND_BTN,
> +        .u.btn.data = &bevt,
> +    };
> +
> +    qemu_input_event_send(src, &evt);
>  }
>  
>  void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
> @@ -513,37 +509,35 @@ int qemu_input_scale_axis(int value,
>      return ((int64_t)value - min_in) * range_out / range_in + min_out;
>  }
>  
> -InputEvent *qemu_input_event_new_move(InputEventKind kind,
> -                                      InputAxis axis, int value)
> -{
> -    InputEvent *evt = g_new0(InputEvent, 1);
> -    InputMoveEvent *move = g_new0(InputMoveEvent, 1);
> -
> -    evt->type = kind;
> -    evt->u.rel.data = move; /* evt->u.rel is the same as evt->u.abs */
> -    move->axis = axis;
> -    move->value = value;
> -    return evt;
> -}
> -
>  void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
>  {
> -    InputEvent *evt;
> -    evt = qemu_input_event_new_move(INPUT_EVENT_KIND_REL, axis, value);
> -    qemu_input_event_send(src, evt);
> -    qapi_free_InputEvent(evt);
> +    InputMoveEvent move = {
> +        .axis = axis,
> +        .value = value,
> +    };
> +    InputEvent evt = {
> +        .type = INPUT_EVENT_KIND_REL,
> +        .u.rel.data = &move,
> +    };
> +
> +    qemu_input_event_send(src, &evt);
>  }
>  
>  void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
>                            int min_in, int max_in)
>  {
> -    InputEvent *evt;
> -    int scaled = qemu_input_scale_axis(value, min_in, max_in,
> +    InputMoveEvent move = {
> +        .axis = axis,
> +        .value = qemu_input_scale_axis(value, min_in, max_in,
>                                         INPUT_EVENT_ABS_MIN,
> -                                       INPUT_EVENT_ABS_MAX);
> -    evt = qemu_input_event_new_move(INPUT_EVENT_KIND_ABS, axis, scaled);
> -    qemu_input_event_send(src, evt);
> -    qapi_free_InputEvent(evt);
> +                                       INPUT_EVENT_ABS_MAX),
> +    };
> +    InputEvent evt = {
> +        .type = INPUT_EVENT_KIND_ABS,
> +        .u.abs.data = &move,
> +    };
> +
> +    qemu_input_event_send(src, &evt);
>  }
>  
>  void qemu_input_check_mode_change(void)
> 
