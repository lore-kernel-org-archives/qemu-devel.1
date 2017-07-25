Received: from eggs.gnu.org ([2001:4830:134:3::10]:36455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1da2Ve-0004FO-IM
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1da2VZ-0004Nh-WA
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:16:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1da2VZ-0004NC-Mr
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:16:29 -0400
Date: Tue, 25 Jul 2017 13:06:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170725160639.GO2757@localhost.localdomain>
References: <20170725150951.16038-1-ldoktor@redhat.com>
	<20170725150951.16038-6-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170725150951.16038-6-ldoktor@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/10] qemu.py: Use custom exceptions
 rather than Exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, apahim@redhat.com, mreitz@redhat.com, f4bug@amsat.org, armbru@redhat.com

On Tue, Jul 25, 2017 at 05:09:46PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> The naked Exception should not be widely used. It makes sense to be a
> bit more specific and use better-suited custom exceptions. As a benefit
> we can store the full reply in the exception in case someone needs it
> when catching the exception.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qemu.py | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 5948e19..e6df54c 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -19,6 +19,19 @@ import subprocess
>  import qmp.qmp
> =20
> =20
> +class MonitorResponseError(qmp.qmp.QMPError):
> +    '''
> +    Represents erroneous QMP monitor reply
> +    '''
> +    def __init__(self, reply):
> +        try:
> +            desc =3D reply["error"]["desc"]
> +        except KeyError:
> +            desc =3D reply
                      ^^^ (*)
> +        super(MonitorResponseError, self).__init__(repr(desc))

This will end up calling Exception.__init__.  I previously
suggested repr(desc) above(*) because I didn't know what happened
when the Exception.__init__ argument is not a string.

I couldn't find any documentation on the right argument types for
Exception.__init__.  The examples in the Python documentation[1]
don't call Exception.__init__ at all: they simply implement
__str__().

However, based on my testing and on the BaseException
documentation[2], I believe repr() isn't really necessary:

"If str() or unicode() is called on an instance of this class,
the representation of the argument(s) to the instance are
returned, or the empty string when there were no arguments."

So your previous version was good, already.

But maybe we could do this instead, to make the constructor as
simple as possible:

class MonitorResponseError(qmp.qmp.QMPError):
    def __init__(self, reply):
        self.reply =3D reply

    def __str__(self):
        return self.reply.get('error', {}).get('desc', repr(self.reply))


[1] https://docs.python.org/2/tutorial/errors.html#user-defined-exception=
s
[2] https://docs.python.org/2/library/exceptions.html#exceptions.BaseExce=
ption

> +        self.reply =3D reply
> +
> +
>  class QEMUMachine(object):
>      '''A QEMU VM'''
> =20
> @@ -197,9 +210,9 @@ class QEMUMachine(object):
>          '''
>          reply =3D self.qmp(cmd, conv_keys, **args)
>          if reply is None:
> -            raise Exception("Monitor is closed")
> +            raise qmp.qmp.QMPError("Monitor is closed")
>          if "error" in reply:
> -            raise Exception(reply["error"]["desc"])
> +            raise MonitorResponseError(reply)
>          return reply["return"]
> =20
>      def get_qmp_event(self, wait=3DFalse):
> --=20
> 2.9.4
>=20

--=20
Eduardo
