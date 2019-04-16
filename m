Received: from eggs.gnu.org ([209.51.188.92]:53510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hGECS-0003En-6Y
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hGECR-0003S8-71
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hGECQ-0003Qz-VN
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:51:55 -0400
Date: Tue, 16 Apr 2019 10:51:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190416025147.GA20550@xz-x1>
References: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
	<1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] migration: do not rom_reset() during
 incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Catherine Ho <catherine.hecx@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On Mon, Apr 08, 2019 at 04:42:13AM -0400, Catherine Ho wrote:
> Commit 18269069c310 ("migration: Introduce ignore-shared capability")
> addes ignore-shared capability to bypass the shared ramblock (e,g,
> membackend + numa node). It does good to live migration.
> 
> As told by Yury,this commit expectes that QEMU doesn't write to guest RAM
> until VM starts, but it does on aarch64 qemu:
> Backtrace:
> 1  0x000055f4a296dd84 in address_space_write_rom_internal () at
> exec.c:3458
> 2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
> 3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
> 4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
> 5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
> 6  0x000055f4a2c9851d in main () at vl.c:4552
> 
> Actually, on arm64 virt marchine, ramblock "dtb" will be filled into ram
> druing rom_reset. In ignore-shared incoming case, this rom filling
> is not required since all the data has been stored in memory backend
> file.
> 
> Further more, as suggested by Peter Xu, if we do rom_reset() now with
> these ROMs then the RAM data should be re-filled again too with the
> migration stream coming in.
> 
> Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
> capability")
> Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
