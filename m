Received: from eggs.gnu.org ([2001:4830:134:3::10]:35818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUoK-0003f1-MU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXUoJ-0005pi-D9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:53:20 -0400
Date: Tue, 18 Jul 2017 16:53:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718155306.GP11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-6-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500385286-21142-6-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 05/10] block: Use JSON null
 instead of "" to disable backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

On Tue, Jul 18, 2017 at 03:41:21PM +0200, Markus Armbruster wrote:
> BlockdevRef is an alternate of BlockdevOptions (inline definition) and
> str (reference to an existing block device by name).  BlockdevRef
> value "" is special: "no block device should be referenced."  It's
> actually interpreted that way in just one place: optional member
> @backing of COW formats.  Semantics:
> 
> * Present means "use this block device" as backing storage
> 
> * Absent means "default to the one stored in the image"
> 
> * Except "" means "don't use backing storage at all"
> 
> The first two are perfectly normal: when the parameter is absent, it
> defaults to an implied value, but the value's meaning is the same.
> 
> The third one overloads the parameter with a second meaning.  The
> overloading is *implicit*, i.e. it's not visible in the types.  Works
> here, because "" is not a value block device ID.
> 
> Pressing argument values the schema accepts, but are semantically
> invalid, into service to mean "do something else entirely" is not
> general, as suitable invalid values need not exist.  I also find it
> ugly.
> 
> To clean this up, we could add a separate flag argument to suppress
> @backing, or add a distinct value to @backing.  This commit implements
> the latter: add JSON null to the values of @backing, deprecate "".
> 
> Because we're so close to the 2.10 freeze, implement it in the
> stupidest way possible: have qmp_blockdev_add() rewrite null to ""
> before anything else can see the null.  Works, because BlockdevRef
> occurs only within arguments of blockdev-add.  The proper way to do it
> would be rewriting "" to null, preferably in a cleaner way, but that
> requires fixing up code to work with null.  Add a TODO comment for
> that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  blockdev.c             | 14 ++++++++++++++
>  qapi/block-core.json   | 29 ++++++++++++++++++++++-------
>  tests/qemu-iotests/085 |  2 +-
>  tests/qemu-iotests/139 |  2 +-
>  4 files changed, 38 insertions(+), 9 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


> 
> diff --git a/blockdev.c b/blockdev.c
> index 9c6dd27..1c42699 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3886,6 +3886,7 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
>      QObject *obj;
>      Visitor *v = qobject_output_visitor_new(&obj);
>      QDict *qdict;
> +    const QDictEntry *ent;
>      Error *local_err = NULL;
>  
>      visit_type_BlockdevOptions(v, NULL, &options, &local_err);
> @@ -3899,6 +3900,19 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
>  
>      qdict_flatten(qdict);
>  
> +    /*
> +     * Rewrite "backing": null to "backing": ""
> +     * TODO Rewrite "" to null instead, and perhaps not even here
> +     */
> +    for (ent = qdict_first(qdict); ent; ent = qdict_next(qdict, ent)) {
> +        char *dot = strrchr(ent->key, '.');
> +
> +        if (!strcmp(dot ? dot + 1 : ent->key, "backing")
> +            && qobject_type(ent->value) == QTYPE_QNULL) {
> +            qdict_put(qdict, ent->key, qstring_new());
> +        }
> +    }

I find it a little yucky that we're modifying the qdict, rather than
the original "options" object, but I guess this is simpler for a quick
hack



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
