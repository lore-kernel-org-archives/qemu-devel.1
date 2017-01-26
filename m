Received: from eggs.gnu.org ([2001:4830:134:3::10]:44374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWmTt-00088C-Sc
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWmTp-0005sb-8L
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:01:01 -0500
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-4-git-send-email-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2b18b666-4ea7-e1a5-5359-7fd34341e9ec@redhat.com>
Date: Thu, 26 Jan 2017 17:00:18 +0100
MIME-Version: 1.0
In-Reply-To: <1485443388-27253-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/8] hw: Default -drive to if=none
 instead of ide when ide cannot work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Stefano Stabellini <sstabellini@kernel.org>, Jia Liu <proljc@gmail.com>, qemu-block@nongnu.org, Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org, kwolf@redhat.com, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Laurent Vivier <laurent@vivier.eu>, mreitz@redhat.com, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, xen-devel@lists.xensource.com

On 26.01.2017 16:09, Markus Armbruster wrote:
> Block backends defined with -drive if=ide are meant to be picked up by
> machine initialization code: a suitable frontend gets created and
> wired up automatically.
> 
> if=ide drives not picked up that way can still be used with -device as
> if they had if=none, but that's unclean and best avoided.  Unused ones
> produce an "Orphaned drive without device" warning.
> 
> -drive parameter "if" is optional, and the default depends on the
> machine type.  If a machine type doesn't specify a default, the
> default is "ide".
> 
> Many machine types implicitly default to if=ide that way, even though
> they don't actually have an IDE controller.  This makes no sense.
> 
> Change the implicit default to if=none.  Affected machines:
> 
> * all targets: none
> * aarch64/arm: akita ast2500 canon cheetah collie connex imx25
>   integratorcp kzm lm3s6965evb lm3s811evb mainstone musicpal n800 n810
>   netduino2 nuri palmetto realview romulus sabrelite smdkc210 sx1 sx1
>   verdex z2
> * cris: axis-dev88
> * i386/x86_64: xenpv
> * lm32: lm32-evr lm32-uclinux milkymist
> * m68k: an5206 dummy mcf5208evb
> * microblaze/microblazeel: petalogix-ml605 petalogix-s3adsp1800
> * mips/mips64/mips64el/mipsel: mipssim
> * moxie: moxiesim
> * or32: or32-sim
> * ppc/ppc64/ppcemb: bamboo ref405ep taihu virtex-ml507
> * ppc/ppc64: mpc8544ds ppce500
> * sh4/sh4eb: shix
> * sparc: leon3_generic
> * sparc64: niagara
> * tricore: tricore_testboard
> * unicore32: puv3
> * xtensa/xtensaeb: kc705 lx200 lx60 ml605 sim
> 
> None of these machines have an IDE controller, let alone code to
> honor if=ide.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: xen-devel@lists.xensource.com
> Cc: Michael Walle <michael@walle.cc>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Anthony Green <green@moxielogic.com>
> Cc: Jia Liu <proljc@gmail.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-By: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  include/sysemu/blockdev.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
> index 16432f3..351a039 100644
> --- a/include/sysemu/blockdev.h
> +++ b/include/sysemu/blockdev.h
> @@ -19,12 +19,11 @@ void blockdev_auto_del(BlockBackend *blk);
>  typedef enum {
>      IF_DEFAULT = -1,            /* for use with drive_add() only */
>      /*
> -     * IF_IDE must be zero, because we want MachineClass member
> -     * block_default_type to default-initialize to IF_IDE
> +     * IF_NONE must be zero, because we want MachineClass member
> +     * block_default_type to default-initialize to IF_NONE
>       */
> -    IF_IDE = 0,
> -    IF_NONE,
> -    IF_SCSI, IF_FLOPPY, IF_PFLASH, IF_MTD, IF_SD, IF_VIRTIO, IF_XEN,
> +    IF_NONE = 0,
> +    IF_IDE, IF_SCSI, IF_FLOPPY, IF_PFLASH, IF_MTD, IF_SD, IF_VIRTIO, IF_XEN,
>      IF_COUNT
>  } BlockInterfaceType;
>  
> 

Makes sense.

Reviewed-by: Thomas Huth <thuth@redhat.com>
