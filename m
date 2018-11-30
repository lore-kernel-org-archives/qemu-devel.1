Received: from eggs.gnu.org ([2001:4830:134:3::10]:37035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSica-0000eK-Rc
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSicP-0003dk-EG
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:14:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSicN-0003Qh-6q
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:14:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18C593001FF7
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 13:14:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181130111222.25386-1-kraxel@redhat.com>
	<20181130111222.25386-2-kraxel@redhat.com>
Date: Fri, 30 Nov 2018 14:13:56 +0100
In-Reply-To: <20181130111222.25386-2-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Fri, 30 Nov 2018 12:12:21 +0100")
Message-ID: <87woouk8rv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/2] usb-mtp: fix utf16_to_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> Make utf16_to_str return an allocated string.  Remove the assumtion that
> the number of string bytes equals the number of utf16 chars (which is
> only true for ascii chars).  Instead call wcstombs twice, once to figure
> the storage size and once for the actual conversion (as suggested by the
> wcstombs manpage).
>
> Reported-by: Michael Hanselmann (hansmi.ch)
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 00a3691bae..fbe1ace035 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1593,17 +1593,22 @@ static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
>      fprintf(stderr, "%s\n", __func__);
>  }
>  
> -static void utf16_to_str(uint8_t len, uint16_t *arr, char *name)
> +static char *utf16_to_str(uint8_t len, uint16_t *arr)
>  {
> -    int count;
> -    wchar_t *wstr = g_new0(wchar_t, len);
> +    wchar_t *wstr = g_new0(wchar_t, len + 1);
> +    int count, dlen;
> +    char *dest;
>  
>      for (count = 0; count < len; count++) {
>          wstr[count] = (wchar_t)arr[count];
>      }
> +    wstr[count] = 0;
>  
> -    wcstombs(name, wstr, len);
> +    dlen = wcstombs(NULL, wstr, 0) + 1;
> +    dest = g_malloc(dlen);
> +    wcstombs(dest, wstr, dlen);
>      g_free(wstr);
> +    return dest;
>  }

Preexisting: casting uint16_t to wchar_t is iffy for at least two
reasons:

* When wchar_t is UCS-4, things fall apart for surrogate pairs.  For
  instance, the surrogate pair

      uint16_t arr = { 0xD834, 0xDD1E };

  should map to the single wchar_t 0x1D11E.

* wchar_t needn't even be Unicode.  It might well be on any host we care
  for, but are you *sure*?

I guess g_utf16_to_utf8() would be differently wrong: it converts to
UTF-8, but we need to convert to the current locale's multibyte string.

>  
>  /* Wrapper around write, returns 0 on failure */
> @@ -1703,7 +1708,7 @@ static void usb_mtp_write_metadata(MTPState *s)
>  {
>      MTPData *d = s->data_out;
>      ObjectInfo *dataset = (ObjectInfo *)d->data;
> -    char *filename = g_new0(char, dataset->length);
> +    char *filename;
>      MTPObject *o;
>      MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);
>      uint32_t next_handle = s->next_handle;
> @@ -1711,7 +1716,7 @@ static void usb_mtp_write_metadata(MTPState *s)
>      assert(!s->write_pending);
>      assert(p != NULL);
>  
> -    utf16_to_str(dataset->length, dataset->filename, filename);
> +    filename = utf16_to_str(dataset->length, dataset->filename);
>  
>      o = usb_mtp_object_lookup_name(p, filename, dataset->length);
>      if (o != NULL) {
