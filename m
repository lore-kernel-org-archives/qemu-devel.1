Received: from eggs.gnu.org ([2001:4830:134:3::10]:55586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVI12-0005N6-C5
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVI0z-0004Av-1k
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:26:08 -0500
Date: Fri, 7 Dec 2018 15:26:01 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207152601.GH18875@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-4-git-send-email-paul.durrant@citrix.com>
	<20181207143525.GF18875@perard.uk.xensource.com>
	<ce9a0cbaa69c42c084e40b96c4d01c26@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ce9a0cbaa69c42c084e40b96c4d01c26@AMSPEX02CL03.citrite.net>
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
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Fri, Dec 07, 2018 at 02:39:40PM +0000, Paul Durrant wrote:
> > -----Original Message-----
> > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > Sent: 07 December 2018 14:35
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> > devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> > <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> > Subject: Re: [PATCH v2 03/18] xen: introduce 'xen-block', 'xen-disk' and
> > 'xen-cdrom'
> > 
> > On Thu, Dec 06, 2018 at 03:08:29PM +0000, Paul Durrant wrote:
> > > +static char *disk_to_vbd_name(unsigned int disk)
> > > +{
> > > +    char *name, *prefix = (disk >= 26) ?
> > > +        disk_to_vbd_name((disk / 26) - 1) : g_strdup("");
> > > +
> > > +    name = g_strdup_printf("%s%c", prefix, 'a' + disk);
> > 
> > I don't think that works, if disk is 27, we do ('a' + 27) here. It's
> > probably missing a `disk % 26`.
> 
> Damn, yes I was not allowing the >2 letters.
> 
> > 
> > > +    g_free(prefix);
> > > +
> > > +    return name;
> > > +}
> > 
> > [...]
> > 
> > > +static unsigned int vbd_name_to_disk(const char *name, const char
> > **endp)
> > > +{
> > > +    unsigned int disk = 0;
> > > +
> > > +    while (*name != '\0') {
> > > +        if (!g_ascii_isalpha(*name) || !g_ascii_islower(*name)) {
> > > +            break;
> > > +        }
> > > +
> > > +        disk *= 26;
> > > +        disk += *name++ - 'a';
> > > +    }
> > > +    *endp = name;
> > > +
> > > +    return disk;
> > > +}
> > > +
> > > +static void xen_block_set_vdev(Object *obj, Visitor *v, const char
> > *name,
> > > +                               void *opaque, Error **errp)
> > > +{
> > 
> > Setting vdev doesn't work. I've tried to add a disk `xvdaa', and it
> > result in `xvda', or `d0p0' (in the trace). (Same result with `xvdaaa',
> > and 'xvdba' gives 'xvdaa'/d26p0)
> > 
> 
> Ok, that's weird. I'll have to figure that out.

It's probably because 'a' is somtime 0 and sometime is 1.

'a' should be 0
'aa' should be 26,
'aaa' Seems to be 702.

'xvda': 0     ->                     0 * 1
'xvdz': 25    ->                    25 * 1
'xvdaa': 26   ->            1 * 26 + 0 * 1
'xvdaaa': 702 -> 1 * 26^2 + 1 * 26 + 0 * 1

So, it's weird. Have fun fixing the algorithm for that.

-- 
Anthony PERARD
