Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D46C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00902206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EhGygdSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00902206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5teb-0005GT-CP
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5tbm-0002IH-4J
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5tbk-0008EN-4t
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:23:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5tbj-0008Dy-Qz
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:23:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85FMxqW100063;
 Thu, 5 Sep 2019 15:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=UT02ZgLWgRo6YDkoXEJzvcAUGPRmQG5BIQ7NDlMzS8c=;
 b=EhGygdSNGEW5VquwMIVSbBclViRWSBqcKHY2Ei4BNHM/YFQYZePGpOxPQE43NNXk24xb
 JGo/rPVUqfr8lTplHMzCEeHOtxniGizCRWlLS3BtKJ/MTLJ/ctJudGy4jTdhI6l+882S
 3QHEfhX4ejv02wDDh8vDxObVLv3/kNy9lUDbqmKGJK+E+FMLhtGAV5qAd8TolstOOubx
 9ycoLE4Fmm7auk+knFFZgDfZ8tF+IljcW34anQuNq5ky1UBeXwfPB4YGS/GwqfVC3o+u
 7G+SAd9oDl1FRRe3RZJj70mIG86h3rguM4KyORsuFDQP0wENSz9jlyOivcQTyJ+S5O0R Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2uu4rgr3qy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:23:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85FCIon127957;
 Thu, 5 Sep 2019 15:23:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2uu1b8raqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:23:25 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x85FNPWG011447;
 Thu, 5 Sep 2019 15:23:25 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Sep 2019 08:23:24 -0700
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <0d668ccf7c5fa09d4968d618df069ab74787ec29.1567534653.git.jag.raman@oracle.com>
 <20190904083756.GB2828@work-vm>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <e2e83ad9-34e7-4371-36a3-07bed1e9e532@oracle.com>
Date: Thu, 5 Sep 2019 11:23:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190904083756.GB2828@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050144
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [RFC v3 PATCH 40/45] multi-process/mon: Refactor
 monitor/chardev functions out of vl.c
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
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 mreitz@redhat.com, kanth.ghatraju@oracle.com, kraxel@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, liran.alon@oracle.com,
 marcandre.lureau@gmail.com, kwolf@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/4/2019 4:37 AM, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
>> Some of the initialization helper functions w.r.t monitor & chardev
>> in vl.c are also used by the remote process. Therefore, these functions
>> are refactored into a shared file that both QEMU & remote process
>> could use.
>>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> 
> Shouldn't the monitor parts be moved into something under monitor/ and
> the chardev parts be moved into chardev/ ?

Sure, will do.

Thanks!
--
Jag

> 
> Dave
> 
>> ---
>>   New patch in v3
>>
>>   vl-parse.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   vl.c       | 91 -------------------------------------------------------------
>>   vl.h       |  4 +++
>>   3 files changed, 96 insertions(+), 91 deletions(-)
>>
>> diff --git a/vl-parse.c b/vl-parse.c
>> index d3716d1..bee904d 100644
>> --- a/vl-parse.c
>> +++ b/vl-parse.c
>> @@ -155,3 +155,95 @@ int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
>>       object_unref(OBJECT(dev));
>>       return 0;
>>   }
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
>> +int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>> +{
>> +    Chardev *chr;
>> +    bool qmp;
>> +    bool pretty = false;
>> +    const char *chardev;
>> +    const char *mode;
>> +
>> +    mode = qemu_opt_get(opts, "mode");
>> +    if (mode == NULL) {
>> +        mode = "readline";
>> +    }
>> +    if (strcmp(mode, "readline") == 0) {
>> +        qmp = false;
>> +    } else if (strcmp(mode, "control") == 0) {
>> +        qmp = true;
>> +    } else {
>> +        error_setg(errp, "unknown monitor mode \"%s\"", mode);
>> +        return -1;
>> +    }
>> +
>> +    if (!qmp && qemu_opt_get(opts, "pretty")) {
>> +        warn_report("'pretty' is deprecated for HMP monitors, it has no effect "
>> +                    "and will be removed in future versions");
>> +    }
>> +    if (qemu_opt_get_bool(opts, "pretty", 0)) {
>> +        pretty = true;
>> +    }
>> +
>> +    chardev = qemu_opt_get(opts, "chardev");
>> +    if (!chardev) {
>> +        error_report("chardev is required");
>> +        exit(1);
>> +    }
>> +    chr = qemu_chr_find(chardev);
>> +    if (chr == NULL) {
>> +        error_setg(errp, "chardev \"%s\" not found", chardev);
>> +        return -1;
>> +    }
>> +
>> +    if (qmp) {
>> +        monitor_init_qmp(chr, pretty);
>> +    } else {
>> +        monitor_init_hmp(chr, true);
>> +    }
>> +    return 0;
>> +}
>> +
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
>> diff --git a/vl.c b/vl.c
>> index 08e9c09..3c03405 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -2264,19 +2264,6 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
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
>> @@ -2285,84 +2272,6 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
>>   }
>>   #endif
>>   
>> -static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>> -{
>> -    Chardev *chr;
>> -    bool qmp;
>> -    bool pretty = false;
>> -    const char *chardev;
>> -    const char *mode;
>> -
>> -    mode = qemu_opt_get(opts, "mode");
>> -    if (mode == NULL) {
>> -        mode = "readline";
>> -    }
>> -    if (strcmp(mode, "readline") == 0) {
>> -        qmp = false;
>> -    } else if (strcmp(mode, "control") == 0) {
>> -        qmp = true;
>> -    } else {
>> -        error_setg(errp, "unknown monitor mode \"%s\"", mode);
>> -        return -1;
>> -    }
>> -
>> -    if (!qmp && qemu_opt_get(opts, "pretty")) {
>> -        warn_report("'pretty' is deprecated for HMP monitors, it has no effect "
>> -                    "and will be removed in future versions");
>> -    }
>> -    if (qemu_opt_get_bool(opts, "pretty", 0)) {
>> -        pretty = true;
>> -    }
>> -
>> -    chardev = qemu_opt_get(opts, "chardev");
>> -    if (!chardev) {
>> -        error_report("chardev is required");
>> -        exit(1);
>> -    }
>> -    chr = qemu_chr_find(chardev);
>> -    if (chr == NULL) {
>> -        error_setg(errp, "chardev \"%s\" not found", chardev);
>> -        return -1;
>> -    }
>> -
>> -    if (qmp) {
>> -        monitor_init_qmp(chr, pretty);
>> -    } else {
>> -        monitor_init_hmp(chr, true);
>> -    }
>> -    return 0;
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
>> diff --git a/vl.h b/vl.h
>> index 8c40fed..21ca747 100644
>> --- a/vl.h
>> +++ b/vl.h
>> @@ -50,5 +50,9 @@ int device_init_func(void *opaque, QemuOpts *opts, Error **errp);
>>   int rdrive_init_func(void *opaque, QemuOpts *opts, Error **errp);
>>   int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp);
>>   
>> +void monitor_parse(const char *optarg, const char *mode, bool pretty);
>> +int mon_init_func(void *opaque, QemuOpts *opts, Error **errp);
>> +int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp);
>> +
>>   #endif /* VL_H */
>>   
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

