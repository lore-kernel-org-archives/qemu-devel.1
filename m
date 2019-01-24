Received: from eggs.gnu.org ([209.51.188.92]:34289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gmihf-0003d5-Ur
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gmihf-0008Ke-0y
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:22:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47380
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gmihe-0008KP-Sn
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:22:10 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0OHGrmH067377
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:22:10 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q7g0ee1ef-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:22:09 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 24 Jan 2019 17:22:08 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190113100531.1346024-3-basil@daynix.com>
References: <20190113100531.1346024-1-basil@daynix.com>
	<20190113100531.1346024-3-basil@daynix.com>
Date: Thu, 24 Jan 2019 11:18:46 -0600
Message-Id: <154835032684.21382.15416323949808181547@sif>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: fix send_response error
 handling
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

Quoting Basil Salman (2019-01-13 04:05:29)
> Sometimes qemu-ga fails to send a response to client due to memory alloca=
tion
> issues due to a large response message, this can be experienced while try=
ing
> to read large number of bytes using QMP command guest-file-read.

send_response has 2 areas that can fail:

1) When formatting the QDict *rsp from qmp_dispatch() into JSON via
qobject_to_json():

    payload_qstr =3D qobject_to_json(QOBJECT(payload));
    if (!payload_qstr) {
        return -EINVAL;
    }

But we can only reach that via qobject_to_json() calling qstring_new()
and that returning NULL. The qstring's initial size is independent of
the actual payload size. So I don't see how a large read would induce
this.

There is other code in qobject_to_json() -> to_json() that could maybe
hit an allocation failure once it start converting the payload to JSON,
but AFAICT that would cause a crash of qemu/qemu-ga once g_realloc()
finally fails to grow the qstring in qstring_append(), not an error
return.

So I don't think it's a bad idea to generate an error response like
you're doing in your patch for future cases, but I don't see how it
is reachable in the current code (even without the fix in patch 1).

Do you have a particular reproducer for this specific failure? Are
you sure it wasn't just the entire guest agent process crashing?

2) The other error you can get from send_response() is if there's
a problem writing things out to the actual communication channel,
in which case sending another error response likely won't help.

> =

> Added a check to send an error response to qemu-ga client in such cases.
> =

> Signed-off-by: Basil Salman <basil@daynix.com>
> ---
>  qga/main.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> =

> diff --git a/qga/main.c b/qga/main.c
> index 87a0711c14..964275c40c 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -561,6 +561,8 @@ static void process_command(GAState *s, QDict *req)
>  {
>      QDict *rsp;
>      int ret;
> +    QDict *ersp;
> +    Error *err =3D NULL;
> =

>      g_assert(req);
>      g_debug("processing command");
> @@ -569,9 +571,20 @@ static void process_command(GAState *s, QDict *req)
>          ret =3D send_response(s, rsp);
>          if (ret < 0) {
>              g_warning("error sending response: %s", strerror(-ret));
> +            goto err;
>          }
>          qobject_unref(rsp);
>      }
> +    return;
> +err:
> +    error_setg(&err, "Insufficient system resources exist to "
> +                      "complete the requested service");
> +    ersp =3D qmp_error_response(err);
> +    ret =3D send_response(s, ersp);
> +    if (ret < 0) {
> +        g_warning("error sending error response: %s", strerror(-ret));
> +    }
> +    qobject_unref(ersp);
>  }
> =

>  /* handle requests/control events coming in over the channel */
> -- =

> 2.17.2
>=20
