Received: from eggs.gnu.org ([2001:4830:134:3::10]:50426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAddx-0002UN-8y
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAddr-0007fA-Ls
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:40:09 -0400
Date: Tue, 16 May 2017 16:39:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170516143945.GF4438@noname.redhat.com>
References: <20170515203114.9477-1-hpoussin@reactos.org>
	<20170515203114.9477-7-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170515203114.9477-7-hpoussin@reactos.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/13] vvfat: fix field names in
 FAT12/FAT16 boot sector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 15.05.2017 um 22:31 hat Herv=E9 Poussineau geschrieben:
> Specification: "FAT: General overview of on-disk format" v1.03, page 11
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> ---
>  block/vvfat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index f60d2a3889..348cffe1c4 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -218,10 +218,12 @@ typedef struct bootsector_t {
>      union {
>          struct {
>              uint8_t drive_number;
> -            uint8_t current_head;
> +            uint8_t reserved1;
>              uint8_t signature;
>              uint32_t id;
>              uint8_t volume_label[11];
> +            uint8_t fat_type[8];
> +            uint8_t ignored[0x1c0];
>          } QEMU_PACKED fat16;
>          struct {
>              uint32_t sectors_per_fat;
> @@ -233,8 +235,6 @@ typedef struct bootsector_t {
>              uint16_t ignored;
>          } QEMU_PACKED fat32;
>      } u;
> -    uint8_t fat_type[8];
> -    uint8_t ignored[0x1c0];
>      uint8_t magic[2];
>  } QEMU_PACKED bootsector_t;

At least, this makes it clear that .fat16 and .fat32 aren't the same
length. But maybe it would be cleaner to have a third union member
uint8_t bytes[0x1da] (if I calculated correctly) instead of relying on
the .fat16 branch to extend the space for .fat32?

Kevin
