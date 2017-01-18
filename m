Received: from eggs.gnu.org ([2001:4830:134:3::10]:52452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTq8s-0002l2-Lh
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTq8r-0007Uo-ON
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:19:10 -0500
Date: Wed, 18 Jan 2017 21:19:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170118131900.GG6199@lemon>
References: <1477928314-11184-1-git-send-email-famz@redhat.com>
	<1477928314-11184-14-git-send-email-famz@redhat.com>
	<2acb8480-8e7d-1d47-4f8b-0d9b68c37884@redhat.com>
	<20170118104825.GF6199@lemon>
	<611793e4-fc6d-1ccf-0e15-e52a56a224f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611793e4-fc6d-1ccf-0e15-e52a56a224f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/14] raw-posix: Implement image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

On Wed, 01/18 14:02, Max Reitz wrote:
> >> Testing whether something is locked would be easier by using F_OFD_GETLK
> >> instead of actually creating an exclusive lock and then releasing it.
> > 
> > My attempt to do this shows it doesn't work: fcntl forces the tested lock type
> > to read lock for some unknown reason, so it cannot be used to test other shared
> > lockers.
> 
> Do you have a reproducer? The attached quick and dirty test case works
> for me (compile test.c to test and test2.c to test2), producing the
> following output (when running ./test):
> 
> set rd lock: 0, Success
> get lock: 0, Success; read lock in place
> set wr lock: -1, Resource temporarily unavailable
> unset lock: 0, Resource temporarily unavailable
> ===
> unset lock: 0, Success
> get lock: 0, Success; unlocked
> set wr lock: 0, Success
> unset lock: 0, Success
> ===
> set wr lock: 0, Success
> get lock: 0, Success; write lock in place
> set wr lock: -1, Resource temporarily unavailable
> unset lock: 0, Resource temporarily unavailable

You are right, now I see why I was confused with the F_OFD_GETLK interface.

Fam

> 
> So the l_type field is correctly set after every F_OFD_GETLK query call.
> 
> Max
