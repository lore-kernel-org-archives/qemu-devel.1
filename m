Received: from eggs.gnu.org ([2001:4830:134:3::10]:48327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBMDH-0005Ni-Si
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBMDD-0003Wk-22
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:20:07 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-14-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <beea743a-a865-8e5a-9555-aaa3ce1c7d58@redhat.com>
Date: Wed, 25 Apr 2018 17:19:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/13] vl.c: new function max_serial_hds()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org, qemu-ppc@nongnu.org

On 20.04.2018 16:52, Peter Maydell wrote:
> Create a new function max_serial_hds() which returns the number of
> serial ports defined by the user. This is needed only by spapr.
> 
> This allows us to remove the MAX_SERIAL_PORTS define.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/sysemu/sysemu.h | 6 ++++--
>  hw/ppc/spapr.c          | 2 +-
>  vl.c                    | 5 +++++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 989cbc2b7b..612659a718 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -159,10 +159,12 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
>  
>  /* serial ports */
>  
> -#define MAX_SERIAL_PORTS 4
> -
>  /* Return the Chardev for serial port i, or NULL if none */
>  Chardev *serial_hd(int i);
> +/* return the number of serial ports defined by the user. serial_hd(i)
> + * will always return NULL for any i which is greater than or equal to this.
> + */
> +int max_serial_hds(void);
>  
>  /* parallel ports */
>  
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b0ecfaca9e..8d2d36a606 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2589,7 +2589,7 @@ static void spapr_machine_init(MachineState *machine)
>      /* Set up VIO bus */
>      spapr->vio_bus = spapr_vio_bus_init();
>  
> -    for (i = 0; i < MAX_SERIAL_PORTS; i++) {
> +    for (i = 0; i < max_serial_hds(); i++) {
>          if (serial_hd(i)) {
>              spapr_vty_create(spapr->vio_bus, serial_hd(i));
>          }
> diff --git a/vl.c b/vl.c
> index a8a98c5a37..b587187052 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2524,6 +2524,11 @@ Chardev *serial_hd(int i)
>      return NULL;
>  }
>  
> +int max_serial_hds(void)
> +{
> +    return num_serial_hds;
> +}
> +
>  static int parallel_parse(const char *devname)
>  {
>      static int index = 0;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
