Received: from eggs.gnu.org ([2001:4830:134:3::10]:49369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHVPg-0000lh-Jo
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHVPb-0002Mz-HQ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:54:36 -0400
Date: Tue, 30 Oct 2018 11:54:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181030145407.GV3902@habkost.net>
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030111348.14713-2-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>

On Tue, Oct 30, 2018 at 12:13:45PM +0100, Gerd Hoffmann wrote:
> Indicates support state for somerhing (device, backend, subsystem, ...)
> in qemu.  Modeled roughly after the "S:" states we have in MAINTANERS.
> 

Personally, I would prefer to start with a very simple data model
(e.g. a 'deprecated' boolean flag), instead of trying to model
every possibility in the first version.

With a detailed maintenance status flag, the meaning of the
values would be confusing for somebody using a downstream
distribution of QEMU.  Would it reflect upstream maintenance
status, or downstream vendor guarantees about support?  Would
downstream vendors be required to patch QEMU to update
DeviceClass::supported on every device they ship?  I think this
would cause confusion and require extra work for every downstream
vendor, and not solve any real world problems.

A 'deprecated' flag could still require extra work, but only in a
few specific cases: deprecated devices are the exception, not the
rule, and downstream vendors would only need to touch device code
if their deprecation status is different from upstream.


> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
[...]
> +
> +##
> +# @SupportState:
> +#
> +# Indicate Support level of qemu devices, backends, subsystems, ...

If we're following that path, I would like to get each possible
value for this enum to be clearly documented.  Especially
considering that this don't match the list on MAINTAINERS
exactly.

For example, I don't understand the difference between "obsolete"
and "deprecated".

> +#
> +# Since: 3.2
> +##
> +{ 'enum': 'SupportState',
> +  'data': [ 'unknown',
> +            'supported',
> +            'maintained',
> +            'odd-fixes',
> +            'orphan',
> +            'obsolete',
> +            'deprecated' ] }
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 0820923c18..6e5f8faf82 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -50,5 +50,6 @@ util-obj-y += range.o
>  util-obj-y += stats64.o
>  util-obj-y += systemd.o
>  util-obj-y += iova-tree.o
> +util-obj-y += support-state.o
>  util-obj-$(CONFIG_LINUX) += vfio-helpers.o
>  util-obj-$(CONFIG_OPENGL) += drm.o
> -- 
> 2.9.3
> 

-- 
Eduardo
