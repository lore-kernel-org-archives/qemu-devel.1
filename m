Received: from eggs.gnu.org ([2001:4830:134:3::10]:52729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWqGE-0006MU-6z
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 15:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWqG9-0007gl-IW
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 15:03:10 -0500
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-2-git-send-email-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <04ee1f95-988e-02f7-c1a9-f9630daf54da@redhat.com>
Date: Thu, 26 Jan 2017 21:02:48 +0100
MIME-Version: 1.0
In-Reply-To: <1485443388-27253-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/8] hw: Default -drive to if=ide
 explicitly where it works
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

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
> Many machine types default to if=ide, even though they don't actually
> have an IDE controller.  A future patch will change these defaults to
> something more sensible.  To prepare for it, this patch makes default
> "ide" explicit for the machines that actually pick up if=ide drives:
> 
> * alpha: clipper
> * arm/aarch64: spitz borzoi terrier tosa
> * i386/x86_64: generic-pc-machine (with concrete subtypes pc-q35-*
>   pc-i440fx-* pc-* isapc xenfv)
> * mips64el: fulong2e

Slightly off-topic, but: Is fulong2e still maintained? I did not spot an
entry in MAINTAINERS...?

> * mips/mipsel/mips64el: malta mips
> * ppc/ppc64: mac99 g3beige prep
> * sh4/sh4eb: r2d
> * sparc64: sun4u sun4v
> 
> Note that ppc64 machine powernv already sets an "ide" default
> explicitly.  Its IDE controller isn't implemented, yet.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/alpha/dp264.c        | 1 +
>  hw/arm/spitz.c          | 3 +++
>  hw/arm/tosa.c           | 1 +
>  hw/i386/pc.c            | 1 +
>  hw/mips/mips_fulong2e.c | 1 +
>  hw/mips/mips_malta.c    | 1 +
>  hw/mips/mips_r4k.c      | 1 +
>  hw/ppc/mac_newworld.c   | 1 +
>  hw/ppc/mac_oldworld.c   | 1 +
>  hw/ppc/prep.c           | 1 +
>  hw/sh4/r2d.c            | 1 +
>  hw/sparc64/sun4u.c      | 2 ++
>  12 files changed, 15 insertions(+)

Patch looks right to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
