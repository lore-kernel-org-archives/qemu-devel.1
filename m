Received: from eggs.gnu.org ([2001:4830:134:3::10]:41889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erR59-0000gy-DQ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erR58-0005DI-9K
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:29:23 -0500
Date: Thu, 1 Mar 2018 16:29:08 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180301162908.GL2787@redhat.com>
References: <20180301135856.22698-1-rjones@redhat.com>
	<20180301135856.22698-2-rjones@redhat.com>
	<20180301161118.GW14643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301161118.GW14643@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] block: curl: Allow arbitrary HTTP
 request headers to be set.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: jcody@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On Thu, Mar 01, 2018 at 04:11:18PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 01, 2018 at 01:58:55PM +0000, Richard W.M. Jones wrote:
> > Allow arbitrary HTTP request headers to be set, like this:
> >=20
> >   qemu-img create -f qcow2 \
> >       -b 'json:{ "file.driver":"http",
> >                  "file.url":"http://192.168.0.249/scratch/test.img",
> >                  "file.header": ["Authorization: letmein"] }' \
> >       test.qcow2
> >=20
> > which adds the =E2=80=98Authorization: letmein=E2=80=99 header to the=
 outgoing request
> > for the backing file.  Multiple headers can be set, and curl built-in
> > headers can be removed (using "Header:").
> >=20
> > Note this uses the same format as curl's CURLOPT_HTTPHEADER, thus
> > pulling in curl API guarantees into qemu, but curl has had very stron=
g
> > API backward compatibility since the start of the project.
>=20
> It doesn't appear like there's anything really curl specific about
> this - isn't   'Key: value' just the standard HTTP format (minus the
> \r\n line ending of course.  IOW, I don't see any problem with using
> this format.

I'm going to withdraw this patch is it's not needed.  However this
does introduce a dependency on curl because of this from
CURLOPT_HTTPHEADER(3):

                                                        "If  you  add  a
   header that is otherwise generated and used by libcurl internally, you=
r
   added one will be used instead. If you add a header with no content  a=
s
   in  'Accept:'  (no data on the right side of the colon), the internall=
y
   used header will get disabled. With this option you can add  new  head=
=E2=80=90
   ers,  replace  internal  headers  and remove internal headers. To add =
a
   header with no content (nothing to the right side of  the  colon),  us=
e
   the form 'MyHeader;' (note the ending semicolon)."

> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 5c5921bfb7..ca1ebdbef1 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3047,12 +3047,15 @@
> >  # @cookie-secret: ID of a QCryptoSecret object providing the cookie =
data in a
> >  #                 secure way. See @cookie for the format. (since 2.1=
0)
> >  #
> > +# @header:      List of HTTP request headers, see CURLOPT_HTTPHEADER=
(3).
>=20
> Put  a '(since 2.12)' anntation on end of the docs for this new field

Will change the second patch accordingly, thanks.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
