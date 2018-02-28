Received: from eggs.gnu.org ([2001:4830:134:3::10]:43083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1er1Mq-00037w-QD
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1er1Mm-00064g-TI
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:01:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1er1Mm-00064J-OH
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:01:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B894402291E
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 13:01:48 +0000 (UTC)
Date: Wed, 28 Feb 2018 21:01:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180228130136.GJ27381@xz-mi>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-4-peterx@redhat.com>
	<20180228090845.GB31550@redhat.com> <20180228124424.GG27381@xz-mi>
	<20180228124743.GG17774@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228124743.GG17774@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/14] qio: introduce
 qio_channel_add_watch_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 28, 2018 at 12:47:43PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 28, 2018 at 08:44:24PM +0800, Peter Xu wrote:
> > On Wed, Feb 28, 2018 at 09:08:45AM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > On Wed, Feb 28, 2018 at 01:06:22PM +0800, Peter Xu wrote:
> > > > It's a more powerful version of qio_channel_add_watch(), which su=
pports
> > > > non-default gcontext.  It's stripped from the old one, then we ha=
ve
> > > > g_source_get_id() to fetch the tag ID to keep the old interface.
> > > >=20
> > > > Note that the new API will return a gsource, meanwhile keep a ref=
erence
> > > > of it so that callers need to unref them explicitly.
> > >=20
> > > I don't really like this. Having qio_channel_add_watch and
> > > qio_channel_add_watch_full with differing return values is
> > > really very surprising. They should be functionally identical,
> > > except for the extra context arg.
> >=20
> > Yeah it's not nice, but I do need the GSource and the tag ID does not
> > help in the series.
> >=20
> > An alternative would be that I modify qio_channel_add_watch() to
> > return GSource too.  Is there an third choice that you could suggest?
>=20
> Given you have the id + GMainContext you can just acquire the GSource,
> if needed, using g_main_context_find_source_by_id.

I always feel unsafe to play around with tag IDs since the IDs can
change after GSource removed and new GSource added, and also the
result of the call will depend on a correct pairing of context (so if
the context is incorrect, instead of failure, we possibly got
everything screwed up while we never know we failed...).

But indeed for this one it seems pretty safe if I call
g_main_context_find_source_by_id() right after I call
qio_channel_add_watch_full() to fetch the GSource.  If you agree, I
can use this approach in my next post.  Thanks,

--=20
Peter Xu
