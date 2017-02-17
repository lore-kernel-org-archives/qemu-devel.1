Received: from eggs.gnu.org ([2001:4830:134:3::10]:37054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceieM-0005pj-9m
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceieL-0007o3-Gu
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:32:38 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceieL-0007nk-AW
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:32:37 -0500
Received: by mail-wr0-x231.google.com with SMTP id i10so29998872wrb.0
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 05:32:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170216161114.220260cf@nial.brq.redhat.com>
References: <1487253461-269218-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA_NgmdDCfbPy+DnHQBmNGmQ4tj1z4ci+OP7+x4tHLLCxg@mail.gmail.com>
	<20170216161114.220260cf@nial.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 13:32:15 +0000
Message-ID: <CAFEAcA-aaEPxhYK2ePq2QXW6UVe2A=NxP=V7cokURkurPzLRGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: fix cpu object reference leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16 February 2017 at 15:11, Igor Mammedov <imammedo@redhat.com> wrote:
> On Thu, 16 Feb 2017 14:18:05 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> I've always found the object reference semantics somewhat
>> confusing (why does realizing a device add a reference,
>> for instance?). Do we document them anywhere?
> I'm not aware of a place where it's documented.
>
> currently device_realize() sets parent thus increasing
> ref counter only if device creator haven't set parent
> explicitly.

It doesn't seem to:

static void device_realize(DeviceState *dev, Error **errp)
{
    DeviceClass *dc = DEVICE_GET_CLASS(dev);

    if (dc->init) {
        int rc = dc->init(dev);
        if (rc < 0) {
            error_setg(errp, "Device initialization failed.");
            return;
        }
    }
}

...it just calls the device's init function if it has one.

It's also pretty confusing that qdev_try_create()
and qdev_create() return a pointer to an object
that has been put into a bus and had unref called
(so the caller doesn't need to manually unref),
but plain object_new() returns a pointer to an
object that hasn't been put into a bus, yet
realizing does put it into a bus but doesn't do the
corresponding unref.

I'd be a lot happier if we had clear documentation that
described how our object model, plugging things into buses,
etc handled reference counting and what the expected
"correct" code patterns are for using it.

That said, I guess this patch is correct so I'm applying
it to target-arm.next.

thanks
-- PMM
