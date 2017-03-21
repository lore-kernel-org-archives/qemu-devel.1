Received: from eggs.gnu.org ([2001:4830:134:3::10]:54761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cqNru-00057E-VN
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cqNrt-0001F1-NR
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:46:51 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cqNrt-0001Ek-9z
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:46:49 -0400
Received: by mail-lf0-x243.google.com with SMTP id g70so13777123lfh.3
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-5-marcandre.lureau@redhat.com>
	<84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
	<87h92xk5p7.fsf@dusky.pond.sub.org>
	<7da78125-495b-4a2b-6383-d0ae22ba282b@redhat.com>
	<1815445054.3686730.1489411694165.JavaMail.zimbra@redhat.com>
	<CAJ+F1CKMUGA26PhTchxL3GNBJr11JMdS-eujvhF3gSyLULjbXg@mail.gmail.com>
	<878tnyk223.fsf@dusky.pond.sub.org>
	<a2b4d4d4-f141-f70a-ef62-233e1ddb740b@redhat.com>
In-Reply-To: <a2b4d4d4-f141-f70a-ef62-233e1ddb740b@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Mar 2017 17:46:36 +0000
Message-ID: <CAJ+F1CKHS=cou3YQpdE+oeZHPSySRxLuVhYghpkN+mtd02+gDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/21] qobject: add quint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com

Hi

On Tue, Mar 21, 2017 at 9:06 PM Eric Blake <eblake@redhat.com> wrote:

> On 03/21/2017 11:49 AM, Markus Armbruster wrote:
>
> >
> > QMP clients that work around the "large positive integers are rejected"
> > bugs by sending large negative ones instead may well exist.  Fixing the
> > interface would break them.  Depressing.  Eric, could you have a peek a=
t
> > libvirt?
>
> Yes, libvirt is such a client already.  From
> util/virjson.c:virJSONValueObjectAddVArgs():
>
>
>  * Adds the key-value pairs supplied as variable argument list to @obj.
>  *
>  * Keys look like   s:name  the first letter is a type code:
> ...
>  * U: unsigned long integer value (see below for quirks)
>  * P: unsigned long integer value, omitted if zero
> ...
>         case 'P':
>         case 'U': {
>             /* qemu silently truncates numbers larger than LLONG_MAX,
>              * so passing the full range of unsigned 64 bit integers
>              * is not safe here.  Pass them as signed 64 bit integers
>              * instead.
>              */
>             long long val =3D va_arg(args, long long);
>
>             if (!val && type =3D=3D 'P')
>                 continue;
>
>             rc =3D virJSONValueObjectAppendNumberLong(obj, key, val);
>         }   break;
>
> So if we "fix" QMP to reject negative values in place of large unsigned
> values, we'll need to also fix libvirt to have a way to introspect the
> difference and cope accordingly.  (I'm thinking that we'll have to keep
> the negative parsing indefinitely, and can merely improve the parser to
> also parse large positive - but that we can still reject values <
> INT64_MIN that would have a weird wraparound).
>

Currently, parsing is done without expected type information. So if the
number fits in an int64, it should be a QINT, otherwise a QFLOAT (see
parse_literal). With this series, it will try QUINT before QFLOAT. But what
I was afraid though is that the int is sometime assigned back to a uint64.
And with my series, get_uint() will fail if the number is negative int, but
for compatibility reasons, I think it should cast it instead. We may want
to have a qmp capability bit to change this silent casting behaviour.
--=20
Marc-Andr=C3=A9 Lureau
