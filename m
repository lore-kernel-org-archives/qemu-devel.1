Received: from eggs.gnu.org ([2001:4830:134:3::10]:54409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gH4CN-0007cp-7q
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gH4CI-0004UI-5k
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gH4CH-0004Ll-Sp
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:50:58 -0400
References: <20181003114454.5662-1-marcandre.lureau@redhat.com>
	<20181003114454.5662-4-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4e920ad-e51a-6783-0522-6ed5f0351ca0@redhat.com>
Date: Mon, 29 Oct 2018 10:50:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181003114454.5662-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] memory-mapping: skip non-volatile
 memory regions in GuestPhysBlockList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, lersek@redhat.com

On 03/10/2018 13:44, Marc-Andr=C3=A9 Lureau wrote:
> diff --git a/memory_mapping.c b/memory_mapping.c
> index 775466f3a8..724dd0b417 100644
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

We should also have

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 5a857cebcf..dd180b531c 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -417,7 +417,9 @@ def get_guest_phys_blocks():
         memory_region =3D flat_range["mr"].dereference()

         # we only care about RAM
-        if not memory_region["ram"]:
+        if not memory_region["ram"] \
+           or memory_region["ram_device"] \
+           or memory_region["nonvolatile"]:
             continue

         section_size =3D int128_get64(flat_range["addr"]["size"])

here.  I queued the patches and will post this soon as a separate patch.

Paolo
