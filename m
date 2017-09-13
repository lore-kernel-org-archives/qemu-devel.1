Received: from eggs.gnu.org ([2001:4830:134:3::10]:51124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds4uh-0006Oi-Fb
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds4uc-000166-Iq
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:28:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ds4uc-00015H-DE
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:28:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C2B1C057FA7
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:28:53 +0000 (UTC)
Date: Wed, 13 Sep 2017 18:28:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170913102842.GE3617@pxdev.xzpeter.org>
References: <1505295366-25295-1-git-send-email-peterx@redhat.com>
	<f7707221-5365-8074-7a83-ac108059aecc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7707221-5365-8074-7a83-ac108059aecc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] qtest: fix "device_del" out-of-order
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed, Sep 13, 2017 at 11:53:16AM +0200, Thomas Huth wrote:
> On 13.09.2017 11:36, Peter Xu wrote:
> > It starts from a "make check" failure on one of my private tree. The
> > problem is that when we do "device_del" we normally looking for two
> > things: one response (which is mostly empty), and a REMOVE event.  The
> > tricky point is the event can either be there before/after the empty
> > response.  So I added qmp_device_del() to make sure the order does not
> > matter, then use it where proper.
> > 
> > Since I'm at it, I also added the sister helper qmp_device_add(), it
> > helps to remove LOCs.
> 
> I've had a similar idea a couple of weeks ago, see here:
> 
> http://patchwork.ozlabs.org/patch/801487/

Good to know!

> 
> > I still don't 100% sure why my private tree can trigger this error,
> > while the master cannot. Anyway, I think this is something we should
> > have, no matter what.
> 
> Did you maybe touch the USB tests in your private tree?

No.  But I changed some internals of QMP there, I guess that's the
reason that caused the misorder to happen more easily.

> As far as I know, some test currently use QMP in a bad way, for example
> usb_test_hotplug() only checks for the DEVICE_DELETED at the end, but
> forgets to read back the final return value. That return value is then
> presented to the next part of the code that uses QMP instead ... it
> currently only works more or less by accident, but as soon as you try to
> add new code inbetween, it certainly will fail.
> ==> We really got to clean this up (either with my patch or your patch
> series).

Agree.

I think your patch is nicer on the interface (as you have mentioned in
the other reply), I can try to review it later.

However it seems that your patch didn't really solve the problem I
encountered (mis-ordered message arrivals).  It would be good if you
want to solve it together, or I can draft patch upon yours.

Thanks,

-- 
Peter Xu
