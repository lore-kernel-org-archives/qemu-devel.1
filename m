Received: from eggs.gnu.org ([2001:4830:134:3::10]:58528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejOxH-0006L9-Ui
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejOxE-00082t-RO
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:36:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ejOxE-00082a-MH
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:36:00 -0500
Date: Wed, 7 Feb 2018 13:35:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180207133542.0f57a35b@redhat.com>
In-Reply-To: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
References: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] how to handle QOM 'container' objects whose
 contents depend on QOM properties?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, 6 Feb 2018 18:18:25 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> [I've cc'd a fairly random selection of people who I thought
> might be interested or have an opinion.]
> 
> It's fairly common to have a setup where we have a QOM container
> object (like an SoC) which in turn instantiates a lot of child
> objects (for all the devices). The neat way of doing this looks
> like hw/arm/xlnx-zynqmp.c -- in the container's init function,
> we use object_initialize() to init all the child objects. If the
> container exposes some properties that are really just being
> forwarded to one of its children it can set those up in init
> with object_property_add_alias(). Finally, in realize the container
> realizes all its children.
> 
> Unfortunately, this pattern interacts badly with the idea that
> you might want to use a QOM property to determine aspects of
> the container that affect what child objects it creates.
> (Examples would include wanting a "which CPU is this" property
> on an SoC object, or if the SoC has a couple of variants which
> maybe have extra devices.)
[...] 

> Another approach is that instead of having a "what CPU" or "what
> SoC variant" property on the container, we create one container
> type per variation. Then instead of "create container, set QOM
> property to specify variant" the user creates the correct container
> type for the variant. hw/arm/aspeed_soc.c has an example of this.
> That looks pretty nice code-wise, but if there are a lot of
> possible options for the variants it could result in a large
> number of QOM types.
hw/arm/aspeed_soc.c looks rather clean and readable.

This types would be used only by boards and won't
be visible outside of QEMU, aren't they?
If so why would be large number of QOM types of a concern here?

> 
> thanks
> -- PMM
> 
