Received: from eggs.gnu.org ([2001:4830:134:3::10]:43434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcWpy-0004Qx-69
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcWps-0006w6-H0
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:03:50 -0400
References: <20170728163004.21905-1-marcandre.lureau@redhat.com>
	<ff7e40d0-bf1f-e4e5-1844-f1f61e6ab50f@redhat.com>
	<CAJ+F1CJrki3DvYX_oOR++n_r8_Uai9OB+LiNyDnBtiU5qebtbA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3aea4cac-8991-c289-a476-6ad0434cedcd@redhat.com>
Date: Tue, 1 Aug 2017 15:03:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJrki3DvYX_oOR++n_r8_Uai9OB+LiNyDnBtiU5qebtbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] iscsi: use scsi_create_task()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, "open list:iSCSI" <qemu-block@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>

On 28/07/2017 19:52, Marc-Andr=C3=A9 Lureau wrote:
>=20
>     Stupid question: what's the benefit? =20
>=20
> scsi_create/scsi_free is a library API. If they have their own
> allocator, we better use it, or it may easily break, no?

Well, that would be an API breakage, but I see the point.  I think I
would prefer something like

static inline struct scsi_task *iscsi_create_task(...)
{
#if ...
    return scsi_create_task(...)
#else
    /* Older versions of libiscsi have a bug, so include our
     * implementation.
     */
    struct scsi_task *task =3D g_try_malloc0(sizeof(struct scsi_task));
    if (!task) {
        task;
    }

    memcpy(&task->cdb[0], cdb, cdb_size);
    task->cdb_size   =3D cdb_size;
    task->xfer_dir   =3D xfer_dir;
    task->expxferlen =3D expxferlen;
    return task;
#endif
}

>=20
>     Change malloc to g_new0 in the
>     existing code, and we even make it shorter...
>=20
>=20
> replacing malloc with g_new is the subject of another upcoming series :=
)
> (https://github.com/elmarco/clang-tools-extra/blob/master/clang-tidy/qe=
mu/UseGnewCheck.cpp)
> =20
