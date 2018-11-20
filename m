Received: from eggs.gnu.org ([2001:4830:134:3::10]:56064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gP48U-0001ag-PS
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gP48T-00021d-S4
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:24:06 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gP48T-00020q-Kq
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:24:05 -0500
Received: by mail-wm1-x342.google.com with SMTP id 79so4784876wmo.0
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 03:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20181120072239.512-1-ppandit@redhat.com>
	<CAJ+F1CJUWy6nw5+4anpctoH5KkkxG42xtfe_0Ro5=mMg7DVHUw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJUWy6nw5+4anpctoH5KkkxG42xtfe_0Ro5=mMg7DVHUw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 20 Nov 2018 15:23:51 +0400
Message-ID: <CAJ+F1CLcmBXN-P-HmWFDUGa7PvXrxYxFiB0ow-5KLrB5hw4p0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] tpm: check localities index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Huawei PSIRT <PSIRT@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

Hi

On Tue, Nov 20, 2018 at 12:02 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Nov 20, 2018 at 11:24 AM P J P <ppandit@redhat.com> wrote:
> >
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > While performing mmio device r/w operations, guest could set 'addr'
> > parameter such that 'locty' index exceeds TPM_TIS_NUM_LOCALITIES=3D5
> > after setting new 'locty' via 'tpm_tis_new_active_locality'.
> > Add check to avoid OOB access.
> >
> > Reported-by: Cheng Feng <PSIRT@huawei.com>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > ---
> >  hw/tpm/tpm_tis.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > Update: add assert() calls
> >   -> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00912.htm=
l
> >
> > diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> > index 12f5c9a759..d6bf3ceb26 100644
> > --- a/hw/tpm/tpm_tis.c
> > +++ b/hw/tpm/tpm_tis.c
> > @@ -293,6 +293,7 @@ static void tpm_tis_request_completed(TPMIf *ti, in=
t ret)
> >      uint8_t locty =3D s->cmd.locty;
> >      uint8_t l;
> >
> > +    assert(TPM_TIS_IS_VALID_LOCTY(locty));
> >      if (s->cmd.selftest_done) {
> >          for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
> >              s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
> > @@ -401,6 +402,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwa=
ddr addr,
> >      uint32_t avail;
> >      uint8_t v;
> >
> > +    assert(TPM_TIS_IS_VALID_LOCTY(locty));
>
> This is probably not really helping,
> Right after tpm_tis_locality_from_addr() you can expect IS_VALID_LOCTY

unless, the mmio memory range is made bigger, (which is unlikely).
But this may be enough to justify the additional assert().

>
>
> >      if (tpm_backend_had_startup_error(s->be_driver)) {
> >          return 0;
> >      }
> > @@ -523,6 +525,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
> >      uint16_t len;
> >      uint32_t mask =3D (size =3D=3D 1) ? 0xff : ((size =3D=3D 2) ? 0xff=
ff : ~0);
> >
> > +    assert(TPM_TIS_IS_VALID_LOCTY(locty));
> >      trace_tpm_tis_mmio_write(size, addr, val);
> >
> >      if (locty =3D=3D 4) {
> > @@ -642,7 +645,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
> >              }
> >          }
> >
> > -        if (set_new_locty) {
> > +        if (set_new_locty && TPM_TIS_IS_VALID_LOCTY(active_locty)) {
> >              tpm_tis_new_active_locality(s, active_locty);
> >          }
> >
>
> tpm_tis_new_active_locality() has explicit code handling for !IS_VALID_LO=
CTY.
>
> > --
> > 2.17.2
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau
