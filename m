Received: from eggs.gnu.org ([2001:4830:134:3::10]:57750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eouZE-0003DC-A3
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eouZD-00081q-Ee
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:22:00 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:44885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eouZD-00080j-6F
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:21:59 -0500
Received: by mail-ot0-x244.google.com with SMTP id 79so5276884oth.11
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 09:21:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180222095917.29eda1d9@w520.home>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219111458.25983-5-kraxel@redhat.com>
	<20180222153740.3zkvjen77uwjqhd2@sirius.home.kraxel.org>
	<CAFEAcA8_VRML=FopCKdGnrPCyZ9MwKokMj60962=tgCNwNT2oA@mail.gmail.com>
	<20180222095917.29eda1d9@w520.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 17:21:37 +0000
Message-ID: <CAFEAcA_arhg_g=qcU68PLE6V8aAfDc3wyHqsNR8osq67g-ZKVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 4/7] qdev: add hotpluggable to
 DeviceState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 22 February 2018 at 16:59, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Thu, 22 Feb 2018 15:46:17 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> What type of device is only sometimes hotpluggable ?
>> The commit message says "display devices" and "consoles",
>> but I would expect those to both be types of device which
>> have a class which is never hotpluggable, so you can mark
>> them non-hotpluggable with the existing class flag rather
>> than needing a per-instance flag.
>
> With this series, a vfio-pci device optionally supports a display.  The
> vfio-pci device is hotpluggable, but QEMU display support is not.  So
> the solution here is to make the vfio-pci device non-hotpluggable only
> when it supports and enables a display.

Ah, I see. I don't have a good suggestion offhand, but I suspect
the patch as it stands is insufficient if we want to take the
approach it uses. For instance qdev_unplug() in qdev-monitor.c
looks directly at dc->hotpluggable to decide whether it should
refuse a user request to hot-unplug a device.

thanks
-- PMM
