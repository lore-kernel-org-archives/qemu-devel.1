Received: from eggs.gnu.org ([209.51.188.92]:56276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gzi4K-00044e-3v
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gzi4H-00017i-HK
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:19:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gzi4H-00016m-8F
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:19:13 -0500
References: <155137678223.44753.5438092367451176318.stgit@bahia.lan>
	<CAFEAcA94Y5jt8wr3Os7PWT_hA_OLRyL7FQqxdp5B_Lfg1Gy+_A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13630cdf-77c5-9708-ff96-da687be52d89@redhat.com>
Date: Fri, 1 Mar 2019 14:19:02 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA94Y5jt8wr3Os7PWT_hA_OLRyL7FQqxdp5B_Lfg1Gy+_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 28/02/19 19:31, Peter Maydell wrote:
> On Thu, 28 Feb 2019 at 17:59, Greg Kurz <groug@kaod.org> wrote:
>>
>> Build fails with gcc 9:
>>
>>   CC      ppc64-softmmu/hw/scsi/virtio-scsi.o
>> hw/scsi/virtio-scsi.c: In function =E2=80=98virtio_scsi_do_tmf=E2=80=99=
:
>> hw/scsi/virtio-scsi.c:265:39: error: taking address of packed member o=
f =E2=80=98struct virtio_scsi_ctrl_tmf_req=E2=80=99 may result in an unal=
igned pointer value [-Werror=3Daddress-of-packed-member]
>>   265 |     virtio_tswap32s(VIRTIO_DEVICE(s), &req->req.tmf.subtype);
>>       |                                       ^~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>> All the fields in struct virtio_scsi_ctrl_tmf_req are naturally aligne=
d,
>> so we could in theory drop QEMU_PACKED. Unfortunately, the header file
>> is imported from linux which already has the packed attribute. Trying =
to
>> fix that in the update-linux-headers.sh script is likely to produce
>> ugliness. Turn the call to virtio_tswap32s() into an assignment instea=
d.
>>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>> ---
>>  hw/scsi/virtio-scsi.c |    8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>> index ce99d288b035..839f1202567d 100644
>> --- a/hw/scsi/virtio-scsi.c
>> +++ b/hw/scsi/virtio-scsi.c
>> @@ -262,7 +262,13 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, Virt=
IOSCSIReq *req)
>>      /* Here VIRTIO_SCSI_S_OK means "FUNCTION COMPLETE".  */
>>      req->resp.tmf.response =3D VIRTIO_SCSI_S_OK;
>>
>> -    virtio_tswap32s(VIRTIO_DEVICE(s), &req->req.tmf.subtype);
>> +    /*
>> +     * req->req.tmf has the QEMU_PACKED attribute. Don't use virtio_t=
swap32s()
>> +     * to avoid compiler errors.
>> +     */
>> +    req->req.tmf.subtype =3D
>> +        virtio_tswap32(VIRTIO_DEVICE(s), req->req.tmf.subtype);
>> +
>>      switch (req->req.tmf.subtype) {
>>      case VIRTIO_SCSI_T_TMF_ABORT_TASK:
>>      case VIRTIO_SCSI_T_TMF_QUERY_TASK:
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> I haven't generally bothered to add comments about packed
> structs when I've switched away from the *s versions of byteswap
> functions, but it doesn't hurt.
>=20
> We should consider just replacing the other dozen uses
> of virtio_tswap*s() with the non-s versions and dropping the
> s functions entirely...

Applied, thanks.

Paolo
