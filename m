Received: from eggs.gnu.org ([209.51.188.92]:50768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw8Ol-0005Fn-Fu
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw8Ok-00048b-J6
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:37:35 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw8Oj-00047I-Ep
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:37:34 -0500
Received: by mail-ot1-x342.google.com with SMTP id n71so35178484ota.10
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20190219163440.15702-1-paul.durrant@citrix.com>
In-Reply-To: <20190219163440.15702-1-paul.durrant@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 16:37:20 +0000
Message-ID: <CAFEAcA8tv=3isnJLfJx2a4TiEZR9rHzwqj+p=fB_94rJw=k54A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] xen-block: stop leaking memory in
 xen_block_drive_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi Paul -- you typoed the qemu-devel list email address; cc'd the right one.

thanks
-- PMM

On Tue, 19 Feb 2019 at 16:35, Paul Durrant <paul.durrant@citrix.com> wrote:
>
> The locally allocated QDict-s need to be freed. ('file_layer' will be
> freed implicitly since it is added as an object to 'driver_layer').
>
> Spotted by Coverity: CID 1398649
>
> While in the neighbourhood free 'driver' and 'filename' as soon as they are
> added to the QDicts. Freeing after the 'done' label doesn't make that much
> sense as, if the error path jumps to that label, the values would be NULL
> anyway.
>
> This patch also makes that more obvious by taking the error path if
> 'params' is NULL and then asserting that both driver and filename are
> non-NULL in the normal path.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> ---
>  hw/block/xen-block.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 37a456c207..70fc2455e8 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -743,12 +743,12 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
>          }
>
>          g_strfreev(v);
> -    }
> -
> -    if (!filename) {
> -        error_setg(errp, "no filename");
> +    } else {
> +        error_setg(errp, "no params");
>          goto done;
>      }
> +
> +    assert(filename);
>      assert(driver);
>
>      drive = g_new0(XenBlockDrive, 1);
> @@ -758,6 +758,7 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
>
>      qdict_put_str(file_layer, "driver", "file");
>      qdict_put_str(file_layer, "filename", filename);
> +    g_free(filename);
>
>      if (mode && *mode != 'w') {
>          qdict_put_bool(file_layer, "read-only", true);
> @@ -793,16 +794,17 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
>      driver_layer = qdict_new();
>
>      qdict_put_str(driver_layer, "driver", driver);
> +    g_free(driver);
> +
>      qdict_put_obj(driver_layer, "file", QOBJECT(file_layer));
>
>      g_assert(!drive->node_name);
>      drive->node_name = xen_block_blockdev_add(drive->id, driver_layer,
>                                                &local_err);
>
> -done:
> -    g_free(driver);
> -    g_free(filename);
> +    qobject_unref(driver_layer);
>
> +done:
>      if (local_err) {
>          error_propagate(errp, local_err);
>          xen_block_drive_destroy(drive, NULL);
> --
> 2.20.1.2.gb21ebb6
