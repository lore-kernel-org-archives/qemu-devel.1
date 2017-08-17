Received: from eggs.gnu.org ([2001:4830:134:3::10]:34366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diLi7-0001tG-9b
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diLi4-0003Rk-3G
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:23:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1diLi3-0003RP-QQ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:23:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C72D313AAB
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 14:23:42 +0000 (UTC)
References: <20170817141148.13111-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dad88591-da0d-d9dd-ef0d-4153bbc68b85@redhat.com>
Date: Thu, 17 Aug 2017 16:23:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170817141148.13111-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] scsi-block: Add qdev error properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 17/08/2017 16:11, Fam Zheng wrote:
> This makes the werror/rerror options available on the scsi-block device=
,
> to allow user specify error handling policy in the same way as scsi-hd
> etc.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> Take care of status, error, sense and QMP as well. [Paolo]
> ---
>  hw/scsi/scsi-disk.c | 81 ++++++++++++++++++++++++++++++++++++++-------=
--------
>  1 file changed, 59 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 5f1e5e8070..124d77c159 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -106,7 +106,8 @@ typedef struct SCSIDiskState
>      bool tray_locked;
>  } SCSIDiskState;
> =20
> -static int scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_f=
ailed);
> +static int scsi_handle_rw_error(SCSIDiskReq *r, int error, int status,
> +                                bool update_sense, bool acct_failed);
> =20
>  static void scsi_free_request(SCSIRequest *req)
>  {
> @@ -179,21 +180,23 @@ static void scsi_disk_load_request(QEMUFile *f, S=
CSIRequest *req)
> =20
>  static bool scsi_disk_req_check_error(SCSIDiskReq *r, int ret, bool ac=
ct_failed)
>  {
> +    int status =3D r->status ? *r->status : 0;
> +
>      if (r->req.io_canceled) {
>          scsi_req_cancel_complete(&r->req);
>          return true;
>      }
> =20
> -    if (ret < 0) {
> -        return scsi_handle_rw_error(r, -ret, acct_failed);
> +    if (ret < 0 || status) {
> +        return scsi_handle_rw_error(r, -ret, status, !r->status, acct_=
failed);

Do we need to pass both ret and !r->status?  We should update the sense
whenever error !=3D 0, meaning the command hasn't run, so you can just ad=
d a

	case 0:
	    /* The command has run, no need to fake sense.  */
	    assert(r->status && *r->status);
	    scsi_req_complete(&r->req, *r->status);

in scsi_handle_rw_error's switch statement.

>      }
> =20
> -    if (r->status && *r->status) {
> +    if (status) {
>          if (acct_failed) {
>              SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req=
.dev);
>              block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acc=
t);
>          }
> -        scsi_req_complete(&r->req, *r->status);
> +        scsi_req_complete(&r->req, status);
>          return true;

This "if" is now dead code (yay!).

>      }
> =20
> @@ -428,7 +447,8 @@ static void scsi_read_data(SCSIRequest *req)
>   * scsi_handle_rw_error always manages its reference counts, independe=
nt
>   * of the return value.
>   */
> -static int scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_f=
ailed)
> +static int scsi_handle_rw_error(SCSIDiskReq *r, int error, int status,
> +                                bool update_sense, bool acct_failed)
>  {
>      bool is_read =3D (r->req.cmd.mode =3D=3D SCSI_XFER_FROM_DEV);
>      SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> @@ -439,22 +459,38 @@ static int scsi_handle_rw_error(SCSIDiskReq *r, i=
nt error, bool acct_failed)
>          if (acct_failed) {
>              block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acc=
t);
>          }
> -        switch (error) {
> -        case ENOMEDIUM:
> -            scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
> -            break;
> -        case ENOMEM:
> -            scsi_check_condition(r, SENSE_CODE(TARGET_FAILURE));
> -            break;
> -        case EINVAL:
> -            scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
> -            break;
> -        case ENOSPC:
> -            scsi_check_condition(r, SENSE_CODE(SPACE_ALLOC_FAILED));
> -            break;
> -        default:
> -            scsi_check_condition(r, SENSE_CODE(IO_ERROR));
> -            break;
> +        if (update_sense) {
> +            switch (error) {
> +            case ENOMEDIUM:
> +                scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
> +                break;
> +            case ENOMEM:
> +                scsi_check_condition(r, SENSE_CODE(TARGET_FAILURE));
> +                break;
> +            case EINVAL:
> +                scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
> +                break;
> +            case ENOSPC:
> +                scsi_check_condition(r, SENSE_CODE(SPACE_ALLOC_FAILED)=
);
> +                break;
> +            default:
> +                scsi_check_condition(r, SENSE_CODE(IO_ERROR));
> +                break;
> +            }
> +        }

Because of the dead code above, you're now not running scsi_req_complete.

> +    }
> +    if (!error) {
> +        assert(status);

Since you are using the request object, you might as well
"assert(r->status && *r->status)" and skip passing the argument.

> +        if (scsi_sense_matches(r, SENSE_CODE(NO_MEDIUM))) {
> +            error =3D ENOMEDIUM;
> +        } else if (scsi_sense_matches(r, SENSE_CODE(TARGET_FAILURE))) =
{
> +            error =3D ENOMEM;
> +        } else if (scsi_sense_matches(r, SENSE_CODE(INVALID_FIELD))) {
> +            error =3D EINVAL;
> +        } else if (scsi_sense_matches(r, SENSE_CODE(SPACE_ALLOC_FAILED=
))) {
> +            error =3D ENOSPC;
> +        } else {
> +            error =3D EIO;

Nice touch :) and in fact the ENOSPC case is needed for correctness.

Later we could also add a blk_error_action version that takes a char*,
and pass a string that describes the sense data (see Linux
drivers/scsi/sense_codes.h).

Paolo

>          }
>      }
>      blk_error_action(s->qdev.conf.blk, action, is_read, error);
> @@ -2972,6 +3008,7 @@ static const TypeInfo scsi_cd_info =3D {
> =20
>  #ifdef __linux__
>  static Property scsi_block_properties[] =3D {
> +    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
>      DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20
