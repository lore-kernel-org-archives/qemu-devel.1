Received: from eggs.gnu.org ([2001:4830:134:3::10]:46625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMhmr-0005la-DO
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMhmq-0000qN-Ea
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:03:29 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMhmq-0000pa-7r
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:03:28 -0500
Received: by mail-oi0-x241.google.com with SMTP id l6so3603447oih.11
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:03:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171206200346.116537-2-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
	<20171206200346.116537-2-brijesh.singh@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Dec 2017 22:03:06 +0000
Message-ID: <CAFEAcA8UvBopec1ammRML+fgh36YLfRyg2wsgmzesmAUFy8H3w@mail.gmail.com>
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

On 6 December 2017 at 20:03, Brijesh Singh <brijesh.singh@amd.com> wrote:
> The debug attribute will be set when qemu attempts to access the guest
> memory for debug (e.g memory access from gdbstub, memory dump commands
> etc).
>
> When guest memory is encrypted, the debug access will need to go through
> the memory encryption APIs.
>
> Cc: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  include/exec/memattrs.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index d4a16420984b..721362e06292 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
>      unsigned int user:1;
>      /* Requester ID (for MSI for example) */
>      unsigned int requester_id:16;
> +    /* Debug memory access for encrypted guest */
> +    unsigned int debug:1;
>  } MemTxAttrs;

Can we have some more detailed semantics for this please?
For instance, if a device gets a debug=1 transaction
should it refuse to do things like read-clears-bits
semantics or other side-effects you wouldn't expect
of debugger accesses?

thanks
-- PMM
