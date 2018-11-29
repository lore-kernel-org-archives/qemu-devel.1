Received: from eggs.gnu.org ([2001:4830:134:3::10]:51571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSRhr-0001gD-QI
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSRhn-0006Bi-50
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:10:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181106102335.20027-1-kraxel@redhat.com>
	<20181106102335.20027-7-kraxel@redhat.com>
Date: Thu, 29 Nov 2018 20:10:22 +0100
In-Reply-To: <20181106102335.20027-7-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Tue, 6 Nov 2018 11:23:35 +0100")
Message-ID: <87r2f3r97l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 6/6] add UsageHints to QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Gerd Hoffmann <kraxel@redhat.com> writes:

> So we can add device usage recommendations to devices,
> independant from support state.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/qemu/support-state.h |  1 +
>  qapi/common.json             | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/include/qemu/support-state.h b/include/qemu/support-state.h
> index 6567d8702b..6ea0d03bd5 100644
> --- a/include/qemu/support-state.h
> +++ b/include/qemu/support-state.h
> @@ -5,6 +5,7 @@
>  
>  typedef struct QemuSupportState {
>      SupportState state;
> +    UsageHints   hints;
>      const char   *help;
>  } QemuSupportState;
>  
> diff --git a/qapi/common.json b/qapi/common.json
> index 00374127b8..6952ea2074 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -183,3 +183,32 @@
>              'unsupported',
>              'obsolete',
>              'deprecated' ] }
> +
> +##
> +# @UsageHints:
> +#
> +# Usage recommendations.
> +#
> +# @unspecified: not specified (zero-initialized).

(zero-initialized) is an implementation detail, which in my opinion
doesn't belong here.  Same in PATCH 2.

> +#
> +# @green: Best choice.  Typically paravirtual devices go into this
> +#         category.
> +#         Example (nic): virtio-net.
> +#         Example (usb); xhci.
> +#
> +# @yellow: Reasonable choice.  Typically emulated devices with
> +#          good performance go into this category.
> +#          Example (nic): e1000, e1000e
> +#
> +# @red: Bad choice.  Avoid this unless you run an old guest which
> +#       lacks support for something better.
> +#       Example (nic): rtl8139, pcnet, ne2k, ...
> +#       Example (usb): ehci, uhci, ohci
> +#
> +# Since: 3.2
> +##
> +{ 'enum': 'UsageHints',
> +  'data': [ 'unspecified',
> +            'green',
> +            'yellow',
> +            'red' ] }

Simple.  I like simple, as long as it's good enough.  Hard to tell
without actual users.
