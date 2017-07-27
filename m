Received: from eggs.gnu.org ([2001:4830:134:3::10]:34477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dadvQ-0007B1-DS
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dadvN-0005wa-LU
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:13:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dadvN-0005v7-Bn
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:13:37 -0400
Date: Thu, 27 Jul 2017 10:13:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170727101332.0db01084@gondolin>
In-Reply-To: <44655faac8ff8a48e1ed7a50ad0ac66bfd70975b.1501084908.git.alistair.francis@xilinx.com>
References: <cover.1501084908.git.alistair.francis@xilinx.com>
	<44655faac8ff8a48e1ed7a50ad0ac66bfd70975b.1501084908.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/5] Convert multi-line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com

On Wed, 26 Jul 2017 09:07:57 -0700
Alistair Francis <alistair.francis@xilinx.com> wrote:

> Convert all the multi-line uses of fprintf(stderr, "warning:"..."\n"...
> to use warn_report() instead. This helps standardise on a single
> method of printing warnings to the user.
> 
> All of the warnings were changed using these commands:
>   find ./* -type f -exec sed -i \
>     'N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N;N {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
>   find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(.*".*warning[,:] \(.*\)\\n"\(.*\));|warn_report("\1"\2);|Ig}' \
>     {} +
> 
> Indentation fixed up manually afterwards.
> 
> Some of the lines were manually edited to reduce the line length to below
> 80 charecters. Some of the lines with newlines in the middle of the
> string were also manually edit to avoid checkpatch errrors.
> 
> The #include lines were manually updated to allow the code to compile.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> ---
> I couldn't figure out any nice way (it is possible with some more logic
> inside the sed apparently) to do this is one command, so I had to use
> all of the commands above.
> 
>  accel/kvm/kvm-all.c         |  7 +++----
>  block/vvfat.c               |  4 ++--
>  hw/acpi/core.c              |  7 +++----
>  hw/arm/vexpress.c           |  4 ++--
>  hw/i386/xen/xen-mapcache.c  |  4 ++--
>  hw/mips/mips_malta.c        |  4 ++--
>  hw/mips/mips_r4k.c          |  7 ++++---
>  hw/s390x/s390-virtio.c      | 16 ++++++++--------
>  net/hub.c                   |  9 ++++-----
>  net/net.c                   | 14 +++++++-------
>  target/i386/cpu.c           | 12 ++++++------
>  target/i386/hax-mem.c       |  6 +++---
>  target/ppc/translate_init.c | 18 +++++++++---------
>  ui/keymaps.c                |  9 +++++----
>  util/main-loop.c            |  6 +++---
>  15 files changed, 63 insertions(+), 64 deletions(-)
> 

> diff --git a/block/vvfat.c b/block/vvfat.c
> index d682f0a9dc..04801f3136 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1227,8 +1227,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      switch (s->fat_type) {
>      case 32:
> -            fprintf(stderr, "Big fat greek warning: FAT32 has not been tested. "
> -                "You are welcome to do so!\n");

Kind of sad to see this one go...

> +        warn_report("FAT32 has not been tested. "
> +                    "You are welcome to do so!");
>          break;
>      case 16:
>      case 12:

> diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
> index afa4148e6b..964df517b4 100644
> --- a/hw/s390x/s390-virtio.c
> +++ b/hw/s390x/s390-virtio.c
> @@ -146,9 +146,9 @@ void gtod_save(QEMUFile *f, void *opaque)
>  
>      r = s390_get_clock(&tod_high, &tod_low);
>      if (r) {
> -        fprintf(stderr, "WARNING: Unable to get guest clock for migration. "
> -                        "Error code %d. Guest clock will not be migrated "
> -                        "which could cause the guest to hang.\n", r);
> +        warn_report("Unable to get guest clock for migration. "
> +                    "Error code %d. Guest clock will not be migrated "
> +                    "which could cause the guest to hang.", r);
>          qemu_put_byte(f, S390_TOD_CLOCK_VALUE_MISSING);
>          return;
>      }
> @@ -165,8 +165,8 @@ int gtod_load(QEMUFile *f, void *opaque, int version_id)
>      int r;
>  
>      if (qemu_get_byte(f) == S390_TOD_CLOCK_VALUE_MISSING) {
> -        fprintf(stderr, "WARNING: Guest clock was not migrated. This could "
> -                        "cause the guest to hang.\n");
> +        warn_report("Guest clock was not migrated. This could "
> +                    "cause the guest to hang.");
>          return 0;
>      }
>  
> @@ -175,9 +175,9 @@ int gtod_load(QEMUFile *f, void *opaque, int version_id)
>  
>      r = s390_set_clock(&tod_high, &tod_low);
>      if (r) {
> -        fprintf(stderr, "WARNING: Unable to set guest clock value. "
> -                        "s390_get_clock returned error %d. This could cause "
> -                        "the guest to hang.\n", r);
> +        warn_report("Unable to set guest clock value. "
> +                    "s390_get_clock returned error %d. This could cause "
> +                    "the guest to hang.", r);
>      }
>  
>      return 0;

s390x part:

Acked-by: Cornelia Huck <cohuck@redhat.com>
