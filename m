Received: from eggs.gnu.org ([2001:4830:134:3::10]:50331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddbCc-0003d1-78
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddbBW-0001Wf-RC
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:55:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:46811 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ddbBW-0001SU-Fh
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:54:30 -0400
References: <1501835795-92331-1-git-send-email-hare@suse.de>
	<1501835795-92331-5-git-send-email-hare@suse.de>
	<f049ca6c-aa7e-e10b-91c0-208f12d61263@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1f69ec77-fc8a-11d8-439e-52ee8a21756b@suse.de>
Date: Fri, 4 Aug 2017 13:54:27 +0200
MIME-Version: 1.0
In-Reply-To: <f049ca6c-aa7e-e10b-91c0-208f12d61263@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv2 4/4] scsi: Add 'enclosure' option for
 scsi devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>, qemu-devel@nongnu.org

On 08/04/2017 12:48 PM, Paolo Bonzini wrote:
> On 04/08/2017 10:36, Hannes Reinecke wrote:
>> Make enclosure support optional with the 'enclosure' argument to
>> the scsi device.
>> Adding 'enclosure=3Don' as option to the SCSI device will present
>> an enclosure service device on LUN0, either as a stand-alone
>> LUN (in case LUN0 is not assigned) or by setting the EncServ bit
>> int the inquiry data if LUN0 is assigned to a block devices.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>> ---
>>  hw/scsi/scsi-bus.c     | 11 ++++++++---
>>  hw/scsi/scsi-disk.c    |  4 +++-
>>  include/hw/scsi/scsi.h |  1 +
>>  3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>> index 79a222f..c11422b 100644
>> --- a/hw/scsi/scsi-bus.c
>> +++ b/hw/scsi/scsi-bus.c
>> @@ -22,6 +22,7 @@ static Property scsi_props[] =3D {
>>      DEFINE_PROP_UINT32("channel", SCSIDevice, channel, 0),
>>      DEFINE_PROP_UINT32("scsi-id", SCSIDevice, id, -1),
>>      DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
>> +    DEFINE_PROP_BOOL("enclosure", SCSIDevice, enclosure, false),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>> =20
>> @@ -494,11 +495,14 @@ static bool scsi_target_emulate_inquiry(SCSITarg=
etReq *r)
>>      if (r->req.lun !=3D 0) {
>>          r->buf[0] =3D TYPE_NO_LUN;
>>      } else {
>> -        r->buf[0] =3D TYPE_ENCLOSURE;
>> +        r->buf[0] =3D r->req.dev->enclosure ?
>> +            TYPE_ENCLOSURE : TYPE_NOT_PRESENT | TYPE_INACTIVE;
>>          r->buf[2] =3D 5; /* Version */
>>          r->buf[3] =3D 2 | 0x10; /* HiSup, response data format */
>>          r->buf[4] =3D r->len - 5; /* Additional Length =3D (Len - 1) =
- 4 */
>> -        r->buf[6] =3D 0x40; /* Enclosure service */
>> +        if (r->req.dev->enclosure) {
>> +            r->buf[6] =3D 0x40; /* Enclosure service */
>> +        }
>>          r->buf[7] =3D 0x10 | (r->req.bus->info->tcq ? 0x02 : 0); /* S=
ync, TCQ.  */
>>          memcpy(&r->buf[8], "QEMU    ", 8);
>>          memcpy(&r->buf[16], "QEMU TARGET     ", 16);
>> @@ -600,7 +604,8 @@ static int32_t scsi_target_send_command(SCSIReques=
t *req, uint8_t *buf)
>>          }
>>          break;
>>      case RECEIVE_DIAGNOSTIC:
>> -        if (!scsi_target_emulate_receive_diagnostic(r)) {
>> +        if (!r->req.dev->enclosure ||
>> +            !scsi_target_emulate_receive_diagnostic(r)) {
>>              goto illegal_request;
>>          }
>>          break;
>> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
>> index 5f1e5e8..153d97d 100644
>> --- a/hw/scsi/scsi-disk.c
>> +++ b/hw/scsi/scsi-disk.c
>> @@ -792,7 +792,9 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *=
req, uint8_t *outbuf)
>>                 the additional length is not adjusted */
>>          outbuf[4] =3D 36 - 5;
>>      }
>> -
>> +    if (s->qdev.lun =3D=3D 0 && s->qdev.enclosure) {
>> +            outbuf[6] =3D 0x40; /* Enclosure service */
>> +    }
>=20
> Should this really be set on disks even if you do have a LUN0?
>=20
Why not? You _can_ have embedded enclosure devices; that's what this bit
is for...

> Why don't you instead add a very simple scsi-enclosure device that you
> can specify as the LUN0?
>=20
You don't have to.
Once you leave LUN0 free (eg by assigning your first disk LUN1) you'll
get this device by virtue of the current LUN0 emulation.

But yeah, maybe I can be doing a separate enclosure device.
Will be checking if and how I can make it to work.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
