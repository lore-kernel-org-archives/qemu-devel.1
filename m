Received: from eggs.gnu.org ([209.51.188.92]:44025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2C7E-000461-Ue
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2C7D-0008Ap-PS
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:48:32 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-4-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <71bce75b-a2a9-061b-a1c2-7c4e49d957b1@redhat.com>
Date: Fri, 8 Mar 2019 10:48:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/18] cutils: Add qemu_strdup_hexlify()
 and qemu_strdup_unhexlify()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

Hi Phil,

most important comment at the bottom.

On 03/08/19 02:32, Philippe Mathieu-Daud=C3=A9 wrote:
> Add two helpers: one to represent a binary data as a string of
> hexadecimal values, and one to restore a such string into its
> original binary data.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/qemu/cutils.h | 33 ++++++++++++++++++++++++++
>  util/cutils.c         | 55 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>=20
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index d2dad3057c..375a5508b0 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -171,6 +171,39 @@ bool test_buffer_is_zero_next_accel(void);
>  int uleb128_encode_small(uint8_t *out, uint32_t n);
>  int uleb128_decode_small(const uint8_t *in, uint32_t *n);
> =20
> +/**
> + * qemu_strdup_hexlify:

(1) I think the name "hexlify" is unusual. I think we should use
encode/decode terminology, or hex/unhex, or, if we want to stick with
the "stringify" pattern, hexify/unhexify. (No "l".)

> + *
> + * Encode a sequence of binary data into its hexadecimal stringified
> + * representation.
> + *
> + * @ptr: Buffer to hexlify
> + * @size: Length of the buffer
> + *
> + * Use qemu_strdup_unhexlify() to convert the hex string to original d=
ata.
> + *
> + * Returns: A newly allocated, zero-terminated hex encoded string repr=
esenting
> + * the data. The returned string must be freed with g_free().
> + */
> +gchar *qemu_strdup_hexlify(gconstpointer ptr, gsize size);
> +
> +/**
> + * qemu_strdup_unhexlify:
> + *
> + * Decode a sequence of hexadecimal encoded text into binary data.
> + *
> + * @hex_string: String to unhexlify
> + * @out_size: if not NULL: gsize to be written with the data length
> + *
> + * This function is the opposite of qemu_strdup_hexlify().
> + *
> + * Returns: A newly allocated buffer containing the binary data that t=
ext
> + * represents. The returned buffer must be freed with g_free().
> + * Note that the returned binary data is not necessarily zero-terminat=
ed,
> + * so it should not be used as a character string.
> + */
> +gpointer qemu_strdup_unhexlify(const gchar *hex_string, gsize *out_siz=
e);
> +
>  /**
>   * qemu_pstrcmp0:
>   * @str1: a non-NULL pointer to a C string (*str1 can be NULL)
> diff --git a/util/cutils.c b/util/cutils.c
> index e098debdc0..bf324c0d8b 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -779,6 +779,61 @@ int uleb128_decode_small(const uint8_t *in, uint32=
_t *n)
>      }
>  }
> =20
> +static guchar hexval(const gchar v)
> +{
> +    switch (v) {
> +    case '0' ... '9':
> +        return v - '0';
> +    case 'A' ... 'F':
> +        return v - 'A' + 10;
> +    case 'a' ... 'f':
> +        return v - 'a' + 10;
> +    default:
> +        return 0;
> +    }
> +}

(2) I don't think that we should silently translate invalid characters
to zero, in any hexadecimal decoder.

> +
> +gchar *qemu_strdup_hexlify(gconstpointer ptr, gsize len)
> +{
> +    guchar *data =3D (guchar *)ptr;
> +    gchar *hex_string;
> +
> +    if (!ptr || !len) {
> +        return g_strdup("");
> +    }
> +
> +    hex_string =3D g_malloc(2 * len + 1);

(3) Should check against integer overflow in the g_malloc() argument
(multiplication and addition).

> +    for (gsize i =3D 0; i < len; i++) {
> +        g_snprintf(&hex_string[2 * i], 3, "%02x", data[i]);
> +    }
> +
> +    return hex_string;
> +}
> +
> +gpointer qemu_strdup_unhexlify(const gchar *hex_string, gsize *out_siz=
e)
> +{
> +    size_t size =3D 0;
> +    guchar *data =3D NULL;
> +
> +    if (hex_string) {
> +        size =3D strlen(hex_string) / 2;

(4) Should likely check that the length of the string is an even integer.

> +        if (size) {
> +            size_t i;
> +
> +            data =3D g_new(guchar, size + 1);
> +            for (i =3D 0; i < size; i++) {
> +                data[i]  =3D hexval(*hex_string++) << 4;
> +                data[i] |=3D hexval(*hex_string++);
> +            }
> +            data[i] =3D '\0';
> +        }
> +    }
> +    if (out_size) {
> +        *out_size =3D size;
> +    }
> +    return data;
> +}
> +
>  /*
>   * helper to parse debug environment variables
>   */
>=20

(5) Most importantly: I don't think we need this patch.

First, AFAICS, the unhex function is never used in the series, and no
unit test is being added for it. That makes it a bad candidate for
"include/qemu/cutils.h".

Second, while the hex function is used in PATCH v2 13/18
("hw/nvram/fw_cfg: Add QMP 'info fw_cfg' command"), the documentation in
that patch and the logic in the patch are inconsistent. The
documentation -- i.e. both the commit message and the "misc.json" change
-- say that "FirmwareConfigurationItem.data" is unused (not populated).
However, that's exactly what create_qmp_fw_cfg_item() uses the hex
function for.

Third, if we do decide that the QMP command should output the fw_cfg
binary data, then the QMP tradition (to my knowledge) has been to use
base64 encoding. GLib provides helpers for base64:

https://developer.gnome.org/glib/stable/glib-Base64-Encoding.html

and you can see examples of it being used in e.g.

(a) qmp_ringbuf_read() [chardev/char-ringbuf.c] -- the  @ringbuf-read
command is defined in "qapi/char.json"

(b) qmp_guest_exec_status() [qga/commands.c] -- the @guest-exec-status
command is defined in "qga/qapi-schema.json".

Thanks
Laszlo
