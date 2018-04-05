Received: from eggs.gnu.org ([2001:4830:134:3::10]:59048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f44aM-0003mc-Jp
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f44aL-0004oe-LF
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:05:50 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f44aL-0004nI-F2
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:05:49 -0400
Received: by mail-oi0-x242.google.com with SMTP id l190-v6so22456796oig.9
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 06:05:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522908551-14885-1-git-send-email-thuth@redhat.com>
References: <1522908551-14885-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 14:05:28 +0100
Message-ID: <CAFEAcA81joSt3wNxaezi0ZzpOZm=Wt0TShcmQ0YtAYV+_ipeeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/arm/fsl-imx: Fix introspection
 problem with fsl-imx6 and fsl-imx7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 5 April 2018 at 07:09, Thomas Huth <thuth@redhat.com> wrote:
> QEMU currently exits unexpectedly when trying to introspect the fsl-imx6
> and fsl-imx7 devices on systems with many SMP CPUs:
>
> $ echo "{'execute':'qmp_capabilities'}"\
>        "{'execute':'device-list-properties',"\
>        " 'arguments':{'typename':'fsl,imx6'}}" \
>        | arm-softmmu/qemu-system-arm -M virt,accel=qtest -qmp stdio -smp 8
> {"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> {"return": {}}
> fsl,imx6: Only 4 CPUs are supported (8 requested)
>
> And:
>
> $ echo "{'execute':'qmp_capabilities'}"\
>        "{'execute':'device-list-properties',"\
>        " 'arguments':{'typename':'fsl,imx7'}}" \
>        | arm-softmmu/qemu-system-arm -M raspi2,accel=qtest -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> {"return": {}}
> fsl,imx7: Only 2 CPUs are supported (4 requested)
>
> This happens because these devices are doing an exit() from their
> instance_init function - which should never be done since instance_init
> can be called at any time for device introspection! Fix it by moving
> the deadly check into the realize() function instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>



Applied to target-arm.next, thanks.

-- PMM
