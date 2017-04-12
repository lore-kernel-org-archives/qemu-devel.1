Received: from eggs.gnu.org ([2001:4830:134:3::10]:33368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cy96t-0004iU-E3
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cy96q-00008z-Ak
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cy96q-000085-1q
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:38:20 -0400
References: <1491965999-17528-1-git-send-email-huang.yong@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <445fb3d9-9766-018b-4eda-0e4c7164cfc4@redhat.com>
Date: Wed, 12 Apr 2017 11:38:14 +0800
MIME-Version: 1.0
In-Reply-To: <1491965999-17528-1-git-send-email-huang.yong@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Main loop: Register a specific IO port to
 monitor guest linux os crash event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Huang Yong <huang.yong@zte.com.cn>
Cc: qemu-devel@nongnu.org



On 12/04/2017 10:59, Huang Yong wrote:
> When guest os crash, there is no way to notify qemu on the host quickly (within 1s), and it is
> not convenient for libvirt management. We suggest to register a IO port (with specific addr) when
> qemu process be launched, on the other hand, a linux module which is comprised of kprobe hooks will
> be inserted in VM. When guest linux os crash, kprobe hooks write IO port mentioned above to notify
> qemu. With this approach, VM management component (e.g.libvirt) can monitor VM running state in time.

QEMU already supports this using the "pvpanic" device.  There is also a
driver in drivers/platform/x86/pvpanic.c.

Paolo

> Signed-off-by: Huang Yong<huang.yong@zte.com.cn>
> ---
>  vl.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/vl.c b/vl.c
> index 0b4ed52..2760c52 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -129,9 +129,12 @@ int main(int argc, char **argv)
>  #include "sysemu/replay.h"
>  #include "qapi/qmp/qerror.h"
>  #include "sysemu/iothread.h"
> +#include "exec/memory.h"
> +#include "qapi/error.h"
>  
>  #define MAX_VIRTIO_CONSOLES 1
>  #define MAX_SCLP_CONSOLES 1
> +#define CRASH_IO_PORT (0xcff0)
>  
>  static const char *data_dir[16];
>  static int data_dir_idx;
> @@ -2939,6 +2942,37 @@ static int qemu_read_default_config_file(void)
>      return 0;
>  }
>  
> +static MemoryRegion crash_io;
> +
> +static uint64_t crash_io_read(void *opaque, hwaddr addr,
> +                              unsigned int size)
> +{
> +    return 0;
> +}
> +
> +static void crash_io_write(void *opaque, hwaddr addr,
> +                           uint64_t value, unsigned int size)
> +{
> +    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE,
> +                                   false, NULL, &error_abort);
> +}
> +
> +static const MemoryRegionOps crash_io_ops = {
> +    .read = crash_io_read,
> +    .write = crash_io_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void init_crash_port(int port)
> +{
> +    int addr = port;
> +    MemoryRegion *system_io = get_system_io();
> +
> +    memory_region_init_io(&crash_io, NULL, &crash_io_ops,
> +                          NULL, "crash_event_port", 2);
> +    memory_region_add_subregion(system_io, addr, &crash_io);
> +}
> +
>  int main(int argc, char **argv, char **envp)
>  {
>      int i;
> @@ -4706,6 +4740,7 @@ int main(int argc, char **argv, char **envp)
>  
>      os_setup_post();
>  
> +    init_crash_port(CRASH_IO_PORT);
>      main_loop();
>      replay_disable_events();
>      iothread_stop_all();
> 
