Received: from eggs.gnu.org ([2001:4830:134:3::10]:33338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dvNMu-0005Gk-Fn
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dvNMp-0006uq-FD
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:47:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dvNMp-0006uV-5z
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:47:39 -0400
Date: Fri, 22 Sep 2017 09:47:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170922124735.GV3030@localhost.localdomain>
References: <20170921162234.847-1-ehabkost@redhat.com>
	<94b1569d-806a-98f3-7056-8f6a1b78e55c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94b1569d-806a-98f3-7056-8f6a1b78e55c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu.py: Call logging.basicConfig()
 automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Fam Zheng <famz@redhat.com>, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com

On Fri, Sep 22, 2017 at 10:37:44AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 21.9.2017 v 18:22 Eduardo Habkost napsal(a):
> > Not all scripts using qemu.py configure the Python logging
> > module, and end up generating a "No handlers could be found for
> > logger" message instead of actual log messages.
> >=20
> > To avoid requiring every script using qemu.py to configure
> > logging manually, call basicConfig() when creating a QEMUMachine
> > object.  This won't affect scripts that already set up logging,
> > but will ensure that scripts that don't configure logging keep
> > working.
> >=20
> > Reported-by: Kevin Wolf <kwolf@redhat.com>
> > Fixes: 4738b0a85a0c2031fddc71b51cccebce0c4ba6b1
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  scripts/qemu.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index 5e02dd8e78..73d6031e02 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -89,6 +89,9 @@ class QEMUMachine(object):
> >          self._qmp =3D None
> >          self._qemu_full_args =3D None
> > =20
> > +        # just in case logging wasn't configured by the main script:
> > +        logging.basicConfig(level=3D(logging.DEBUG if debug else log=
ging.WARN))
> > +
> >      def __enter__(self):
> >          return self
> > =20
> >=20
>=20
> Hello Eduardo,
>=20
> what troubles me about this approach is it enables debug based
> on first instance arguments, while other instances might use a
> different value. Ideally we should create `"%s.%s" % (__name__,
> id(self))` logger per each instance and only set this log level
> there. The same would have to happen for QMP and other modules,
> which should either use the configured instance's logger, or
> create own logger as a child of that logger and optionally
> tweaked the levels there (if necessary), so the result would
> be:
>=20
> QEMUMachine(debug=3DTrue)
> QEMUMachine(debug=3DFalse)
>=20
> qemu.139855463298312: DEBUG: Starting instance 139855463298312
> qemu.139855463298312.qmp: DEBUG: Initializing connection to qmp
> qemu.139855463298312: INFO: Started qemu cmd...
> qemu.139855463216512: INFO: Started qemu cmd...
>=20
> while with your patch you get:
>=20
> qemu.139855463298312: DEBUG: Starting instance 139855463298312
> qemu.139855463298312.qmp: DEBUG: Initializing connection to qmp
> qemu.139855463298312: INFO: Started qemu cmd...
> qemu.139855463216512: DEBUG: Starting instance 139855463298312
> qemu.139855463216512.qmp: DEBUG: Initializing connection to qmp
> qemu.139855463216512: INFO: Started qemu cmd...
>=20
>=20

IMO, the solution for that is to obsolete the 'debug' parameter
and use the Python logging configuration to control QEMUMachine
logging.  Most (or all?) scripts have a global verbosity setting,
anyway.

> But mine approach would break other scripts that call
> logging.baseConfig (eg. qemu/device-crash-test), because they
> rely on root logger's log-level (because `import qemu` would
> have issued logging.baseConfig). I can't come-up with a better
> alternative and this indeed fixes the issues with scripts using
> qemu without initializing loggers so considering this as a
> **hotfix**:
>=20
> Acked-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

Thanks!

>=20
> But we should focus on fixing all the entry points (either
> initialize from all of them, or force-create the root logger
> based on the entry-point requirements). Kevin, could you please
> share the exact reproducer? I used a custom file importing
> QEMUMachine() with a some added LOG calls.
>=20
> Luk=C3=A1=C5=A1
>=20

--=20
Eduardo
