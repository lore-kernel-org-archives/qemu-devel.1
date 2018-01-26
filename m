Received: from eggs.gnu.org ([2001:4830:134:3::10]:33921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ef53F-0001vV-6h
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ef53B-0003Lw-Vp
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:32:21 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<1512670493-18114-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3d73ed91-c1be-4d32-e3de-b945dea52ae5@amsat.org>
Date: Fri, 26 Jan 2018 11:32:13 -0300
MIME-Version: 1.0
In-Reply-To: <1512670493-18114-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/6] hw/arm/virt: Check that the
 CPU realize method succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, patches@linaro.org

On 12/07/2017 03:14 PM, Peter Maydell wrote:
> We were passing a NULL error pointer to the object_property_set_bool()
> call that realizes the CPU object. This meant that we wouldn't detect
> failure, and would plough blindly on to crash later trying to use a
> NULL CPU object pointer. Detect errors and fail instead.
> 
> In particular, this will be necessary to detect the user error
> of using "-cpu host" without "-enable-kvm" once we make the host
> CPU type be registered unconditionally rather than only in
> kvm_arch_init().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 151592b..62af013 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1402,7 +1402,7 @@ static void machvirt_init(MachineState *machine)
>                                       "secure-memory", &error_abort);
>          }
>  
> -        object_property_set_bool(cpuobj, true, "realized", NULL);
> +        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
>          object_unref(cpuobj);
>      }
>      fdt_add_timer_nodes(vms);
> 
