Received: from eggs.gnu.org ([2001:4830:134:3::10]:42988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdrYi-0004k9-RI
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 02:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdrYh-0002pu-Uj
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 02:28:04 -0400
References: <1531409463-3843-1-git-send-email-thuth@redhat.com>
	<1531409463-3843-2-git-send-email-thuth@redhat.com>
	<20180712165224.GD31657@localhost.localdomain>
	<224a0bbb-9dbb-87eb-9e9b-1c82923010b5@redhat.com>
	<CAFEAcA8-1TiRD2S4hJW1tXfi2ivV-ONg=wEFiX+uGfweD6mY6g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7773c58-8559-5056-0575-92756d504246@redhat.com>
Date: Fri, 13 Jul 2018 08:27:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-1TiRD2S4hJW1tXfi2ivV-ONg=wEFiX+uGfweD6mY6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] qom/object: Add a new function
 object_initialize_as_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 12/07/2018 19:09, Peter Maydell wrote:
>> That's the same what object_initialize() is doing (see above). Otherwise
>> all the callers have to cast their pointers with OBJECT() first.
> Casting with OBJECT() would not work, because it does a typecheck.
> At the point where something is calling object_initialize() or
> object_initialize_with_child(), the memory at 'childobj' has not
> been initialized, so a typecheck is impossible.
> 
> It's only once the object has actually been initialized that
> the memory is a valid Object* that you can put through OBJECT().

OBJECT is special and just does a cast, because every pointer to a QOM
object would pass.  However, your reasoning still applies: you should
not put through OBJECT() an object that hasn't been initialized yet,
just like you should not put it through DEVICE() or any of the macros
that _do_ perform the typecheck.

Paolo
