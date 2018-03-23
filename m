Received: from eggs.gnu.org ([2001:4830:134:3::10]:53759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezFbh-0001oq-8N
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 01:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezFbd-0000fb-DC
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 01:51:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezFbd-0000ew-7Z
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 01:51:13 -0400
Date: Fri, 23 Mar 2018 13:50:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180323054932.GL32362@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-20-peterx@redhat.com>
	<CAJ+F1CLhE+rMrvWAAJVjsq7_hFn5sRiNiehvnnX6Z1Q9bA27iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLhE+rMrvWAAJVjsq7_hFn5sRiNiehvnnX6Z1Q9bA27iA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 19/23] qmp: isolate responses into io
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 22, 2018 at 01:00:19PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Mar 9, 2018 at 10:00 AM, Peter Xu <peterx@redhat.com> wrote:
> > For those monitors who have enabled IO thread, we'll offload the
> > responding procedure into IO thread.  The main reason is that chardev=
 is
> > not thread safe, and we need to do all the read/write IOs in the same
> > thread.  For use_io_thr=3Dtrue monitors, that thread is the IO thread=
.
>=20
> Actually, the chr write path is suppose to be somewhat thread safe
> (chr_write_lock).
>=20
> Secondly, the function responsible to write monitor data has some
> thread-safety, it's called monitor_flush_locked(), because you need
> the mon->out_lock.
>=20
> I think that patch is making things more complicated than they need to
> be. You should be able to call monitor_json_emitter/monitor_puts()
> directly from any thread, it will queue the data, start writing, and
> add a watch if necessary in the appropriate context.
>=20
> Am I missing something?

Yes there are the locks either in monitor code and chardev code to
protect write operations.  However I don't know enough to be sure of
its safety.  Considering that, having the whole chardev operations
separated into the other IOThread seems to be the only safe approach
to me for now.

Thanks,

--=20
Peter Xu
