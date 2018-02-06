Received: from eggs.gnu.org ([2001:4830:134:3::10]:57662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej7pQ-0007jq-4Y
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej7pP-00026T-91
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:18:48 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:39587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej7pP-000260-25
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:18:47 -0500
Received: by mail-oi0-x229.google.com with SMTP id j188so2036830oib.6
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 10:18:47 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 18:18:25 +0000
Message-ID: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] how to handle QOM 'container' objects whose contents
 depend on QOM properties?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

[I've cc'd a fairly random selection of people who I thought
might be interested or have an opinion.]

It's fairly common to have a setup where we have a QOM container
object (like an SoC) which in turn instantiates a lot of child
objects (for all the devices). The neat way of doing this looks
like hw/arm/xlnx-zynqmp.c -- in the container's init function,
we use object_initialize() to init all the child objects. If the
container exposes some properties that are really just being
forwarded to one of its children it can set those up in init
with object_property_add_alias(). Finally, in realize the container
realizes all its children.

Unfortunately, this pattern interacts badly with the idea that
you might want to use a QOM property to determine aspects of
the container that affect what child objects it creates.
(Examples would include wanting a "which CPU is this" property
on an SoC object, or if the SoC has a couple of variants which
maybe have extra devices.)

One current approach to that is that instead of init'ing those
child objects in the container init, we postpone that to
container realize. This looks pretty ugly, and it also means
that you can't do "forward this property" using add_alias if the
target is the late-inited child (instead you have to have a
real property on the container and set the property on the child
manually after it's inited). You can see an example of this kind
of thing in hw/arm/armv7m.c.

Another approach is that instead of having a "what CPU" or "what
SoC variant" property on the container, we create one container
type per variation. Then instead of "create container, set QOM
property to specify variant" the user creates the correct container
type for the variant. hw/arm/aspeed_soc.c has an example of this.
That looks pretty nice code-wise, but if there are a lot of
possible options for the variants it could result in a large
number of QOM types.

The other popular approach to this is "don't let the container
be as configurable as it ideally ought to be"...

So, does anybody have a view on what the best way to structure
this kind of container object is? I feel like I'm running into
the annoyances of the approach that armv7m.c is currently taking,
so if there's a better way I'd like to do that instead.

thanks
-- PMM
