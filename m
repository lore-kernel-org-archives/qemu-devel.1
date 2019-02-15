Received: from eggs.gnu.org ([209.51.188.92]:56568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1guibk-0007WI-3c
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1guibi-0003re-79
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:53:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1guibf-0003lu-Oo
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 13:53:04 -0500
From: Bandan Das <bsd@redhat.com>
References: <20190130073426.11525-1-kraxel@redhat.com>
	<20190130073426.11525-8-kraxel@redhat.com>
	<CAFEAcA-hgtFq-LHY=73+PtQKp2J-b6LdG73+Ag_uPtwF9Z4iYg@mail.gmail.com>
Date: Fri, 15 Feb 2019 13:45:51 -0500
In-Reply-To: <CAFEAcA-hgtFq-LHY=73+PtQKp2J-b6LdG73+Ag_uPtwF9Z4iYg@mail.gmail.com>
	(Peter Maydell's message of "Thu, 14 Feb 2019 18:52:21 +0000")
Message-ID: <jpgef886gbk.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 7/8] usb-mtp: breakup MTP write into smaller
 chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 30 Jan 2019 at 07:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> From: Bandan Das <bsd@redhat.com>
>>
>> For every MTP_WRITE_BUF_SZ copied, this patch writes it to file before
>> getting the next block of data. The file is kept opened for the
>> duration of the operation but the sanity checks on the write operation
>> are performed only once when the write operation starts. Additionally,
>> we also update the file size in the object metadata once the file has
>> completely been written.
>>
>> Suggested-by: Gerd Hoffman <kraxel@redhat.com>
>> Signed-off-by: Bandan Das <bsd@redhat.com>
>> Message-id: 20190129131908.27924-3-bsd@redhat.com
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Hi; Coverity has spotted a couple of issues with this patch:
>
>
>> +static void usb_mtp_update_object(MTPObject *parent, char *name)
>> +{
>> +    MTPObject *o =
>> +        usb_mtp_object_lookup_name(parent, name, strlen(name));
>> +
>> +    if (o) {
>> +        lstat(o->path, &o->stat);
>
> CID 1398651: We don't check the return value of this lstat() for failure.
>

Thanks, will post a patch for this.

>> +    }
>> +}
>> +
>>  static void usb_mtp_write_data(MTPState *s)
>>  {
>>      MTPData *d = s->data_out;
>
> [...]
>
>> +    case WRITE_CONTINUE:
>> +    case WRITE_END:
>> +        rc = write_retry(d->fd, d->data, d->data_offset,
>> +                         d->offset - d->data_offset);
>> +        if (rc != d->data_offset) {
>>              usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
>>                                   0, 0, 0, 0);
>>              goto done;
>> +        }
>> +        if (d->write_status != WRITE_END) {
>> +            return;
>
> CID 1398642: This early-return case in usb_mtp_write_data() returns
> from the function without doing any of the cleanup (closing file,
> freeing data, etc). Possibly it should be "goto done;" instead ?
> The specific thing Coverity complains about is the memory pointed
> to by "path".
>

I believe this is a false positive, there's still more data incoming
and we have successfully written the data we got this time, so we return
without freeing up any of the structures. I will add a comment here.

Bandan

> thanks
> -- PMM
