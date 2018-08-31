Received: from eggs.gnu.org ([2001:4830:134:3::10]:40894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fvmOm-0001Gt-29
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fvmOh-0005hu-3R
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:35:52 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fvmOg-0005ha-Uc
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:35:47 -0400
Received: by mail-io0-f196.google.com with SMTP id c22-v6so10931721iob.1
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 09:35:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <721c3a96-60a3-0d74-80d6-586d5bb7a2e1@weilnetz.de>
References: <20180831145314.14736-1-marcandre.lureau@redhat.com>
	<20180831145314.14736-4-marcandre.lureau@redhat.com>
	<721c3a96-60a3-0d74-80d6-586d5bb7a2e1@weilnetz.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Aug 2018 18:35:45 +0200
Message-ID: <CAMxuvawK3NP0ANN=JWUWXRN2F3Fq-Va2VegGxrLE7OVCA4+eZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] RFC: delete PID file on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "P. Berrange, Daniel" <berrange@redhat.com>, qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Fri, Aug 31, 2018 at 6:29 PM, Stefan Weil <sw@weilnetz.de> wrote:
> Am 31.08.2018 um 16:53 schrieb Marc-Andr=C3=A9 Lureau:
> [...]
>> +static const char *pid_file;
>> +
>> +static void qemu_unlink_pidfile(void)
>> +{
>> +    if (pid_file) {
>> +        unlink(pid_file);
>> +    }
>> +}
>> +
>>  bool machine_init_done;
>>
>>  void qemu_add_machine_init_done_notifier(Notifier *notify)
>> @@ -2927,7 +2936,6 @@ int main(int argc, char **argv, char **envp)
>>      const char *vga_model =3D NULL;
>>      const char *qtest_chrdev =3D NULL;
>>      const char *qtest_log =3D NULL;
>> -    const char *pid_file =3D NULL;
>>      const char *incoming =3D NULL;
>>      bool userconfig =3D true;
>>      bool nographic =3D false;
>> @@ -4000,6 +4008,7 @@ int main(int argc, char **argv, char **envp)
>>          error_reportf_err(err, "cannot create PID file: ");
>>          exit(1);
>>      }
>> +    atexit(qemu_unlink_pidfile);
>
>
> Could qemu_unlink_pidfile be combined with qemu_run_exit_notifiers to
> avoid an additional call of atexit from the same function (main)?
>
> Even if there is support for 32 or more atexit calls, it might be good
> to be a little bit more restrictive.

Sure, that would require an additional Notifier, but that's not much anyway=
.
I'll update the patch.
