Received: from eggs.gnu.org ([2001:4830:134:3::10]:44708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Pw0-000370-Dh
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Pvu-0003zc-R5
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:14:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8Pvp-0003uO-VA
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:14:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id z4-v6so13523940wrb.1
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:14:10 -0700 (PDT)
References: <1538744508-17108-1-git-send-email-thuth@redhat.com>
	<1538744508-17108-2-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2a85e1f7-cbc7-5ecb-6eb6-1560aac0298e@redhat.com>
Date: Fri, 5 Oct 2018 15:14:06 +0200
MIME-Version: 1.0
In-Reply-To: <1538744508-17108-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] cpu: Provide a proper prototype for
 target_words_bigendian() in a header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On 05/10/2018 15:01, Thomas Huth wrote:
> We've got three places already that provide a prototype for this
> function in a .c file - that's ugly. Let's provide a proper prototype
> in a header instead, with a proper description why this function should
> not be used in most cases.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  NB: I've tried to replace the "utterly broken" comment with something
>  better, as suggested by Laszlo... not sure whether I've really got the
>  message right here, so feel free to provide some better wording if you
>  like!
> 
>  exec.c             |  5 -----
>  hw/virtio/virtio.c |  1 -
>  include/qom/cpu.h  | 11 +++++++++++
>  qom/cpu.c          |  1 -
>  4 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index d0821e6..5d99ef5 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3906,11 +3906,6 @@ int qemu_target_page_bits_min(void)
>  }
>  #endif
>  
> -/*
> - * A helper function for the _utterly broken_ virtio device model to find out if
> - * it's running on a big endian machine. Don't do this at home kids!
> - */
> -bool target_words_bigendian(void);
>  bool target_words_bigendian(void)
>  {
>  #if defined(TARGET_WORDS_BIGENDIAN)
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
> index dc130cd..6d35c37 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -1085,6 +1085,17 @@ void cpu_exec_initfn(CPUState *cpu);
>  void cpu_exec_realizefn(CPUState *cpu, Error **errp);
>  void cpu_exec_unrealizefn(CPUState *cpu);
>  
> +/**
> + * target_words_bigendian:
> + * Returns true if the (default) endianness of the target is big endian,
> + * false otherwise. Note that in target-specifc code, you can use
> + * TARGET_WORDS_BIGENDIAN directly instead. On the other hand, common
> + * code should normally never need to know about the endianness of the
> + * target, so please do *not* use this function unless you know very well
> + * what you are doing!
> + */

Thanks for this cleanup!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
