Received: from eggs.gnu.org ([2001:4830:134:3::10]:49960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fb0sz-0001h3-S2
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fb0su-0004gg-Vy
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:49:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fb0su-0004er-Qh
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:49:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13856B5C5
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 09:49:08 +0000 (UTC)
Date: Thu, 5 Jul 2018 17:49:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180705094903.GA23001@xz-mi>
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-5-peterx@redhat.com>
	<87woua9iay.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87woua9iay.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] monitor: move need_resume flag into
 monitor struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Jul 05, 2018 at 10:51:33AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > It was put into the request object to show whether we'll need to resu=
me
> > the monitor after dispatching the command.  Now we move that into the
> > monitor struct so that it might be even used in other places in the
> > future, e.g., out-of-band message flow controls.
> >
> > One thing to mention is that there is no lock needed before when
> > accessing the flag since the request object will always be owned by a
> > single thread.  After we move it into monitor struct we need to prote=
ct
> > that flag since it might be accessed by multiple threads now.  Renami=
ng
> > the qmp_queue_lock into qmp_lock to protect the flag as well.
> >
> > No functional change.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> Marc-Andr=C3=A9's "[PATCH v3 04/38] monitor: no need to save need_resum=
e" and
> "[PATCH v3 05/38] monitor: further simplify previous patch" also mess
> with need_resume.  Marc-Andr=C3=A9, could you have a look at this patch=
 and
> the next one?

Sorry I should have looked at those before hand.  I think I must be
waiting for another post to split the patches into two (after
Marc-Andre poked me with that thread) but then I forgot about that.

So now I suspect we'd better keep that flag since in the next patch
the suspend operation can happen conditionally now.

Thanks,

--=20
Peter Xu
