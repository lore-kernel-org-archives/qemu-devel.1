Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A580CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725C62073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k0C5bf+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725C62073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9se0-0003MG-Lf
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j9sco-00023F-Od
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j9scn-0005tB-6t
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:41:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j9scm-0005pp-TO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:41:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025FNtPi182142;
 Thu, 5 Mar 2020 15:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tNKkpA+b+ShFcB74ZdgXL8tWN2inkSe378ZXSJ8ci3U=;
 b=k0C5bf+fd8vp4ZlTN+ZhKPgm1zmq9QoMGJi1RzhtcjN8B/iIFE0h8lVXBMWfBju8ziAE
 kz+QcJf17b+nPndQKsEMi6AkP83aIaICjjPtp+a/DthnFAujLtSIRBepS1LqUnwj20zK
 rhNSXVLcBMeVm+ClJM03gxI2wZqBY75M86sM9TtBYyt9sSA0m/Ww7dL56cKZp1BTjZ6Z
 /H6nNx8ycq0+YXzEg6DAEucj6Iskb2r+tC4OID/5DATH2T/xUixCsIxf+zdkZLeKCzRd
 fQu6ycGvNJpzDWaSbuIbfucUJkyvjZI2fdZKl1IZntaWsR5SBJ932E0rXKMZAKJF8luS hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2yffcux0ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Mar 2020 15:41:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025FRAhE173583;
 Thu, 5 Mar 2020 15:41:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2yg1h3rdnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Mar 2020 15:41:13 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 025FfAEQ006808;
 Thu, 5 Mar 2020 15:41:10 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Mar 2020 07:41:09 -0800
Subject: Re: [PATCH v5 37/50] multi-process/mon: Refactor monitor/chardev
 functions out of vl.c
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <67a859b87b37fa5ecab72d561e327e80941fc705.1582576372.git.jag.raman@oracle.com>
 <20200305105154.GG3130@work-vm>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <76e3469f-a9e2-3c5f-285d-63456965a967@oracle.com>
Date: Thu, 5 Mar 2020 10:41:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305105154.GG3130@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050100
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



On 3/5/2020 5:51 AM, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
>> Some of the initialization helper functions w.r.t monitor & chardev
>> in vl.c are also used by the remote process. Therefore, these functions
>> are refactored into shared files that both QEMU & remote process
>> could use.
>>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> This looks like another good candidate to go in a separate post that
> doesn't need to wait for the rest of multi-process; you are probably
> best splitting it into separate chardev and monitor chunks so they can
> go via their respective maintainers.

Sure, thanks!

--
Jag

> 
> Dave
> 
> 
>> ---
>>   chardev/char.c            | 14 ++++++++++++++
>>   include/chardev/char.h    |  1 +
>>   include/monitor/monitor.h |  2 ++
>>   monitor/monitor.c         | 40 ++++++++++++++++++++++++++++++++++++++-
>>   remote/remote-main.c      |  1 +
>>   remote/remote-opts.c      |  1 +
>>   softmmu/vl.c              | 48 -----------------------------------------------
>>   7 files changed, 58 insertions(+), 49 deletions(-)
>>
>> diff --git a/chardev/char.c b/chardev/char.c
>> index 8723756..1d03ea0 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -1189,4 +1189,18 @@ static void register_types(void)
>>       qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
>>   }
>>   
>> +int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
>> +{
>> +    Error *local_err = NULL;
>> +
>> +    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return -1;
>> +        }
>> +        exit(0);
>> +    }
>> +    return 0;
>> +}
>> +
>>   type_init(register_types);
>> diff --git a/include/chardev/char.h b/include/chardev/char.h
>> index 00589a6..e370320 100644
>> --- a/include/chardev/char.h
>> +++ b/include/chardev/char.h
>> @@ -290,4 +290,5 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
>>   /* console.c */
>>   void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp);
>>   
>> +int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp);
>>   #endif
>> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
>> index b7bdd2b..d92bf1c 100644
>> --- a/include/monitor/monitor.h
>> +++ b/include/monitor/monitor.h
>> @@ -45,5 +45,7 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags);
>>   int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
>>   void monitor_fdset_dup_fd_remove(int dup_fd);
>>   int64_t monitor_fdset_dup_fd_find(int dup_fd);
>> +void monitor_parse(const char *optarg, const char *mode, bool pretty);
>> +int mon_init_func(void *opaque, QemuOpts *opts, Error **errp);
>>   
>>   #endif /* MONITOR_H */
>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> index c1a6c44..5759b84 100644
>> --- a/monitor/monitor.c
>> +++ b/monitor/monitor.c
>> @@ -33,7 +33,10 @@
>>   #include "sysemu/qtest.h"
>>   #include "sysemu/sysemu.h"
>>   #include "trace.h"
>> -
>> +#include "qemu/cutils.h"
>> +#include "qemu/option.h"
>> +#include "qemu-options.h"
>> +#include "qemu/config-file.h"
>>   /*
>>    * To prevent flooding clients, events can be throttled. The
>>    * throttling is calculated globally, rather than per-Monitor
>> @@ -609,6 +612,41 @@ void monitor_init_globals_core(void)
>>                                      NULL);
>>   }
>>   
>> +int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>> +{
>> +    return monitor_init_opts(opts, errp);
>> +}
>> +
>> +void monitor_parse(const char *optarg, const char *mode, bool pretty)
>> +{
>> +    static int monitor_device_index;
>> +    QemuOpts *opts;
>> +    const char *p;
>> +    char label[32];
>> +
>> +    if (strstart(optarg, "chardev:", &p)) {
>> +        snprintf(label, sizeof(label), "%s", p);
>> +    } else {
>> +        snprintf(label, sizeof(label), "compat_monitor%d",
>> +                 monitor_device_index);
>> +        opts = qemu_chr_parse_compat(label, optarg, true);
>> +        if (!opts) {
>> +            error_report("parse error: %s", optarg);
>> +            exit(1);
>> +        }
>> +    }
>> +
>> +    opts = qemu_opts_create(qemu_find_opts("mon"), label, 1, &error_fatal);
>> +    qemu_opt_set(opts, "mode", mode, &error_abort);
>> +    qemu_opt_set(opts, "chardev", label, &error_abort);
>> +    if (!strcmp(mode, "control")) {
>> +        qemu_opt_set_bool(opts, "pretty", pretty, &error_abort);
>> +    } else {
>> +        assert(pretty == false);
>> +    }
>> +    monitor_device_index++;
>> +}
>> +
>>   int monitor_init_opts(QemuOpts *opts, Error **errp)
>>   {
>>       Chardev *chr;
>> diff --git a/remote/remote-main.c b/remote/remote-main.c
>> index 5284ee9..23fc0df 100644
>> --- a/remote/remote-main.c
>> +++ b/remote/remote-main.c
>> @@ -54,6 +54,7 @@
>>   #include "qemu/cutils.h"
>>   #include "remote-opts.h"
>>   #include "monitor/monitor.h"
>> +#include "chardev/char.h"
>>   #include "sysemu/reset.h"
>>   
>>   static MPQemuLinkState *mpqemu_link;
>> diff --git a/remote/remote-opts.c b/remote/remote-opts.c
>> index 7e12700..565e641 100644
>> --- a/remote/remote-opts.c
>> +++ b/remote/remote-opts.c
>> @@ -39,6 +39,7 @@
>>   #include "block/block.h"
>>   #include "remote/remote-opts.h"
>>   #include "include/qemu-common.h"
>> +#include "monitor/monitor.h"
>>   
>>   #include "vl.h"
>>   /*
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index a8a6f35..4a4f52c 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -2133,19 +2133,6 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
>>       return qdev_device_help(opts);
>>   }
>>   
>> -static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
>> -{
>> -    Error *local_err = NULL;
>> -
>> -    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
>> -        if (local_err) {
>> -            error_propagate(errp, local_err);
>> -            return -1;
>> -        }
>> -        exit(0);
>> -    }
>> -    return 0;
>> -}
>>   
>>   #ifdef CONFIG_VIRTFS
>>   static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
>> @@ -2154,41 +2141,6 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
>>   }
>>   #endif
>>   
>> -static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>> -{
>> -    return monitor_init_opts(opts, errp);
>> -}
>> -
>> -static void monitor_parse(const char *optarg, const char *mode, bool pretty)
>> -{
>> -    static int monitor_device_index = 0;
>> -    QemuOpts *opts;
>> -    const char *p;
>> -    char label[32];
>> -
>> -    if (strstart(optarg, "chardev:", &p)) {
>> -        snprintf(label, sizeof(label), "%s", p);
>> -    } else {
>> -        snprintf(label, sizeof(label), "compat_monitor%d",
>> -                 monitor_device_index);
>> -        opts = qemu_chr_parse_compat(label, optarg, true);
>> -        if (!opts) {
>> -            error_report("parse error: %s", optarg);
>> -            exit(1);
>> -        }
>> -    }
>> -
>> -    opts = qemu_opts_create(qemu_find_opts("mon"), label, 1, &error_fatal);
>> -    qemu_opt_set(opts, "mode", mode, &error_abort);
>> -    qemu_opt_set(opts, "chardev", label, &error_abort);
>> -    if (!strcmp(mode, "control")) {
>> -        qemu_opt_set_bool(opts, "pretty", pretty, &error_abort);
>> -    } else {
>> -        assert(pretty == false);
>> -    }
>> -    monitor_device_index++;
>> -}
>> -
>>   struct device_config {
>>       enum {
>>           DEV_USB,       /* -usbdevice     */
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

