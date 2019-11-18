Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF7C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663A420857
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fi5DFPxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663A420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWixv-0003Y1-Hb
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iWiwx-0002eT-00
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iWiwv-0002TH-G3
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:28:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iWiwv-0002SX-6j
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:28:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIFNuRN063791;
 Mon, 18 Nov 2019 15:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=2I3jWXfJWt8pv4lv++x8qZfx061wb6KGFDoyzhL9JFI=;
 b=fi5DFPxKPiMGv3/u78a7+3F69LRjpMTjxiMoLIDUWyn5arOuZVlob+c/RLRcJQbzUN4p
 pXlnZ4HsEYS5FnHAys3tGu0QQa5EVHkEZ4U/cWNl0xpIHy9qIXmyOGnBrbRKmWxoops8
 bbv9XiyCuzIGK8/99Tnfxe1BN09OWZcYORpDwjc9p/OH+1UBjOI0NZ3fn5GoGo5keFWG
 asKKCnsqPwwTcnfyfzxm6WwskeKeCkQI5YLU/+D84ZpRyoW8OxYgojXcMI9fWkssgle5
 v57zuD1ZAZnGnQ67qUnqwJExveQbSFMWujqNgA/qNrIfChRZ2vey88YDagwd/46y/ubr uA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2wa8htgxec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2019 15:28:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIFNe1M015493;
 Mon, 18 Nov 2019 15:26:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2watmt0pv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2019 15:26:11 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAIFQAjm011659;
 Mon, 18 Nov 2019 15:26:10 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 18 Nov 2019 07:26:10 -0800
Subject: Re: [RFC v4 PATCH 07/49] multi-process: define mpqemu-link object
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <b0bc2a517b0a41eb138ed4127aebe8a3952daec6.1571905346.git.jag.raman@oracle.com>
 <20191113155352.GC563983@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <cc92ed5b-62fa-7fa6-a04a-c4e8d56053c8@oracle.com>
Date: Mon, 18 Nov 2019 10:26:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191113155352.GC563983@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180141
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 liran.alon@oracle.com, rth@twiddle.net, quintela@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 mst@redhat.com, kraxel@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 dgilbert@redhat.com, marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/13/2019 10:53 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:08:48AM -0400, Jagannathan Raman wrote:
>> +#ifndef MPQEMU_LINK_H
>> +#define MPQEMU_LINK_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +
>> +#include <stddef.h>
>> +#include <stdint.h>
> 
> These are already included by "qemu/osdep.h".
> 
>> +#include <pthread.h>
> 
> Is <pthread.h> needed?

It's not needed. We'll remove it.

> 
>> +
>> +#include "qom/object.h"
>> +#include "qemu/thread.h"
>> +
>> +#define TYPE_MPQEMU_LINK "mpqemu-link"
>> +#define MPQEMU_LINK(obj) \
>> +    OBJECT_CHECK(MPQemuLinkState, (obj), TYPE_MPQEMU_LINK)
>> +
>> +#define REMOTE_MAX_FDS 8
>> +
>> +#define MPQEMU_MSG_HDR_SIZE offsetof(MPQemuMsg, data1.u64)
>> +
>> +/**
>> + * mpqemu_cmd_t:
>> + * CONF_READ        PCI config. space read
>> + * CONF_WRITE       PCI config. space write
>> + *
>> + * proc_cmd_t enum type to specify the command to be executed on the remote
>> + * device.
>> + */
>> +typedef enum {
>> +    INIT = 0,
>> +    CONF_READ,
>> +    CONF_WRITE,
>> +    MAX,
>> +} mpqemu_cmd_t;
> 
> Please allow for future non-PCI devices by clearly naming PCI-specific
> commands and including a bus type in the initialization messages.

OK, will do.

> 
>> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
>> new file mode 100644
>> index 0000000..b39f4d0
>> --- /dev/null
>> +++ b/io/mpqemu-link.c
>> @@ -0,0 +1,309 @@
>> +/*
>> + * Communication channel between QEMU and remote device process
>> + *
>> + * Copyright 2019, Oracle and/or its affiliates.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this software and associated documentation files (the "Software"), to deal
>> + * in the Software without restriction, including without limitation the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +
>> +#include <assert.h>
>> +#include <errno.h>
>> +#include <pthread.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <sys/types.h>
>> +#include <sys/socket.h>
>> +#include <sys/un.h>
>> +#include <unistd.h>
>> +#include <limits.h>
>> +#include <poll.h>
> 
> Many of these are already included by "qemu/osdep.h".  Some of them
> shouldn't be used directly because QEMU or glib have abstractions that
> hide the platform-specific differences (e.g. pthread, poll).
> 
>> +MPQemuLinkState *mpqemu_link_create(void)
>> +{
>> +    return MPQEMU_LINK(object_new(TYPE_MPQEMU_LINK));
>> +}
> 
> I'm not sure what the purpose of this object is.  mpqemu_link_create()
> suggests the objects will be created internally instead of via -object
> mpqemu-link,..., which is unusual.
> 
> mpqemu_msg_send() and mpqemu_msg_recv() seem to be the main functions
> but they do not even use their MPQemuLinkState *s argument.

The LINK object is made up of multiple CHANNELS objects. For example, a
link between QEMU & the remote process could be comprised of multiple
channels.

You're correct, mpqemu_msg_send() & mpqemu_msg_recv() don't use the the
argument "s". This was a consequence of adding the multi-channel
support, before which this argument was used. We will fix this in the
next review.

Thank you!
--
Jag

> 
>> +void mpqemu_start_coms(MPQemuLinkState *s)
>> +{
>> +
>> +    g_assert(g_source_attach(&s->com->gsrc, s->ctx));
>> +
>> +    g_main_loop_run(s->loop);
>> +}
> 
> There is already IOThread if you need an event loop thread.  But does
> this need to be its own thread?  The communication should be
> asynchronous and therefore it can run in the main event loop or any
> existing IOThread.
> 

