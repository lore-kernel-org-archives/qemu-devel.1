Received: from eggs.gnu.org ([2001:4830:134:3::10]:52831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs8B-00075F-Jt
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs8A-0002S8-IF
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:23:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-18-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26e5fbf1-8ff7-943d-c997-1b3f1af3b8a2@amsat.org>
Date: Fri, 14 Jul 2017 01:22:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 17/29] virtio-serial: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Amit Shah <amit@kernel.org>, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 07/13/2017 01:32 PM, Marc-André Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/virtio-serial-bus.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index f5bc173844..17a1bb008a 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -663,7 +663,7 @@ static void virtio_serial_save_device(VirtIODevice *vdev, QEMUFile *f)
>   
>       /* The ports map */
>       max_nr_ports = s->serial.max_virtserial_ports;
> -    for (i = 0; i < (max_nr_ports + 31) / 32; i++) {
> +    for (i = 0; i < DIV_ROUND_UP(max_nr_ports, 32); i++) {
>           qemu_put_be32s(f, &s->ports_map[i]);
>       }
>   
> @@ -798,7 +798,7 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
>       qemu_get_be32s(f, &tmp);
>   
>       max_nr_ports = s->serial.max_virtserial_ports;
> -    for (i = 0; i < (max_nr_ports + 31) / 32; i++) {
> +    for (i = 0; i < DIV_ROUND_UP(max_nr_ports, 32); i++) {
>           qemu_get_be32s(f, &ports_map);
>   
>           if (ports_map != s->ports_map[i]) {
> @@ -863,7 +863,7 @@ static uint32_t find_free_port_id(VirtIOSerial *vser)
>       unsigned int i, max_nr_ports;
>   
>       max_nr_ports = vser->serial.max_virtserial_ports;
> -    for (i = 0; i < (max_nr_ports + 31) / 32; i++) {
> +    for (i = 0; i < DIV_ROUND_UP(max_nr_ports, 32); i++) {
>           uint32_t map, zeroes;
>   
>           map = vser->ports_map[i];
> @@ -1075,7 +1075,7 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
>           vser->ovqs[i] = virtio_add_queue(vdev, 128, handle_output);
>       }
>   
> -    vser->ports_map = g_malloc0(((vser->serial.max_virtserial_ports + 31) / 32)
> +    vser->ports_map = g_malloc0((DIV_ROUND_UP(vser->serial.max_virtserial_ports, 32))
>           * sizeof(vser->ports_map[0]));

This line seems quite long now

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>       /*
>        * Reserve location 0 for a console port for backward compat
> 
