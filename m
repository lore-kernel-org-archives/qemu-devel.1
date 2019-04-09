Received: from eggs.gnu.org ([209.51.188.92]:42132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDrOv-0003gd-OW
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDrOu-0004pC-M8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:07:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hDrOs-0004la-7p
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:06:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id c1so2283232wml.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 07:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180326150916.9602-36-marcandre.lureau@redhat.com>
	<20180412144814.GH2704@work-vm>
In-Reply-To: <20180412144814.GH2704@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Apr 2019 16:06:42 +0200
Message-ID: <CAJ+F1CLQ=UBWHQnHSZPu2Gtjbbd66DHsF+D-T5rn1dhT0+TCHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 35/38] console: make screendump
 asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Thu, Apr 12, 2018 at 4:49 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > Make screendump asynchronous to provide correct screendumps.
> >
> > HMP doesn't have async support, so it has to remain synchronous and
> > potentially incorrect to avoid potential races.
> >
> > Fixes:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>   Looking at this and the previous pair of patches, I think we'd be
> better if we defined that async commands took a callback function
> pointer and data that they call.
>
>   Here we've got 'graphic_hw_update_done' that explicitly walks qmp
> lists; but I think it's better just to pass graphic_hw_update() the
> completion data together with a callback function and it calls that when
> it's done.

The calling context is in QmpReturn: it will handle further dispatch
on the associated session (it has the associated cb+data, if you
will).

gfx_update_async() doesn't have cb+data to associate the call with a
finish handler. Further down, spice doesn't keep the request "context"
either. All it does is call graphic_hw_update_done() when update is
finished, that's why we walk the list of pending screendumps here.

We could move the pending list of async screendumps down to spice (and
other console renderers), but that would make the code more
complicated & duplicated for no strong reason.

>
> (Also isn't it a little bit of a race, calling graphic_hw_update() and
> *then* adding the entry to the list? Can't it end up calling the _done()
> before we've added it to the list).

Yes, in theory it could. In practice that won't happen today, but we
may change things later and not realize we "broke" screendump. So I
will rearrange the code to add it to the pending list before calling
graphic_hw_update().


>
> Also, do we need a list of outstanding screendumps, or should we just
> have a list of async commands.

We have both, mostly for simplicity and flexibility reasons. If we
removed the outstanding screendump list, we would have to query it
from the session.

Thanks for the review, I'll send an update revision.


--
Marc-Andr=C3=A9 Lureau
