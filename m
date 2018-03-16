Received: from eggs.gnu.org ([2001:4830:134:3::10]:34320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ewqM0-00054y-1D
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ewqLz-0005Cy-3e
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:29:08 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:51713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ewqLy-0005CP-TV
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:29:07 -0400
Received: by mail-wm0-x242.google.com with SMTP id h21so3394738wmd.1
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 07:29:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180316142503.GM3066@redhat.com>
References: <20180316142223.28745-1-marcandre.lureau@redhat.com>
	<20180316142503.GM3066@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 16 Mar 2018 15:29:04 +0100
Message-ID: <CAJ+F1CJJEi=5TZCZRe8NSEaJmfSp1cTYPEGedNtm3D0B4hw5SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi

On Fri, Mar 16, 2018 at 3:25 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> On Fri, Mar 16, 2018 at 03:22:23PM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> No need to close the TPM data socket on the emulator end, qemu will
>> close it after a SHUTDOWN. This avoids a race between close() and
>> read() in the TPM data thread.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  tests/tpm-emu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
>> index 4dada76834..8c2bd53cad 100644
>> --- a/tests/tpm-emu.c
>> +++ b/tests/tpm-emu.c
>> @@ -125,7 +125,7 @@ void *tpm_emu_ctrl_thread(void *data)
>>          case CMD_SHUTDOWN: {
>>              ptm_res res =3D 0;
>>              qio_channel_write(ioc, (char *)&res, sizeof(res), &error_ab=
ort);
>> -            qio_channel_close(s->tpm_ioc, &error_abort);
>> +            /* the tpm data thread is expected to finish now */
>>              g_thread_join(s->emu_tpm_thread);
>
> Won't this leave an orphaed FD open in the test suite ? Is it perhaps
> sufficient to just swap the order of the g_thread_join and qio_channel_cl=
ose
> calls, so that we join the thread before we close the channel that the
> thread is using ?

Isn't the socket close on the last unref? (at end of tpm_emu_tpm_thread())

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>



--=20
Marc-Andr=C3=A9 Lureau
