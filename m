Received: from eggs.gnu.org ([209.51.188.92]:34458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFya1-00087z-OW
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFya0-00063g-65
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:11:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hFyZz-00062O-0d
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:11:11 -0400
Date: Mon, 15 Apr 2019 11:11:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190415101101.GF5718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
	<20190411120421.GP3641@redhat.com>
	<219131554985898@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190411123911.GR3641@redhat.com>
	<226271554987011@iva6-8a76e93b6298.qloud-c.yandex.net>
	<243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>, Juan Quintela <quintela@redhat.com>

On Mon, Apr 15, 2019 at 12:50:08PM +0300, Yury Kotov wrote:
> Hi,
> 
> Just to clarify. I see two possible solutions:
> 
> 1) Since the migration code doesn't receive fd, it isn't responsible for
> closing it. So, it may be better to use migrate_fd_param for both
> incoming/outgoing and add dupping for migrate_fd_param. Thus, clients must
> close the fd themselves. But existing clients will have a leak.

We can't break existing clients in this way as they are correctly
using the monitor with its current semantics.

> 2) If we don't duplicate fd, then at least we should remove fd from
> the corresponding list. Therefore, the solution is to fix qemu_close to find
> the list and remove fd from it. But qemu_close is currently consistent with
> qemu_open (which opens/dups fd), so adding additional logic might not be
> a very good idea.

qemu_close is not appropriate place to deal with something speciifc
to the montor.

> I don't see any other solution, but I might miss something.
> What do you think?

All callers of monitor_get_fd() will close() the FD they get back.
Thus monitor_get_fd() should remove it from the list when it returns
it, and we should add API docs to monitor_get_fd() to explain this.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
