Received: from eggs.gnu.org ([2001:4830:134:3::10]:41266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ds5O0-0005E4-OZ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ds5O0-0004fB-05
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:59:16 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:37292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ds5Nz-0004eJ-Ow
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:59:15 -0400
Received: by mail-wr0-x22b.google.com with SMTP id k20so27945444wre.4
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 03:59:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504776162-31400-1-git-send-email-thuth@redhat.com>
References: <1504776162-31400-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Sep 2017 11:58:53 +0100
Message-ID: <CAFEAcA8jE4UqPFNwvVcENESnopgeNDtAoMrocQarO7X1TuW-Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/qdev: Do not allow hot-plugging
 without hotplug controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 7 September 2017 at 10:22, Thomas Huth <thuth@redhat.com> wrote:
> qdev_unplug() bails out with an assertion if the user tries to device_del
> a hot-plugged device that does not have a hotplug controller. Unfortunately,
> our devices are all marked with hotpluggable = true by default (see the
> device_class_init() function in qdev.c), so it currently can happen that
> the user runs into this situation and QEMU gets terminated unexpectedly:

Why are our devices hotpluggable by default? Hotpluggable
is the unusual case which requires the device author to
take special case (notably writing a function to undo anything
done in realize so we don't leak stuff on unplug), so it
should be the case that requires the device author to
mark the device as hotplugged specifically.

We should just change the default (and effectively whitelist
devices which do hotplug successfully), or we'll be continually
playing whack-a-mole with devices or classes of devices or
machines that accidentally forgot to disable hotplugging.

thanks
-- PMM
