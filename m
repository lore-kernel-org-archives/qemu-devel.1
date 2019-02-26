Received: from eggs.gnu.org ([209.51.188.92]:50851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gyRlX-0001Al-UT
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 20:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gyRlT-0001hv-0O
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 20:42:38 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gyRlM-0001eP-Gi
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 20:42:30 -0500
Received: by mail-ua1-f68.google.com with SMTP id s15so10366638uap.6
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 17:42:24 -0800 (PST)
MIME-Version: 1.0
References: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190225202630.GA4925@habkost.net>
In-Reply-To: <20190225202630.GA4925@habkost.net>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 26 Feb 2019 03:42:11 +0200
Message-ID: <CAMRbyysWcfctB8AeSZrQ9x9HRAKut7mWYFqVP=oQ5uVoQgvh0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] iotests: handle TypeError
 for Python3 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block <qemu-block@nongnu.org>, philmd@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, den@openvz.org

On Mon, Feb 25, 2019 at 10:36 PM Eduardo Habkost <ehabkost@redhat.com>
wrote:

> On Fri, Feb 22, 2019 at 02:26:13PM +0300, Andrey Shinkevich wrote:
> > The data type for bytes in Python3 differs from the one in Python2.
> > Those cases should be managed separately.
> >
> > v1:
> > In the first version, the TypeError in Python3 was handled as the
> > exception.
> > Discussed in the e-mail thread with the Message ID:
> > <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>
> >
> > Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > Reported-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/242 | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
> > index 16c65ed..446fbf8 100755
> > --- a/tests/qemu-iotests/242
> > +++ b/tests/qemu-iotests/242
> > @@ -20,6 +20,7 @@
> >
> >  import iotests
> >  import json
> > +import sys
> >  from iotests import qemu_img_create, qemu_io, qemu_img_pipe, \
> >      file_path, img_info_log, log, filter_qemu_io
> >
> > @@ -65,9 +66,12 @@ def toggle_flag(offset):
> >      with open(disk, "r+b") as f:
> >          f.seek(offset, 0)
> >          c = f.read(1)
> > -        toggled = chr(ord(c) ^ bitmap_flag_unknown)
> > +        toggled = ord(c) ^ bitmap_flag_unknown
> >          f.seek(-1, 1)
> > -        f.write(toggled)
> > +        if sys.version_info.major >= 3:
> > +            f.write(bytes([toggled]))
> > +        else:
> > +            f.write(chr(toggled))
>
> Pretending we are dealing with text strings and using str/ord is
> a python2-specific quirk.  I think it would be nice to get rid of
> it.
>
> Python 2 has bytearray(), which behaves more similarly to the
> bytes type from Python 3.  If we use it, we can make the code
> more python3-like:
>
> diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
> index 16c65edcd7..7794fd4a70 100755
> --- a/tests/qemu-iotests/242
> +++ b/tests/qemu-iotests/242
> @@ -64,10 +64,12 @@ def write_to_disk(offset, size):
>  def toggle_flag(offset):
>      with open(disk, "r+b") as f:
>          f.seek(offset, 0)
> -        c = f.read(1)
> -        toggled = chr(ord(c) ^ bitmap_flag_unknown)
> +        # The casts to bytearray() below are only necessary
> +        # for Python 2 compatibility
> +        c = bytearray(f.read(1))[0]
>

This is simpler and makes the intent of the code more clear:

    flag, = struct.unpack("B", f.read(1))


> +        toggled = c ^ bitmap_flag_unknown
>          f.seek(-1, 1)
> -        f.write(toggled)
> +        f.write(bytearray([toggled]))
>

For consistency, we can use struct.pack here:

    f.write(struct.pack("B", toggled))

Nir


>
>
>  qemu_img_create('-f', iotests.imgfmt, disk, '1M')
>
> --
> Eduardo
>
>
