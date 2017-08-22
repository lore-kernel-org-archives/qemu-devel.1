Received: from eggs.gnu.org ([2001:4830:134:3::10]:44146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkD1J-000608-C6
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkD1I-0004vs-Hv
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:31:17 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkD1I-0004vh-B4
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 13:31:16 -0400
Received: by mail-wr0-x229.google.com with SMTP id a47so15409718wra.0
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 10:31:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503412231-13961-1-git-send-email-thuth@redhat.com>
References: <1503412231-13961-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 18:30:54 +0100
Message-ID: <CAFEAcA-jE3yn+p+krW9oM9h5bY5yJ6yZUfqPZW=jS_JZgueWug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/digic: Mark device with
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

On 22 August 2017 at 15:30, Thomas Huth <thuth@redhat.com> wrote:
> QEMU currently shows some unexpected behavior when the user trys to
> do a "device_add digic" on an unrelated ARM machine like integratorcp
> in "-nographic" mode (the device_add command does not immediately
> return to the monitor prompt), and trying to "device_del" the device
> later results in a "qemu/qdev-monitor.c:872:qdev_unplug: assertion
> failed: (hotplug_ctrl)" error condition.
> Looking at the realize function of the device, it uses serial_hds
> directly and this means that the device can not be added a second
> time, so let's simply mark it with "user_creatable = false" now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Updated the comment and the patch description
>
>  hw/arm/digic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/digic.c b/hw/arm/digic.c
> index 94f3263..6184020 100644
> --- a/hw/arm/digic.c
> +++ b/hw/arm/digic.c
> @@ -101,6 +101,8 @@ static void digic_class_init(ObjectClass *oc, void *data)
>      DeviceClass *dc = DEVICE_CLASS(oc);
>
>      dc->realize = digic_realize;
> +    /* Reason: Uses serial_hds in the realize function --> not usable twice */
> +    dc->user_creatable = false;
>  }
>
>  static const TypeInfo digic_type_info = {

Applied to target-arm.next for 2.11, thanks.

-- PMM
