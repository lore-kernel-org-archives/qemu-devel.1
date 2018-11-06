Received: from eggs.gnu.org ([2001:4830:134:3::10]:53860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJy4c-00010e-0n
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJxuJ-0003y0-2J
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:44:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gJxuH-0003sT-3W
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:44:21 -0500
References: <20181029173437.32559-1-pbonzini@redhat.com>
	<20181029173437.32559-4-pbonzini@redhat.com>
	<341d56df-d0f4-1730-57a9-89ebb02e5ec9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0075294e-ef76-6e0d-2de2-ca8c00508a58@redhat.com>
Date: Tue, 6 Nov 2018 10:44:12 +0100
MIME-Version: 1.0
In-Reply-To: <341d56df-d0f4-1730-57a9-89ebb02e5ec9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oZAI2QnG68Fy9ZA2QpeljXuTgxKLUtdUp"
Subject: Re: [Qemu-devel] [PATCH 3/4] scsi-generic: avoid invalid access to
 struct when emulating block limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oZAI2QnG68Fy9ZA2QpeljXuTgxKLUtdUp
From: Paolo Bonzini <pbonzini@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <0075294e-ef76-6e0d-2de2-ca8c00508a58@redhat.com>
Subject: Re: [PATCH 3/4] scsi-generic: avoid invalid access to struct when
 emulating block limits
References: <20181029173437.32559-1-pbonzini@redhat.com>
 <20181029173437.32559-4-pbonzini@redhat.com>
 <341d56df-d0f4-1730-57a9-89ebb02e5ec9@redhat.com>
In-Reply-To: <341d56df-d0f4-1730-57a9-89ebb02e5ec9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/11/2018 03:16, Max Reitz wrote:
>> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
>> index c5497bbea8..8fc74ef0bd 100644
>> --- a/hw/scsi/scsi-generic.c
>> +++ b/hw/scsi/scsi-generic.c
>> @@ -16,6 +16,7 @@
>>  #include "qemu-common.h"
>>  #include "qemu/error-report.h"
>>  #include "hw/scsi/scsi.h"
>> +#include "hw/scsi/emulation.h"
>>  #include "sysemu/block-backend.h"
>> =20
>>  #ifdef __linux__
>> @@ -209,9 +210,24 @@ static void scsi_handle_inquiry_reply(SCSIGeneric=
Req *r, SCSIDevice *s)
>>      }
>>  }
>> =20
>> -static int scsi_emulate_block_limits(SCSIGenericReq *r)
>> +static int scsi_generic_emulate_block_limits(SCSIGenericReq *r, SCSID=
evice *s)
>>  {
>> -    r->buflen =3D scsi_disk_emulate_vpd_page(&r->req, r->buf);
>> +    int len, buflen;
>=20
> buflen is unused, so this does not compile for me.

Yeah, I forgot to commit it.

>> +    uint8_t buf[64];
>> +
>> +    SCSIBlockLimits bl =3D {
>> +        .max_io_sectors =3D blk_get_max_transfer(s->conf.blk) / s->bl=
ocksize
>> +    };
>> +
>> +    memset(r->buf, 0, r->buflen);
>> +    stb_p(buf, s->type);
>> +    stb_p(buf + 1, 0xb0);
>> +    len =3D scsi_emulate_block_limits(buf + 4, &bl);
>> +    assert(len <=3D sizeof(buf) - 4);
>=20
> Let's hope our stack grows downwards, otherwise we'll never get back
> here if there was an overflow.  Maybe it would be better to pass the
> buffer length to scsi_emulate_block_limits() and then move the assertio=
n
> there.

Isn't that a problem always with stacks that grow upwards?  A buffer
overflow on an argument that points to a local variable will always
corrupt the stack frame (on the other hand, a stack that grows downwards
will corrupt the stack frame if the buffer overflow occurs directly in
the function with no call in between).

> With buflen dropped, and you taking full responsibility for any future
> bugs on ABIs with upwards stacks when someone extended
> scsi_emulate_block_limits(), forgetting to adjust the buffer size here
> (:-)):

I think it's quite likely that the bug would be caught first on a
downwards-stack architecture. :)

The complete delta between v1 and v2 will be

diff --git a/hw/scsi/emulation.c b/hw/scsi/emulation.c
index 94c2254bb4..06d62f3c38 100644
--- a/hw/scsi/emulation.c
+++ b/hw/scsi/emulation.c
@@ -3,10 +3,10 @@
 #include "qemu/bswap.h"
 #include "hw/scsi/emulation.h"

-int scsi_emulate_block_limits(uint8_t *outbuf, SCSIBlockLimits *bl)
+int scsi_emulate_block_limits(uint8_t *outbuf, const SCSIBlockLimits *bl=
)
 {
     /* required VPD size with unmap support */
-    memset(outbuf, 0, 0x3C);
+    memset(outbuf, 0, 0x3c);

     outbuf[0] =3D bl->wsnz; /* wsnz */

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index b8fa0a0f7e..7237b4162e 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -182,7 +182,7 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq
*r, SCSIDevice *s)
             /* Also take care of the opt xfer len. */
             stl_be_p(&r->buf[12],
                     MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
-        } else if (page =3D=3D 0x00 && s->needs_vpd_bl_emulation) {
+        } else if (s->needs_vpd_bl_emulation && page =3D=3D 0x00) {
             /*
              * Now we're capable of supplying the VPD Block Limits
              * response if the hardware can't. Add it in the INQUIRY
@@ -268,15 +268,14 @@ static void scsi_read_complete(void * opaque, int r=
et)
      * resulted in sense error but would need emulation.
      * In this case, emulate a valid VPD response.
      */
-    if (ret =3D=3D 0 &&
+    if (s->needs_vpd_bl_emulation && ret =3D=3D 0 &&
         (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) &&
-        scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr).key
=3D=3D ILLEGAL_REQUEST &&
-        s->needs_vpd_bl_emulation) {
-        int is_vpd_bl =3D r->req.cmd.buf[0] =3D=3D INQUIRY &&
-                         r->req.cmd.buf[1] & 0x01 &&
-                         r->req.cmd.buf[2] =3D=3D 0xb0;
-
-        if (is_vpd_bl) {
+        r->req.cmd.buf[0] =3D=3D INQUIRY &&
+        (r->req.cmd.buf[1] & 0x01) &&
+        r->req.cmd.buf[2] =3D=3D 0xb0) {
+        SCSISense sense =3D
+            scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr);
+        if (sense.key =3D=3D ILLEGAL_REQUEST) {
             len =3D scsi_generic_emulate_block_limits(r, s);
             /*
              * No need to let scsi_read_complete go on and handle an
diff --git a/include/hw/scsi/emulation.h b/include/hw/scsi/emulation.h
index 42de7c30c2..09fba1ff39 100644
--- a/include/hw/scsi/emulation.h
+++ b/include/hw/scsi/emulation.h
@@ -11,6 +11,6 @@ typedef struct SCSIBlockLimits {
     uint32_t max_io_sectors;
 } SCSIBlockLimits;

-int scsi_emulate_block_limits(uint8_t *outbuf, SCSIBlockLimits *bl);
+int scsi_emulate_block_limits(uint8_t *outbuf, const SCSIBlockLimits *bl=
);

 #endif

with most of the changes being just cosmetic to avoid the long line
without reindenting everything.

Paolo

> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
>> +    stw_be_p(buf + 2, len);
>> +
>> +    memcpy(r->buf, buf, MIN(r->buflen, len + 4));
>> +
>>      r->io_header.sb_len_wr =3D 0;
>> =20
>>      /*
>=20



--oZAI2QnG68Fy9ZA2QpeljXuTgxKLUtdUp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlvhYm4ACgkQv/vSX3jH
roOLRAf/ZO8Y6bN9UWGVo14bp32FArqSi1+y51cCF1rI1/8QBixHHwJ3hjYE+bwk
TV1KbMNQ8TGb3oprU3cUY/u1iIfQkfSCKlp5TMlkIXmjT5m0YsWEmih4gJqHEa5v
XrxCXBRzqG9h0dkwLNX1yiCtOhZ6ynnY4KIFU3/UZE+Fv4gJFYTWgBfnWCrHW0vJ
ZDUI1AZOXWEd+EkwkuI/4d7sLfqWdkV1wZlBs8GGpGZO/AFFrZchjxgymUA25yOT
ESgFkA4fdneGzjR5+YwHqchuTNCQOVtC85Aqo5vY1S5bBj0hcUiWkywFxKLBdHbZ
dE254TxB1guHOdccsuQaZDyqDOrmYQ==
=LgFj
-----END PGP SIGNATURE-----

--oZAI2QnG68Fy9ZA2QpeljXuTgxKLUtdUp--
