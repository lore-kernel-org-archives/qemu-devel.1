Received: from eggs.gnu.org ([209.51.188.92]:36671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h2LL2-0003cz-4W
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h2LKz-00009W-MW
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:39:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1h2LKz-00005m-Fj
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:39:21 -0500
From: Bandan Das <bsd@redhat.com>
References: <20190307095441.31921-1-kraxel@redhat.com>
	<20190307095441.31921-3-kraxel@redhat.com>
	<CAFEAcA8qsLyowga086b_ELvucVKWC+PSzykG3th81pnts1jiuQ@mail.gmail.com>
Date: Fri, 08 Mar 2019 14:39:12 -0500
In-Reply-To: <CAFEAcA8qsLyowga086b_ELvucVKWC+PSzykG3th81pnts1jiuQ@mail.gmail.com>
	(Peter Maydell's message of "Fri, 8 Mar 2019 17:37:06 +0000")
Message-ID: <jpga7i5f95r.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 2/4] usb-mtp: fix some usb_mtp_write_data
 return paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 7 Mar 2019 at 09:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> From: Bandan Das <bsd@redhat.com>
>>
>> During a write, free up the "path" before getting more data.
>> Also, while we at it, remove the confusing usage of d->fd for
>> storing mkdir status
>>
>> Spotted by Coverity: CID 1398642
>>
>> Signed-off-by: Bandan Das <bsd@redhat.com>
>> Message-id: 20190306210409.14842-3-bsd@redhat.com
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Hi; Coverity found an issue with the code change here
> (CID 1399415):
>
>> index 4dde14fc7887..1f22284949df 100644
>> --- a/hw/usb/dev-mtp.c
>> +++ b/hw/usb/dev-mtp.c
>> @@ -1605,7 +1605,7 @@ static int usb_mtp_update_object(MTPObject *parent, char *name)
>>      return ret;
>>  }
>>
>> -static void usb_mtp_write_data(MTPState *s)
>> +static int usb_mtp_write_data(MTPState *s)
>
> Here we change usb_mtp_write_data() to return an error code...
>
>>  {
>>      MTPData *d = s->data_out;
>>      MTPObject *parent =
>
>> @@ -1727,14 +1731,12 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
>>      s->write_pending = true;
>>
>>      if (s->dataset.format == FMT_ASSOCIATION) {
>> -        usb_mtp_write_data(s);
>> -        /* next_handle will be allocated to the newly created dir */
>> -        if (d->fd == -1) {
>> +        if (usb_mtp_write_data(s)) {
>> +            /* next_handle will be allocated to the newly created dir */
>>              usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
>>                                   0, 0, 0, 0);
>>              return;
>
> ...and we updated this callsite to check the error return value.
>
> But the two places in usb_mtp_get_data() that call
> usb_mtp_write_metadata() still don't check its return
> value: don't they need to handle failure too?
>
I believe this is ok because:
The return value of usb_mtp_write_data is only used to check if mkdir
failed and update s->result in usb_mtp_write_metadata().
The next time usb_mtp_handle_data is called, it will process s->result. 

Bandan

> thanks
> -- PMM
