Received: from eggs.gnu.org ([2001:4830:134:3::10]:52031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fsKv2-00019p-NQ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 00:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fsKuy-000626-Ll
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 00:38:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46866 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fsKuy-00061g-FN
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 00:38:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B458B40216E8
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 04:38:51 +0000 (UTC)
Date: Wed, 22 Aug 2018 12:38:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180822043844.GD3324@xz-x1>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-2-peterx@redhat.com>
	<CAMxuvaxKmT_MqXOhbYbwbJo0LtuACO8wXantiMY-9VvXd=o7DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvaxKmT_MqXOhbYbwbJo0LtuACO8wXantiMY-9VvXd=o7DQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/13] monitor: simplify
 monitor_qmp_setup_handlers_bh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Aug 21, 2018 at 08:13:59PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Aug 15, 2018 at 3:37 PM, Peter Xu <peterx@redhat.com> wrote:
> > When we reach monitor_qmp_setup_handlers_bh() we must be using the
> > IOThread then, so no need to check against it any more.  Instead, we
> > assert.
> >
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> That's a clear simplification that I also found, so ack in principle.
>=20
> However, I don't understand the need of a BH in the first place.
> monitor_get_io_context() will return the iothread associated context.
> Could you explain?
> thanks

Please refer to the comment in monitor_init():

        /*
        * We can't call qemu_chr_fe_set_handlers() directly here
        * since chardev might be running in the monitor I/O
        * thread.  Schedule a bottom half.
        */
        aio_bh_schedule_oneshot(monitor_get_aio_context(),
                                monitor_qmp_setup_handlers_bh, mon);

To be more specific: in qemu_chr_fe_set_handlers() after we call
qemu_chr_be_update_read_handlers() then the iothread might already
have started to operate on the chardev, so it can race with
qemu_chr_fe_set_handlers() itself if we call it directly in the main
thread.

Regards,

--=20
Peter Xu
