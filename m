Received: from eggs.gnu.org ([209.51.188.92]:49881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLrxg-0002Cn-I3
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLrxd-00041V-H8
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:20:00 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:55820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1hLrxd-0003ZC-8S
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:19:57 -0400
Message-Id: <5CC9C785020000480009D9AB@prv-mh.provo.novell.com>
Date: Wed, 01 May 2019 10:21:25 -0600
From: "Bruce Rogers" <brogers@suse.com>
References: <20190430131946.26628-1-brogers@suse.com>
	<4361ed56-ff32-7f89-4e1a-173898e8081a@redhat.com>
In-Reply-To: <4361ed56-ff32-7f89-4e1a-173898e8081a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH v2] scsi-disk: handle invalid cdb length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jsnow@redhat.com
Cc: "fam@euphon.net" <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>

>>> On 4/30/2019 at 2:40 PM, John Snow <jsnow@redhat.com> wrote:

>=20
> On 4/30/19 9:19 AM, Bruce Rogers wrote:
>> While investigating link-time-optimization, the compiler flagged this
>> case of not handling the error return from scsi_cdb_length(). Handle
>> this error case with a trace report.
>>=20
>> Signed-off-by: Bruce Rogers <brogers@suse.com>
>> ---
>>  hw/scsi/scsi-disk.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
>> index e7e865ab3b..8fbf7512e5 100644
>> --- a/hw/scsi/scsi-disk.c
>> +++ b/hw/scsi/scsi-disk.c
>> @@ -2520,6 +2520,10 @@ static void scsi_disk_new_request_dump(uint32_t =
lun,=20
> uint32_t tag, uint8_t *buf)
>>      int len =3D scsi_cdb_length(buf);
>>      char *line_buffer, *p;
>> =20
>> +    if (len < 0) {
>> +        trace_scsi_disk_new_request(lun, tag, "bad cdb length");
>=20
> This is going to print:
>=20
> "Command: lun=3D%d tag=3D0x%x data=3Dbad cdb length"
>=20
> which is maybe not the best. I'd rather print something more direct, but
> it's probably better than actually rolling forward with len =3D -1.
>=20
> Then again, this should literally never happen, because scsi_req_new is
> parsing the cdb object and already rejecting such cases.
>=20

Indeed, that is true.


> Can you satisfy the compiler by asserting that it is greater than zero?
> It ought to be provably true.

Yes, that seems to work and is probably the way to go. I'll send a patch
with that approach then. Thanks for the review.

>=20
> --js
>=20
>> +        return;
>> +    }
>>      line_buffer =3D g_malloc(len * 5 + 1);
>> =20
>>      for (i =3D 0, p =3D line_buffer; i < len; i++) {
>>=20

Bruce
