Received: from eggs.gnu.org ([2001:4830:134:3::10]:60797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk9cF-0008U8-2j
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk9cB-0001i4-As
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:53:11 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:37563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dk9cB-0001ha-3D
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:53:07 -0400
Received: by mail-wr0-x236.google.com with SMTP id z91so124302413wrc.4
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 06:53:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503407712-9894-1-git-send-email-thuth@redhat.com>
References: <1503407712-9894-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 14:52:45 +0100
Message-ID: <CAFEAcA-V1igN7Sz3SusczcPadtZC-z4fyw-pvPggGT5VFFMvRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/digic: Mark device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Antony Pavlov <antonynpavlov@gmail.com>

On 22 August 2017 at 14:15, Thomas Huth <thuth@redhat.com> wrote:
> QEMU currently hangs completely when the user is trying to do a
> "device_add digic" on an unrelated ARM machine like integratorcp.
> Looks like this device is not meant to be hot-pluggable at all, so
> let's simply mark it with "user_creatable = false" to avoid the hang.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/digic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/digic.c b/hw/arm/digic.c
> index 94f3263..208dfb3 100644
> --- a/hw/arm/digic.c
> +++ b/hw/arm/digic.c
> @@ -101,6 +101,8 @@ static void digic_class_init(ObjectClass *oc, void *data)
>      DeviceClass *dc = DEVICE_CLASS(oc);
>
>      dc->realize = digic_realize;
> +    /* Reason: Hangs QEMU when trying to device_add this directly */
> +    dc->user_creatable = false;
>  }

Maybe "uses serial_hds[]" is a better reason, or does it hang for
some other reason? I think we should identify why we don't expect
it to work and state that, rather than just the empirical "didn't
work for me".

Not that it really makes sense to have command line creation
of SoC objects at all really.

thanks
-- PMM
