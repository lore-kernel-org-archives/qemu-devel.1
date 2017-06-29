Received: from eggs.gnu.org ([2001:4830:134:3::10]:33921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQQ7o-0005qq-7z
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQQ7l-0007gz-3J
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQQ7k-0007gQ-TX
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:28:09 -0400
Date: Thu, 29 Jun 2017 11:28:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170629032802.GD32268@pxdev.xzpeter.org>
References: <1498654172-26570-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170628125232eucas1p1af5a7b0d734c7af25a20981e25812ee2@eucas1p1.samsung.com>
	<1498654172-26570-4-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498654172-26570-4-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v6 3/3] migration: add bitmap for received
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

On Wed, Jun 28, 2017 at 08:49:32AM -0400, Alexey Perevalov wrote:

[...]

> @@ -2324,8 +2352,14 @@ static int ram_load_setup(QEMUFile *f, void *opaque)

[1]

>  
>  static int ram_load_cleanup(void *opaque)
>  {
> +    RAMBlock *rb;
>      xbzrle_load_cleanup();
>      compress_threads_load_cleanup();
> +
> +    RAMBLOCK_FOREACH(rb) {
> +        g_free(rb->receivedmap);
> +        rb->receivedmap = NULL;
> +    }
>      return 0;
>  }

Can we put init into ram_load_setup()? (I don't have the codes, but I
see this function above at [1], I suppose it'll be called on dest side
before migration really starts?)

Sorry for my harshness, but this just looks weird. I am not asking
that we _must_ put it somewhere outside RAM codes, but at least I
think they should be paired. If you cleanup the bitmap in RAM code,
why not you init it in RAM code as well? Did I miss anything again?

-- 
Peter Xu
