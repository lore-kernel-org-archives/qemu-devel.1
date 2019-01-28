Received: from eggs.gnu.org ([209.51.188.92]:49874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=924f879ed=tim.smith@citrix.com>)
	id 1goA7w-0000hB-V8
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=924f879ed=tim.smith@citrix.com>)
	id 1goA7v-0002xE-Tq
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:51:16 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:26422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=924f879ed=tim.smith@citrix.com>)
	id 1goA7v-0002vi-KL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:51:15 -0500
From: Tim Smith <tim.smith@citrix.com>
Date: Mon, 28 Jan 2019 16:50:31 +0000
Message-ID: <3048424.2nWJ6aN5el@dhcp-3-135.uk.xensource.com>
In-Reply-To: <23d84b3a-f4ac-07e0-5ce2-f86ec899cc2c@virtuozzo.com>
References: <1914320.zObNlfPuOX@dhcp-3-135.uk.xensource.com>
	<23d84b3a-f4ac-07e0-5ce2-f86ec899cc2c@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Qemu-devel] Very slow finding extents in QCOW2-backed nbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Monday, 28 January 2019 14:41:35 GMT Vladimir Sementsov-Ogievskiy wrote:
> 28.01.2019 14:58, Tim Smith wrote:
> 
> > Hi all, I have a question about the intent of the last call to
> > bdrv_co_block_status() in bdrv_co_block_status(), in block/io.c about
> > line
> > 2195, which looks like this:
> > 
> > 
> >          ret2 = bdrv_co_block_status(local_file, want_zero, local_map,
> >          
> >                                      *pnum, &file_pnum, NULL, NULL);
> >          
> >          if (ret2 >= 0) {
> >          
> >              /* Ignore errors.  This is just providing extra information,
> >              it
> >              
> >               * is useful but not necessary.
> >               */
> 
> 
> Hi Tim!
> 
> The question is highly discussed now on list, in short: yes it's a problem,
> and, I hope, we'll soon reach a consensus about how to finally fix it. 
> This second block_status request is needed when we have qcow2 image with
> metadata preallocation, which means that qcow2 data clusters are actually
> backed by holes on filesystem level.
> 
> You can follow the discussion under the following threads:
> 
> initial discussion:
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05749.html
> 
> solutions:
> 
> cache lseek results, by Kevin:
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06271.html
> 
> detect preallocation, and don't do second block_status for not
> preallocated, my last try:
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06598.html

Thanks, I'll keep an eye on these. My use-case does not require preallocation 
so I'll carry a patch for a bit and see how it works out.

-- 
Tim Smith <tim.smith@citrix.com>
