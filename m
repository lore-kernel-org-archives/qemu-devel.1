Received: from eggs.gnu.org ([209.51.188.92]:40092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gzFAw-0002yQ-P1
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 01:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gzFAw-00074D-2S
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 01:28:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gzFAv-00072Z-R9
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 01:28:09 -0500
Date: Thu, 28 Feb 2019 14:28:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190228062803.GA7471@xz-x1>
References: <20190227164900.16378-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227164900.16378-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Cleanup during exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, alex.bennee@linaro.org

On Wed, Feb 27, 2019 at 04:49:00PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Currently we cleanup the migration object as we exit main after the
> main_loop finishes; however if there's a migration running things
> get messy and we can end up with the migration thread still trying
> to access freed structures.
> 
> We now take a ref to the object around the migration thread itself,
> so the act of dropping the ref during exit doesn't cause us to lose
> the state until the thread quits.
> 
> Cancelling the migration during migration also tries to get the thread
> to quit.
> 
> We do this a bit earlier; so hopefully migration gets out of the way
> before all the devices etc are freed.

So does it mean that even with the patch it's still possible the
migration thread will be accessing device structs that have already
been freed which can still crash QEMU?

Thanks,

-- 
Peter Xu
