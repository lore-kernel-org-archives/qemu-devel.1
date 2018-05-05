Received: from eggs.gnu.org ([2001:4830:134:3::10]:53742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEugK-0000qN-8t
	for qemu-devel@nongnu.org; Sat, 05 May 2018 06:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEugJ-0005FV-7j
	for qemu-devel@nongnu.org; Sat, 05 May 2018 06:44:48 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEugJ-0005Ev-24
	for qemu-devel@nongnu.org; Sat, 05 May 2018 06:44:47 -0400
Received: by mail-ot0-x241.google.com with SMTP id t1-v6so27185886ott.13
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 03:44:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525396794-17042-1-git-send-email-mjc@sifive.com>
References: <1525396794-17042-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 May 2018 11:44:25 +0100
Message-ID: <CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] device_tree: Add qemu_fdt_totalsize
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair.francis@wdc.com>, David Gibson <david@gibson.dropbear.id.au>

cc'ing David -- is this the best way to do this?

(It would be nicer if libfdt would just dynamically
reallocate the buffer as needed, and then tell you
the final size, rather than having to specify a
maximum buffer size up front, but given the API we
have a "tell me how big this thing actually is"
function seems reasonable. I'm just surprised we
need to know so much about the DT internals to do it.)

thanks
-- PMM

On 4 May 2018 at 02:19, Michael Clark <mjc@sifive.com> wrote:
> Currently the device-tree create_device_tree function
> returns the size of the allocated device tree buffer
> however there is no way to get the actual amount of
> buffer space used by the device-tree.
>
> 14ec3cbd7c1e31dca4d23f028100c8f43e156573 increases
> the FDT_MAX_SIZE to 1 MiB. This creates an issue
> for boards that have less than 1 MiB in their ROM
> for device tree. While cpu_physical_memory_write
> will not write past the end of a buffer there is
> and a board is aware of its ROM buffer size, so
> can use min(fdt_size,rom_size); this provides no
> indication as to whether the device-tree may be
> truncated. qemu_fdt_totalsize allows a board to
> check that a dynamically created device tree will
> fit within its alloted ROM space.
>
> Add qemu_fdt_totalsize which uses the logic and
> public APIs from libfdt to calculate the device
> size: struct_offset + struct_size + strings_size
> + terminator.
>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  device_tree.c                | 6 ++++++
>  include/sysemu/device_tree.h | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/device_tree.c b/device_tree.c
> index 52c3358a5583..3a2166d61f37 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -215,6 +215,12 @@ void *load_device_tree_from_sysfs(void)
>
>  #endif /* CONFIG_LINUX */
>
> +size_t qemu_fdt_totalsize(void *fdt)
> +{
> +    return fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt) +
> +           fdt_size_dt_strings(fdt) + sizeof(uint32_t) /* terminator */;
> +}
> +
>  static int findnode_nofail(void *fdt, const char *node_path)
>  {
>      int offset;
> diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
> index e22e5bec9c3f..4af232dfdc65 100644
> --- a/include/sysemu/device_tree.h
> +++ b/include/sysemu/device_tree.h
> @@ -26,6 +26,12 @@ void *load_device_tree_from_sysfs(void);
>  #endif
>
>  /**
> + * qemu_fdt_total_size: returns the size required to store the current
> + * device tree versus the buffer size returned by create_device_tree
> + */
> +size_t qemu_fdt_totalsize(void *fdt);
> +
> +/**
>   * qemu_fdt_node_path: return the paths of nodes matching a given
>   * name and compat string
>   * @fdt: pointer to the dt blob
> --
> 2.7.0
