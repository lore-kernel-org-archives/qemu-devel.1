Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D145C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB86E23A9F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IT1xqegJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB86E23A9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZEi-000657-U8
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZAY-00014b-Q1
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:52:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZAW-0007Tr-J0
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:52:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLmwxJ103150;
 Thu, 24 Sep 2020 21:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Jh7JSdrVX4oeneOO2S5qNi+Gxwkny2qnQR1mx16lPkQ=;
 b=IT1xqegJlD01UsRjlY10Q+Z3uO73fBbbU5Zg7uKpMSj/ek8tthkfk1lPXJfrYO0NVk30
 1l9Zz5/NdbIulqVIPg1vlC8kPWaKffTQbDa8rTxd+hKcROdNy4L1px7k8UAS8IuMxtoB
 Qglg9lfxug+HYvLW2gLlCJL8d5JW9BSkOnfnvw6aAJt9mrIqZxQGFijkrrfUATEjD6MB
 1KsyxQUeJlmncNa7Ku956AB5sCdMu+NbJR4SgfnmMns79/i/z5KjaaRLszAgXwSTj+fr
 EcazgTjPH3uZVXLiaxjf103bVcS8aLYb8+ePNId2GjW4E8KtoNIOFnd6qyVR4u73Gzcf iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33ndnutssp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 21:52:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLoSPc037911;
 Thu, 24 Sep 2020 21:52:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 33nujrf11t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 21:52:44 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OLqgU6010519;
 Thu, 24 Sep 2020 21:52:43 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 14:52:42 -0700
Subject: Re: [PATCH V1 17/32] util: env var helpers
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-18-git-send-email-steven.sistare@oracle.com>
 <20200911190009.GC3311@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <cbffaea9-52dd-7e0c-796d-3b0913ca3bf9@oracle.com>
Date: Thu, 24 Sep 2020 17:52:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911190009.GC3311@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240156
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 17:49:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/2020 3:00 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> Add functions for saving fd's and ram extents in the environment via
>> setenv, and for reading them back via getenv.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> 
> This is an awful lot of env stuff - how about dumping
> all this stuff into a file and reloading it?

I don't think there will be significantly fewer lines if this is
re-written to use a file, and the existing code is very simple -- a few
easy to understand lines for each accessor.  Please skim env.c, you will
grok it in less time than it took to write our emails.  A file-based
version may be even  longer because the code would need to check for
malformed input, since the file contents could be changed outside qemu,
and we would need to provide an option for where the file is stored.

The env is nice because it eliminates a failure point -- the variables always 
get carried through to the post-exec process.  No lost or stale files.

- Steve

>> ---
>>  MAINTAINERS           |   7 +++
>>  include/qemu/cutils.h |   1 +
>>  include/qemu/env.h    |  31 ++++++++++++
>>  util/Makefile.objs    |   2 +-
>>  util/env.c            | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 172 insertions(+), 1 deletion(-)
>>  create mode 100644 include/qemu/env.h
>>  create mode 100644 util/env.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3395abd..8d377a7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3115,3 +3115,10 @@ Performance Tools and Tests
>>  M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>>  S: Maintained
>>  F: scripts/performance/
>> +
>> +Environment variable helpers
>> +M: Steve Sistare <steven.sistare@oracle.com>
>> +M: Mark Kanda <mark.kanda@oracle.com>
>> +S: Maintained
>> +F: include/qemu/env.h
>> +F: util/env.c
>> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
>> index eb59852..d4c7d70 100644
>> --- a/include/qemu/cutils.h
>> +++ b/include/qemu/cutils.h
>> @@ -1,6 +1,7 @@
>>  #ifndef QEMU_CUTILS_H
>>  #define QEMU_CUTILS_H
>>  
>> +#include "qemu/env.h"
>>  /**
>>   * pstrcpy:
>>   * @buf: buffer to copy string into
>> diff --git a/include/qemu/env.h b/include/qemu/env.h
>> new file mode 100644
>> index 0000000..53cc121
>> --- /dev/null
>> +++ b/include/qemu/env.h
>> @@ -0,0 +1,31 @@
>> +/*
>> + * Copyright (c) 2020 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#ifndef QEMU_ENV_H
>> +#define QEMU_ENV_H
>> +
>> +#define FD_PREFIX "QEMU_FD_"
>> +#define ADDR_PREFIX "QEMU_ADDR_"
>> +#define LEN_PREFIX "QEMU_LEN_"
>> +#define BOOL_PREFIX "QEMU_BOOL_"
>> +
>> +typedef int (*walkenv_cb)(const char *name, const char *val, void *handle);
>> +
>> +bool getenv_ram(const char *name, void **addrp, size_t *lenp);
>> +void setenv_ram(const char *name, void *addr, size_t len);
>> +void unsetenv_ram(const char *name);
>> +int getenv_fd(const char *name);
>> +void setenv_fd(const char *name, int fd);
>> +void unsetenv_fd(const char *name);
>> +bool getenv_bool(const char *name);
>> +void setenv_bool(const char *name, bool val);
>> +void unsetenv_bool(const char *name);
>> +int walkenv(const char *prefix, walkenv_cb cb, void *handle);
>> +void printenv(void);
>> +
>> +#endif
>> diff --git a/util/Makefile.objs b/util/Makefile.objs
>> index cc5e371..d357932 100644
>> --- a/util/Makefile.objs
>> +++ b/util/Makefile.objs
>> @@ -1,4 +1,4 @@
>> -util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
>> +util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o env.o
>>  util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
>>  util-obj-$(CONFIG_POSIX) += aio-posix.o
>>  util-obj-$(CONFIG_POSIX) += fdmon-poll.o
>> diff --git a/util/env.c b/util/env.c
>> new file mode 100644
>> index 0000000..0cc4a9f
>> --- /dev/null
>> +++ b/util/env.c
>> @@ -0,0 +1,132 @@
>> +/*
>> + * Copyright (c) 2020 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/env.h"
>> +
>> +static uint64_t getenv_ulong(const char *prefix, const char *name, bool *found)
>> +{
>> +    char var[80], *val;
>> +    uint64_t res;
>> +
>> +    snprintf(var, sizeof(var), "%s%s", prefix, name);
>> +    val = getenv(var);
>> +    if (val) {
>> +        *found = true;
>> +        res = strtol(val, 0, 10);
>> +    } else {
>> +        *found = false;
>> +        res = 0;
>> +    }
>> +    return res;
>> +}
>> +
>> +static void setenv_ulong(const char *prefix, const char *name, uint64_t val)
>> +{
>> +    char var[80], val_str[80];
>> +    snprintf(var, sizeof(var), "%s%s", prefix, name);
>> +    snprintf(val_str, sizeof(val_str), "%"PRIu64, val);
>> +    setenv(var, val_str, 1);
>> +}
>> +
>> +static void unsetenv_ulong(const char *prefix, const char *name)
>> +{
>> +    char var[80];
>> +    snprintf(var, sizeof(var), "%s%s", prefix, name);
>> +    unsetenv(var);
>> +}
>> +
>> +bool getenv_ram(const char *name, void **addrp, size_t *lenp)
>> +{
>> +    bool found1, found2;
>> +    *addrp = (void *) getenv_ulong(ADDR_PREFIX, name, &found1);
>> +    *lenp = getenv_ulong(LEN_PREFIX, name, &found2);
>> +    assert(found1 == found2);
>> +    return found1;
>> +}
>> +
>> +void setenv_ram(const char *name, void *addr, size_t len)
>> +{
>> +    setenv_ulong(ADDR_PREFIX, name, (uint64_t)addr);
>> +    setenv_ulong(LEN_PREFIX, name, len);
>> +}
>> +
>> +void unsetenv_ram(const char *name)
>> +{
>> +    unsetenv_ulong(ADDR_PREFIX, name);
>> +    unsetenv_ulong(LEN_PREFIX, name);
>> +}
>> +
>> +int getenv_fd(const char *name)
>> +{
>> +    bool found;
>> +    int fd = getenv_ulong(FD_PREFIX, name, &found);
>> +    if (!found) {
>> +        fd = -1;
>> +    }
>> +    return fd;
>> +}
>> +
>> +void setenv_fd(const char *name, int fd)
>> +{
>> +    setenv_ulong(FD_PREFIX, name, fd);
>> +}
>> +
>> +void unsetenv_fd(const char *name)
>> +{
>> +    unsetenv_ulong(FD_PREFIX, name);
>> +}
>> +
>> +bool getenv_bool(const char *name)
>> +{
>> +    bool found;
>> +    bool val = getenv_ulong(BOOL_PREFIX, name, &found);
>> +    if (!found) {
>> +        val = -1;
>> +    }
>> +    return val;
>> +}
>> +
>> +void setenv_bool(const char *name, bool val)
>> +{
>> +    setenv_ulong(BOOL_PREFIX, name, val);
>> +}
>> +
>> +void unsetenv_bool(const char *name)
>> +{
>> +    unsetenv_ulong(BOOL_PREFIX, name);
>> +}
>> +
>> +int walkenv(const char *prefix, walkenv_cb cb, void *handle)
>> +{
>> +    char *str, name[128];
>> +    char **envp = environ;
>> +    size_t prefix_len = strlen(prefix);
>> +
>> +    while (*envp) {
>> +        str = *envp++;
>> +        if (!strncmp(str, prefix, prefix_len)) {
>> +            char *val = strchr(str, '=');
>> +            str += prefix_len;
>> +            strncpy(name, str, val - str);
>> +            name[val - str] = 0;
>> +            if (cb(name, val + 1, handle)) {
>> +                return 1;
>> +            }
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +void printenv(void)
>> +{
>> +    char **ptr = environ;
>> +    while (*ptr) {
>> +        puts(*ptr++);
>> +    }
>> +}
>> -- 
>> 1.8.3.1
>>
>>

