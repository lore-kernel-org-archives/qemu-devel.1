Received: from eggs.gnu.org ([2001:4830:134:3::10]:45971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWUZ3-0000gX-Dh
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWUYz-0004IE-De
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:53:09 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50865)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWUYz-0004H5-36
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:53:05 -0500
References: <1485377117-18105-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f60c6090-0ca8-8ce9-8015-4e8e34123a5a@vivier.eu>
Date: Wed, 25 Jan 2017 21:52:54 +0100
MIME-Version: 1.0
In-Reply-To: <1485377117-18105-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix crash when
 running without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>

Le 25/01/2017 à 21:45, Thomas Huth a écrit :
> When running QEMU with "-M none -device loader,file=kernel.elf", it
> currently crashes with a segmentation fault, because the "none"-machine
> does not have any CPU by default and the generic loader code tries
> to dereference s->cpu. Fix it by adding an appropriate check for a
> NULL pointer.
> 
> Reported-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/generic-loader.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index 58f1f02..4601267 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -137,20 +137,21 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>  #endif
>  
>      if (s->file) {
> +        AddressSpace *as = s->cpu ? s->cpu->as :  NULL;

Should we just abort if s->cpu is NULL?

Laurent
