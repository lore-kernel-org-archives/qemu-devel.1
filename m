Received: from eggs.gnu.org ([2001:4830:134:3::10]:57705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f44UQ-0000wi-VT
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f44UP-0000zS-VQ
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:59:43 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:33851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f44UP-0000zF-P1
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:59:41 -0400
Received: by mail-ot0-x22e.google.com with SMTP id m7-v6so27096864otd.1
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 05:59:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522862420-7484-1-git-send-email-thuth@redhat.com>
References: <1522862420-7484-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 13:59:20 +0100
Message-ID: <CAFEAcA8wMp=9GToj0bZy3et8O2sxk7_zQjxsbkYuzHqJ4eaKaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/arm/allwinner-a10: Do not use
 nd_table in instance_init function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 4 April 2018 at 18:20, Thomas Huth <thuth@redhat.com> wrote:
> The instance_init function of a device can be called at any time, even
> if the device is not going to be used (i.e. not going to be realized).
> So a instance_init function must not do things that could cause QEMU
> to exit, like calling qemu_check_nic_model(&nd_table[0], ...) for example.
> But this is what the instance_init function of the allwinner-a10 device
> is currently doing - and this causes QEMU to quit unexpectedly when
> you run the 'device-list-properties' QMP command for example:
>
> $ echo "{'execute':'qmp_capabilities'}"\
>        "{'execute':'device-list-properties',"\
>        " 'arguments':{'typename':'allwinner-a10'}}" \
>        | arm-softmmu/qemu-system-arm -M mps2-an505,accel=qtest -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> {"return": {}}
> Unsupported NIC model: lan9118
>
> ... and QEMU quits after printing the last line (which should not happen
> just because of running 'device-list-properties' here).
>
> And with the cubieboard, this even causes QEMU to abort():
>
> $ echo "{'execute':'qmp_capabilities'}"\
>        "{'execute':'device-list-properties',"\
>        " 'arguments':{'typename':'allwinner-a10'}}" \
>        | arm-softmmu/qemu-system-arm -M cubieboard,accel=qtest -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> {"return": {}}
> Unexpected error in error_set_from_qdev_prop_error() at hw/core/qdev-properties.c:1095:
> Property 'allwinner-emac.netdev' can't take value 'hub0port0', it's in use
> Aborted (core dumped)
>
> To fix the problem we've got to move the offending code to the realize
> function instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I know, an even cleaner fix would likely be to remove serial_hds and
>  nd_table from the device completely and wire it up from the board code
>  instead - but that's a major rework compared to this simple fix here,
>  which we likely should avoid at this point in time of the hard freeze
>  period.
>



Applied to target-arm.next, thanks.

-- PMM
