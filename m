Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CE6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19D120737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RUmb+S1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19D120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrMl5-0001OB-3u
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 10:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrMjx-0000VZ-Nz; Fri, 03 Jul 2020 10:32:34 -0400
Received: from mail-eopbgr80127.outbound.protection.outlook.com
 ([40.107.8.127]:26745 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrMju-0001F2-7u; Fri, 03 Jul 2020 10:32:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPGCS9HuDXvI6auVZ4vbvN7RvkAMgNPBKkRDHRKx9V9rhfMD9jy4d7ptqqmGRITi5Ix5xCsj7Ca1CTmpDtAPCSF43dbMffUyAkhb6pUuHdS9Kd88hAhGfF1Qx2RoI23+SjUagnxiwm+U2An/Z8Vq9YyvrMf+Yu8S3+ISfLBjsfDIMOAzxW3EcsTFZbJkZ7E7+OXWH5eXax5DDIFYLKqNKBEtHK/ElYf4HWepzv/SgjzUIHqbx9rJGpzpqFts5AZ1pY812FmG4QYnDMX8WitVafxft9XNTorLFUJ7xf0NwJVpomAJzotZRa+30Vm5nOeCCx+UGnlkMKfmPPlbz6g9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFEiIDR//fIEebIv5AJSvLz3y+DfTRQnJ2PHtqetPd4=;
 b=WZhZo7ur53FqlrTGTnqo02FgABuiQ/+8Ee2lbo2rcDZwh49EZMF2BylDy6MCMA9iloLZtFE9uDc8wBN/DTxQ1K6+KNUTj8rvyG3BdO2GkCDusUSPjuT9H+X1ruBy+dAdTIDy7qu10e8tHFxdaaQYBFd5rGuG0h/mG67ZeGe7WIqgO51t/aM4tPr5/r9z0GnrVaY3iuHpCBkLussZR/gadLQpYo3qeJLyzFweaoXPbNSAGmjyG0h9dyh6ZwBigWATzd0NpYiQ12KAvPsvrx36oProh/Hr38uNUXX2D28pl4ySwAGllbELNjqiOlWLO7a8bUL8st0RLdB2c9TQMOBTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFEiIDR//fIEebIv5AJSvLz3y+DfTRQnJ2PHtqetPd4=;
 b=RUmb+S1e1TW0YYY2seDmJ284QZNOOp8gAljl5WRYG6ykFUeDa3rvuSu8JZAIEahOwE47wyFLhCiPTR5j5bRlDQsMKZezOk2U/dDdT4hmPPW3YM3VefpdyQhsTONb1stL0olnlmsHAiQ390tj3lkCZNcSyppKq52nXXScD8gjPz4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4165.eurprd08.prod.outlook.com (2603:10a6:20b:a2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Fri, 3 Jul
 2020 14:32:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 14:32:25 +0000
Subject: Re: [PATCH v2 16/44] qapi: Make visitor functions taking Error **
 return bool, not void
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-17-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3dd46515-d6e9-7b26-9c21-03def1170a91@virtuozzo.com>
Date: Fri, 3 Jul 2020 17:32:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM0PR10CA0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Fri, 3 Jul 2020 14:32:24 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aad1799e-ea0a-4c61-2302-08d81f5de7be
X-MS-TrafficTypeDiagnostic: AM6PR08MB4165:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4165B3A8E198A55131FEAB88C16A0@AM6PR08MB4165.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xab2yGh2y0SqyMN+YdaTD9knHD2r9bo0U2W17i9tYTW2ZWF3qO7Lj6BhU/nkm24TpE3yjrb7JafENb1y6PZpU7vjwffBbpfeAcvvz3QSDH6hPcj4HmDgf9EiLhlvBMFJhPWz5d0xnP1RhBozrUIb/WFGCtURKduCjPvSEDdMAMG3fIw+iYRsWN/DmnPTurn3eRof7PhnxOgd/oFGnET/d0K1PJV4HmRl0AOxe4xeqFUbVI+pnuEfaY6bVGFkRedSW0xJ4qUSl7SCcwQMHoeL99pCfBQqMIQsIZadFdw4iRK0rR8uYr1xrZMnOzDRJIa2osnOlizcyHVplONqMyK11O5qoEMHIquB2Z1CJnkCxk2sn+uFCpfreC3d2dvnzhbB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(366004)(39840400004)(396003)(376002)(36756003)(66556008)(66476007)(66946007)(83380400001)(478600001)(86362001)(31696002)(4326008)(956004)(52116002)(31686004)(8936002)(2616005)(6486002)(16526019)(186003)(2906002)(26005)(16576012)(5660300002)(316002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rflG2fZaBazgVJLOwWeJ2DRz5i8WlINscCDKKHdAo8QDsmq49sQZ5WyuT9aTFAe97Dfzk+PbQ0IIF6SH6pKSGfTm6t9PDE1pb6a87QQQdP/YSvdlc37K2WtDvgEGAe8iVR8XWY1O/1iejOJexdClIPJnJBr0FtxfyT2LMznX122GFmqXvhRMuex3RIvCszXotI3KL8cpRdtPL0Jl4Zm/C0y/P7+aGLjoXfToP6Yl8y9hAXjct0Cnu4e3CiP5eT5JQHNvJurWJI5v+NwOpvEq9yjn59zmKeIwYMmR3hTqDfDGqFmS4H7B3AUI5blayfahaz7TG/xL+F4tQboecfwjIcm/HIfMtyC5bJcCC/UKt6dO60kqocWJkcQY3TSovcXLnduPI7vWSeX5aHqVKA0wC72x/fZLp1Xr/oRr0XXvP8abNbC440V7fauqu6a4EToeb+e1n7E8qS/aO8Gqkr8lJlaq75FIZ2DMaN1LBEjVKmZNy8DAAjsGfmOwOWDhY61W
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad1799e-ea0a-4c61-2302-08d81f5de7be
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 14:32:25.4696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnAfG631NBM32+19x5HV/Ohm1VPJnptT78aArfkKVORL8/1OITcHwoJXOkVGnsXukUnHjo73zpHD5/D/aEtHGe8I2vOJoVYEpEiupSSwEcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4165
Received-SPF: pass client-ip=40.107.8.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 10:32:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 18:49, Markus Armbruster wrote:
> See recent commit "error: Document Error API usage rules" for
> rationale.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/devel/qapi-code-gen.txt  |  51 +++++------
>   include/qapi/clone-visitor.h  |   8 +-
>   include/qapi/visitor-impl.h   |  26 +++---
>   include/qapi/visitor.h        | 102 ++++++++++++---------
>   audio/audio_legacy.c          |  15 ++--
>   qapi/opts-visitor.c           |  58 +++++++-----
>   qapi/qapi-clone-visitor.c     |  67 ++++++++------
>   qapi/qapi-dealloc-visitor.c   |  27 ++++--
>   qapi/qapi-visit-core.c        | 165 ++++++++++++++++++----------------
>   qapi/qobject-input-visitor.c  | 109 +++++++++++++---------
>   qapi/qobject-output-visitor.c |  27 ++++--
>   qapi/string-input-visitor.c   |  62 +++++++------
>   qapi/string-output-visitor.c  |  32 ++++---
>   scripts/qapi/visit.py         |  58 +++++-------
>   14 files changed, 452 insertions(+), 355 deletions(-)
> 
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index a7794ef658..9bfc57063c 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -1408,42 +1408,38 @@ Example:
>       #include "example-qapi-types.h"
>   
>   
> -    void visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp);
> -    void visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp);
> -    void visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp);
> +    bool visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp);
> +    bool visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp);
> +    bool visit_type_UserDefOneList(Visitor *v, const char *name, UserDefOneList **obj, Error **errp);
>   
> -    void visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp);
> +    bool visit_type_q_obj_my_command_arg_members(Visitor *v, q_obj_my_command_arg *obj, Error **errp);
>   
>       #endif /* EXAMPLE_QAPI_VISIT_H */
>       $ cat qapi-generated/example-qapi-visit.c

should it be tests/test-qapi-visit.c ? [preexisting, don't care]

>   [Uninteresting stuff omitted...]
>   
> -    void visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp)
> +    bool visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Error **errp)
>       {
>           Error *err = NULL;
>   
> -        visit_type_int(v, "integer", &obj->integer, &err);
> -        if (err) {
> -            goto out;
> +        if (!visit_type_int(v, "integer", &obj->integer, errp)) {
> +            return false;
>           }
>           if (visit_optional(v, "string", &obj->has_string)) {
> -            visit_type_str(v, "string", &obj->string, &err);
> -            if (err) {
> -                goto out;
> +            if (!visit_type_str(v, "string", &obj->string, errp)) {
> +                return false;
>               }
>           }
> -
> -    out:
>           error_propagate(errp, err);
> +        return !err;

Looks weird with redundant err variable.. Still works. I see, after the whole series it is handled, so, OK.

>       }
>   
> -    void visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp)
> +    bool visit_type_UserDefOne(Visitor *v, const char *name, UserDefOne **obj, Error **errp)
>       {
>           Error *err = NULL;
>   
> -        visit_start_struct(v, name, (void **)obj, sizeof(UserDefOne), &err);
> -        if (err) {
> -            goto out;

[..]

> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 5fe0276c1c..6d8f4b6928 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -133,7 +133,7 @@ opts_visitor_insert(GHashTable *unprocessed_opts, const QemuOpt *opt)
>   }
>   
>   

[..]

>   
>   
> @@ -221,7 +224,7 @@ lookup_distinct(const OptsVisitor *ov, const char *name, Error **errp)
>   }
>   
>   
> -static void
> +static bool
>   opts_start_list(Visitor *v, const char *name, GenericList **list, size_t size,
>                   Error **errp)
>   {
> @@ -238,6 +241,7 @@ opts_start_list(Visitor *v, const char *name, GenericList **list, size_t size,
>       } else {
>           *list = NULL;

should return false here, as errp is set.


>       }
> +    return true;
>   }
>   
>   
> @@ -285,13 +289,14 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
>   }
>   
>   

[..]

> diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
> index daab6819b4..5a54bd593f 100644
> --- a/qapi/qapi-clone-visitor.c
> +++ b/qapi/qapi-clone-visitor.c
> @@ -24,7 +24,7 @@ static QapiCloneVisitor *to_qcv(Visitor *v)
>       return container_of(v, QapiCloneVisitor, visitor);
>   }
>   
> -static void qapi_clone_start_struct(Visitor *v, const char *name, void **obj,
> +static bool qapi_clone_start_struct(Visitor *v, const char *name, void **obj,
>                                       size_t size, Error **errp)
>   {
>       QapiCloneVisitor *qcv = to_qcv(v);
> @@ -34,11 +34,12 @@ static void qapi_clone_start_struct(Visitor *v, const char *name, void **obj,
>           /* Only possible when visiting an alternate's object
>            * branch. Nothing further to do here, since the earlier
>            * visit_start_alternate() already copied memory. */
> -        return;
> +        return true;
>       }
>   
>       *obj = g_memdup(*obj, size);
>       qcv->depth++;
> +    return true;
>   }
>   
>   static void qapi_clone_end(Visitor *v, void **obj)
> @@ -51,11 +52,12 @@ static void qapi_clone_end(Visitor *v, void **obj)
>       }
>   }
>   
> -static void qapi_clone_start_list(Visitor *v, const char *name,
> +static bool qapi_clone_start_list(Visitor *v, const char *name,
>                                     GenericList **listp, size_t size,
>                                     Error **errp)
>   {
>       qapi_clone_start_struct(v, name, (void **)listp, size, errp);
> +    return true;

should be return qapi_clone_start_struct(v, name, (void **)listp, size, errp);

>   }
>   
>   static GenericList *qapi_clone_next_list(Visitor *v, GenericList *tail,
> @@ -69,45 +71,49 @@ static GenericList *qapi_clone_next_list(Visitor *v, GenericList *tail,
>       return tail->next;
>   }
>   
> -static void qapi_clone_start_alternate(Visitor *v, const char *name,
> +static bool qapi_clone_start_alternate(Visitor *v, const char *name,
>                                          GenericAlternate **obj, size_t size,
>                                          Error **errp)
>   {
>       qapi_clone_start_struct(v, name, (void **)obj, size, errp);
> +    return true;

similar here

>   }
>   
> -static void qapi_clone_type_int64(Visitor *v, const char *name, int64_t *obj,
> -                                   Error **errp)
> -{
> -    QapiCloneVisitor *qcv = to_qcv(v);
> -
> -    assert(qcv->depth);
> -    /* Value was already cloned by g_memdup() */
> -}


With three return values fixed:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir

