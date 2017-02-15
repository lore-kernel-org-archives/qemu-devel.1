Received: from eggs.gnu.org ([2001:4830:134:3::10]:37609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ce5Lo-0007Cb-Ht
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ce5Lj-0001mY-Lw
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:34:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ce5Lj-0001la-A2
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:34:47 -0500
Date: Wed, 15 Feb 2017 21:34:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170215211910-mutt-send-email-mst@kernel.org>
References: <9dffe31a245cf6a717eef8227fe80ca666b168b5.1487139038.git.ben@skyportsystems.com>
	<20170215115723.77e4d9d7@nial.brq.redhat.com>
	<1f4a6eb2-0838-2218-88e3-4f65498a41d6@redhat.com>
	<20170215162225.74d48058@nial.brq.redhat.com>
	<20170215172515-mutt-send-email-mst@kernel.org>
	<20170215165602.72e96c28@nial.brq.redhat.com>
	<20170215183736-mutt-send-email-mst@kernel.org>
	<20170215184309.521aa90f@nial.brq.redhat.com>
	<20170215194647-mutt-send-email-mst@kernel.org>
	<20170215192436.2695b9f6@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170215192436.2695b9f6@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/7] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, ben@skyportsystems.com

On Wed, Feb 15, 2017 at 07:24:36PM +0100, Igor Mammedov wrote:
> > As long as all users pass in 0 though there's a real possibility guests
> > will implement this incorrectly.
> We are here to ensure that at least Seabios (I'll review it)
> and OVMF (Laszlo would take care of it I suppose) do it right,
> and if there are other firmwares, they should do it correctly
> as described fix their own bugs later wrt randomly written
> implementation.

As long as it's untested, it can always do the wrong thing
even if it looks right, or it can bitrot.

> > I guess we can put in the offset just
> > behind the zero-filled padding we have there.
> I've assumed padding was there to make commands fixed size and give
> a room for future extensions

you mean
        char pad[124];
?

Right. So you can easily add fields, but if you do firmware
will just assume it does not know how to handle these
commands and skip them.

> so hunk changing BiosLinkerLoaderEntry
> would look like:
> 
> diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
> index d963ebe..6983713 100644
> --- a/hw/acpi/bios-linker-loader.c
> +++ b/hw/acpi/bios-linker-loader.c
> @@ -49,6 +49,7 @@ struct BiosLinkerLoaderEntry {
>              char file[BIOS_LINKER_LOADER_FILESZ];
>              uint32_t align;
>              uint8_t zone;
> +            uint32_t padding;
>          } alloc;
>  
>          /*
> @@ -62,6 +63,7 @@ struct BiosLinkerLoaderEntry {
>              char src_file[BIOS_LINKER_LOADER_FILESZ];
>              uint32_t offset;
>              uint8_t size;
> +            uint32_t padding;
>          } pointer;
>  
>          /*
> @@ -76,10 +78,25 @@ struct BiosLinkerLoaderEntry {
>              uint32_t offset;
>              uint32_t start;
>              uint32_t length;
> +            uint32_t padding;
>          } cksum;

why is this necessary?

> +        /*
> +         * COMMAND_WRITE_POINTER - write the fw_cfg file (originating from
> +         * @dest_file) at @wr_pointer.offset, by writing a pointer to @src_offset
> +         * within the table originating from @src_file. 1,2,4 or 8 byte unsigned
> +         * addition is used depending on @wr_pointer.size.
> +         */
> +         struct {
> +             char dest_file[BIOS_LINKER_LOADER_FILESZ];
> +             char src_file[BIOS_LINKER_LOADER_FILESZ];
> +             uint32_t dst_offset;
> +             uint32_t src_offset;
> +             uint8_t size;
> +        } wr_pointer;
> +
>          /* padding */
> -        char pad[124];
> +        char pad[120];

and this shrinks entry size by 4 bytes. Why?

>      };
>  } QEMU_PACKED;
>  typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
> 
>  
> > I'm mostly concerned we are adding new features to something
> > that has been through 25 revisions already.
> It's ABI so it's worth extra effort,

There's always yet another possible enhancement you can add.
I see it as a bit of a feature creep frankly.

> it looks like only one more revision is left and there is
> about a week left to post and merge it.

If we can do it quickly, fine, but I think we should merge ASAP.

-- 
MST
