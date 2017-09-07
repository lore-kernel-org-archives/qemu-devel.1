Received: from eggs.gnu.org ([2001:4830:134:3::10]:33537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpt9Q-0000SF-Kg
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpt9P-0004PI-MW
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:31:08 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpt9P-0004Oz-F3
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:31:07 -0400
Received: by mail-wm0-x22b.google.com with SMTP id f199so92220wme.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 02:31:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170907092010.3605-2-aik@ozlabs.ru>
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-2-aik@ozlabs.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 10:30:45 +0100
Message-ID: <CAFEAcA-s026tJqgfa+kNsLtY2fEKpFs7ZT6zOk8CMg7ZX84CQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH qemu 1/4] memory: Postpone flatview and
 dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

On 7 September 2017 at 10:20, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> Most devices use at least one address space and every time a new address
> space is added, flat views and dispatch trees are rebuild for all address
> spaces. This is not a problem for a relatively small amount of devices but
> even 50 virtio-pci devices use more than 8GB of RAM.
>
> What happens that on every flatview/dispatch rebuild, new arrays are
> allocated and old ones release but the release is done via RCU so until
> an entire machine is build, they are not released.
>
> This wraps devices creation into memory_region_transaction_begin/commit
> to massively reduce amount of flat view/dispatch tree (re)allocations.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  vl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/vl.c b/vl.c
> index 8e247cc2a2..3c39cc8b3a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4655,12 +4655,16 @@ int main(int argc, char **argv, char **envp)
>      igd_gfx_passthru();
>
>      /* init generic devices */
> +    memory_region_transaction_begin();
> +
>      rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
>      if (qemu_opts_foreach(qemu_find_opts("device"),
>                            device_init_func, NULL, NULL)) {
>          exit(1);
>      }
>
> +    memory_region_transaction_commit();

What happens if something in a device realize function tries
to do a read from an AddressSpace? I can't think of any examples
that need to do that and I suspect it's probably a bug if anybody
tries it, but I'm curious whether this change alters the failure
mode...

thanks
-- PMM
