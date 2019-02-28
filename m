Received: from eggs.gnu.org ([209.51.188.92]:49002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzQQC-0000aS-DN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzQQB-0007ka-ER
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:28:40 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzQQA-0007hj-HQ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:28:38 -0500
Received: by mail-ot1-x344.google.com with SMTP id m1so18591470otf.5
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:28:35 -0800 (PST)
MIME-Version: 1.0
References: <155137665241.44413.528147250140332507.stgit@bahia.lan>
In-Reply-To: <155137665241.44413.528147250140332507.stgit@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 18:28:23 +0000
Message-ID: <CAFEAcA_B4fMvhP+cXhZQX0g5FMq1MvPxcfboT=pDSu9Ww_fFNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

On Thu, 28 Feb 2019 at 17:57, Greg Kurz <groug@kaod.org> wrote:
>
> Build fails with gcc 9:
>
>   CC      hw/usb/dev-mtp.o
> hw/usb/dev-mtp.c: In function =E2=80=98usb_mtp_write_metadata=E2=80=99:
> hw/usb/dev-mtp.c:1754:36: error: taking address of packed member of =E2=
=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointer value =
[-Werror=3Daddress-of-packed-member]
>  1754 |                             dataset->filename);
>       |                             ~~~~~~~^~~~~~~~~~
> cc1: all warnings being treated as errors
>
> The way the MTP protocol encodes strings with a leading 8-bit unsigned
> integer containing the string length causes the @filename field of the
> packed ObjectInfo structure to be unaligned.
>
> Use a temporary buffer for the utf16 filename instead of passing the
> dataset->filename pointer around.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/usb/dev-mtp.c |   18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 4ee4fc5a893a..8a0ef7f9f4a8 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1692,13 +1692,25 @@ static void usb_mtp_write_metadata(MTPState *s, u=
int64_t dlen)
>      MTPObject *o;
>      MTPObject *p =3D usb_mtp_object_lookup(s, s->dataset.parent_handle);
>      uint32_t next_handle =3D s->next_handle;
> +    uint16_t *utf16_filename;
> +    uint8_t filename_len;
>
>      assert(!s->write_pending);
>      assert(p !=3D NULL);
>
> -    filename =3D utf16_to_str(MIN(dataset->length,
> -                                dlen - offsetof(ObjectInfo, filename)),
> -                            dataset->filename);
> +    /*
> +     * MTP Specification 3.2.3 Strings
> +     * Strings in PTP (and thus MTP) consist of standard 2-byte Unicode
> +     * characters as defined by ISO 10646. Strings begin with a single, =
8-bit
> +     * unsigned integer that identifies the number of characters to foll=
ow (not
> +     * bytes).
> +     *
> +     * This causes dataset->filename to be unaligned.
> +     */
> +    filename_len =3D MIN(dataset->length, dlen - offsetof(ObjectInfo, fi=
lename));
> +    utf16_filename =3D g_memdup(dataset->filename, filename_len * 2);
> +    filename =3D utf16_to_str(filename_len, utf16_filename);
> +    g_free(utf16_filename);

I think there's an underlying problem with this code which we
should deal with differently. The 'dataset' local in this
file is (I think) pointing at on-the-wire information from
the USB device, but we're treating it as an array of
host-order uint16_t values. Is this really correct on a
big-endian host ? Do we do the right thing if we are
passed a malicious USB packet that ends halfway through a
utf16_t character, or do we index off the end of the packet
data ?

I think that we should define the "filename" field in
ObjectInfo to be a uint8_t array, make utf16_to_str()
take a uint8_t* for its data array, and have it do the
reading of data from the array with lduw_he_p(), which
can handle accessing unaligned data.

We should also check what the endianness of other fields in
the ObjectInfo struct is (eg "format" and "size" and see
whether we should be doing byte swapping here.

PS: it is a bit confusing that in this function the local
variable "dataset" is a pointer to a struct of entirely
different type to the one that s->dataset is.

thanks
-- PMM
