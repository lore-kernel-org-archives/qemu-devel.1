Received: from eggs.gnu.org ([2001:4830:134:3::10]:56177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHsBm-000620-RK
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHsBj-0006L3-Ob
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:36:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHsBj-0006Kg-Fl
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:36:55 -0400
Date: Mon, 5 Jun 2017 10:36:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170605133650.GM4294@thinpad.lan.raisama.net>
References: <CAFEAcA_pErWnoUh_-fxaBMZB1L=4jYxUXYfx9CA5uVnx0H2_pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_pErWnoUh_-fxaBMZB1L=4jYxUXYfx9CA5uVnx0H2_pw@mail.gmail.com>
Subject: Re: [Qemu-devel] qdev properties vs qom object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Jun 05, 2017 at 02:10:06PM +0100, Peter Maydell wrote:
> I perpetually get confused about qdev properties vs QOM object
> properties.

You are not alone.  :)

> 
> Why do we have both of these APIs?

I don't know.  Probably because the QOM property API was
introduced, it was just a subset of of the features provided by
qdev properties, so the qdev API had to be kept.


> How do they interact?

qdev properties are implemented on top of the QOM property APIs.
After the properties are registered by qdev code, we can simply
use the QOM APIs to interact with them (to get/set/enumerate
properties).

But qdev provide some extra features[1], that's why we can't
simply replace all code using qdev properties to use the QOM APIs
directly.

[1] Some of the differences I remember:
* qdev properties can be defined declaratively using
  using Property arrays.
* qdev properties allows you to set a default value more clearly
  in the code.
* qdev properties don't require custom getters/setters to be
  written.  You just need to provide the field name (which is
  saved as a field offset by the DEFINE_PROP_* macros).
* qdev setters automatically check if "realized" is true, and
  refuse to change a property after the device is realized.
* some existing code (mostly monitor code, I think) looks for
  qdev properties only, but will ignore other QOM properties.
* A few data types (and their corresponding parsers) are only
  defined as qdev types (PropertyInfo structs), not on the QAPI
  schema.


> Which is the recommended one for new device code?

qdev properties are easier to use, so I recommend using them
unless you need custom getters/setters.


> Do we have a transition plan for old code?

We don't.  I believe we should first make the QOM API as powerful
as the qdev property API.  Then we can replace qdev-specific code
with equivalent QOM code.


> Where should I be looking for the documentation on this?

Good question.  The QOM API is well documented, but the way the
qdev property code interacts with the QOM API is not.


> 
> For a specific example, I see that target/arm is the only code
> using qdev_property_add_static(), but there's no indication
> that the function is deprecated or what the right thing to be
> doing instead is. Any suggestions?

qdev_property_static() is still easier to use than writing custom
getters/setters for object_property_add(), so I don't think we
should deprecate it yet.

-- 
Eduardo
