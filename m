Received: from eggs.gnu.org ([2001:4830:134:3::10]:54383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbLJ5-00068f-8Z
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbLJ4-0001oA-6c
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:00:43 -0500
Date: Wed, 8 Feb 2017 14:00:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170208060033.GC13286@lemon.lan>
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-15-famz@redhat.com>
	<f20385ca-81d1-df52-31e5-283c0c2fac0a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f20385ca-81d1-df52-31e5-283c0c2fac0a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 14/16] file-posix: Implement image
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

On Wed, 02/08 04:05, Max Reitz wrote:
> > +static int raw_lt_write_to_write_share(RawLockTransOp op,
> > +                                       int old_lock_fd, int new_lock_fd,
> > +                                       BDRVRawLockMode old_lock,
> > +                                       BDRVRawLockMode new_lock,
> > +                                       Error **errp)
> > +{
> > +    int ret = 0;
> > +
> > +    assert(old_lock == RAW_L_WRITE);
> > +    assert(new_lock == RAW_L_WRITE_SHARE_RW);
> > +    /*
> > +     *        lock byte "no other writer"      lock byte "write"
> > +     * old                X                           X
> > +     * new                0                           S
> > +     *
> > +     * (0 = unlocked; S = shared; X = exclusive.)
> > +     */
> > +    switch (op) {
> > +    case RAW_LT_PREPARE:
> > +        break;
> > +    case RAW_LT_COMMIT:
> > +        ret = qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_WRITE, 1, false);
> > +        if (ret) {
> > +            error_report("Failed to downgrade old fd (share byte)");
> > +            break;
> > +        }
> > +        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, false);
> > +        if (ret) {
> > +            error_report("Failed to unlock new fd (share byte)");
> > +            break;
> > +        }
> 
> The second one is not an "unlock", but a new shared lock.

You are right.

> Which brings
> me to the point that both of these commands can fail and thus should be
> in the prepare path.

We cannot. If we lose the exclusive lock already in prepare, and some other
things fail later in the transaction, abort() may not be able to restore that
lock (another process took a shared lock in between).

The reason for my code is, the lock semantics implies both of these commands can
succeed, so it doesn't hurt if we ignore ret codes here. I'm just trying to
catch the very unlikely abnormalities.

> 
> (This function should be a mirror of raw_lt_write_to_read, if I'm not
> mistaken.)
> 
> > +        break;
> > +    case RAW_LT_ABORT:
> > +        break;
> > +    }
> > +    return ret;
> > +}

Fam
