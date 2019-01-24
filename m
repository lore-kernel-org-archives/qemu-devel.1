Received: from eggs.gnu.org ([209.51.188.92]:34297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gmihg-0003dR-CB
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gmihe-0008KL-Ji
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:22:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47068
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gmihe-0008JE-BQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:22:10 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0OHGsl9067444
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:22:08 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q7g0ee1e7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:22:08 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 24 Jan 2019 17:22:08 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190113100531.1346024-2-basil@daynix.com>
References: <20190113100531.1346024-1-basil@daynix.com>
	<20190113100531.1346024-2-basil@daynix.com>
Date: Thu, 24 Jan 2019 10:44:25 -0600
Message-Id: <154834826562.21382.15414554890276314999@sif>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qga-win: prevent crash when
 executing guest-file-read with large count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Basil Salman <basil@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Bishara AbuHattoum <bishara@daynix.com>

Quoting Basil Salman (2019-01-13 04:05:28)
> BZ: #1594054
> guest-file-read command is currently implelmented to read from a

*implemented

> file handle count number of bytes. when executed with a very large count =
number
> qemu-ga crashes.
> after some digging turns out that qemu-ga crashes after trying to allocate
> a buffer large enough to save the data read in it, the buffer was allocat=
ed using
> g_malloc0 which is not fail safe, and results a crash in case of failure.
> g_malloc0 was replaced with g_try_malloc0() which returns NULL on failure,
> A check was added for that case in order to prevent qemu-ga from crashing
> and to send a response to the qemu-ga client accordingly.
> =

> Signed-off-by: Basil Salman <basil@daynix.com>
> ---
>  qga/commands-win32.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 62e1b51dfe..4260faa573 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -345,7 +345,13 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, b=
ool has_count,
>      }
> =

>      fh =3D gfh->fh;
> -    buf =3D g_malloc0(count+1);
> +    buf =3D g_try_malloc0(count + 1);
> +    if (!buf) {
> +        error_setg(errp,
> +                   "failed to allocate sufficient memory"
> +                   "to complete the requested service");
> +        return read_data;

return NULL might be a little clearer since that's what we do in the
preceeding checks

> +    }
>      is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
>      if (!is_ok) {
>          error_setg_win32(errp, GetLastError(), "failed to read file");
> -- =

> 2.17.2
>=20
