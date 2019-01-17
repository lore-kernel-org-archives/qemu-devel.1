Received: from eggs.gnu.org ([209.51.188.92]:43054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk3rs-00057s-8L
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk3rp-0001QA-N8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:21:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gk3rp-0001Js-EC
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:21:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-2-berrange@redhat.com>
	<a53244ea-4ff3-c5d6-73b2-9f839b6b0195@redhat.com>
	<20190116092741.GB20275@redhat.com>
Date: Thu, 17 Jan 2019 10:21:34 +0100
In-Reply-To: <20190116092741.GB20275@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Wed, 16 Jan 2019 09:27:41 +0000")
Message-ID: <8736pr63mp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/12] chardev: fix validation of options
 for QMP created chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Yongji Xie <elohimes@gmail.com>, Eric Blake <eblake@redhat.com>

Eric, there's a QAPI code generation idea at the end.

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jan 16, 2019 at 06:07:41AM +0100, Thomas Huth wrote:
>> On 2019-01-15 15:52, Daniel P. Berrang=C3=A9 wrote:
>> > The TLS creds option is not valid with certain address types. The user
>> > config was only checked for errors when parsing legacy QemuOpts, thus
>> > the user could pass unsupported values via QMP.
>> >=20
>> > Pull all code for validating options out into a new method
>> > qmp_chardev_validate_socket, that is called from the main
>> > qmp_chardev_open_socket method. This adds a missing check for rejecting
>> > TLS creds with the vsock address type.
>> >=20
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  chardev/char-socket.c | 92 +++++++++++++++++++++++++++++++------------
>> >  1 file changed, 66 insertions(+), 26 deletions(-)
>> >=20
>> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> > index eaa8e8b68f..6669acb35f 100644
>> > --- a/chardev/char-socket.c
>> > +++ b/chardev/char-socket.c
>> > @@ -987,6 +987,65 @@ static gboolean socket_reconnect_timeout(gpointer=
 opaque)
>> >      return false;
>> >  }
>> >=20=20
>> > +
>>=20
>> Please remove the additional empty line.
>
> Having two blanks lines between functions is intentional to
> give visual separation.
>
>> > +static bool qmp_chardev_validate_socket(ChardevSocket *sock,
>> > +                                        SocketAddress *addr,
>> > +                                        Error **errp)
>> > +{
>> > +    /* Validate any options which have a dependancy on address type */
>>=20
>> I'd maybe rather write "dependency" which is AFAIK the more common
>> spelling - but I'm not a native speaker, so feel free to ignore me here.

For what it's worth, my dictionary wants dependency.

>> > +    switch (addr->type) {
>> > +    case SOCKET_ADDRESS_TYPE_FD:
>> > +        if (sock->has_reconnect) {
>> > +            error_setg(errp,
>> > +                       "'reconnect' option is incompatible with "
>> > +                       "'fd' address type");
>> > +            return false;
>> > +        }
>> > +        if (sock->has_tls_creds &&
>> > +            !(sock->has_server && sock->server)) {
>> > +            error_setg(errp,
>> > +                       "'tls_creds' option is incompatible with "
>> > +                       "'fd' address type as client");
>> > +            return false;
>> > +        }
>> > +        break;
>> > +
>> > +    case SOCKET_ADDRESS_TYPE_UNIX:
>> > +        if (sock->has_tls_creds) {
>> > +            error_setg(errp,
>> > +                       "'tls_creds' option is incompatible with "
>> > +                       "'unix' address type");
>> > +            return false;
>> > +        }
>> > +        break;
>> > +
>> > +    case SOCKET_ADDRESS_TYPE_INET:
>> > +        break;
>>=20
>> You could drop the empty case.
>
> I preferred to explicitly list all cases, so it is clear what
> needs to be handled here when further checks are added later.

Matter of taste, your choice unless maintainer overrules.

>>=20
>> > +    case SOCKET_ADDRESS_TYPE_VSOCK:
>> > +        if (sock->has_tls_creds) {
>> > +            error_setg(errp,
>> > +                       "'tls_creds' option is incompatible with "
>> > +                       "'vsock' address type");
>> > +            return false;
>> > +        }
>> > +
>
> Opps, missing default.

I guess you mean break.

>> > +    default:
>> > +        break;
>>=20
>> You could drop the empty default case.
>
> If that is not there, then the compiler forces the
> listing of SOCKET_ADDRESS_TYPE__MAX instead due
> to -Wswitch

I wonder whether generating something like

    typedef enum SocketAddressType {
        SOCKET_ADDRESS_TYPE_INET,
        SOCKET_ADDRESS_TYPE_UNIX,
        SOCKET_ADDRESS_TYPE_VSOCK,
        SOCKET_ADDRESS_TYPE_FD,
    } SocketAddressType;

    #define SOCKET_ADDRESS_TYPE__MAX (SOCKET_ADDRESS_TYPE_FD + 1)

would be better.
