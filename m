Received: from eggs.gnu.org ([2001:4830:134:3::10]:42126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcdvL-0002cj-ER
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcdvK-0006io-Ha
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:42:23 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcdvK-0006iT-4V
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:42:22 -0400
Received: by mail-oi0-x242.google.com with SMTP id i12-v6so38749625oik.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 14:42:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531170180-21199-1-git-send-email-thuth@redhat.com>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 22:42:00 +0100
Message-ID: <CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 9 July 2018 at 22:03, Thomas Huth <thuth@redhat.com> wrote:
> When trying to "device_add bcm2837" on a machine that is not suitable for
> this device, you can quickly crash QEMU afterwards, e.g. with "info qtree":
>
> echo "{'execute':'qmp_capabilities'} {'execute':'device_add', " \
>  "'arguments':{'driver':'bcm2837'}} {'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  aarch64-softmmu/qemu-system-aarch64 -M integratorcp,accel=qtest -S -qmp stdio
>
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> {"return": {}}
> {"error": {"class": "GenericError", "desc": "Device 'bcm2837' can not be
>  hotplugged on this machine"}}
> Segmentation fault (core dumped)
>
> The problem is that qdev_set_parent_bus() from instance_init adds a link
> to the child devices which is not valid anymore after the device init
> failed. Thus the qdev_set_parent_bus() must rather be done in the realize
> function instead.

Yuck. The real problem here is that we're still requiring the
code that creates these QOM devices to manually set the parent
in the first place. It's not surprising that we don't get it right
(either parenting in the wrong place or not at all). I'd much
rather see us fix that properly than keep papering over places
where we get it wrong.

Also, "device_add bcm2837" is just nonsensical: there's no
way to create an SoC device like this with device_add.
We should not allow it (for this and all the other
devices that device_add will never work with)...

thanks
-- PMM
