Received: from eggs.gnu.org ([2001:4830:134:3::10]:46080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eNRaD-0008NL-7t
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 17:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eNRa9-0007ni-9R
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 17:57:29 -0500
Received: from mail-by2nam03on0071.outbound.protection.outlook.com
	([104.47.42.71]:32000
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eNRa8-0007mD-Ti
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 17:57:25 -0500
References: <20171206200346.116537-1-brijesh.singh@amd.com>
	<20171206200346.116537-2-brijesh.singh@amd.com>
	<CAFEAcA8UvBopec1ammRML+fgh36YLfRyg2wsgmzesmAUFy8H3w@mail.gmail.com>
	<7e7b6c05-68de-c4f8-6163-53588a6d545e@amd.com>
	<CAFEAcA_A9c3QMOJeHK+gyTpwkxo0hpkU9jhCdvQnpfbGBw+Wfg@mail.gmail.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <053109e5-3b12-b76c-7d87-5f1e4941ebed@amd.com>
Date: Fri, 8 Dec 2017 16:57:13 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_A9c3QMOJeHK+gyTpwkxo0hpkU9jhCdvQnpfbGBw+Wfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 01/23] memattrs: add debug attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: brijesh.singh@amd.com, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>



On 12/8/17 3:55 AM, Peter Maydell wrote:
>> If you give me example on how
>> to trigger this type of request with debug=3D1 then I can look into the =
code
>> and see what we can do when memory encryption is enabled. The things lik=
e
>> read-clears-bits semantics will be tricky.
> The question was really whether we want to make this a general
> indicator of "this operation was triggered by a debugger" and
> expand that to mean "don't do things that mess with the state
> of the simulation unexpectedly", or if this is really a very
> encrypted-memory specific thing.

It can be used as a generic indicator that operation was triggered by a
debugger. There is not anything encryption specific. Having said that,
in the current patch series I have been only focused on making it work
from the gdbstub and HMP point of view. The debug=3D1 from gdbstub and HMP
is tested on both encrypted and non-encrypted guest. If we decide to
extend to support other callers (device model etc) then we may need to
update memory load/store functions defined in memory_ldst_inc.c to work
with debug=3D1.

> By the way, I don't think this:
>
>> /* Access the guest memory for debug purposes */
>> #define MEMTXATTRS_DEBUG ((MemTxAttrs) { .debug =3D 1 })
> is a great idea. Callers that care about the transaction
> attributes should just specify them properly. MEMTXATTRS_UNSPECIFIED
> is a fallback for the large set of places that don't care at all.

OK, I will drop the macro and update the patches in the series to set
MemTxAttr.debug =3D 1 when we do debugger request.=C2=A0 thanks

--Brijesh
