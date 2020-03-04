Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F42C3F2D7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5208720870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pow9JehZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5208720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Yzk-00054X-FS
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 13:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j9Yyr-0003wK-Fa
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j9Yyq-0005Yu-0d
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:42:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j9Yyp-0005Yc-LV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:42:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024IYCnn015916;
 Wed, 4 Mar 2020 18:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DpXKi64i86/lDhJnxbdgQwLfJzL/0WkhHeMHB/UOXtI=;
 b=pow9JehZRsTJAdKpxOT/E+y8AEjefxLdDyFw+/8EeGcBEddQZweGKZgwVey0VFGLeRrM
 jNXrfOr6cP7JK/Numr6jsXgU6lZuPKbw3eK7+MVfuQ8Dx860IYWRw1CuXPocEK7Vl3Hc
 6/w3mAL0OYPrqlRon8duySCLF0TnmXCpX9b/Dfyine9RGj31/fP1a6CFgtwAzp0lWiFT
 aiDEoHzlOfi3/qdhcuhgApHaMeAv2Jk7OBFB/FRCC14MnGzXasoN5IwcDBprTWzwwiMP
 c8TdYppBtAgIyAjPOcy6B0cUlxGsymistXplVAVUl6nLjK2KB9L5wc7jTgL7b3bU5rp5 aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yffwr06xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 18:42:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024IWVGo104912;
 Wed, 4 Mar 2020 18:42:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2yg1p864vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 18:42:36 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024IgXAl010130;
 Wed, 4 Mar 2020 18:42:33 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Mar 2020 10:42:33 -0800
Subject: Re: [PATCH v5 08/50] multi-process: add functions to synchronize
 proxy and remote endpoints
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <3d013f0091ac6babb55f30cadf6ed806c322b7ce.1582576372.git.jag.raman@oracle.com>
 <20200303195627.GW3170@work-vm>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <8205fd32-2c74-f599-a630-1c31828cf61e@oracle.com>
Date: Wed, 4 Mar 2020 13:42:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303195627.GW3170@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040125
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/3/2020 2:56 PM, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
>> In some cases, for example MMIO read, QEMU has to wait for the remote to
>> complete a command before proceeding. An eventfd based mechanism is
>> added to synchronize QEMU & remote process.
>>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> ---
>>   include/io/mpqemu-link.h |  7 +++++++
>>   io/mpqemu-link.c         | 41 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
>> index 2f2dd83..ae04fca 100644
>> --- a/include/io/mpqemu-link.h
>> +++ b/include/io/mpqemu-link.h
>> @@ -135,4 +135,11 @@ void mpqemu_link_set_callback(MPQemuLinkState *s,
>>                                 mpqemu_link_callback callback);
>>   void mpqemu_start_coms(MPQemuLinkState *s);
>>   
>> +#define GET_REMOTE_WAIT eventfd(0, EFD_CLOEXEC)
>> +#define PUT_REMOTE_WAIT(wait) close(wait)
>> +#define PROXY_LINK_WAIT_DONE 1
>> +
>> +uint64_t wait_for_remote(int efd);
>> +void notify_proxy(int fd, uint64_t val);
>> +
>>   #endif
>> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
>> index bac120b..73b7032 100644
>> --- a/io/mpqemu-link.c
>> +++ b/io/mpqemu-link.c
>> @@ -10,6 +10,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu-common.h"
>> +#include <poll.h>
>>   
>>   #include "qemu/module.h"
>>   #include "io/mpqemu-link.h"
>> @@ -216,6 +217,46 @@ int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *chan)
>>       return rc;
>>   }
>>   
>> +uint64_t wait_for_remote(int efd)
>> +{
>> +    struct pollfd pfd = { .fd = efd, .events = POLLIN };
>> +    uint64_t val;
>> +    int ret;
>> +
>> +    ret = poll(&pfd, 1, 1000);
>> +
>> +    switch (ret) {
>> +    case 0:
>> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: Timed out\n");
>> +        /* TODO: Kick-off error recovery */
>> +        return ULLONG_MAX;
> 
> Shouldn't these be UINT64_MAX?

Sure, we'll change these to UINT64_MAX.

> 
>> +    case -1:
>> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Poll error wait_for_remote: %s\n",
>> +                      strerror(errno));
>> +        return ULLONG_MAX;
>> +    default:
>> +        if (read(efd, &val, sizeof(val)) == -1) {
>> +            qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: %s\n",
>> +                          strerror(errno));
>> +            return ULLONG_MAX;
>> +        }
>> +    }
>> +
>> +    val = (val == ULLONG_MAX) ? val : (val - 1);
> 
> Can you explain what's going on there??

This wait_for_remote() function serves two purposes. This first one is
to synchronize QEMU and the remote process. Secondly, it allows the
remote process to return a 64-bit value to QEMU. When the remote process
has completed the task, it uses the notify_proxy() function to return to
QEMU along with a return value.

We have implemented this synchronization mechanism using eventfd, as
it's easy to setup. So the remote process could write a non-zero value
to the eventfd to wake QEMU up. However, the drawback of using eventfd
for this purpose is that a return value of zero wouldn't wake QEMU up.
Therefore, we offset the return value by one at the remote process and
correct it in the QEMU end.

--
Jag

> 
>> +    return val;
>> +}
>> +
>> +void notify_proxy(int efd, uint64_t val)
>> +{
>> +    val = (val == ULLONG_MAX) ? val : (val + 1);
>> +
>> +    if (write(efd, &val, sizeof(val)) == -1) {
> 
> I'd actually check the write/read's are returning sizeof(val) - they
> can on a bad day return 0 or send only a few bytes; in theory?
> 
> Dave
> 
>> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Error notify_proxy: %s\n",
>> +                      strerror(errno));
>> +    }
>> +}
>> +
>>   static gboolean mpqemu_link_handler_prepare(GSource *gsrc, gint *timeout)
>>   {
>>       g_assert(timeout);
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

