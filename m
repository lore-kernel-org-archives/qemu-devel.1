Received: from eggs.gnu.org ([2001:4830:134:3::10]:46170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dI3nM-0007YL-2q
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dI3nH-0004qW-8z
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dI3nH-0004q2-2e
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:00:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4CD180C11
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 02:00:25 +0000 (UTC)
Date: Tue, 6 Jun 2017 10:00:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170606020021.GJ4056@pxdev.xzpeter.org>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-5-git-send-email-peterx@redhat.com>
	<d74b1067-d582-78af-d849-8d8b7b837dcf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d74b1067-d582-78af-d849-8d8b7b837dcf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 4/6] migration: shut src return path
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Mon, Jun 05, 2017 at 03:22:24PM -0500, Eric Blake wrote:
> On 05/19/2017 01:43 AM, Peter Xu wrote:
> > We were do the shutting off only for postcopy. Now we do this as long as
> > the source return path is there.
> > 
> > Moving the cleanup of from_src_file there too.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c    | 8 +++++++-
> >  migration/postcopy-ram.c | 1 -
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> This commit causes a regression in qemu-iotests 68:
> 
> $ cd tests/qemu-iotests
> $ ./check -qcow2 68
> ...
> 068 1s ... - output mismatch (see 068.out.bad)
> --- /home/eblake/qemu-tmp2/tests/qemu-iotests/068.out	2017-05-30
> 09:27:26.795821748 -0500
> +++ 068.out.bad	2017-06-05 15:21:18.566816816 -0500
> @@ -6,6 +6,8 @@
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm 0
>  (qemu) quit
> +./common.config: line 107:  1912 Segmentation fault      (core dumped)
> ( if [ -n "${QEMU_NEED_PID}" ]; then
> +    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
> +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) quit
> -*** done
> +(qemu) *** done
> Failures: 068
> Failed 1 of 1 tests
> 
> I didn't investigate further; but am hoping you'll be able to fix the
> segfault and get the test working again.

Sorry for that! I will have a look.

-- 
Peter Xu
