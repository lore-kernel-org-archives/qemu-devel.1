Received: from eggs.gnu.org ([2001:4830:134:3::10]:52260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f11La-0000dr-2O
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f11LX-0003Zk-0m
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:01:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:50829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1f11LW-0003Xm-K0
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:01:54 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Wed, 28 Mar 2018 03:01:44 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73948919A@shsmsx102.ccr.corp.intel.com>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-2-xiaoguangrong@tencent.com>
In-Reply-To: <20180313075739.11194-2-xiaoguangrong@tencent.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/8] migration: stop compressing page in
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'guangrong.xiao@gmail.com'" <guangrong.xiao@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Xiao Guangrong <xiaoguangrong@tencent.com>

On Tuesday, March 13, 2018 3:58 PM, Xiao Guangrong wrote:
>=20
> As compression is a heavy work, do not do it in migration thread, instead=
, we
> post it out as a normal page
>=20
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>


Hi Guangrong,

Dave asked me to help review your patch, so I will just drop my 2 cents whe=
rever possible, and hope that could be inspiring for your work.


> ---
>  migration/ram.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c index
> 7266351fd0..615693f180 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1132,7 +1132,7 @@ static int ram_save_compressed_page(RAMState
> *rs, PageSearchStatus *pss,
>      int pages =3D -1;
>      uint64_t bytes_xmit =3D 0;
>      uint8_t *p;
> -    int ret, blen;
> +    int ret;
>      RAMBlock *block =3D pss->block;
>      ram_addr_t offset =3D pss->page << TARGET_PAGE_BITS;
>=20
> @@ -1162,23 +1162,23 @@ static int
> ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>          if (block !=3D rs->last_sent_block) {
>              flush_compressed_data(rs);
>              pages =3D save_zero_page(rs, block, offset);
> -            if (pages =3D=3D -1) {
> -                /* Make sure the first page is sent out before other pag=
es */
> -                bytes_xmit =3D save_page_header(rs, rs->f, block, offset=
 |
> -                                              RAM_SAVE_FLAG_COMPRESS_PAG=
E);
> -                blen =3D qemu_put_compression_data(rs->f, p, TARGET_PAGE=
_SIZE,
> -                                                 migrate_compress_level(=
));
> -                if (blen > 0) {
> -                    ram_counters.transferred +=3D bytes_xmit + blen;
> -                    ram_counters.normal++;
> -                    pages =3D 1;
> -                } else {
> -                    qemu_file_set_error(rs->f, blen);
> -                    error_report("compressed data failed!");
> -                }
> -            }
>              if (pages > 0) {
>                  ram_release_pages(block->idstr, offset, pages);
> +            } else {
> +                /*
> +                 * Make sure the first page is sent out before other pag=
es.
> +                 *
> +                 * we post it as normal page as compression will take mu=
ch
> +                 * CPU resource.
> +                 */
> +                ram_counters.transferred +=3D save_page_header(rs, rs->f=
, block,
> +                                                offset | RAM_SAVE_FLAG_P=
AGE);
> +                qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
> +                                      migrate_release_ram() &
> +                                      migration_in_postcopy());
> +                ram_counters.transferred +=3D TARGET_PAGE_SIZE;
> +                ram_counters.normal++;
> +                pages =3D 1;
>              }
>          } else {
>              pages =3D save_zero_page(rs, block, offset);
> --

I agree that this patch is an improvement for the current implementation. S=
o just pile up mine here:
Reviewed-by: Wei Wang <wei.w.wang@intel.com>


If you are interested in something more aggressive, I can share an alternat=
ive approach, which I think would be better. Please see below.

Actually, we can use the multi-threaded compression for the first page as w=
ell, which will not block the migration thread progress. The advantage is t=
hat we can enjoy the compression benefit for the first page and meanwhile n=
ot blocking the migration thread - the page is given to a compression threa=
d and compressed asynchronously to the migration thread execution.

The main barrier to achieving the above that is that we need to make sure t=
he first page of each block is sent first in the multi-threaded environment=
. We can twist the current implementation to achieve that, which is not har=
d:

For example, we can add a new flag to RAMBlock - bool first_page_added. In =
each thread of compression, they need
1) check if this is the first page of the block.
2) If it is the first page, set block->first_page_added after sending the p=
age;
3) If it is not the first the page, wait to send the page only when block->=
first_page_added is set.

Best,
Wei
