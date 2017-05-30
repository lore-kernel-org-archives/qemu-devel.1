Received: from eggs.gnu.org ([2001:4830:134:3::10]:60729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFd1t-000542-Qe
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFd1t-0004D0-1b
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dFd1s-0004Cw-SH
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:01:28 -0400
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-4-aurelien@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b2da0fdb-f964-8d2f-e364-b91a0595d4e0@redhat.com>
Date: Tue, 30 May 2017 11:01:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-4-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/29] target/s390x: implement
 local-TLB-clearing in IPTE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 29.05.2017 21:24, Aurelien Jarno wrote:
> And at the same time make IPTE SMP aware.
>=20
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/s390x/helper.h     |  2 +-
>  target/s390x/mem_helper.c | 19 ++++++++++++-------
>  target/s390x/translate.c  |  6 +++++-
>  3 files changed, 18 insertions(+), 9 deletions(-)
[...]
> @@ -1092,13 +1091,19 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t =
pto, uint64_t vaddr)
> =20
>      /* XXX we exploit the fact that Linux passes the exact virtual
>         address here - it's not obliged to! */
> -    tlb_flush_page(cs, page);
> +    /* XXX: the LC bit should be considered as 0 if the local-TLB-clea=
ring
> +       facility is not installed.  */

That should be easy, I think:

    if (!s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING)) {
        m4 =3D 0;
    }

> +    if (m4 & 1) {
> +        tlb_flush_page(cs, page);
> +    } else {
> +        tlb_flush_page_all_cpus_synced(cs, page);
> +    }
> =20
>      /* XXX 31-bit hack */
> -    if (page & 0x80000000) {
> -        tlb_flush_page(cs, page & ~0x80000000);
> +    if (m4 & 1) {
> +        tlb_flush_page(cs, page ^ 0x80000000);
>      } else {
> -        tlb_flush_page(cs, page | 0x80000000);
> +        tlb_flush_page_all_cpus_synced(cs, page ^ 0x80000000);
>      }
>  }

 Thomas
