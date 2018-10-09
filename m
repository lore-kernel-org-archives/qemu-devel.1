Received: from eggs.gnu.org ([2001:4830:134:3::10]:34638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9nKH-0001zt-0U
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 04:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9nKE-0002PV-SL
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 04:25:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9nKD-0002Mr-3E
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 04:25:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id i8-v6so897361wmg.0
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 01:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-5-marcandre.lureau@redhat.com>
	<96e94552-5875-24dd-04ff-e0a73cfa923c@redhat.com>
In-Reply-To: <96e94552-5875-24dd-04ff-e0a73cfa923c@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 12:24:48 +0400
Message-ID: <CAJ+F1C+zDF+1Jdxgkg5+h=Lz_txw1wD7GgpWCt2UsTf3BRFmGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/12] qemu-option: improve
 qemu_opts_print_help() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

Hi

On Tue, Oct 9, 2018 at 2:03 AM Max Reitz <mreitz@redhat.com> wrote:
>
> First of all, this patch broke iotest 082.  But then again, all that'd
> be needed is a correction of the reference output.

Oops, ok. Let see if we change it again,

>
> However:
>
> On 07.09.18 09:59, Marc-Andr=C3=A9 Lureau wrote:
> > Modify qemu_opts_print_help():
> > - to print expected argument type
> > - skip description if not available
> > - sort lines
> > - prefix with the list name (like qdev, to avoid confusion)
>
> Is this really useful?  My main issue right now is this:
>
> $ qemu-img amend -f qcow2 -o help
> Creation options for 'qcow2':
> qcow2-create-opts.backing_file=3Dstr - File name of a base image
> qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
> qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
> [...]
>
> (The reason create is not affected is because it copies the options into
> a new list.)

I didn't realize this would change qemu-img help in such a way (I
checked create output, my bad...).

>
> This is supposed to be a human-readable output.  I don't see how the
> rather internal list name[1] really helps here.
>
> ([1] I suppose if you write a configuration file, these identifiers
> become visible.  But you don't use "help" in a configuration file, so I
> find that point becomes rather moot.)
>
> So this is why I don't think it is a good idea to print this name.
>
> Now if it helped to prevent confusion, OK, but without further
> explanation I don't see how.  Is this because I can use "help" in places
> where it's unclear to the user what exactly the "help" refers to?

I think that's one of the reason why the original qdev help did prefix
with the class/driver name. Although in practice, it exit() after, so
I am not sure it's really helpeful (unless there is some help that can
be printed before?).

Another reason to want the prefix is to be close to the -global
syntax. Again, probably not worthwhile.


> Also, this is bikeshedding, but still, I don't like the dot notation
> here.  It doesn't mean anything (I can't use
> "qcow2-create-opts.backing_file", nor can I use
> "virtio-blk-pci.iothread"), so I'd prefer a nice "human" prefix like
> "(qcow2-create-opts) backing_file" or "qcow2-create-opts: ".
>
> Actually, I don't like the whole notation.  It looks like code.  Here is
> an excerpt from -device virtio-blk-pci,help:
>
> virtio-blk-pci.iothread=3Dlink<iothread>
> virtio-blk-pci.request-merging=3Dbool (on/off)
> virtio-blk-pci.logical_block_size=3Duint16 (A power of two between 512 an=
d
> 32768)
>
> I can imagine some ways this would be more readable to human users (and
> I don't think ease of parsing is a high priority here), for instance:
>
> virtio-blk-pci options:
> iothread: link to object of type iothread
> request-merging: bool (on/off)
> logical_block_size: uint16 (A power of two between 512 and 32768)
>

That would be fine for me.

> (But it appears that transforming "link<iothread>" to something readable
> wouldn't be easy.  Though then again, I really think it's unreadable
> unless you know what it's supposed to mean.)
>
>
> So my concrete requests are this:
>
> 1. If the ID is really useful, I would put it above the whole list in an
> own line.  It's not useful to human readers to re-print it on every
> single line.  It would be nice to have an option to disable this line,
> however, if the caller has already printed something along the lines
> (which qemu-img amend does).
>
> 2. Put some more whitespace into the whole thing, and make it less
> robot-y overall.  I much prefer ": " when reading over "=3D" (even
> programming languages do when it's about types, in fact).
>
>
> I'm not writing a patch yet because maybe there is some reason to print
> the ID on every single line.  So I'm just proposing first.

I think we have stronger reasons to want it remove now.

Feel free to send a patch

thanks

>
> Max
>
> > - drop 16-chars alignment, use a '-' as seperator for option name and
> >   description
> >
> > For ex, "-spice help" output is changed from:
> >
> > port             No description available
> > tls-port         No description available
> > addr             No description available
> > [...]
> > gl               No description available
> > rendernode       No description available
> >
> > to:
> >
> > spice.addr=3Dstr
> > spice.agent-mouse=3Dbool (on/off)
> > spice.disable-agent-file-xfer=3Dbool (on/off)
> > [...]
> > spice.x509-key-password=3Dstr
> > spice.zlib-glz-wan-compression=3Dstr
> >
> > "qemu-img create -f qcow2 -o help", changed from:
> >
> > size             Virtual disk size
> > compat           Compatibility level (0.10 or 1.1)
> > backing_file     File name of a base image
> > [...]
> > lazy_refcounts   Postpone refcount updates
> > refcount_bits    Width of a reference count entry in bits
> >
> > to:
> >
> > backing_file=3Dstr - File name of a base image
> > backing_fmt=3Dstr - Image format of the base image
> > cluster_size=3Dsize - qcow2 cluster size
> > [...]
> > refcount_bits=3Dnum - Width of a reference count entry in bits
> > size=3Dsize - Virtual disk size
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> >  util/qemu-option.c | 38 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/util/qemu-option.c b/util/qemu-option.c
> > index 557b6c6626..069de36d2c 100644
> > --- a/util/qemu-option.c
> > +++ b/util/qemu-option.c
> > @@ -208,17 +208,51 @@ out:
> >      return result;
> >  }
> >
> > +static const char *opt_type_to_string(enum QemuOptType type)
> > +{
> > +    switch (type) {
> > +    case QEMU_OPT_STRING:
> > +        return "str";
> > +    case QEMU_OPT_BOOL:
> > +        return "bool (on/off)";
> > +    case QEMU_OPT_NUMBER:
> > +        return "num";
> > +    case QEMU_OPT_SIZE:
> > +        return "size";
> > +    }
> > +
> > +    g_assert_not_reached();
> > +}
> > +
> >  void qemu_opts_print_help(QemuOptsList *list)
> >  {
> >      QemuOptDesc *desc;
> > +    int i;
> > +    GPtrArray *array =3D g_ptr_array_new();
> >
> >      assert(list);
> >      desc =3D list->desc;
> >      while (desc && desc->name) {
> > -        printf("%-16s %s\n", desc->name,
> > -               desc->help ? desc->help : "No description available");
> > +        GString *str =3D g_string_new(NULL);
> > +        if (list->name) {
> > +            g_string_append_printf(str, "%s.", list->name);
> > +        }
> > +        g_string_append_printf(str, "%s=3D%s", desc->name,
> > +                               opt_type_to_string(desc->type));
> > +        if (desc->help) {
> > +            g_string_append_printf(str, " - %s", desc->help);
> > +        }
> > +        g_ptr_array_add(array, g_string_free(str, false));
> >          desc++;
> >      }
> > +
> > +    g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp);
> > +    for (i =3D 0; i < array->len; i++) {
> > +        printf("%s\n", (char *)array->pdata[i]);
> > +    }
> > +    g_ptr_array_set_free_func(array, g_free);
> > +    g_ptr_array_free(array, true);
> > +
> >  }
> >  /* ------------------------------------------------------------------ =
*/
> >
> >
>
>


--=20
Marc-Andr=C3=A9 Lureau
