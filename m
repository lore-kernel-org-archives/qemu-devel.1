Received: from eggs.gnu.org ([2001:4830:134:3::10]:57131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gJh61-00040O-0L
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gJgx6-0007sC-2D
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:38:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gJgx5-0007rP-Sc
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:38:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4084630832D8
	for <qemu-devel@nongnu.org>; Mon,  5 Nov 2018 15:38:07 +0000 (UTC)
References: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
	<1540929011-19894-9-git-send-email-pbonzini@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4a977f62-40aa-0620-5698-42bf3afaa869@redhat.com>
Date: Mon, 5 Nov 2018 16:37:51 +0100
MIME-Version: 1.0
In-Reply-To: <1540929011-19894-9-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 08/10] memory-mapping: skip non-volatile
 memory regions in GuestPhysBlockList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 10/30/18 20:50, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> GuestPhysBlockList is currently used to produce dumps. Given the size
> and the typical usage of NVDIMM for storage, they are not a good idea
> to have in the dumps. We may want to have an extra dump option to
> include them. For now, skip non-volatile regions.
>=20
> The TCG memory clear function is going to use the GuestPhysBlockList
> as well, and will thus skip NVDIMM for similar reasons.
>=20
> Cc: lersek@redhat.com
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-Id: <20181003114454.5662-4-marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  memory_mapping.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/memory_mapping.c b/memory_mapping.c
> index 775466f..724dd0b 100644
> --- a/memory_mapping.c
> +++ b/memory_mapping.c
> @@ -206,7 +206,8 @@ static void guest_phys_blocks_region_add(MemoryList=
ener *listener,
> =20
>      /* we only care about RAM */
>      if (!memory_region_is_ram(section->mr) ||
> -        memory_region_is_ram_device(section->mr)) {
> +        memory_region_is_ram_device(section->mr) ||
> +        memory_region_is_nonvolatile(section->mr)) {
>          return;
>      }
> =20
>=20

This patch misses my R-b, and (in chronological order) DavidH's, from:

http://mid.mail-archive.com/9fa8a684-8d5d-1644-3aee-86a196d31f8d@redhat.c=
om
http://mid.mail-archive.com/79e58e5c-4d78-e93d-ebe8-4b1bb65752fe@redhat.c=
om

Thanks
Laszlo
