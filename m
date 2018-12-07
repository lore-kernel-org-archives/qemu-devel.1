Received: from eggs.gnu.org ([2001:4830:134:3::10]:41959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVHE6-000509-Ok
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVHE3-0000F4-Hi
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:35:34 -0500
Date: Fri, 7 Dec 2018 14:35:25 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207143525.GF18875@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-4-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544108924-10841-4-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/18] xen: introduce 'xen-block',
 'xen-disk' and 'xen-cdrom'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Dec 06, 2018 at 03:08:29PM +0000, Paul Durrant wrote:
> +static char *disk_to_vbd_name(unsigned int disk)
> +{
> +    char *name, *prefix = (disk >= 26) ?
> +        disk_to_vbd_name((disk / 26) - 1) : g_strdup("");
> +
> +    name = g_strdup_printf("%s%c", prefix, 'a' + disk);

I don't think that works, if disk is 27, we do ('a' + 27) here. It's
probably missing a `disk % 26`.

> +    g_free(prefix);
> +
> +    return name;
> +}

[...]

> +static unsigned int vbd_name_to_disk(const char *name, const char **endp)
> +{
> +    unsigned int disk = 0;
> +
> +    while (*name != '\0') {
> +        if (!g_ascii_isalpha(*name) || !g_ascii_islower(*name)) {
> +            break;
> +        }
> +
> +        disk *= 26;
> +        disk += *name++ - 'a';
> +    }
> +    *endp = name;
> +
> +    return disk;
> +}
> +
> +static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{

Setting vdev doesn't work. I've tried to add a disk `xvdaa', and it
result in `xvda', or `d0p0' (in the trace). (Same result with `xvdaaa',
and 'xvdba' gives 'xvdaa'/d26p0)

-- 
Anthony PERARD
