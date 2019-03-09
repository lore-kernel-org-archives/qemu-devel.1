Received: from eggs.gnu.org ([209.51.188.92]:51310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2d1o-0003Xh-GY
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2d1m-00067R-Fx
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:32:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-4-philmd@redhat.com>
	<71bce75b-a2a9-061b-a1c2-7c4e49d957b1@redhat.com>
Date: Sat, 09 Mar 2019 15:32:20 +0100
In-Reply-To: <71bce75b-a2a9-061b-a1c2-7c4e49d957b1@redhat.com> (Laszlo Ersek's
	message of "Fri, 8 Mar 2019 10:48:07 +0100")
Message-ID: <87y35o3yq3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

Laszlo Ersek <lersek@redhat.com> writes:

> Hi Phil,
>
> most important comment at the bottom.
>
> On 03/08/19 02:32, Philippe Mathieu-Daud=C3=A9 wrote:
>> Add two helpers: one to represent a binary data as a string of
>> hexadecimal values, and one to restore a such string into its
>> original binary data.
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  include/qemu/cutils.h | 33 ++++++++++++++++++++++++++
>>  util/cutils.c         | 55 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 88 insertions(+)
>>=20
>> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
>> index d2dad3057c..375a5508b0 100644
>> --- a/include/qemu/cutils.h
>> +++ b/include/qemu/cutils.h
>> @@ -171,6 +171,39 @@ bool test_buffer_is_zero_next_accel(void);
>>  int uleb128_encode_small(uint8_t *out, uint32_t n);
>>  int uleb128_decode_small(const uint8_t *in, uint32_t *n);
>>=20=20
>> +/**
>> + * qemu_strdup_hexlify:
>
> (1) I think the name "hexlify" is unusual.

hexlify-buffer is an interactive autoloaded Lisp function in
=E2=80=98hexl.el=E2=80=99.

(hexlify-buffer)

Convert a binary buffer to hexl format.
This discards the buffer=E2=80=99s undo information.

;-P

>                                            I think we should use
> encode/decode terminology, or hex/unhex, or, if we want to stick with
> the "stringify" pattern, hexify/unhexify. (No "l".)
>
>> + *
>> + * Encode a sequence of binary data into its hexadecimal stringified
>> + * representation.
>> + *
>> + * @ptr: Buffer to hexlify

Similar parameters elsewhere in this header are called @buf.

>> + * @size: Length of the buffer
>> + *
>> + * Use qemu_strdup_unhexlify() to convert the hex string to original da=
ta.
>> + *
>> + * Returns: A newly allocated, zero-terminated hex encoded string repre=
senting
>> + * the data. The returned string must be freed with g_free().
>> + */
>> +gchar *qemu_strdup_hexlify(gconstpointer ptr, gsize size);

Avoid the silly GLib types, please.

>> +
>> +/**
>> + * qemu_strdup_unhexlify:
>> + *
>> + * Decode a sequence of hexadecimal encoded text into binary data.
>> + *
>> + * @hex_string: String to unhexlify
>> + * @out_size: if not NULL: gsize to be written with the data length
>> + *
>> + * This function is the opposite of qemu_strdup_hexlify().
>> + *
>> + * Returns: A newly allocated buffer containing the binary data that te=
xt
>> + * represents. The returned buffer must be freed with g_free().
>> + * Note that the returned binary data is not necessarily zero-terminate=
d,
>> + * so it should not be used as a character string.
>> + */
>> +gpointer qemu_strdup_unhexlify(const gchar *hex_string, gsize *out_size=
);
>> +
>>  /**
>>   * qemu_pstrcmp0:
>>   * @str1: a non-NULL pointer to a C string (*str1 can be NULL)
>> diff --git a/util/cutils.c b/util/cutils.c
>> index e098debdc0..bf324c0d8b 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -779,6 +779,61 @@ int uleb128_decode_small(const uint8_t *in, uint32_=
t *n)
>>      }
>>  }
>>=20=20
>> +static guchar hexval(const gchar v)

Naming the parameter @ch would be more idiomatic, I think.

>> +{
>> +    switch (v) {
>> +    case '0' ... '9':
>> +        return v - '0';
>> +    case 'A' ... 'F':
>> +        return v - 'A' + 10;
>> +    case 'a' ... 'f':
>> +        return v - 'a' + 10;
>> +    default:
>> +        return 0;
>> +    }
>> +}
>
> (2) I don't think that we should silently translate invalid characters
> to zero, in any hexadecimal decoder.

Yup.  Let's abort().

>> +
>> +gchar *qemu_strdup_hexlify(gconstpointer ptr, gsize len)
>> +{
>> +    guchar *data =3D (guchar *)ptr;
>> +    gchar *hex_string;
>> +
>> +    if (!ptr || !len) {
>> +        return g_strdup("");
>> +    }

A null pointer is not the same as the empty string.  Replace this by

        assert(ptr);

and ...

>> +
>> +    hex_string =3D g_malloc(2 * len + 1);
>
> (3) Should check against integer overflow in the g_malloc() argument
> (multiplication and addition).

E.g.
        assert(len <=3D (SIZE_MAX - 1) / 2);

>> +    for (gsize i =3D 0; i < len; i++) {
>> +        g_snprintf(&hex_string[2 * i], 3, "%02x", data[i]);
>> +    }
>> +

... esnure termination here

        hex_string[2 * i] =3D 0;

What does g_snprintf() buy us over plain snprintf()?  I count 400+ uses
of the latter, and none of the former.

>> +    return hex_string;
>> +}
>> +
>> +gpointer qemu_strdup_unhexlify(const gchar *hex_string, gsize *out_size)
>> +{
>> +    size_t size =3D 0;
>> +    guchar *data =3D NULL;
>> +
>> +    if (hex_string) {

A null pointer is not the same as the empty string.  assert(hex_string)
and make the conversion unconditional.


>> +        size =3D strlen(hex_string) / 2;
>
> (4) Should likely check that the length of the string is an even integer.
>
>> +        if (size) {
>> +            size_t i;
>> +
>> +            data =3D g_new(guchar, size + 1);
>> +            for (i =3D 0; i < size; i++) {
>> +                data[i]  =3D hexval(*hex_string++) << 4;
>> +                data[i] |=3D hexval(*hex_string++);
>> +            }
>> +            data[i] =3D '\0';
>> +        }
>> +    }
>> +    if (out_size) {
>> +        *out_size =3D size;
>> +    }
>> +    return data;

This maps "" to null.  I think it shold return "".  It naturally does if
you make the if (size) code unconditional.

>> +}
>> +
>>  /*
>>   * helper to parse debug environment variables
>>   */
>>=20
>
> (5) Most importantly: I don't think we need this patch.
>
> First, AFAICS, the unhex function is never used in the series, and no
> unit test is being added for it. That makes it a bad candidate for
> "include/qemu/cutils.h".
>
> Second, while the hex function is used in PATCH v2 13/18
> ("hw/nvram/fw_cfg: Add QMP 'info fw_cfg' command"), the documentation in
> that patch and the logic in the patch are inconsistent. The
> documentation -- i.e. both the commit message and the "misc.json" change
> -- say that "FirmwareConfigurationItem.data" is unused (not populated).
> However, that's exactly what create_qmp_fw_cfg_item() uses the hex
> function for.
>
> Third, if we do decide that the QMP command should output the fw_cfg
> binary data, then the QMP tradition (to my knowledge) has been to use
> base64 encoding. GLib provides helpers for base64:
>
> https://developer.gnome.org/glib/stable/glib-Base64-Encoding.html
>
> and you can see examples of it being used in e.g.
>
> (a) qmp_ringbuf_read() [chardev/char-ringbuf.c] -- the  @ringbuf-read
> command is defined in "qapi/char.json"
>
> (b) qmp_guest_exec_status() [qga/commands.c] -- the @guest-exec-status
> command is defined in "qga/qapi-schema.json".

Yes.  I wish you had wrote that first, saving me the trouble of looking
at the patch.
