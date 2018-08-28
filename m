Received: from eggs.gnu.org ([2001:4830:134:3::10]:53083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fugIu-0005Hb-MO
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fugIr-0002ir-Dn
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:53:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fugIr-0002h2-7C
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:53:13 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-5-marcandre.lureau@redhat.com>
	<20180827045602.GF3020@xz-x1>
Date: Tue, 28 Aug 2018 17:46:29 +0200
In-Reply-To: <20180827045602.GF3020@xz-x1> (Peter Xu's message of "Mon, 27 Aug
	2018 12:56:02 +0800")
Message-ID: <87a7p6mr3e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Sat, Aug 25, 2018 at 03:57:19PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> There is no need for per-command need_resume granularity, it should
>> resume after running an non-oob command on oob-disabled monitor.
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Note that this series/patch still conflict with the "enable
> out-of-band by default" series.
>
>   [PATCH v6 00/13] monitor: enable OOB by default

Yes.

> I'm not against this patch to be merged since it has its r-b, but I
> feel like we'd better judge on whether we still like the response
> queue first, in case one day we'll need to add these things back.

Let's not worry about things that may or may not happen at some
indeterminate time in the future.

However:

> When there could be functional changes around the code path I would
> think we'd better keep the cleanup patches postponed a bit until those
> functional changes are settled.  For now the functional part is decide
> how to fix up the rest of out-of-band issues (my proposal is in the
> series above which should solve everything that is related to
> out-of-band to be fixed; if there is more, I'll continue to work on
> it), whether we should enable it by default for 3.1 (my answer
> is... yes...), and what to do with it.

I agree the important job is to finish OOB.

Sometimes, it's better to clean up first.  Sometimes, it's not.

Right now, the response queue is a useless complication, and
Marc-Andr=C3=A9's PATCH 3+4 get rid of it.  Lovely.  I understand this
conflicts with your OOB work.  The question is whether your work
fundamentally needs the response queue or not.

If your OOB work happens to be coded for the response queue, but the
problem could also be solved without the response queue, then the OOB
job doesn't fundamentally need the response queue.

Unless that's the case, getting rid of the response queue is unnecessary
churn.

If it is the case, we still need to consider effort.  Which order is
less total work?  Which order gets us to the goal faster?

Can you guys agree on answers to these questions, or do you need me to
answer them?

Restating the questions:

1. Can you think of a way to do what Peter's OOB series does, but
without the response queue?

2. If you can, what's easier / cheaper / faster:

   a. Merge Marc-Andr=C3=A9's patches to get rid of response queue, rewrite
      OOB series without response queue on top.

   b. Merge Peter's OOB series with response queue, rewrite patches to
      get rid of response queue on top.

> If we found that it's too hard to enable it by default, I'm thinking
> whether we can make it a persistent flag for monitor (maybe turning
> the "x-oob" into a real "oob" and keep it, then we don't turn it on by
> default), then we can let libvirt start working with out-of-band with
> the flag.  After all it's actually working mostly (the pending issues
> are only things like flow control for malicious/buggy clients, but
> libvirt never had such an issue with it).

The OOB job isn't complete without working flow control.  Nevertheless,
I'm willing to consider enabling OOB without working flow control.
