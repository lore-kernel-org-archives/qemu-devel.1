Received: from eggs.gnu.org ([2001:4830:134:3::10]:42111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQRO-0003tp-V4
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQRK-0003ia-Om
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:56:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eOQRK-0003hN-Fe
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:56:22 -0500
References: <20171206112116.29413-1-ppandit@redhat.com>
	<20171206113442.fjcpuwdfwx6brdkb@starbug-vm.ie.oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71be3a5c-811c-f7e8-db53-13eb67e59893@redhat.com>
Date: Mon, 11 Dec 2017 16:56:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171206113442.fjcpuwdfwx6brdkb@starbug-vm.ie.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi: check current request object before
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Zhangboxian <zhangboxian@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 06/12/2017 12:34, Darren Kenny wrote:
> Are both tests for NULL necessary, the second one would seem to
> suffice - but also the first check changes whether esp_dma_done()
> would get called or not here:
>=20
> =C2=A0276=C2=A0=C2=A0=C2=A0=C2=A0 if (s->async_len =3D=3D 0) {
> =C2=A0277=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi_req_cont=
inue(s->current_req);
> =C2=A0278=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If there i=
s still data to be read from the device then
> =C2=A0279=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 complete the DMA operation immediately.=C2=A0 Otherwise defer
> =C2=A0280=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 until the scsi layer has completed.=C2=A0 */
> =C2=A0281=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (to_device=
 || s->dma_left !=3D 0 || s->ti_size =3D=3D 0) {
> =C2=A0282=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return;
> =C2=A0283=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0284=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0285 =C2=A0286=C2=A0=C2=A0=C2=A0=C2=A0 /* Partially filled a scsi =
buffer. Complete immediately.=C2=A0 */
> =C2=A0287=C2=A0=C2=A0=C2=A0=C2=A0 esp_dma_done(s);
>=20
> I don't know the SCSI code well enough to know if it is correct to
> change this, so just pointing it out in case someone else might.

The second test should definitely not be necessary, it's only papering
over a bug elsewhere.  But without a testcase it's not possible for me
to judge if the first test is the right fix, or _also_ papering over a
bug elsewhere.

Thanks,

Paolo

> Thanks,
>=20
> Darren.
>=20
> On Wed, Dec 06, 2017 at 04:51:16PM +0530, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> During a dma access, SCSIRequest object 'current_req' could be
>> null, leading to a null pointer dereference. Add check to avoid
>> it.
>>
>> Reported-by: Zhangboxian <zhangboxian@huawei.com>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>> hw/scsi/esp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>> hw/scsi/scsi-bus.c | 3 +++
>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index ee586e7d6c..0c6925a708 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -273,7 +273,7 @@ static void esp_do_dma(ESPState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->ti_size +=3D len;
>> =C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->ti_size -=3D len;
>> -=C2=A0=C2=A0=C2=A0 if (s->async_len =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0 if (s->current_req && s->async_len =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi_req_continue(s->curren=
t_req);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If there is still data t=
o be read from the device then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 complete =
the DMA operation immediately.=C2=A0 Otherwise defer
>> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>> index 977f7bce1f..ac64a239e9 100644
>> --- a/hw/scsi/scsi-bus.c
>> +++ b/hw/scsi/scsi-bus.c
>> @@ -1338,6 +1338,9 @@ void scsi_req_unref(SCSIRequest *req)
>> =C2=A0=C2=A0 will start the next chunk or complete the command.=C2=A0 =
*/
>> void scsi_req_continue(SCSIRequest *req)
>> {
>> +=C2=A0=C2=A0=C2=A0 if (!req) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0 if (req->io_canceled) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_scsi_req_continue_can=
celed(req->dev->id, req->lun,
>> req->tag);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> --=C2=A0
>> 2.13.6
>>
>>
