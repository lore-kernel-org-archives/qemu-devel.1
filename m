Received: from eggs.gnu.org ([2001:4830:134:3::10]:41635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYcsq-0003T7-Vp
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYcsn-00021r-TP
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:42:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dYcsn-00021J-Jf
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:42:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AAB84E33A
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 18:42:34 +0000 (UTC)
Date: Fri, 21 Jul 2017 15:42:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170721184227.GB2757@localhost.localdomain>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-6-ldoktor@redhat.com>
	<20170720182753.GV2757@localhost.localdomain>
	<6701dad4-40a5-7287-a4b8-a22e19b90ce2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6701dad4-40a5-7287-a4b8-a22e19b90ce2@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu.py: Use custom exceptions
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
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com

On Fri, Jul 21, 2017 at 08:37:34AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 20.7.2017 v 20:27 Eduardo Habkost napsal(a):
> > On Thu, Jul 20, 2017 at 06:28:09PM +0200, Luk=C3=A1=C5=A1 Doktor wrot=
e:
> >> The naked Exception should not be widely used. It makes sense to be =
a
> >> bit more specific and use better-suited custom exceptions. As a bene=
fit
> >> we can store the full reply in the exception in case someone needs i=
t
> >> when catching the exception.
> >>
> >> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> >> ---
> >>  scripts/qemu.py | 17 +++++++++++++++--
> >>  1 file changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/scripts/qemu.py b/scripts/qemu.py
> >> index 5948e19..2bd522f 100644
> >> --- a/scripts/qemu.py
> >> +++ b/scripts/qemu.py
> >> @@ -19,6 +19,19 @@ import subprocess
> >>  import qmp.qmp
> >> =20
> >> =20
> >> +class MonitorResponseError(qmp.qmp.QMPError):
> >> +    '''
> >> +    Represents erroneous QMP monitor reply
> >> +    '''
> >> +    def __init__(self, reply):
> >> +        try:
> >> +            desc =3D reply["error"]["desc"]
> >> +        except KeyError:
> >> +            desc =3D reply
> >> +        super(MonitorResponseError, self).__init__(desc)
> >> +        self.reply =3D reply
> >=20
> > This would require every user of self.reply to first check if
> > it's a string or dictionary.  All because of the "Monitor is
> > closed" case below:
> >=20
> I haven't used it for the `Monitor is closed` exception, so
> it's just to be able to store really broken reply safely.
> Anyway people can check whether the reply is a dict, or I can
> add `is_valid_reply` property which would check for
> `[error][desc]` presence (which is a bit more precise than just
> plain dict type checking).


Oops, I wasn't paying enough attention, sorry.  self.reply is
actually always set to the response from the monitor.

If you are just trying a safe fallback for 'desc' if the response
broken, what about using repr(reply) or json.dumps(reply) if
reply['error']['desc'] isn't set?

>=20
> >> +
> >> +
> >>  class QEMUMachine(object):
> >>      '''A QEMU VM'''
> >> =20
> >> @@ -197,9 +210,9 @@ class QEMUMachine(object):
> >>          '''
> >>          reply =3D self.qmp(cmd, conv_keys, **args)
> >>          if reply is None:
> >> -            raise Exception("Monitor is closed")
> >> +            raise qmp.qmp.QMPError("Monitor is closed")
> >=20
> > Should we really use the same exception type for this, if it's
> > not really a QMP monitor error reply, and won't even have a real
> > QMP reply in self.reply?
> >=20
> I wasn't sure but the same exception can be caused by other
> failures when obtaining replies so I think in case the monitor
> is closed we might expect the same exception. Would importing
> it in the top level of this module to become `qemu.QMPError`
> work for you better, or would you prefer IOError, RuntimeError
> or another custom exception?

I was not paying enough attention.  QMPError sounds good to me.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

>=20
> Luk=C3=A1=C5=A1
>=20
> >=20
> >>          if "error" in reply:
> >> -            raise Exception(reply["error"]["desc"])
> >> +            raise MonitorResponseError(reply)
> >>          return reply["return"]
> >> =20
> >>      def get_qmp_event(self, wait=3DFalse):
> >> --=20
> >> 2.9.4
> >>
> >=20
>=20
>=20




--=20
Eduardo
