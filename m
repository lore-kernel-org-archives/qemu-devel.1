Received: from eggs.gnu.org ([2001:4830:134:3::10]:56628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNq8f-0007C4-H6
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 21:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNq8c-0007we-B0
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 21:15:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:40082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gNq8b-0007v8-70
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 21:15:09 -0500
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sat, 17 Nov 2018 02:15:01 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DE5BD8E@shsmsx102.ccr.corp.intel.com>
References: <20181116164806.26929-1-pbonzini@redhat.com>
	<20181116164806.26929-2-pbonzini@redhat.com>
In-Reply-To: <20181116164806.26929-2-pbonzini@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] migration: savevm: consult migration
 blockers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Saturday, November 17, 2018 12:48 AM, Paolo Bonzini wrote:
> To: qemu-devel@nongnu.org
> Subject: [Qemu-devel] [PATCH] migration: savevm: consult migration
> blockers
>=20
> There is really no difference between live migration and savevm, except t=
hat
> savevm does not require bdrv_invalidate_cache to be implemented by all
> disks.  However, it is unlikely that savevm is used with anything except =
qcow2
> disks, so the penalty is small and worth the improvement in catching bad
> usage of savevm.
>=20
> Only one place was taking care of savevm when adding a migration blocker,
> and it can be removed.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  migration/savevm.c | 4 ++++
>  target/i386/kvm.c  | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c index
> ef707b8c43..1c49776a91 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2455,6 +2455,10 @@ int save_snapshot(const char *name, Error
> **errp)
>      struct tm tm;
>      AioContext *aio_context;
>=20
> +    if (migration_is_blocked(errp)) {
> +        return false;

Just curious why returning false here when the returning type is "int"

Best,
Wei
