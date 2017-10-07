Received: from eggs.gnu.org ([2001:4830:134:3::10]:60873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0g2f-0007SK-9z
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 23:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0g2e-00068P-EL
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 23:44:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-72-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c3044e1-abfd-5156-6098-21844ba6d928@amsat.org>
Date: Sat, 7 Oct 2017 00:44:32 -0300
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-72-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 71/88] block: avoid use of g_new0()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-block@nongnu.org

On 10/06/2017 08:50 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  block/qcow2.c | 2 +-
>  block/vhdx.c  | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index f63d1831f8..3e7d6c81be 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2738,7 +2738,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
>  
>      /* Write the header */
>      QEMU_BUILD_BUG_ON((1 << MIN_CLUSTER_BITS) < sizeof(*header));
> -    header = g_malloc0(cluster_size);
> +    header = g_malloc(cluster_size);

self-NACK since this is wrong.

>      *header = (QCowHeader) {
>          .magic                      = cpu_to_be32(QCOW_MAGIC),
>          .version                    = cpu_to_be32(version),
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 8260fb46cd..91e532df8a 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -244,10 +244,11 @@ static void vhdx_region_register(BDRVVHDXState *s,
>  {
>      VHDXRegionEntry *r;
>  
> -    r = g_new0(VHDXRegionEntry, 1);
> -
> -    r->start = start;
> -    r->end = start + length;
> +    r = g_new(VHDXRegionEntry, 1);
> +    *r = (VHDXRegionEntry) {
> +        .start = start,
> +        .end = start + length,

this is not wrong since all members are initialized, but it is not good
code practice (if the VHDXRegionEntry structure is expanded with another
member).

> +    };
>  
>      QLIST_INSERT_HEAD(&s->regions, r, entries);
>  }
> 
