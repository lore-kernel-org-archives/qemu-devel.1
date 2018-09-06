Received: from eggs.gnu.org ([2001:4830:134:3::10]:47766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fxx7u-0004Qr-Fb
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fxx7t-0006EZ-Ef
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:27:26 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fxx7t-0006E9-7B
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:27:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id w11-v6so12078433wrc.5
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 09:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180906151227.25514-1-marcandre.lureau@redhat.com>
	<20180906151227.25514-11-marcandre.lureau@redhat.com>
	<02fe751d-661d-04ab-44ba-caf3469eebcd@redhat.com>
In-Reply-To: <02fe751d-661d-04ab-44ba-caf3469eebcd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Sep 2018 20:27:11 +0400
Message-ID: <CAJ+F1C+rXupKahjD5rDDfxKKg7iw9z7EhGqyyk=S3x6vVKi+pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/10] vl: list user creatable propeties if
 '?' as argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>

Hi

On Thu, Sep 6, 2018 at 7:40 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 09/06/2018 10:12 AM, Marc-Andr=C3=A9 Lureau wrote:
>
> Subject has typo and awkward grammar; I'd suggest:
>
> vl: list user creatable properties when 'help' is argument
>
> > Iterate over the writable class properties, sort and print them out
> > with the description if available.
> >
> > Ex: qemu -object memory-backend-memfd,?
>
> As elsewhere in the series, s/\?/help/
>
> > memory-backend-memfd.dump=3Dbool (Set to 'off' to exclude from core dum=
p)
> > memory-backend-memfd.host-nodes=3Dint (Binds memory to the list of NUMA=
 host nodes)
> > memory-backend-memfd.hugetlb=3Dbool (Use huge pages)
> > memory-backend-memfd.hugetlbsize=3Dint (Huge pages size (ex: 2M, 1G))
> > memory-backend-memfd.merge=3Dbool (Mark memory as mergeable)
> > memory-backend-memfd.policy=3DHostMemPolicy (Set the NUMA policy)
> > memory-backend-memfd.prealloc=3Dbool (Preallocate memory)
> > memory-backend-memfd.seal=3Dbool (Seal growing & shrinking)
> > memory-backend-memfd.share=3Dbool (Mark the memory as private to QEMU o=
r shared)
> > memory-backend-memfd.size=3Dint (Size of the memory region (ex: 500M))
>
> Why "name=3Dtype (text)" here, but "name=3Dtype - text" in 2/10?
> Consistency would be nice.

We use name=3Dtype (text) for devices properties, ex:

qemu-system-x86_64 -device tpm-tis,?
tpm-tis.tpmdev=3Dstr (ID of a tpm to use as a backend)
tpm-tis.irq=3Duint32
tpm-tis.tpm-tis-mmio[0]=3Dchild<qemu:memory-region>

But
qemu-img create -f qcow2 -o ?

    size             Virtual disk size
    compat           Compatibility level (0.10 or 1.1)
    backing_file     File name of a base image

I think I like more "name=3Dtype - text" form I introduced in "improve
qemu_opts_print_help() output". I guess I should change device
properties help for consistency then.

> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   qom/object_interfaces.c |  6 +++---
> >   vl.c                    | 45 ++++++++++++++++++++++++++++++++++++++--=
-
> >   2 files changed, 45 insertions(+), 6 deletions(-)
> >
>
> > +++ b/vl.c
> > @@ -2721,6 +2721,11 @@ static int machine_set_property(void *opaque,
> >       return 0;
> >   }
> >
> > +static gint
> > +pstrcmp(const char **a, const char **b)
> > +{
> > +    return g_strcmp0(*a, *b);
> > +}
>
> This is the second time your series has added this static helper. Should
> it be a common helper instead?

as qemu_pstrcmp in cutils? inline in the header?

>
>
> > +        g_ptr_array_sort(array, (GCompareFunc)pstrcmp);
> > +        for (i =3D 0; i < array->len; i++) {
> > +            error_printf("%s\n", (char *)array->pdata[i]);
> > +        }
> > +        g_ptr_array_set_free_func(array, g_free);
> > +        g_ptr_array_free(array, true);
> > +        exit(0);
>
> Again, printing to stderr then exiting with status 0 is awkward.  Print
> to stdout when successfully offering help text.

We use error_printf() for qdev list (qdev_device_help), which
redirects to monitor or stderr.

Should I also change ir for consistency? hopefully nobody relies on
the output going to stderr...

> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>


--=20
Marc-Andr=C3=A9 Lureau
