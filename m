Received: from eggs.gnu.org ([2001:4830:134:3::10]:38124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9ZPK-00042l-AI
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9ZPG-0004P1-Fi
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:01:10 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:38800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9ZPG-0004Ok-BK
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:01:06 -0400
Received: by mail-qk0-x244.google.com with SMTP id b39so9303612qkb.5
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 10:01:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ea52251d-6f18-4f18-cf86-9378e7c6d985@amsat.org>
Date: Fri, 20 Apr 2018 14:01:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/13] vl.c: Remove compile time limit on
 number of serial ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 04/20/2018 11:52 AM, Peter Maydell wrote:
> Instead of having a fixed sized global serial_hds[] array,
> use a local dynamically reallocated one, so we don't have
> a compile time limit on how many serial ports a system has.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/sysemu/sysemu.h |  2 --
>  vl.c                    | 15 +++++++--------
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index bd5b55c514..989cbc2b7b 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -161,8 +161,6 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
>  
>  #define MAX_SERIAL_PORTS 4
>  
> -extern Chardev *serial_hds[MAX_SERIAL_PORTS];
> -

Finally :)))

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  /* Return the Chardev for serial port i, or NULL if none */
>  Chardev *serial_hd(int i);
>  
> diff --git a/vl.c b/vl.c
> index 6daf026da6..a8a98c5a37 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -154,7 +154,8 @@ QEMUClockType rtc_clock;
>  int vga_interface_type = VGA_NONE;
>  static DisplayOptions dpy;
>  int no_frame;
> -Chardev *serial_hds[MAX_SERIAL_PORTS];
> +static int num_serial_hds = 0;
> +static Chardev **serial_hds = NULL;
>  Chardev *parallel_hds[MAX_PARALLEL_PORTS];
>  Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
>  Chardev *sclp_hds[MAX_SCLP_CONSOLES];
> @@ -2496,30 +2497,28 @@ static int foreach_device_config(int type, int (*func)(const char *cmdline))
>  
>  static int serial_parse(const char *devname)
>  {
> -    static int index = 0;
> +    int index = num_serial_hds;
>      char label[32];
>  
>      if (strcmp(devname, "none") == 0)
>          return 0;
> -    if (index == MAX_SERIAL_PORTS) {
> -        error_report("too many serial ports");
> -        exit(1);
> -    }
>      snprintf(label, sizeof(label), "serial%d", index);
> +    serial_hds = g_renew(Chardev *, serial_hds, index + 1);
> +
>      serial_hds[index] = qemu_chr_new(label, devname);
>      if (!serial_hds[index]) {
>          error_report("could not connect serial device"
>                       " to character backend '%s'", devname);
>          return -1;
>      }
> -    index++;
> +    num_serial_hds++;
>      return 0;
>  }
>  
>  Chardev *serial_hd(int i)
>  {
>      assert(i >= 0);
> -    if (i < ARRAY_SIZE(serial_hds)) {
> +    if (i < num_serial_hds) {
>          return serial_hds[i];
>      }
>      return NULL;
> 
