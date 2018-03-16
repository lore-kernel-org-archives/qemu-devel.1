Received: from eggs.gnu.org ([2001:4830:134:3::10]:34728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewqNg-0006GW-2X
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewqNc-00078p-8Q
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:30:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewqNc-000781-3K
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:30:48 -0400
Date: Fri, 16 Mar 2018 14:30:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316143040.GO3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180316142223.28745-1-marcandre.lureau@redhat.com>
	<20180316142503.GM3066@redhat.com>
	<CAJ+F1CJJEi=5TZCZRe8NSEaJmfSp1cTYPEGedNtm3D0B4hw5SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJJEi=5TZCZRe8NSEaJmfSp1cTYPEGedNtm3D0B4hw5SQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: fix tpm-crb tpm-tis tests race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Fri, Mar 16, 2018 at 03:29:04PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Mar 16, 2018 at 3:25 PM, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> > On Fri, Mar 16, 2018 at 03:22:23PM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> >> No need to close the TPM data socket on the emulator end, qemu will
> >> close it after a SHUTDOWN. This avoids a race between close() and
> >> read() in the TPM data thread.
> >>
> >> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  tests/tpm-emu.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
> >> index 4dada76834..8c2bd53cad 100644
> >> --- a/tests/tpm-emu.c
> >> +++ b/tests/tpm-emu.c
> >> @@ -125,7 +125,7 @@ void *tpm_emu_ctrl_thread(void *data)
> >>          case CMD_SHUTDOWN: {
> >>              ptm_res res =3D 0;
> >>              qio_channel_write(ioc, (char *)&res, sizeof(res), &erro=
r_abort);
> >> -            qio_channel_close(s->tpm_ioc, &error_abort);
> >> +            /* the tpm data thread is expected to finish now */
> >>              g_thread_join(s->emu_tpm_thread);
> >
> > Won't this leave an orphaed FD open in the test suite ? Is it perhaps
> > sufficient to just swap the order of the g_thread_join and qio_channe=
l_close
> > calls, so that we join the thread before we close the channel that th=
e
> > thread is using ?
>=20
> Isn't the socket close on the last unref? (at end of tpm_emu_tpm_thread=
())

Oh yes, that is true. I should have looked at more than just diff context=
.
In that case

  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
