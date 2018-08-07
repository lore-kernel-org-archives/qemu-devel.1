Received: from eggs.gnu.org ([2001:4830:134:3::10]:36154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fmzJ9-00036S-HN
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fmzJ8-0006ep-GQ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:33:43 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fmzJ8-0006eV-9V
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:33:42 -0400
Received: by mail-wm0-x244.google.com with SMTP id w24-v6so17499515wmc.1
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 03:33:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180807101505.GF7335@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
	<20180807101505.GF7335@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Aug 2018 12:33:40 +0200
Message-ID: <CAJ+F1C+=aucconH7EZ8D2g_Wir2wEeq4GMobK+jNPZ8b0LbZKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/10] display: add -display app launching
 external application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Tue, Aug 7, 2018 at 12:15 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> On Fri, Aug 03, 2018 at 07:36:14PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Add a new display backend that will configure Spice to allow a remote
>> client to control QEMU in a similar fashion as other display backend
>> like GTK.
>>
>> For this to work, we set up Spice server with a unix socket, and
>> register a VC chardev that will be exposed as Spice ports. A QMP
>> monitor is also exposed as a Spice port, this allows the remote client
>> fuller qemu control and state handling.
>>
>> - doesn't handle VC set_echo() - this doesn't seem a strong
>>   requirement, very few front-end use it
>> - spice options can be tweaked with other -spice arguments
>> - Windows support shouldn't be hard to do, but will probably use a TCP
>>   port instead
>> - we may want to watch the child process to quit automatically if it
>>   crashed
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>> +    type_register(&char_vc_type_info);
>> +
>> +    sock_path =3D g_strjoin("", tmp_dir, "/", "spice.sock", NULL);
>> +    qopts =3D qemu_opts_create(qemu_find_opts("spice"), NULL, 0, &error=
_abort);
>> +    qemu_opt_set(qopts, "disable-ticketing", "on", &error_abort);
>> +    qemu_opt_set(qopts, "unix", "on", &error_abort);
>> +    qemu_opt_set(qopts, "addr", sock_path, &error_abort);
>> +    qemu_opt_set(qopts, "image-compression", "off", &error_abort);
>> +    qemu_opt_set(qopts, "streaming-video", "off", &error_abort);
>> +    qemu_opt_set(qopts, "gl", opts->has_gl ? "on" : "off", &error_abort=
);
>
> Hmm, so ultimately "-display app" is just syntactic sugar for a hardcoded
> set of "-display spice" arguments, plus automatic launching of the client
> app.  I'm thinking users may well ask for ability to control some of thos=
e

You can do it via additional -spice arguments.

> spice arguments over time.  So if we want auto-launching of a remote app,
> I think it is preferrable to do it via extra args to the existing
> "-display spice" format. eg we could add a "client=3Dyes|no" to control
> launching the client
>
>    -display spice,client=3Dyes

There is no -display spice, atm.

However there is a -display vnc.

It's a bit unclear to me the relation between -display and
-vnc/-spice/-curses etc. In the end, I tend to think of -display foo
as a shortcut for a longer -foo configuration.

So -display spice,client=3Dyes is a reasonable proposal to me, making it
clear that it will run spice. (client=3Dyes is less clear to me but
fine)

I wanted a simple and short replacement for "gtk", "app" was generic
enough, and could be also further tweaked if needed (specify vnc,
spice, auto-quit etc)


>
> would do what your "-display app" proposes, and still let users tweak
> all the other spice args as desired.  Another option "autoquit=3Dyes|no"
> could control whether QEMU automatically exits when the client quits,
> vs whether it stays alive.

Yes, I haven't looked at that in details, but we could either have
extra URI args, use a .vv file with extra config keys, use a dedicated
spice message to tell the client, or have a global client config. Too
many options to chose from :)

--=20
Marc-Andr=C3=A9 Lureau
