Received: from eggs.gnu.org ([2001:4830:134:3::10]:44163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxZO9-0003mH-6T
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxZO4-0001N0-CN
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:02:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxZO4-0001L0-0x
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:02:00 -0400
Date: Thu, 28 Sep 2017 11:01:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170928140150.GS4115@localhost.localdomain>
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-5-ehabkost@redhat.com>
	<20170927133321.GB8521@lemon.lan>
	<20170927134431.GN21016@localhost.localdomain>
	<7b84fb9c-9969-c9d5-8ede-2d54c3825ea6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b84fb9c-9969-c9d5-8ede-2d54c3825ea6@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fixup! scripts: Remove debug parameter
 from QEMUMonitorProtocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On Thu, Sep 28, 2017 at 11:33:57AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 27.9.2017 v 15:44 Eduardo Habkost napsal(a):
> > On Wed, Sep 27, 2017 at 09:33:21PM +0800, Fam Zheng wrote:
> >> On Wed, 09/27 10:03, Eduardo Habkost wrote:
> >>> @@ -51,7 +54,6 @@ class QEMUMonitorProtocol(object):
> >>>          """
> >>>          self.__events =3D []
> >>>          self.__address =3D address
> >>> -        self._debug =3D debug
> >>
> >> Should you also drop the debug parameter from the method?
> >>
> >>>          self.__sock =3D self.__get_sock()
> >>>          self.__sockfile =3D None
> >>>          if server:
> >>> @@ -83,8 +85,7 @@ class QEMUMonitorProtocol(object):
> >>>                  return
> >>>              resp =3D json.loads(data)
> >>>              if 'event' in resp:
> >>> -                if self._debug:
> >>> -                    print >>sys.stderr, "QMP:<<< %s" % resp
>=20
> This is the only user of `sys` import, please remove it as
> well. Apart from this it looks good, although you might
> consider using `__name__` instead of hardcoded `QMP` in `logger
> =3D logging.getLogger(__name__)` for the sake of consistency
> (people might expect it to correlate with the module name).

I will remove 'import sys' in v2, but I disagree about using the
module name: prefixing them with "QMP" makes them more readable
and familiar than using "qmp.qmp".

Thanks!

>=20
> Luk=C3=A1=C5=A1
>=20
> >>> +                self.logger.debug("<<< %s", resp)
> >>>                  self.__events.append(resp)
> >>>                  if not only_event:
> >>>                      continue
> >>> @@ -164,8 +165,7 @@ class QEMUMonitorProtocol(object):
> >>>          @return QMP response as a Python dict or None if the conne=
ction has
> >>>                  been closed
> >>>          """
> >>> -        if self._debug:
> >>> -            print >>sys.stderr, "QMP:>>> %s" % qmp_cmd
> >>> +        self.logger.debug("<<< %s", qmp_cmd)
> >>
> >> This should be ">>> %s".
> >>
> >=20
> > Fixed.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  scripts/qmp/qmp.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> > index be79d7aa80..369d9fef39 100644
> > --- a/scripts/qmp/qmp.py
> > +++ b/scripts/qmp/qmp.py
> > @@ -40,7 +40,7 @@ class QEMUMonitorProtocol(object):
> >      #: Socket's timeout
> >      timeout =3D socket.timeout
> > =20
> > -    def __init__(self, address, server=3DFalse, debug=3DFalse):
> > +    def __init__(self, address, server=3DFalse):
> >          """
> >          Create a QEMUMonitorProtocol class.
> > =20
> > @@ -165,7 +165,7 @@ class QEMUMonitorProtocol(object):
> >          @return QMP response as a Python dict or None if the connect=
ion has
> >                  been closed
> >          """
> > -        self.logger.debug("<<< %s", qmp_cmd)
> > +        self.logger.debug(">>> %s", qmp_cmd)
> >          try:
> >              self.__sock.sendall(json.dumps(qmp_cmd))
> >          except socket.error as err:
> >=20
>=20
>=20




--=20
Eduardo
