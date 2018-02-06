Received: from eggs.gnu.org ([2001:4830:134:3::10]:41090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ej8YE-0006YF-FW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ej8Y9-0001Ju-Mr
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:05:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ej8Y9-0001JO-Do
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:05:01 -0500
Date: Tue, 6 Feb 2018 17:04:32 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180206190432.GF3291@localhost.localdomain>
References: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Tue, Feb 06, 2018 at 06:18:25PM +0000, Peter Maydell wrote:
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
> 
> One current approach to that is that instead of init'ing those
> child objects in the container init, we postpone that to
> container realize. This looks pretty ugly, and it also means
> that you can't do "forward this property" using add_alias if the
> target is the late-inited child (instead you have to have a
> real property on the container and set the property on the child
> manually after it's inited). You can see an example of this kind
> of thing in hw/arm/armv7m.c.

My rule of thumb is: if something is configurable (even if it's
just slightly), it belongs to realize.  instance_init is reserved
for stuff that don't take any external input.  If your container
contents are not static, creating the contents is not a task for
instance_init.

But I would like to understand the drawbacks of this approach
better.  So, if the object didn't have any "forward this
property" aliases, would you see other problems with this
approach?

Why exactly those boards need the aliases?  Who sets those alias
properties?  Can we provide helpers that make this task easier?


> 
> Another approach is that instead of having a "what CPU" or "what
> SoC variant" property on the container, we create one container
> type per variation. Then instead of "create container, set QOM
> property to specify variant" the user creates the correct container
> type for the variant. hw/arm/aspeed_soc.c has an example of this.
> That looks pretty nice code-wise, but if there are a lot of
> possible options for the variants it could result in a large
> number of QOM types.

Yeah, this may be reasonable in some cases (e.g. some CPU types),
but it won't always work.

> 
> The other popular approach to this is "don't let the container
> be as configurable as it ideally ought to be"...

I like this approach.  :)

> 
> So, does anybody have a view on what the best way to structure
> this kind of container object is? I feel like I'm running into
> the annoyances of the approach that armv7m.c is currently taking,
> so if there's a better way I'd like to do that instead.

-- 
Eduardo
