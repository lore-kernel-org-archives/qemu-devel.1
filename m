Received: from eggs.gnu.org ([2001:4830:134:3::10]:35917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fu9ZZ-0003hV-9E
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fu9ZU-0000hn-9n
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:56:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fu9ZU-0000hV-4q
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:56:12 -0400
Date: Mon, 27 Aug 2018 12:56:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180827045602.GF3020@xz-x1>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180825135724.8981-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/9] monitor: no need to save need_resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Sat, Aug 25, 2018 at 03:57:19PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> There is no need for per-command need_resume granularity, it should
> resume after running an non-oob command on oob-disabled monitor.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Note that this series/patch still conflict with the "enable
out-of-band by default" series.

  [PATCH v6 00/13] monitor: enable OOB by default

I'm not against this patch to be merged since it has its r-b, but I
feel like we'd better judge on whether we still like the response
queue first, in case one day we'll need to add these things back.

When there could be functional changes around the code path I would
think we'd better keep the cleanup patches postponed a bit until those
functional changes are settled.  For now the functional part is decide
how to fix up the rest of out-of-band issues (my proposal is in the
series above which should solve everything that is related to
out-of-band to be fixed; if there is more, I'll continue to work on
it), whether we should enable it by default for 3.1 (my answer
is... yes...), and what to do with it.

If we found that it's too hard to enable it by default, I'm thinking
whether we can make it a persistent flag for monitor (maybe turning
the "x-oob" into a real "oob" and keep it, then we don't turn it on by
default), then we can let libvirt start working with out-of-band with
the flag.  After all it's actually working mostly (the pending issues
are only things like flow control for malicious/buggy clients, but
libvirt never had such an issue with it).

Regards,

--=20
Peter Xu
