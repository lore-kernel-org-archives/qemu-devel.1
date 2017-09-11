Received: from eggs.gnu.org ([2001:4830:134:3::10]:51534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drPcJ-0000mT-Fk
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drPcD-0003E2-JM
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:23:15 -0400
Date: Mon, 11 Sep 2017 16:22:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170911142249.GB6951@localhost.localdomain>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-2-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500993699-19299-2-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V5 01/10] specs/qcow2: add compress format
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com

Am 25.07.2017 um 16:41 hat Peter Lieven geschrieben:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  docs/interop/qcow2.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  roms/ipxe              |  2 +-
>  2 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index d7fdb1f..d0d2a8f 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -86,7 +86,12 @@ in the description of a field.
>                                  be written to (unless for regaining
>                                  consistency).
>  
> -                    Bits 2-63:  Reserved (set to 0)
> +                    Bit 2:      Compress format bit.  If and only if this bit
> +                                is set then the compress format extension
> +                                MUST be present and MUST be parsed and checked
> +                                for compatibility.
> +
> +                    Bits 3-63:  Reserved (set to 0)
>  
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation can
> @@ -137,6 +142,7 @@ be stored. Each extension has a structure like the following:
>                          0x6803f857 - Feature name table
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header pointer
> +                        0xC03183A3 - Compress format extension
>                          other      - Unknown header extension, can be safely
>                                       ignored
>  
> @@ -311,6 +317,49 @@ The algorithms used for encryption vary depending on the method
>     in the LUKS header, with the physical disk sector as the
>     input tweak.
>  
> +
> +== Compress format extension ==
> +
> +The compress format extension is an optional header extension. It provides
> +the ability to specify the compress algorithm and compress parameters
> +that are used for compressed clusters. This new header MUST be present if
> +the incompatible-feature bit "compress format bit" is set and MUST be absent
> +otherwise.
> +
> +The fields of the compress format extension are:
> +
> +    Byte  0 - 13:  compress_format_name (padded with zeros, but not
> +                   necessarily null terminated if it has full length).
> +                   Valid compression format names currently are:
> +
> +                   deflate: Standard zlib deflate compression without
> +                            compression header
> +
> +              14:  compress_level (uint8_t)
> +
> +                   0 = default compress level (valid for all formats, default)
> +
> +                   Additional valid compression levels for deflate compression:
> +
> +                   All values between 1 and 9. 1 gives best speed, 9 gives best
> +                   compression. The default compression level is defined by zlib
> +                   and currently defaults to 6.
> +
> +              15:  compress_window_size (uint8_t)
> +
> +                   Window or dictionary size used by the compression format.
> +                   Currently only used by the deflate compression algorithm.
> +
> +                   Valid window sizes for deflate compression range from 8 to
> +                   15 inclusively.

So what is the plan with respect to adding new compression algorithms?

If I understand correctly, we'll use the same extension type
(0xC03183A3) and a different compress_format_name. However, the other
algorithm will likely have different options and also a different number
of options. Will the meaning of bytes 14-end then depend on the specific
algorithm?

Part of why I'm asking this is because I wonder why compress_format_name
is 14 characters. It looks to me as if that is intended to make the
header a round 16 bytes for the deflate algorithm. But unless we say
"16 bits ought to be enough for every algorithm", this is just
optimising a special case. (Or actually not optimising, but just moving
the padding from the end of the header extension to padding inside the
compress_format_name field.)

Wouldn't 8 bytes still be plenty of space for a format name, and look
more natural? Then any format that requires options would have a little
more space without immediately going to a 24 byte header extension.

Kevin
