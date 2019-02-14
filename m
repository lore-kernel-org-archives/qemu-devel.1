Received: from eggs.gnu.org ([209.51.188.92]:42188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guJlB-0004kH-Va
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guJlA-0004X5-Ko
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:21:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guJlA-0004Uz-C8
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:21:12 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 17:21:08 +0100
Message-ID: <87wom249zf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Object instantiation vs. device realization: what to
 do when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

One of qdev's perennial sources of confusion is what to do at object
instantiation time, i.e. in TypeInfo::instance_init(), and what to do at
device realization time, i.e. in DeviceClass::realize().  qdev-core.h's
comment falls short:

 * # Realization #
 * Devices are constructed in two stages,
 * 1) object instantiation via object_initialize() and
 * 2) device realization via #DeviceState:realized property.
 * The former may not fail (and must not abort or exit, since it is called
 * during device introspection already), and the latter may return error
 * information to the caller and must be re-entrant.
 * Trivial field initializations should go into #TypeInfo.instance_init.

As usual, "trivial" was too trivial to explain; the reader is trusted to
figure it out himself.  Well, I'm afraid I'm not to be trusted.

The easy part is "can fail means it's not trivial", because
::instance_init() must not fail.

What about side effects?  If you already understand how introspection
works, or perhaps even if you read carefully and paranoidly, then "since
it is called during device introspection already" implies "guest-visible
side-effects would be disastrous".  So guest-visible side-effect also
means it's not trivial.

 * Operations depending on @props static properties should go into @realize.

Actually, these *have* to go into realize(), because properties get set
between ::instance_init() and ::realize().

Even if I had a precise definition of "trivial field initializations",
I'd still wonder where operations should go that are neither such
trivial field initializations, nor depend on @props.

 * After successful realization, setting static properties will fail.
 *
 * As an interim step, the #DeviceState:realized property can also be
 * set with qdev_init_nofail().
 * In the future, devices will propagate this state change to their children
 * and along busses they expose.

This sentence is five years old.  Any progress?  If not, any intentions
to make progress?

 * The point in time will be deferred to machine creation, so that values
 * set in @realize will not be introspectable beforehand. Therefore devices
 * must not create children during @realize; they should initialize them via
 * object_initialize() in their own #TypeInfo.instance_init and forward the
 * realization events appropriately.

This is mostly greek to me.  Pity the developer who knows less about
qdev than I do.

 *
 * Any type may override the @realize and/or @unrealize callbacks but needs
 * to call the parent type's implementation if keeping their functionality
 * is desired. Refer to QOM documentation for further discussion and examples.

"Refer to QOM documentation"... okay, but this comment needs to make
sense without having to read the 3000+ lines under include/qom/ (which
by the way requires finding it first; I'd expect the naive reader to
look under docs/ and draw a blank).

Can we come up with clear guidelines on how to split work between
::instance_init() and ::realize()?
