Received: from eggs.gnu.org ([2001:4830:134:3::10]:34213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cRduH-0007wr-Cy
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cRdu8-0008M1-JG
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:51:01 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:33405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cRdu8-0008LN-Di
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:50:52 -0500
Received: by mail-oi0-x22b.google.com with SMTP id w204so19896874oiw.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 03:50:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170112121623.6b92a336@bahia.lan>
References: <1483981368-9965-1-git-send-email-ashijeetacharya@gmail.com>
	<1483981368-9965-5-git-send-email-ashijeetacharya@gmail.com>
	<CAFEAcA_jcWo+mJ=3FLgx_R7QEvZ9NeTp-RhYZF4nczY-FViySg@mail.gmail.com>
	<CAC2QTZYnL--Uyab7mmnzUQjE6UFWJWqJq2kBdxBbtef2Mpp7Tg@mail.gmail.com>
	<20170112121623.6b92a336@bahia.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 12 Jan 2017 17:20:50 +0530
Message-ID: <CAC2QTZa_-25T+yMzGyEUWNhGROzWeiy6rUqCbStk-=FWSOcM0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 4/4] migration: Fail migration blocker
 for --only-migratble
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thursday, 12 January 2017, Greg Kurz <groug@kaod.org> wrote:

> On Thu, 12 Jan 2017 16:15:28 +0530
> Ashijeet Acharya <ashijeetacharya@gmail.com <javascript:;>> wrote:
>
> > On Tuesday, 10 January 2017, Peter Maydell <peter.maydell@linaro.org
> <javascript:;>> wrote:
> >
> > > On 9 January 2017 at 17:02, Ashijeet Acharya <
> ashijeetacharya@gmail.com <javascript:;>
> > > <javascript:;>> wrote:
> > > > migrate_add_blocker should rightly fail if the '--only-migratable'
> > > > option was specified and the device in use should not be able to
> > > > perform the action which results in an unmigratable VM.
> > > >
> > > > Make migrate_add_blocker return -EACCES in this case.
> > >
> > > > diff --git a/block/qcow.c b/block/qcow.c
> > > > index 11526a1..bdc6446 100644
> > > > --- a/block/qcow.c
> > > > +++ b/block/qcow.c
> > > > @@ -254,7 +254,10 @@ static int qcow_open(BlockDriverState *bs, QDict
> > > *options, int flags,
> > > >                 bdrv_get_device_or_node_name(bs));
> > > >      ret = migrate_add_blocker(s->migration_blocker, errp);
> > > >      if (ret < 0) {
> > > > -        error_free(s->migration_blocker);
> > > > +        if (ret == -EACCES) {
> > > > +            error_append_hint(errp, "Cannot use a node with qcow
> format
> > > as "
> > > > +                              "it does not support live migration");
> > > > +        }
> > > >          goto fail;
> > > >      }
> > > >
> > >
> > > The error handling for these call sites should look just like
> > > that for any other function call that takes an Error**:
> > >
> > >     Error *local_err = NULL;
> > >     [...]
> > >     migrate_add_blocker(s->migration_blocker, &local_err);
> > >     if (local_err) {
> > >         error_propagate(errp, local_err);
> > >         return; // or otherwise handle failure appropriately
> > >     }
> >
> >
> > One more reason Peter I found for returning an error value is that in
> cases
> > like 9pfs where we do not set errp inside migrate_add_blocker() (as
> > suggested by Greg) and other similar ones where we pass NULL for errp, we
> > cannot rely on checking for
> > "if (local_err)" as it will never be set and always be NULL.
> > Thus we will never fail appropriately at the caller sites when we fail to
> > add migration blocker.
> > Sounds right?
> >
>
> The need for 9pfs is just to return an error to the guest, which will end
> up being the errno for the failed mount(). And we don't want to print out
> any error message to avoid a stupid guest to fill the QEMU log in case it
> would loop over mount().


Yes, I completely understood that earlier :-)
I had a doubt further because atm I was passing NULL as an argument i.e.

migrate_add_blocker(s->migration_blocker, NULL);

which is why the whole 'local_err being returned as  NULL' situation
arrived. But I will make it pass &local_err now.

Still, I think we need to return an error value from migrate_add_blocker()
to avoid setting it manually and also avoid repetition of code at call
sites.

>
> The only reason I see for migration_add_blocker() to return an error
> would be to differentiate between the --only-migratable and the migration
> in progress cases... But honestly, I don't care that much and something
> like the following would be perfectly ok:
>
>     Error *local_err = NULL;
>     [...]
>     migrate_add_blocker(s->migration_blocker, &local_err);
>     if (local_err) {
>         error_free(local_err);
>         err = -EBUSY
>         goto out_nofid;
>     }
>
> Maybe yes, if everyone is okay with the same error value being set in both
the cases, then I will submit the patches like you proposed above :-)

Ashijeet
