Received: from eggs.gnu.org ([2001:4830:134:3::10]:54075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ekGVl-0008Hx-BC
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ekGVi-0007WG-7v
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:47:13 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1ekGVi-0007UH-0P
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:47:10 -0500
Date: Fri, 9 Feb 2018 16:47:06 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180209214706.GA3684@flamenco>
References: <20180208180019.13683-1-antonios.motakis@huawei.com>
	<20180208180019.13683-5-antonios.motakis@huawei.com>
	<20180209162233.1d191ace@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209162233.1d191ace@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 4/4] 9pfs: stat_to_qid: implement slow path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: antonios.motakis@huawei.com
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, veaceslav.falico@huawei.com, Eduard.Shishkin@huawei.com, andy.wangguoli@huawei.com, Jani.Kokkonen@huawei.com, berrange@redhat.com

On Fri, Feb 09, 2018 at 16:22:33 +0100, Greg Kurz wrote:
> On Thu, 8 Feb 2018 19:00:19 +0100
> <antonios.motakis@huawei.com> wrote:
(snip)
> >  /* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
> >   * to a unique QID path (64 bits). To avoid having to map and keep track
> >   * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
> > @@ -646,6 +695,10 @@ static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
> >  
> >      /* map inode+device to qid path (fast path) */
> >      err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
> > +    if (err == -ENFILE) {
> > +        /* fast path didn't work, fal back to full map */
> > +        err = qid_path_fullmap(pdu, stbuf, &qidp->path);
> 
> Hmm... if we have already generate QIDs with fast path, how
> can we be sure we won't collide with the ones from the full
> map ?
> 
> IIRC, Emilio had suggested to use bit 63 to distinguish between
> fast and slow path.

Yep. Antonios: did you consider that approach? For reference:
  https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05084.html

That would make the fast path faster by just using bit masks, which I
think it's a superior approach if indeed the assumption about top bits
being zero in most cases is accurate.

		Emilio
