Received: from eggs.gnu.org ([2001:4830:134:3::10]:59440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eNFNk-0008Iu-Ss
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eNFNk-00038k-00
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:55:48 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:44565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eNFNj-00038b-Qi
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:55:47 -0500
Received: by mail-ot0-x230.google.com with SMTP id d27so8761905ote.11
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 01:55:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7e7b6c05-68de-c4f8-6163-53588a6d545e@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
	<20171206200346.116537-2-brijesh.singh@amd.com>
	<CAFEAcA8UvBopec1ammRML+fgh36YLfRyg2wsgmzesmAUFy8H3w@mail.gmail.com>
	<7e7b6c05-68de-c4f8-6163-53588a6d545e@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Dec 2017 09:55:26 +0000
Message-ID: <CAFEAcA_A9c3QMOJeHK+gyTpwkxo0hpkU9jhCdvQnpfbGBw+Wfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 01/23] memattrs: add debug attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>

On 7 December 2017 at 21:20, Brijesh Singh <brijesh.singh@amd.com> wrote:
> On 12/06/2017 04:03 PM, Peter Maydell wrote:
>> For instance, if a device gets a debug=1 transaction
>> should it refuse to do things like read-clears-bits
>> semantics or other side-effects you wouldn't expect
>> of debugger accesses?
>>
>
> Sorry I am not able to understand "if a device gets a debug=1 transition"
> comment, Can you please explain me a bit more.

A device model (eg a UART) can be written to look at the
MemTxAttrs that it's passed and behave differently if debug=1.

> If you give me example on how
> to trigger this type of request with debug=1 then I can look into the code
> and see what we can do when memory encryption is enabled. The things like
> read-clears-bits semantics will be tricky.

The question was really whether we want to make this a general
indicator of "this operation was triggered by a debugger" and
expand that to mean "don't do things that mess with the state
of the simulation unexpectedly", or if this is really a very
encrypted-memory specific thing.

By the way, I don't think this:

> /* Access the guest memory for debug purposes */
> #define MEMTXATTRS_DEBUG ((MemTxAttrs) { .debug = 1 })

is a great idea. Callers that care about the transaction
attributes should just specify them properly. MEMTXATTRS_UNSPECIFIED
is a fallback for the large set of places that don't care at all.

thanks
-- PMM
