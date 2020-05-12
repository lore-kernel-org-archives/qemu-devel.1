Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A515C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DBF20675
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="deTQ4dx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DBF20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYU2h-0008UV-Vk
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYU1m-0007cU-8C
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:28:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYU1k-0006d6-IN
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:28:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CCH26J015852;
 Tue, 12 May 2020 12:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=eJL0bIOiCDEuncLqfcsJrBTubCNznnWsyjZ/TkjWfek=;
 b=deTQ4dx+RB8jvESuGIuAnOVcSR8DvisXYocpCCI70gQ5mg4lg+Ae+aXmiaEgvY+Zadwr
 /32O5ikpNQrUJt8nmXCvrLV4S3AzgTg4ql6/XMjrcL44UdH1SpoesrAPx3cANlAZ92KC
 9Hy+HmNQ5qQ0F2JJ8rhjApouPrqJmCzKsx4MO8PluZsX6edPrKWqnZSltuFk3aYPTAdk
 66cp96NuzoamhkpH5iWxwARKukirUti7qFg3ypTViTsdYnf5wErRycP2FDbxzbLc5rl4
 q7f67tPzGgRmhM4g4NxrF8TmzM1rjnd3HZFPukARiGgzAWF/xcpvEv1/qnkq9DGE84QE 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 30x3gsjmbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 12:28:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CCIZC9002302;
 Tue, 12 May 2020 12:28:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 30xbgjecr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 12:28:44 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04CCShqo027657;
 Tue, 12 May 2020 12:28:43 GMT
Received: from dhcp-10-39-202-98.vpn.oracle.com (/10.39.202.98)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 05:28:42 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH RESEND v6 12/36] multi-process: add functions to
 synchronize proxy and remote endpoints
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200512102120.GC300009@stefanha-x1.localdomain>
Date: Tue, 12 May 2020 08:28:39 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5540C92-59DD-45DB-9A9A-956C845B4592@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <7542e59e646421515051902fcd05fbb69fa4d866.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512102120.GC300009@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=3 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120093
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 07:56:54
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On May 12, 2020, at 6:21 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Wed, Apr 22, 2020 at 09:13:47PM -0700, elena.ufimtseva@oracle.com =
wrote:
>> From: Jagannathan Raman <jag.raman@oracle.com>
>>=20
>> In some cases, for example MMIO read, QEMU has to wait for the remote =
to
>> complete a command before proceeding. An eventfd based mechanism is
>> added to synchronize QEMU & remote process.
>=20
> Why are temporary eventfds used instead of sending a reply message =
from
> the remote device program back to QEMU?

Originally, we were envisioning a scenario where the remote process =
would
interrupt QEMU with a message. We used separate eventfds to distinguish
the two.

>=20
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> ---
>> include/io/mpqemu-link.h |  7 +++++
>> io/mpqemu-link.c         | 61 =
++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 68 insertions(+)
>>=20
>> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
>> index af401e640c..ef95599bca 100644
>> --- a/include/io/mpqemu-link.h
>> +++ b/include/io/mpqemu-link.h
>> @@ -124,4 +124,11 @@ void mpqemu_link_set_callback(MPQemuLinkState =
*s,
>> void mpqemu_start_coms(MPQemuLinkState *s, MPQemuChannel* chan);
>> bool mpqemu_msg_valid(MPQemuMsg *msg);
>>=20
>> +#define GET_REMOTE_WAIT eventfd(0, EFD_CLOEXEC)
>> +#define PUT_REMOTE_WAIT(wait) close(wait)
>=20
> Hiding this in macros makes the code harder to understand.
>=20
> Why is an eventfd necessary instead of a reply message? It's simpler =
and
> probably faster to use a reply message instead of creating and passing
> temporary eventfds.

OK, got it.

>=20
>> +#define PROXY_LINK_WAIT_DONE 1
>> +
>> +uint64_t wait_for_remote(int efd);
>> +void notify_proxy(int fd, uint64_t val);
>> +
>> #endif
>> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
>> index 48f53a8928..cc0a7aecd4 100644
>> --- a/io/mpqemu-link.c
>> +++ b/io/mpqemu-link.c
>> @@ -10,6 +10,7 @@
>>=20
>> #include "qemu/osdep.h"
>> #include "qemu-common.h"
>> +#include <poll.h>
>>=20
>> #include "qemu/module.h"
>> #include "io/mpqemu-link.h"
>> @@ -204,6 +205,66 @@ int mpqemu_msg_recv(MPQemuMsg *msg, =
MPQemuChannel *chan)
>>     return rc;
>> }
>>=20
>> +/*
>> + * wait_for_remote() Synchronizes QEMU and the remote process. The =
maximum
>> + *                   wait time is 1s, after which the wait times =
out.
>> + *                   The function alse returns a 64 bit return value =
after
>> + *                   the wait. The function uses eventfd() to do the =
wait
>> + *                   and pass the return values. eventfd() can't =
return a
>> + *                   value of '0'. Therefore, all return values are =
offset
>> + *                   by '1' at the sending end, and corrected at the
>> + *                   receiving end.
>> + */
>> +
>> +uint64_t wait_for_remote(int efd)
>> +{
>> +    struct pollfd pfd =3D { .fd =3D efd, .events =3D POLLIN };
>> +    uint64_t val;
>> +    int ret;
>> +
>> +    ret =3D poll(&pfd, 1, 1000);
>=20
> This 1 second blocking operation is not allowed in an event loop since
> it will stall any other event loop activity. If locks are held then
> other threads may also be stalled.
>=20
> It's likely that this will need to change as part of the QEMU event =
loop
> integration. Caller code can be kept mostly unchanged if you use
> coroutines.

In case the remote process has hung or terminated, the 1 second timeout
ensures that the IO operation does not block for too long.

--
Jag

>=20
>> +
>> +    switch (ret) {
>> +    case 0:
>> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: =
Timed out\n");
>> +        /* TODO: Kick-off error recovery */
>> +        return UINT64_MAX;
>> +    case -1:
>> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Poll error wait_for_remote: =
%s\n",
>> +                      strerror(errno));
>> +        return UINT64_MAX;
>> +    default:
>> +        if (read(efd, &val, sizeof(val)) =3D=3D -1) {
>> +            qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: =
%s\n",
>> +                          strerror(errno));
>> +            return UINT64_MAX;
>> +        }
>> +    }
>> +
>> +    /*
>> +     * The remote process could write a non-zero value
>> +     * to the eventfd to wake QEMU up. However, the drawback of =
using eventfd
>> +     * for this purpose is that a return value of zero wouldn't wake =
QEMU up.
>> +     * Therefore, we offset the return value by one at the remote =
process and
>> +     * correct it in the QEMU end.
>> +     */
>> +    val =3D (val =3D=3D UINT64_MAX) ? val : (val - 1);
>> +
>> +    return val;
>> +}
>> +
>> +void notify_proxy(int efd, uint64_t val)
>> +{
>> +    val =3D (val =3D=3D UINT64_MAX) ? val : (val + 1);
>> +    ssize_t len =3D -1;
>> +
>> +    len =3D write(efd, &val, sizeof(val));
>> +    if (len =3D=3D -1 || len !=3D sizeof(val)) {
>> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Error notify_proxy: %s\n",
>> +                      strerror(errno));
>> +    }
>> +}
>> +
>> static gboolean mpqemu_link_handler_prepare(GSource *gsrc, gint =
*timeout)
>> {
>>     g_assert(timeout);
>> --=20
>> 2.25.GIT
>>=20


