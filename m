Received: from eggs.gnu.org ([2001:4830:134:3::10]:34522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHl-0002Y1-5H
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHi-0003oB-PB
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45478
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHi-0003mU-Hr
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:34 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJcfo3131158
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:33 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g840atccd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:33 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:31 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-11-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-11-armbru@redhat.com>
Date: Sun, 18 Feb 2018 16:43:54 -0600
Message-Id: <151899383495.12376.8016627258791627753@sif>
Subject: Re: [Qemu-devel] [PATCH v2 10/29] qapi: Touch generated files only
 when they change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2018-02-11 03:35:48)
> A massive number of objects depends on QAPI-generated headers.  In my
> "build everything" tree, it's roughly 4800 out of 5100.  This is
> particularly annoying when only some of the generated files change,
> say for a doc fix.
> =

> Improve qapi-gen.py to touch its output files only if they actually
> change.  Rebuild time for a QAPI doc fix drops from many minutes to a
> few seconds.  Rebuilds get faster for certain code changes, too.  For
> instance, adding a simple QMP event now recompiles less than 200
> instead of 4800 objects.  But adding a QAPI type is as bad as ever;
> we've clearly got more work to do.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  scripts/qapi/common.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> =

> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 8290795dc1..2e58573a39 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1951,9 +1951,16 @@ class QAPIGen(object):
>              except os.error as e:
>                  if e.errno !=3D errno.EEXIST:
>                      raise
> -        f =3D open(os.path.join(output_dir, fname), 'w')
> -        f.write(self._top(fname) + self._preamble + self._body
> +        fd =3D os.open(os.path.join(output_dir, fname),
> +                     os.O_RDWR | os.O_CREAT, 0666)
> +        f =3D os.fdopen(fd, 'r+')
> +        text =3D (self._top(fname) + self._preamble + self._body
>                  + self._bottom(fname))
> +        oldtext =3D f.read(len(text) + 1)
> +        if text !=3D oldtext:
> +            f.seek(0)
> +            f.truncate(0)
> +            f.write(text)
>          f.close()
> =

> =

> -- =

> 2.13.6
>=20
