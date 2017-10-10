Received: from eggs.gnu.org ([2001:4830:134:3::10]:48900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e22rw-0007yu-Cz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e22rr-0005rU-A0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:19:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1e22rr-0005rD-45
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:19:15 -0400
Date: Tue, 10 Oct 2017 18:19:13 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <594422884.28308183.1507673953337.JavaMail.zimbra@redhat.com>
In-Reply-To: <c2e72712-5f40-1fd8-f161-9d31887f63fe@linux.vnet.ibm.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-34-marcandre.lureau@redhat.com>
	<c2e72712-5f40-1fd8-f161-9d31887f63fe@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 33/42] tpm-passthrough: remove error
 cleanup from handle_device_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amarnath valluri <amarnath.valluri@intel.com>

Hi

----- Original Message -----
> On 10/09/2017 06:56 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Clean-up is handled by the create() function.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/tpm/tpm_passthrough.c | 15 ++-------------
> >   1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> > index aa9167e3c6..0806cf86af 100644
> > --- a/hw/tpm/tpm_passthrough.c
> > +++ b/hw/tpm/tpm_passthrough.c
> > @@ -261,27 +261,16 @@ tpm_passthrough_handle_device_opts(TPMPassthruSta=
te
> > *tpm_pt, QemuOpts *opts)
> >       if (tpm_pt->tpm_fd < 0) {
> >           error_report("Cannot access TPM device using '%s': %s",
> >                        tpm_pt->tpm_dev, strerror(errno));
> > -        goto err_free_parameters;
> > +        return -1;
> >       }
> >
> >       if (tpm_util_test_tpmdev(tpm_pt->tpm_fd, &tpm_pt->tpm_version)) {
> >           error_report("'%s' is not a TPM device.",
> >                        tpm_pt->tpm_dev);
> > -        goto err_close_tpmdev;
> > +        return -1;
> >       }
>=20
> I would prefer the cleanup to happen in the functions where the state is
> created...

This is the role for a destructor, no need to worry about local object chan=
ge cleanup.

I can drop the patch if you feel strongly about it, but I think it's a nice=
 code simplification.
