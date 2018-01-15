Received: from eggs.gnu.org ([2001:4830:134:3::10]:44417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1Yl-0000NM-BH
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1Ye-0005Us-HR
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:00:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb1Ye-0005UF-7O
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:00:00 -0500
Date: Mon, 15 Jan 2018 09:59:43 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180115095943.GB8218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171227011428.40996-1-programmingkidx@gmail.com>
	<20180110161453.GM3205@redhat.com>
	<F5EDE821-6D37-4C33-8489-BA99CF08ED45@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F5EDE821-6D37-4C33-8489-BA99CF08ED45@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] Add ability for user to specify mouse
 ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: peter.maydell@linaro.org, kraxel@redhat.com, qemu-devel@nongnu.org

On Fri, Jan 12, 2018 at 10:15:24PM -0500, Programmingkid wrote:
>=20
> > On Jan 10, 2018, at 11:14 AM, Daniel P. Berrange <berrange@redhat.com=
> wrote:
> >=20
> > On Tue, Dec 26, 2017 at 08:14:28PM -0500, John Arbuckle wrote:
> >> Currently the ungrab keys for the Cocoa and GTK interface are Contro=
l-Alt-g.
> >> This combination may not be very fun for the user to have to enter, =
so we
> >> now enable the user to specify their own key(s) as the ungrab key(s)=
. The
> >> list of keys that can be used is found in the file qapi/ui.json unde=
r QKeyCode.
> >> The max number of keys that can be used is three. The original ungra=
b keys
> >> still remain usable because there is a real risk of the user forgett=
ing=20
> >> the keys he or she specified as the ungrab keys. They remain as a pl=
an B
> >> if plan A is forgotten.
> >=20
> > This is a bad idea. A key reason to give a custom ungrab sequence, is=
 because
> > the user wants to be able to use the default ungrab sequence inside t=
he
> > guest. Always having the default ungrab sequence active prevents this=
.
>=20
> Sounds like a great idea.
>=20
> >=20
> >> Syntax: -ungrab <key-key-key>
> >>=20
> >> Example usage:  -ungrab home
> >> 	        -ungrab shift-ctrl
> >> 		-ungrab ctrl-x
> >> 		-ungrab pgup-pgdn
> >> 		-ungrab kp_5-kp_6
> >> 		-ungrab kp_4-kp_5-kp_6
> >=20
> > I'm in two minds about using '-' as a separator.  Perhaps '+' is a be=
tter
> > choice ?
>=20
> I think '-' is better because the user isn't required to push the shift=
 key or order to see the symbol unlike '+'.
>=20
> >=20
> >>=20
> >> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> >> ---
> >> v4 changes:
> >> - Removed initialization code for key_value_array.
> >> - Added void keyword to console_ungrab_key_sequence(),
> >>  and console_ungrab_key_string() functions.
> >>=20
> >> v3 changes:
> >> - Added the ability for any "sendkey supported" key to be used.
> >> - Added ability for one to three key sequences to be used.
> >>=20
> >> v2 changes:
> >> - Removed the "int i" code from the for loops.=20
> >>=20
> >> include/ui/console.h |  6 ++++++
> >> qemu-options.hx      |  2 ++
> >> ui/cocoa.m           | 48 +++++++++++++++++++++++++++++++++++++++--
> >> ui/console.c         | 60 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> >> vl.c                 |  3 +++
> >> 5 files changed, 117 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/include/ui/console.h b/include/ui/console.h
> >> index 580dfc57ee..37dc150268 100644
> >> --- a/include/ui/console.h
> >> +++ b/include/ui/console.h
> >> @@ -534,4 +534,10 @@ static inline void early_gtk_display_init(int o=
pengl)
> >> /* egl-headless.c */
> >> void egl_headless_init(void);
> >>=20
> >> +/* console.c */
> >> +void set_ungrab_seq(const char *new_seq);
> >> +int *console_ungrab_key_sequence(void);
> >> +const char *console_ungrab_key_string(void);
> >> +int console_ungrab_sequence_length(void);
> >=20
> > We don't need to have a console_ungrab_sequence_length() method if
> > we make the array returned by console_ungrab_key_sequence() be a
> > zero terminated array.
>=20
> I kind of liked having it but calculating it once in the front-end isn'=
t a problem.
>=20
> >=20
> >> diff --git a/ui/cocoa.m b/ui/cocoa.m
> >> index 330ccebf90..412a5fc02d 100644
> >> --- a/ui/cocoa.m
> >> +++ b/ui/cocoa.m
> >> @@ -303,6 +303,7 @@ - (float) cdx;
> >> - (float) cdy;
> >> - (QEMUScreen) gscreen;
> >> - (void) raiseAllKeys;
> >> +- (bool) user_ungrab_seq;
> >> @end
> >>=20
> >> QemuCocoaView *cocoaView;
> >> @@ -674,9 +675,24 @@ - (void) handleEvent:(NSEvent *)event
> >>                 }
> >>             }
> >>=20
> >> +            /*
> >> +             * This code has to be here because the user might use =
a modifier
> >> +             * key like shift as an ungrab key.
> >> +             */
> >> +            if ([self user_ungrab_seq] =3D=3D true) {
> >> +                [self ungrabMouse];
> >> +                return;
> >> +            }
> >>             break;
> >>         case NSEventTypeKeyDown:
> >>             keycode =3D cocoa_keycode_to_qemu([event keyCode]);
> >> +            [self toggleModifier: keycode];
> >> +
> >> +            // If the user is issuing the custom ungrab key sequenc=
e
> >> +            if ([self user_ungrab_seq] =3D=3D true) {
> >> +                [self ungrabMouse];
> >> +                return;
> >> +            }
> >=20
> > There's a small benefit to only processing the grab sequence in the
> > Up event, rather than Down event if we are clever with tracking
> > the key sequence.
> >=20
> > Check if each press as it comes in. If it is part of the ungrab
> > sequence, then record that is is pressed. If is is not part of
> > the ungrab sequence, the clear out all previously pressed keys.
> > Only trigger ungrab upon key release
> >=20
> > This means that you can use Ctrl+Alt  as your ungrab sequence
> > and still be able to press Ctrl+Alt+F1 and have it go to the
> > guest without triggering the grab sequence.
> >=20
> > ie, in your patch we get
> >=20
> > down(ctrl)
> > down(alt)
> > ..ungrab activates..
> >=20
> > with my suggest we would get
> >=20
> > down(ctrl)
> > down(alt)
> > up(ctrl)
> > up(alt)
> > ..ungrab activates..
> >=20
> > down(ctrl)
> > down(alt)
> > down(f1)
> > up(ctrl)
> > up(alt)
> > up(f1)
> > ..no ungrab activates..
> >=20
> > to do this I think you need a separate array for tracking the grab
> > instead of reusing the  toggleModifier() tracking.
>=20
> This is a challenge. I am currently coming close to being able to do th=
is.=20
>=20
> snip
>=20
> >>=20
> >> +/* Sets the mouse ungrab key sequence to what the user wants */
> >> +void set_ungrab_seq(const char *new_seq)
> >> +{
> >> +    char *buffer1 =3D (char *) malloc(strlen(new_seq) * sizeof(char=
));
> >> +    char *buffer2 =3D (char *) malloc(strlen(new_seq) * sizeof(char=
));
> >> +    int count =3D 0;
> >> +    int key_value;
> >> +    char *token;
> >> +    const char *separator =3D "-";  /* What the user places between=
 keys */
> >> +
> >> +    sprintf(buffer1, "%s", new_seq); /* edited by strtok */
> >> +    sprintf(buffer2, "%s", new_seq); /* used for ungrab_key_string =
*/
> >> +    ungrab_key_string =3D buffer2;
> >> +
> >> +    token =3D strtok(buffer1, separator);
> >> +    while (token !=3D NULL && count < max_keys) {
> >> +        /* Translate the names into Q_KEY_CODE values */
> >> +        key_value =3D index_from_key(token, strlen(token));
> >> +        if (key_value =3D=3D Q_KEY_CODE__MAX) {
> >> +            printf("-ungrab: unknown key: %s\n", token);
> >> +            exit(EXIT_FAILURE);
> >> +        }
> >> +        key_value_array[count] =3D key_value;
> >> +
> >> +        count++;
> >> +        token =3D strtok(NULL, separator);
> >> +    }
> >=20
> > Rather than this malloc+sprintf+strtok mix, you can just use the
> > glib function  g_strsplit() to break it into tokens.
>=20
> I really like these functions because they are so familiar and part of =
the ANSI standard.
>=20
>  CC      qga/qapi-generated/qga-qmp-marshal.o
> rm spapr-rtas.img spapr-rtas.o
>  CC      qemu-img.o
> /var/tmp/patchew-tester-tmp-m3pgevh1/src/ui/console.c:70:12: error: var=
iably modified =E2=80=98key_value_array=E2=80=99 at file scope
> static int key_value_array[max_keys + 1];
>            ^
> make: *** [ui/console.o] Error 1
> make: *** Waiting for unfinished jobs....
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
> Recently the automated patch checking system sent me this error. GCC on=
 my
> system doesn't have a problem with the code. Would you know a way to ge=
t
> around this issue?

IIUC, it does not like the fact that you are using a variable 'max_keys' =
to
declare the array size. I'd suggest using a constant instead, ie turning =
it
to #define MAX_KEYS 3


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
