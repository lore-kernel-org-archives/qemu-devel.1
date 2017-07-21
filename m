Received: from eggs.gnu.org ([2001:4830:134:3::10]:42505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYcx9-00056d-49
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYcx6-0004Zd-2v
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:47:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dYcx5-0004ZB-Pn
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:47:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0D18883A0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 18:47:02 +0000 (UTC)
Date: Fri, 21 Jul 2017 15:46:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170721184657.GD2757@localhost.localdomain>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-10-ldoktor@redhat.com>
	<20170720183832.GY2757@localhost.localdomain>
	<c964cd15-16f6-e330-ebac-f7e71918471d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c964cd15-16f6-e330-ebac-f7e71918471d@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/11] qmp.py: Avoid overriding a builtin
 object
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

On Fri, Jul 21, 2017 at 08:53:49AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 20.7.2017 v 20:38 Eduardo Habkost napsal(a):
> > On Thu, Jul 20, 2017 at 06:28:13PM +0200, Luk=C3=A1=C5=A1 Doktor wrot=
e:
> >> The "id" is a builtin method to get object's identity and should not=
 be
> >> overridden. This might bring some issues in case someone was directl=
y
> >> calling "cmd(..., id=3Did)" but I haven't found such usage on brief =
search
> >> for "cmd\(.*id=3D".
> >>
> >> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> >> ---
> >>  scripts/qmp/qmp.py | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> >> index a14b001..c3e0206 100644
> >> --- a/scripts/qmp/qmp.py
> >> +++ b/scripts/qmp/qmp.py
> >> @@ -177,19 +177,19 @@ class QEMUMonitorProtocol(object):
> >>              print >>sys.stderr, "QMP:<<< %s" % resp
> >>          return resp
> >> =20
> >> -    def cmd(self, name, args=3DNone, id=3DNone):
> >> +    def cmd(self, name, args=3DNone, cmd_id=3DNone):
> >>          """
> >>          Build a QMP command and send it to the QMP Monitor.
> >> =20
> >>          @param name: command name (string)
> >>          @param args: command arguments (dict)
> >> -        @param id: command id (dict, list, string or int)
> >> +        @param cmd_id: command id (dict, list, string or int)
> >>          """
> >>          qmp_cmd =3D {'execute': name}
> >>          if args:
> >>              qmp_cmd['arguments'] =3D args
> >> -        if id:
> >> -            qmp_cmd['id'] =3D id
> >> +        if cmd_id:
> >> +            qmp_cmd['cmd_id'] =3D cmd_id
> >=20
> > The member sent through the monitor should still be called "id".
> > i.e.:
> >=20
> >     qmp_cmd['id'] =3D cmd_id
> >=20
> Oups, sorry, automatic rename changed it and I forgot to fix
> this one back. I'll address this in v2. The main problem with
> this patch is it could break named arguments (`cmd(..., id=3Did)`
> calls) so I'm not sure it's worth including. But as mentioned
> in commit message I grepped full sources so we better fix this
> before someone starts using it.

I'm not convinced we need this patch, either.  What exactly
breaks if we don't apply this patch and somebody tries to use
cmd(..., id=3Did)?

--=20
Eduardo
