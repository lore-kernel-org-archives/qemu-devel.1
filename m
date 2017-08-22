Received: from eggs.gnu.org ([2001:4830:134:3::10]:56025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7QO-0003f9-0z
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7QK-0003i2-25
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:32:48 -0400
MIME-Version: 1.0
In-Reply-To: <1502117160-24655-5-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-5-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Aug 2017 13:32:42 +0200
Message-ID: <CAJ+F1CLhMBQuKFT1w9Q-U1xAts4zpERNd_CZB7V2Yg4w0Q+m3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 04/56] char: Make ringbuf-read size
 unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, jcody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

Hi

On Mon, Aug 7, 2017 at 4:45 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Sizes should use QAPI type 'size' (uint64_t).  ringbuf-read parameter
> @size is 'int' (int64_t).  qmp_ringbuf_read() rejects negative values,
> then implicitly converts to size_t.
>
> Change the parameter to 'size' and drop the check for negative values.
>
> ringbuf-read now accepts size values between 2^63 and 2^64-1.  It
> accepts negative values as before, because that's how the QObject
> input visitor works for backward compatibility.
>

Negative values over json will be implicitly converted to positive
values with this change, right? Or are they rejected earlier?

If so that is a change of behaviour that I am not sure is worth doing
now (without explicit protocol break), but I don't mind.

> The HMP command's size parameter remains uint32_t, as HMP args_type
> strings can't do uint64_t byte counts: 'l' is signed, and 'o'
> multiplies by 2^20.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

> ---
>  chardev/char-ringbuf.c | 11 +++--------
>  qapi-schema.json       |  2 +-
>  2 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
> index df52b04..a9205ea 100644
> --- a/chardev/char-ringbuf.c
> +++ b/chardev/char-ringbuf.c
> @@ -65,10 +65,10 @@ static int ringbuf_chr_write(Chardev *chr, const uint=
8_t *buf, int len)
>      return len;
>  }
>
> -static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
> +static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, size_t len)
>  {
>      RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
> -    int i;
> +    size_t i;
>
>      qemu_mutex_lock(&chr->chr_write_lock);
>      for (i =3D 0; i < len && d->cons !=3D d->prod; i++) {
> @@ -151,7 +151,7 @@ void qmp_ringbuf_write(const char *device, const char=
 *data,
>      }
>  }
>
> -char *qmp_ringbuf_read(const char *device, int64_t size,
> +char *qmp_ringbuf_read(const char *device, uint64_t size,
>                         bool has_format, enum DataFormat format,
>                         Error **errp)
>  {
> @@ -171,11 +171,6 @@ char *qmp_ringbuf_read(const char *device, int64_t s=
ize,
>          return NULL;
>      }
>
> -    if (size <=3D 0) {
> -        error_setg(errp, "size must be greater than zero");
> -        return NULL;
> -    }
> -
>      count =3D ringbuf_count(chr);
>      size =3D size > count ? count : size;
>      read_data =3D g_malloc(size + 1);
> diff --git a/qapi-schema.json b/qapi-schema.json
> index febe70e..18ec301 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -543,7 +543,7 @@
>  #
>  ##
>  { 'command': 'ringbuf-read',
> -  'data': {'device': 'str', 'size': 'int', '*format': 'DataFormat'},
> +  'data': {'device': 'str', 'size': 'size', '*format': 'DataFormat'},
>    'returns': 'str' }
>
>  ##
> --
> 2.7.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
