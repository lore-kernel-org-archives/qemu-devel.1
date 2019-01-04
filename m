Received: from eggs.gnu.org ([208.118.235.92]:55800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=90051d582=anthony.perard@citrix.com>)
	id 1gfSNk-0002wS-QP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=90051d582=anthony.perard@citrix.com>)
	id 1gfSNh-00064B-N4
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:31:36 -0500
Date: Fri, 4 Jan 2019 16:31:24 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190104163124.GE1508@perard.uk.xensource.com>
References: <20181220171439.11159-1-paul.durrant@citrix.com>
	<20181220171439.11159-17-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181220171439.11159-17-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v7 16/18] xen: automatically create
 XenBlockDevice-s
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

Almost done, there is one thing left which I believe is an issue.
Whenever I attach a raw file to QEMU, it print:
    qemu-system-i386: warning: Opening a block device as a file using the 'file' driver is deprecated

So, I think the comment below isn't true. We should create a "raw"
driver for "raw" files.

On Thu, Dec 20, 2018 at 05:14:37PM +0000, Paul Durrant wrote:
> +static XenBlockDrive *xen_block_drive_create(const char *id,
> +                                             const char *device_type,
> +                                             QDict *opts, Error **errp)
> +{
...

> +    if (params) {
> +        char **v = g_strsplit(params, ":", 2);
> +
> +        if (v[1] == NULL) {
> +            filename = g_strdup(v[0]);
> +            driver = g_strdup("file");
> +        } else {
> +            if (strcmp(v[0], "aio") == 0) {
> +                driver = g_strdup("file");
> +            } else if (strcmp(v[0], "vhd") == 0) {
> +                driver = g_strdup("vpc");
> +            } else {
> +                driver = g_strdup(v[0]);
> +            }
> +            filename = g_strdup(v[1]);
> +        }
> +
> +        g_strfreev(v);
> +    }
> +
...

> +    /* If the image is a raw file then we are done */

raw files should use the "raw" driver, so we aren't done yet.

> +    if (!strcmp(driver, "file")) {
> +        goto done;
> +    }

-- 
Anthony PERARD
