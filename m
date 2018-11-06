Received: from eggs.gnu.org ([2001:4830:134:3::10]:51641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gK2JH-0002yC-0f
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gK2JA-0008LD-Ux
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:26:26 -0500
Date: Tue, 6 Nov 2018 12:26:11 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181106142611.GQ12503@habkost.net>
References: <20181106102335.20027-1-kraxel@redhat.com>
	<20181106102335.20027-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106102335.20027-3-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>

On Tue, Nov 06, 2018 at 11:23:31AM +0100, Gerd Hoffmann wrote:
> Indicates support state for something (device, backend, subsystem, ...)
> in qemu.  Add QemuSupportState field to ObjectClass.  Add some support
> code.
> 
> TODO: wire up to qom-list-types
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
[...]
> +##
> +# @SupportState:
> +#
> +# Indicate Support level of qemu devices, backends, subsystems, ...
> +#
> +# @unspecified: not specified (zero-initialized).
> +#
> +# @experimental: in development, can be unstable or incomplete.

People reading this document would ask: what would appear on
MAINTAINERS if SupportState is `experimental`?

> +#
> +# @supported: works stable and is fully supported.
> +#             (supported + maintained in MAINTAINERS).
> +#
> +# @unsupported: should work, support is weak or not present.
> +#               (odd-fixes + orphan in MAINTAINERS).

What's the difference in practice between unsupported and
experimental?

> +#
> +# @obsolete: is obsolete, still present for compatibility reasons,
> +#            will likely be removed at some point in the future.
> +#            Not deprecated (yet).
> +#            (obsolete in MAINTAINERS).
> +#
> +# @deprecated: is deprecated, according to qemu deprecation policy.

I believe we want to differentiate "deprecated, but still safe to
use in production if you have a migration plan" from "deprecated,
and also unstable and unsafe for production".

I expect enterprise distributions to have a strict policy of not
allowing unsupported and experimental devices to be enabled, but
still allow deprecated devices to be enabled (but only if they
are stable/supported).

-- 
Eduardo
