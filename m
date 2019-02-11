Received: from eggs.gnu.org ([209.51.188.92]:60897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gt2ho-00064E-6K
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gt2hn-0002XQ-GW
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:56:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gt2hf-0002Qr-VN
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:56:24 -0500
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <59572a7353830be4b7aa57d79ccb7ad6b72f0dda.1549406119.git.jag.raman@oracle.com>
Date: Sun, 10 Feb 2019 22:56:12 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <421D1EA3-D2FB-46B6-81CD-C64A8763CB5E@oracle.com>
References: <cover.1549406119.git.jag.raman@oracle.com>
	<cover.1549406119.git.jag.raman@oracle.com>
	<59572a7353830be4b7aa57d79ccb7ad6b72f0dda.1549406119.git.jag.raman@oracle.com>
Subject: Re: [Qemu-devel] [PATCH] memory: Do not update coalesced IO range
 in the case of NOP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

ping

> On Feb 5, 2019, at 5:50 PM, Jagannathan Raman <jag.raman@oracle.com> =
wrote:
>=20
> Do not add/del coalesced IO ranges in the case where the
> same FlatRanges are present in both old and new FlatViews
>=20
> Fixes: 3ac7d43a6fbb ("memory: update coalesced_range on =
transaction_commit")
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
> memory.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/memory.c b/memory.c
> index 61d66e4..e49369d 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -932,9 +932,7 @@ static void =
address_space_update_topology_pass(AddressSpace *as,
>         } else if (frold && frnew && flatrange_equal(frold, frnew)) {
>             /* In both and unchanged (except logging may have changed) =
*/
>=20
> -            if (!adding) {
> -                flat_range_coalesced_io_del(frold, as);
> -            } else {
> +            if (adding) {
>                 MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, =
region_nop);
>                 if (frnew->dirty_log_mask & ~frold->dirty_log_mask) {
>                     MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, =
log_start,
> @@ -946,7 +944,6 @@ static void =
address_space_update_topology_pass(AddressSpace *as,
>                                                   =
frold->dirty_log_mask,
>                                                   =
frnew->dirty_log_mask);
>                 }
> -                flat_range_coalesced_io_add(frnew, as);
>             }
>=20
>             ++iold;
> --=20
> 1.8.3.1
>=20
>=20
