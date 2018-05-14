Received: from eggs.gnu.org ([2001:4830:134:3::10]:53338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIGC6-0004Um-If
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIGC5-0001AL-Jg
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:19:26 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:38384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIGC5-000196-EL
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:19:25 -0400
Received: by mail-ot0-x22b.google.com with SMTP id n3-v6so14951169ota.5
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:19:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525817687-34620-16-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
	<1525817687-34620-16-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 17:19:04 +0100
Message-ID: <CAFEAcA9=byErqiGKfeSmgrd7Uyu31LDZubLv+Ov-Z3c+86a5QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 15/30] opts: don't silently truncate long
 option values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 May 2018 at 23:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> The existing QemuOpts parsing code uses a fixed size 1024 byte buffer
> for storing the option values. If a value exceeded this size it was
> silently truncated and no error reported to the user. Long option values
> is not a common scenario, but it is conceivable that they will happen.
> eg if the user has a very deeply nested filesystem it would be possible
> to come up with a disk path that was > 1024 bytes. Most of the time if
> such data was silently truncated, the user would get an error about
> opening a non-existant disk. If they're unlucky though, QEMU might use a
> completely different disk image from another VM, which could be
> considered a security issue. Another example program was in using the
> -smbios command line arg with very large data blobs. In this case the
> silent truncation will be providing semantically incorrect data to the
> guest OS for SMBIOS tables.
>
> If the operating system didn't limit the user's argv when spawning QEMU,
> the code should honour whatever length arguments were given without
> imposing its own length restrictions. This patch thus changes the code
> to use a heap allocated buffer for storing the values during parsing,
> lifting the arbitrary length restriction.

Hi; Coverity doesn't like this change (CID1391003):

> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -70,25 +70,37 @@ static const char *get_opt_name(const char *p, char *=
*option, char delim)
>   * delimiter is fixed to be comma which starts a new option. To specify =
an
>   * option value that contains commas, double each comma.
>   */
> -const char *get_opt_value(char *buf, int buf_size, const char *p)
> +const char *get_opt_value(const char *p, char **value)
>  {
> -    char *q;
> +    size_t capacity =3D 0, length;
> +    const char *offset;
> +
> +    *value =3D NULL;

Here we write to *value, so value must be non-NULL, and
within the loop the only place we write to value it
can't become NULL either (g_renew can't fail)...

> +    while (1) {
> +        offset =3D strchr(p, ',');
> +        if (!offset) {
> +            offset =3D p + strlen(p);
> +        }
>
> -    q =3D buf;
> -    while (*p !=3D '\0') {
> -        if (*p =3D=3D ',') {
> -            if (*(p + 1) !=3D ',')
> -                break;
> -            p++;
> +        length =3D offset - p;
> +        if (*offset !=3D '\0' && *(offset + 1) =3D=3D ',') {
> +            length++;
> +        }
> +        if (value) {

...so this check for whether value is NULL can never be true.

> +            *value =3D g_renew(char, *value, capacity + length + 1);
> +            strncpy(*value + capacity, p, length);
> +            (*value)[capacity + length] =3D '\0';
> +        }
> +        capacity +=3D length;
> +        if (*offset =3D=3D '\0' ||
> +            *(offset + 1) !=3D ',') {
> +            break;
>          }
> -        if (q && (q - buf) < buf_size - 1)
> -            *q++ =3D *p;
> -        p++;
> +
> +        p +=3D (offset - p) + 2;
>      }
> -    if (q)
> -        *q =3D '\0';
>
> -    return p;
> +    return offset;
>  }
>

thanks
-- PMM
