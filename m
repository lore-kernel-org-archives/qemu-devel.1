Received: from eggs.gnu.org ([2001:4830:134:3::10]:53639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVDAv-0003Gk-8X
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVDAn-0004fQ-1b
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:15:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVDAm-0004em-Gf
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:15:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so3833071wmd.0
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:15:52 -0800 (PST)
References: <20181206232333.22408-1-pbonzini@redhat.com>
	<20181206232333.22408-4-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3cb3ef4c-4d58-7f5f-6d22-2eca1d2e6dee@redhat.com>
Date: Fri, 7 Dec 2018 11:15:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181206232333.22408-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] qemu/queue.h: typedef QTAILQ heads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 12/7/18 12:23 AM, Paolo Bonzini wrote:
> This will be needed when we change the QTAILQ head and elem structs
> to unions.  However, it is also consistent with the usage elsewhere
> in QEMU for other list head structs (see for example FsMountList).
> 
> Note that most QTAILQs only need their name in order to do backwards
> walks.  Those do not break with the struct->union change, and anyway
> the change will also remove the need to name heads when doing backwards
> walks, so those are not touched here.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  exec.c            |  3 ++-
>  include/qom/cpu.h |  5 +++--
>  ui/input.c        | 14 ++++++++------
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index b6b2007f27..a629c98eb5 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -94,7 +94,8 @@ int target_page_bits;
>  bool target_page_bits_decided;
>  #endif
>  
> -struct CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
> +CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
> +
>  /* current CPU in the current thread. It is only valid inside
>     cpu_exec() */
>  __thread CPUState *current_cpu;
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 62aef77b87..4662a205c1 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -435,8 +435,9 @@ struct CPUState {
>      GArray *iommu_notifiers;
>  };
>  
> -QTAILQ_HEAD(CPUTailQ, CPUState);
> -extern struct CPUTailQ cpus;
> +typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
> +extern CPUTailQ cpus;
> +
>  #define first_cpu        QTAILQ_FIRST_RCU(&cpus)
>  #define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
>  #define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus, node)
> diff --git a/ui/input.c b/ui/input.c
> index 7c9a4109c4..35c7964f64 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -19,6 +19,9 @@ struct QemuInputHandlerState {
>  };
>  
>  typedef struct QemuInputEventQueue QemuInputEventQueue;
> +typedef QTAILQ_HEAD(QemuInputEventQueueHead, QemuInputEventQueue)
> +    QemuInputEventQueueHead;
> +
>  struct QemuInputEventQueue {
>      enum {
>          QEMU_INPUT_QUEUE_DELAY = 1,
> @@ -37,8 +40,7 @@ static QTAILQ_HEAD(, QemuInputHandlerState) handlers =
>  static NotifierList mouse_mode_notifiers =
>      NOTIFIER_LIST_INITIALIZER(mouse_mode_notifiers);
>  
> -static QTAILQ_HEAD(QemuInputEventQueueHead, QemuInputEventQueue) kbd_queue =
> -    QTAILQ_HEAD_INITIALIZER(kbd_queue);
> +static QemuInputEventQueueHead kbd_queue = QTAILQ_HEAD_INITIALIZER(kbd_queue);
>  static QEMUTimer *kbd_timer;
>  static uint32_t kbd_default_delay_ms = 10;
>  static uint32_t queue_count;
> @@ -257,7 +259,7 @@ static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
>  
>  static void qemu_input_queue_process(void *opaque)
>  {
> -    struct QemuInputEventQueueHead *queue = opaque;
> +    QemuInputEventQueueHead *queue = opaque;
>      QemuInputEventQueue *item;
>  
>      g_assert(!QTAILQ_EMPTY(queue));
> @@ -288,7 +290,7 @@ static void qemu_input_queue_process(void *opaque)
>      }
>  }
>  
> -static void qemu_input_queue_delay(struct QemuInputEventQueueHead *queue,
> +static void qemu_input_queue_delay(QemuInputEventQueueHead *queue,
>                                     QEMUTimer *timer, uint32_t delay_ms)
>  {
>      QemuInputEventQueue *item = g_new0(QemuInputEventQueue, 1);
> @@ -306,7 +308,7 @@ static void qemu_input_queue_delay(struct QemuInputEventQueueHead *queue,
>      }
>  }
>  
> -static void qemu_input_queue_event(struct QemuInputEventQueueHead *queue,
> +static void qemu_input_queue_event(QemuInputEventQueueHead *queue,
>                                     QemuConsole *src, InputEvent *evt)
>  {
>      QemuInputEventQueue *item = g_new0(QemuInputEventQueue, 1);
> @@ -318,7 +320,7 @@ static void qemu_input_queue_event(struct QemuInputEventQueueHead *queue,
>      queue_count++;
>  }
>  
> -static void qemu_input_queue_sync(struct QemuInputEventQueueHead *queue)
> +static void qemu_input_queue_sync(QemuInputEventQueueHead *queue)
>  {
>      QemuInputEventQueue *item = g_new0(QemuInputEventQueue, 1);
>  
> 
