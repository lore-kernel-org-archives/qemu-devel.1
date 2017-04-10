Received: from eggs.gnu.org ([2001:4830:134:3::10]:42949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cxW27-0002Hk-8A
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cxW26-0000CW-9v
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:54:51 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:36617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cxW25-0000CI-UM
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:54:50 -0400
Received: by mail-lf0-x229.google.com with SMTP id s141so32120672lfe.3
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-10-git-send-email-amarnath.valluri@intel.com>
	<20170407144100.GL26896@redhat.com>
	<CAJ+F1CJ1wfP_RS25=gokRvk2y0+-_7pX8adzmBUMZPpaz=AOgw@mail.gmail.com>
	<094e28c1-b780-f8ff-fc6a-9f6dd3421a3a@intel.com>
In-Reply-To: <094e28c1-b780-f8ff-fc6a-9f6dd3421a3a@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Apr 2017 09:54:37 +0000
Message-ID: <CAJ+F1CKo=tAXKHzoY4mfZxc9V2N5+sszOJwPOVqkJZK2tD6vMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 9/9] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com

Hi

On Mon, Apr 10, 2017 at 9:33 AM Amarnath Valluri <amarnath.valluri@intel.co=
m>
wrote:

>
>
> On 07.04.2017 18:11, Marc-Andr=C3=A9 Lureau wrote:
>
> Hi
>
> On Fri, Apr 7, 2017 at 4:41 PM Daniel P. Berrange
>
> > +        .name =3D "data-path",
> > +        .type =3D QEMU_OPT_STRING,
> > +        .help =3D "Socket path to use for data exhange",
> > +    },
> > +    {
> > +        .name =3D "ctrl-path",
> > +        .type =3D QEMU_OPT_STRING,
> > +        .help =3D "Socket path to use for out-of-band control messages=
",
> > +    },
>
> I'm still not convinced by the need for 2 separate UNIX sockets, unless
> there's a performance reason, but that looks unlikely.
>
>
> We would also need something more than an implementation of the protocol
> that qemu is going to rely on as an external dependency.  A protocol
> specification would help to start the discussion.
>
> I would agree with you, Can we adopt the current swtpm's control interfac=
e
> as initial proposal.
>
>
Perhaps, but I think it would be a mistake to rely on it without some
review.


> Alternatively, I would suggest to not rely on a public protocol,
>
> What do you mean by public protocol here, can you please help me
> understanding this.
>
>
By "public protocol", I mean qemu communication with a foreign project,
swtpm or other.

If qemu grows new needs, or if the protocol is found limited or buggy, it
may change. Subtle interactions may break between various implementations.
The minimum would be some versioning or capabilities. A document describing
the states and messages allowed/denied & effects would be quite necessary.

Otoh, there doesn't seem to be other users of this protocol, or other
implementations. So it may make sense to make it qemu-specific, and thus
"private": the protocol and implementation can evolve without risk to break
other users. This gives us a lot more flexibility and control, and doesn't
have to be very strictly documented (although it is still better to be
strict, but requires more effort).

--=20
Marc-Andr=C3=A9 Lureau
