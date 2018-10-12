Received: from eggs.gnu.org ([2001:4830:134:3::10]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAuNJ-0006Sj-AI
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAuNF-00007u-BN
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:08:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gAuNF-00007S-3Q
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:08:49 -0400
References: <2B9C18D722D31E48A98313968F2F243C1209F2A8@H3CMLB14-EX.srv.huawei-3com.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56b04cc0-1e56-60ca-596f-1e5f10753db5@redhat.com>
Date: Fri, 12 Oct 2018 12:08:33 +0200
MIME-Version: 1.0
In-Reply-To: <2B9C18D722D31E48A98313968F2F243C1209F2A8@H3CMLB14-EX.srv.huawei-3com.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] about qemu crash in scsi_handle_rw_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wangguang <wang.guangA@h3c.com>, "'famz@redhat.com'" <famz@redhat.com>
Cc: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>

On 12/10/2018 10:05, Wangguang wrote:
> Hi
>=20
> qemu had a assert when we use scsi-3 reservation=E3=80=82
>=20
> This happen when scsi sence is recoverd error=E3=80=82
>=20
> And which lead scsi_req_complete twice.
>=20
> =C2=A0
>=20
> =C2=A0
>=20
> static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool
> acct_failed)
>=20
> {
>=20
> =C2=A0=C2=A0=C2=A0 bool is_read =3D (r->req.cmd.mode =3D=3D SCSI_XFER_F=
ROM_DEV);
>=20
> =C2=A0=C2=A0=C2=A0 SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, =
r->req.dev);
>=20
> =C2=A0=C2=A0=C2=A0 BlockErrorAction action =3D blk_get_error_action(s->=
qdev.conf.blk,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0is_read, error);
>=20
> =C2=A0
>=20
> =C2=A0=C2=A0=C2=A0 if (action =3D=3D BLOCK_ERROR_ACTION_REPORT) {
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (acct_failed) {
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bloc=
k_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (error) {
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* T=
he command has run, no need to fake sense.=C2=A0 */
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asse=
rt(r->status && *r->status);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi=
_req_complete(&r->req, *r->status);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> the=C2=A0 first complete
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ENOMEDIUM:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi=
_check_condition(r, SENSE_CODE(NO_MEDIUM));
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ENOMEM:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi=
_check_condition(r, SENSE_CODE(TARGET_FAILURE));
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case EINVAL:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi=
_check_condition(r, SENSE_CODE(INVALID_FIELD));
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ENOSPC:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi=
_check_condition(r, SENSE_CODE(SPACE_ALLOC_FAILED));
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi=
_check_condition(r, SENSE_CODE(IO_ERROR));
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 if (!error) {
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(r->status && *r->stat=
us);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error =3D scsi_sense_buf_to_=
errno(r->req.sense, sizeof(r->req.sense));
>=20
> =C2=A0
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error =3D=3D ECANCELED |=
| error =3D=3D EAGAIN || error =3D=3D ENOTCONN ||
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r =3D=3D 0)=C2=A0 {
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* T=
hese errors are handled by guest. */
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scsi_=
req_complete(&r->req, *r->status);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> complete again when error=3D=3D0;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn true;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 }
> =C2=A0
>=20
> Shall we delete error=3D=3D0=C2=A0 at the second scsi_req_complete =EF=BC=
=9F=EF=BC=9F

No, the first call must go away.  In fact, even better, you can move the
entire contents of "if (!error)" inside the "case 0:".

Paolo
