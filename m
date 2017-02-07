Received: from eggs.gnu.org ([2001:4830:134:3::10]:59465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cb7R0-000607-1V
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cb7Qw-0003kI-TO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:11:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170127094154.19778-1-berto@igalia.com>
Date: Tue, 07 Feb 2017 16:11:51 +0100
In-Reply-To: <20170127094154.19778-1-berto@igalia.com> (Alberto Garcia's
	message of "Fri, 27 Jan 2017 11:41:54 +0200")
Message-ID: <87wpd211e0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Clarify that -vga std is now the
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Alberto Garcia <berto@igalia.com> writes:

> The QEMU manual page states that Cirrus Logic is the default video
> card if the user doesn't specify any. However this is not true since
> QEMU 2.2.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  qemu-options.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 80df52651a..66ee562821 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1195,12 +1195,12 @@ Select type of VGA card to emulate. Valid values for @var{type} are
>  Cirrus Logic GD5446 Video card. All Windows versions starting from
>  Windows 95 should recognize and use this graphic card. For optimal
>  performances, use 16 bit color depth in the guest and the host OS.
> -(This one is the default)
> +(This card was the default before QEMU 2.2)
>  @item std
>  Standard VGA card with Bochs VBE extensions.  If your guest OS
>  supports the VESA 2.0 VBE extensions (e.g. Windows XP) and if you want
>  to use high resolution modes (>= 1280x1024x16) then you should use
> -this option.
> +this option. (This card is the default since QEMU 2.2)
>  @item vmware
>  VMWare SVGA-II compatible adapter. Use it if you have sufficiently
>  recent XFree86/XOrg server or Windows guest with a driver for this

Do we want to cover history in the user manual?  Or should we simply
move the "(This one is the default)" phrase?

Hmm, the default seems to depend on the machine type:

    if (default_vga) {
        if (machine_class->default_display) {
            vga_model = machine_class->default_display;
        } else if (vga_interface_available(VGA_CIRRUS)) {
            vga_model = "cirrus";
        } else if (vga_interface_available(VGA_STD)) {
            vga_model = "std";
        }
    }

The pc-*-2.2 and newer set ->default_display = "std".

Everything else keeps it null, and therefore gets "cirrus" if compiled
in, else "std".

The easy way out is to simply delete "(This one is the default)".
