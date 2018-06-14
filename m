Received: from eggs.gnu.org ([2001:4830:134:3::10]:41673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTNtv-0005aA-O2
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTNtu-0004w1-Dy
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:46:39 -0400
Date: Thu, 14 Jun 2018 09:46:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180614084628.GL6355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180612125821.4229-1-armbru@redhat.com>
	<20180612125821.4229-13-armbru@redhat.com>
	<20180612153909.GG4355@localhost.localdomain>
	<87efha6774.fsf@dusky.pond.sub.org>
	<20180614084058.GA8564@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180614084058.GA8564@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 12/18] block-qdict: Clean up
 qdict_crumple() a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, jcody@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Thu, Jun 14, 2018 at 10:40:58AM +0200, Kevin Wolf wrote:
> Am 13.06.2018 um 17:23 hat Markus Armbruster geschrieben:
> > Kevin Wolf <kwolf@redhat.com> writes:
> > 
> > > Am 12.06.2018 um 14:58 hat Markus Armbruster geschrieben:
> > >> When you mix scalar and non-scalar keys, whether you get an "already
> > >> set as scalar" or an "already set as dict" error depends on qdict
> > >> iteration order.  Neither message makes much sense.  Replace by
> > >> ""Cannot mix scalar and non-scalar keys".  This is similar to the
> > >> message we get for mixing list and non-list keys.
> > >> 
> > >> I find qdict_crumple()'s first loop hard to understand.  Rearrange it
> > >> and add a comment.
> > >> 
> > >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > >
> > > To be honest, I found the old version of the loop more obvious.
> > >
> > >>  qobject/block-qdict.c | 42 +++++++++++++++++++++---------------------
> > >>  1 file changed, 21 insertions(+), 21 deletions(-)
> > >> 
> > >> diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
> > >> index a4e1c8d08f..35e9052816 100644
> > >> --- a/qobject/block-qdict.c
> > >> +++ b/qobject/block-qdict.c
> > >> @@ -403,7 +403,7 @@ static int qdict_is_list(QDict *maybe_list, Error **errp)
> > >>  QObject *qdict_crumple(const QDict *src, Error **errp)
> > >>  {
> > >>      const QDictEntry *ent;
> > >> -    QDict *two_level, *multi_level = NULL;
> > >> +    QDict *two_level, *multi_level = NULL, *child_dict;
> > >>      QObject *dst = NULL, *child;
> > >>      size_t i;
> > >>      char *prefix = NULL;
> > >> @@ -422,29 +422,29 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
> > >>          }
> > >>  
> > >>          qdict_split_flat_key(ent->key, &prefix, &suffix);
> > >> -
> > >>          child = qdict_get(two_level, prefix);
> > >> +        child_dict = qobject_to(QDict, child);
> > >> +
> > >> +        if (child) {
> > >> +            /*
> > >> +             * An existing child must be a dict and @ent must be a
> > >> +             * dict member (i.e. suffix not null), or else @ent
> > >> +             * clashes.
> > >> +             */
> > >> +            if (!child_dict || !suffix) {
> > >> +                error_setg(errp,
> > >> +                           "Cannot mix scalar and non-scalar keys");
> > >> +                goto error;
> > >> +            }
> > >> +        } else if (suffix) {
> > >> +            child_dict = qdict_new();
> > >> +            qdict_put(two_level, prefix, child_dict);
> > >> +        } else {
> > >> +            qdict_put_obj(two_level, prefix, qobject_ref(ent->value));
> > >> +        }
> > >
> > > At least, can you please move the else branch to the if below so that
> > > the addition of the new entry is symmetrical for both scalars and dicts?
> > > As the code is, it mixes the conflict check, creation of the child dict
> > > and addition of scalars (but not to the child dict) in a weird way in a
> > > single if block.
> > >
> > > Or maybe organise it like this:
> > >
> > > if (child && !(child_dict && suffix)) {
> > >     error
> > > }
> > >
> > > if (suffix) {
> > >     if (!child_dict) {
> > >         create it
> > >         add it to two_level
> > >     }
> > >     add entry to child_dict
> > > } else {
> > >     add entry to two_level
> > > }
> > 
> > Fleshing out...
> > 
> >         if (child && !child_dict) {
> >             /*
> >              * @prefix already exists and it's a non-dictionary,
> >              * i.e. we've seen a scalar with key @prefix.  The same
> >              * key can't occur twice, therefore suffix must be
> >              * non-null.
> >              */
> >             assert(suffix);
> >             /*
> >              * @ent has key @prefix.@suffix, but we've already seen
> >              * key @prefix: clash.
> >              */
> >             error_setg(errp, "Cannot mix scalar and non-scalar keys");
> >             goto error;
> >         }
> 
> This catches "foo.bar" after "foo", but not "foo" after "foo.bar".
> 
> >         if (suffix) {
> >             if (!child_dict) {
> >                 child_dict = qdict_new();
> >                 qdict_put(two_level, prefix, child_dict);
> >             }
> >             qdict_put_obj(child_dict, suffix, qobject_ref(ent->value));
> >         } else {
> >             assert(!child);
> 
> So "foo" after "foo.bar" would fail this assertion.

We got coverage of bad inputs in tests/check-qdict.c

If the qdict_crumple_test_bad_inputs doesn't already cover these scenarios
we should extend it to make sure we detect them during testing


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
