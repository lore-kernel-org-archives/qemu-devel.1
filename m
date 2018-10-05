Received: from eggs.gnu.org ([2001:4830:134:3::10]:38669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Nfn-0003X0-P7
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 06:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Nfk-0004e6-BS
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 06:49:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8Nfh-0004Zh-AO
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 06:49:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so13039572wra.11
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 03:49:22 -0700 (PDT)
References: <1538734535-7483-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7381a5a1-07f5-f79a-177d-cd39bce5a52e@redhat.com>
Date: Fri, 5 Oct 2018 12:49:19 +0200
MIME-Version: 1.0
In-Reply-To: <1538734535-7483-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Compile only once,
 not for each target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi Thomas,

On 10/5/18 12:15 PM, Thomas Huth wrote:
> The generic-loader is currently compiled target specific due to one
> single "#ifdef TARGET_WORDS_BIGENDIAN" in the file. We've already
> got a function called target_words_bigendian() for this instead, so
> we can put the generic-loader into common-obj to save some compilation
> time.

Please do this in 2 patches:
- clean the target_words_bigendian() mess, if possible documenting the
new function added in "qom/cpu.h"
- then move generic-loader to common

Is the comment added in 8e4a424b305 still valid?

/*
 * A helper function for the _utterly broken_ virtio device model to
find out if
 * it's running on a big endian machine. Don't do this at home kids!
 */
bool target_words_bigendian(void);

Thanks,

Phil.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  exec.c                   | 1 -
>  hw/core/Makefile.objs    | 2 +-
>  hw/core/generic-loader.c | 6 +-----
>  hw/virtio/virtio.c       | 1 -
>  include/qom/cpu.h        | 2 ++
>  qom/cpu.c                | 1 -
>  6 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index d0821e6..3ae0e54 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3910,7 +3910,6 @@ int qemu_target_page_bits_min(void)
>   * A helper function for the _utterly broken_ virtio device model to find out if
>   * it's running on a big endian machine. Don't do this at home kids!
>   */
> -bool target_words_bigendian(void);
>  bool target_words_bigendian(void)
>  {
>  #if defined(TARGET_WORDS_BIGENDIAN)
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index eb88ca9..b736ce2 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -20,6 +20,6 @@ common-obj-$(CONFIG_SOFTMMU) += register.o
>  common-obj-$(CONFIG_SOFTMMU) += or-irq.o
>  common-obj-$(CONFIG_SOFTMMU) += split-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
> +common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
>  
> -obj-$(CONFIG_SOFTMMU) += generic-loader.o
>  obj-$(CONFIG_SOFTMMU) += null-machine.o
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index be29ae1..fbae05f 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -130,11 +130,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>          s->cpu = first_cpu;
>      }
>  
> -#ifdef TARGET_WORDS_BIGENDIAN
> -    big_endian = 1;
> -#else
> -    big_endian = 0;
> -#endif
> +    big_endian = target_words_bigendian();
>  
>      if (s->file) {
>          AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 94f5c8e..4e61944 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1169,7 +1169,6 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>      return 0;
>  }
>  
> -bool target_words_bigendian(void);
>  static enum virtio_device_endian virtio_default_endian(void)
>  {
>      if (target_words_bigendian()) {
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index dc130cd..0e2ce80 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -1085,6 +1085,8 @@ void cpu_exec_initfn(CPUState *cpu);
>  void cpu_exec_realizefn(CPUState *cpu, Error **errp);
>  void cpu_exec_unrealizefn(CPUState *cpu);
>  
> +bool target_words_bigendian(void);
> +
>  #ifdef NEED_CPU_H
>  
>  #ifdef CONFIG_SOFTMMU
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 92599f3..f774654 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -194,7 +194,6 @@ static bool cpu_common_debug_check_watchpoint(CPUState *cpu, CPUWatchpoint *wp)
>      return true;
>  }
>  
> -bool target_words_bigendian(void);
>  static bool cpu_common_virtio_is_big_endian(CPUState *cpu)
>  {
>      return target_words_bigendian();
> 
