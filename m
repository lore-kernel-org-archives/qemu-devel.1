Received: from eggs.gnu.org ([2001:4830:134:3::10]:48533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYGLW-0008SU-Po
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dYGLS-00083b-SO
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:38:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dYGLS-00083O-Lv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:38:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA19C4A6EF
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 18:38:41 +0000 (UTC)
Date: Thu, 20 Jul 2017 15:38:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170720183832.GY2757@localhost.localdomain>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-10-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170720162815.19802-10-ldoktor@redhat.com>
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

On Thu, Jul 20, 2017 at 06:28:13PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> The "id" is a builtin method to get object's identity and should not be
> overridden. This might bring some issues in case someone was directly
> calling "cmd(..., id=3Did)" but I haven't found such usage on brief sea=
rch
> for "cmd\(.*id=3D".
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
>  scripts/qmp/qmp.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index a14b001..c3e0206 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -177,19 +177,19 @@ class QEMUMonitorProtocol(object):
>              print >>sys.stderr, "QMP:<<< %s" % resp
>          return resp
> =20
> -    def cmd(self, name, args=3DNone, id=3DNone):
> +    def cmd(self, name, args=3DNone, cmd_id=3DNone):
>          """
>          Build a QMP command and send it to the QMP Monitor.
> =20
>          @param name: command name (string)
>          @param args: command arguments (dict)
> -        @param id: command id (dict, list, string or int)
> +        @param cmd_id: command id (dict, list, string or int)
>          """
>          qmp_cmd =3D {'execute': name}
>          if args:
>              qmp_cmd['arguments'] =3D args
> -        if id:
> -            qmp_cmd['id'] =3D id
> +        if cmd_id:
> +            qmp_cmd['cmd_id'] =3D cmd_id

The member sent through the monitor should still be called "id".
i.e.:

    qmp_cmd['id'] =3D cmd_id


>          return self.cmd_obj(qmp_cmd)
> =20
>      def command(self, cmd, **kwds):
> --=20
> 2.9.4
>=20

--=20
Eduardo
