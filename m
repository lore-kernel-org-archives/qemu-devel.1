Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F15C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47BD206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZTG0bKmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47BD206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmw7-00039t-Mq
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCmvK-0002fT-OM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCmvH-0001Sb-GS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:12:34 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com
 ([40.107.8.94]:27213 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCmv8-0000HR-TG; Fri, 13 Mar 2020 12:12:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLGeDsOHF/ZJ4LephNL0ew0DtF2dM2k/NMxtYLvZEQZEvLjYDxZyEyeTgwn3qHj8CJt19GkRHDsDC6Gn/OTInfG8nZNXjKT5gIRH2zM0+SiiZB60lRTn4LptwLANYplGzenvSYZ8YzTwtu2MTT3qZzdkMMULxlwq9aI+M2HferBJimuo9G8q0yH2q/6Sy5AiU7/w1l0DGULTpGCr+POea9IZMb7n4RUGw4pBBq+VEG8n5K/Dzhswj8Cs3EvQK9hDW1WQe/EbUHCvYiPY0pZomV5GKTVE5k5o+4sgsZChHdTkKRNVP5Jo65YSItCxylA3u5FcfbDWTnnGto4Zi6in/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKzgaJG3oHxIhBPaa5HnSG8MPqX3D9xcDLEsLi40GhU=;
 b=TohP4U12RHGmVyCyKuR+FWnz8AEcfz7TvZTm9LD7HWFvTeNqnGunIJTnmwfWazKsRKHpZFtnWf7YMCf4II1BNDH+jl9z/95MEdyeWLO2NRhAh08y2TdImy9ROGuaBYjK1AgKO+VFLx/QCfp+8pVgnXiZuo3qcAVwWb3N4kgvtk2feQg6h1mIlRThJgwlqz0TLo5VSDLcTTo8Mrbb+RMbbK35NqNmG9m1qaN8k5Z0Gyz8rpnP7WBEEpPOkuea7z77c5pV8oHqBNzGCG9jSiz5NOhrUkWxWUvHFZeiL6KjYYRltHeyG4VWC2yHPO8BuCgMqVBYyCfeetKK8+RIXH6rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKzgaJG3oHxIhBPaa5HnSG8MPqX3D9xcDLEsLi40GhU=;
 b=ZTG0bKmhfmrNKGAfL6tXRBKTDv2nPapSJfrS7bcBwRUsALckETN7o3EHTGktaLuoTKLbGze36dzbVPvWKUeRjFW6gZACsF7d8YJCM6Mzg516YDftQlpopX3GoRil75ZvW57muV8zT8Sr2RLcMxwCGMJkKiPsvsSYTfv7GVlyUGY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3624.eurprd08.prod.outlook.com (20.177.116.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 16:12:20 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.016; Fri, 13 Mar 2020
 16:12:20 +0000
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
 <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
 <875zf8gt2m.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200313191217439
Message-ID: <7c6f9a91-76cf-242d-8166-0693ec14b24d@virtuozzo.com>
Date: Fri, 13 Mar 2020 19:12:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <875zf8gt2m.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0401CA0071.eurprd04.prod.outlook.com
 (2603:10a6:3:19::39) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0401CA0071.eurprd04.prod.outlook.com (2603:10a6:3:19::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.20 via Frontend Transport; Fri, 13 Mar 2020 16:12:18 +0000
X-Tagtoolbar-Keys: D20200313191217439
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c61f7ff4-1285-4892-6000-08d7c7694e7c
X-MS-TrafficTypeDiagnostic: AM6PR08MB3624:
X-Microsoft-Antispam-PRVS: <AM6PR08MB362497A4377F7FEFD8109095C1FA0@AM6PR08MB3624.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(376002)(39850400004)(396003)(199004)(956004)(31686004)(2906002)(2616005)(31696002)(66946007)(5660300002)(86362001)(66476007)(6486002)(4326008)(66574012)(66556008)(53546011)(52116002)(30864003)(16576012)(316002)(8936002)(81166006)(81156014)(26005)(16526019)(186003)(8676002)(478600001)(54906003)(7416002)(6916009)(36756003)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3624;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLtksrqnvnUDS9bKLllbTg8vNulu9pl49JJgsUccSpI6n27IxeOa0NMyPSouvGpUSoAuxbbhAXvXL2kia0vfQK56RuFGxbvc4bD3MqlXm3OQ953QsuCYoK+TN8P8Tw2jB7YzBZR45hIgvvzOpaMS++vK7apSWN2QbmSFiEL5iuawOnStglrto5VmISPnx1DXipnUvTY+1Cz3LMRf3fw1Y+Na9yLbS96nwdbyWtB/oNapdtHhDEGxICg6SUZlfM7K8vs15rYhRcLL32dzFWS/rlAYPQXlWOg7PvseX1IIjeE7kvsYSxZuMOyvVo+VzdzBGocvusApEnB4ZY1vHuzKiGnHIRAJOMgnIQO9pc63K8l1K2h9jm+v8qi7eDxKAa7GZMz5XndH10rovCIccmmM1fq/Lbn7CS7/xRv5BV5xDWl2OmD5ClEy4S9u8IF4wVCFYySoJkecr0qGGj8DMFkOy5aoj5QCo4mJmlFH0+cZ3qObiBP92yGDtiGbkSByifSUpDRjyGQO9YAoRcZjwJMRbVqC4j7IIDBXeO45GXaCVJC0ZzD+xwW/oU06D99py9rc
X-MS-Exchange-AntiSpam-MessageData: 9/JLVw8TzEEWmrzYO7q7sNO4RYRtdX7AFxb+gwDYCJsmzpsXZBFVJGTlfsvJL8vjhJfocvza7PxZBjvljjQGiqTaqJA9UBzDf1GE3JxyrgEeceJGnihw2BaFTv3zOBOKhuqabyrpjkE+HejO+MwrZw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61f7ff4-1285-4892-6000-08d7c7694e7c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 16:12:20.0980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzIJTr2tXJarL2I0UYq9o9Pl5eiK2/f6weiAKAv4NUgZnZ2XYdM4edEZm82yX7L2AQrdaEL+1U9ztj6SLGoWA1wMfdnM6CkeAU9JNiDc7l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3624
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.94
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.03.2020 18:42, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> 12.03.2020 19:36, Markus Armbruster wrote:
>>> I may have a second look tomorrow with fresher eyes, but let's get this
>>> out now as is.
>>>
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
>>>> does corresponding changes in code (look for details in
>>>> include/qapi/error.h)
>>>>
>>>> Usage example:
>>>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>    --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>>>>    --max-width 80 FILES...
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>
>>>> Cc: Eric Blake <eblake@redhat.com>
>>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>>> Cc: Max Reitz <mreitz@redhat.com>
>>>> Cc: Greg Kurz <groug@kaod.org>
>>>> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>>> Cc: Anthony Perard <anthony.perard@citrix.com>
>>>> Cc: Paul Durrant <paul@xen.org>
>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>> Cc: qemu-devel@nongnu.org
>>>> Cc: qemu-block@nongnu.org
>>>> Cc: xen-devel@lists.xenproject.org
>>>>
>>>>    scripts/coccinelle/auto-propagated-errp.cocci | 327 +++++++++++++++=
+++
>>>>    include/qapi/error.h                          |   3 +
>>>>    MAINTAINERS                                   |   1 +
>>>>    3 files changed, 331 insertions(+)
>>>>    create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>>>
>>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/c=
occinelle/auto-propagated-errp.cocci
>>>> new file mode 100644
>>>> index 0000000000..7dac2dcfa4
>>>> --- /dev/null
>>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>>> @@ -0,0 +1,327 @@
>>>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>>> +//
>>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>>> +//
>>>> +// This program is free software; you can redistribute it and/or
>>>> +// modify it under the terms of the GNU General Public License as
>>>> +// published by the Free Software Foundation; either version 2 of the
>>>> +// License, or (at your option) any later version.
>>>> +//
>>>> +// This program is distributed in the hope that it will be useful,
>>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> +// GNU General Public License for more details.
>>>> +//
>>>> +// You should have received a copy of the GNU General Public License
>>>> +// along with this program.  If not, see
>>>> +// <http://www.gnu.org/licenses/>.
>>>> +//
>>>> +// Usage example:
>>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>> +//  --macro-file scripts/cocci-macro-file.h --in-place \
>>>> +//  --no-show-diff --max-width 80 FILES...
>>>> +//
>>>> +// Note: --max-width 80 is needed because coccinelle default is less
>>>> +// than 80, and without this parameter coccinelle may reindent some
>>>> +// lines which fit into 80 characters but not to coccinelle default,
>>>> +// which in turn produces extra patch hunks for no reason.
>>>
>>> This is about unwanted reformatting of parameter lists due to the ___
>>> chaining hack.  --max-width 80 makes that less likely, but not
>>> impossible.
>>>
>>> We can search for unwanted reformatting of parameter lists.  I think
>>> grepping diffs for '^\+.*Error \*\*' should do the trick.  For the whol=
e
>>> tree, I get one false positive (not a parameter list), and one hit:
>>>
>>>       @@ -388,8 +388,10 @@ static void object_post_init_with_type(O
>>>            }
>>>        }
>>>
>>>       -void object_apply_global_props(Object *obj, const GPtrArray *pro=
ps, Error **errp)
>>>       +void object_apply_global_props(Object *obj, const GPtrArray *pro=
ps,
>>>       +                               Error **errp)
>>>        {
>>>       +    ERRP_AUTO_PROPAGATE();
>>>            int i;
>>>
>>>            if (!props) {
>>>
>>> Reformatting, but not unwanted.
>>
>> Yes, I saw it. This line is 81 character length, so it's OK to fix it in=
 one hunk with
>> ERRP_AUTO_PROPAGATE addition even for non-automatic patch.
>=20
> Agree.
>=20
>>>
>>> The --max-width 80 hack is good enough for me.
>>>
>>> It does result in slightly long transformed lines, e.g. this one in
>>> replication.c:
>>>
>>>       @@ -113,7 +113,7 @@ static int replication_open(BlockDriverS
>>>                s->mode =3D REPLICATION_MODE_PRIMARY;
>>>                top_id =3D qemu_opt_get(opts, REPLICATION_TOP_ID);
>>>                if (top_id) {
>>>       -            error_setg(&local_err, "The primary side does not su=
pport option top-id");
>>>       +            error_setg(errp, "The primary side does not support =
option top-id");
>>>                    goto fail;
>>>                }
>>>            } else if (!strcmp(mode, "secondary")) {
>>>
>>> v8 did break this line (that's how I found it).  However, v9 still
>>> shortens the line, just not below the target.  All your + lines look
>>> quite unlikely to lengthen lines.  Let's not worry about this.
>>>
>>>> +// Switch unusual Error ** parameter names to errp
>>>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>>>> +//
>>>> +// Disable optional_qualifier to skip functions with
>>>> +// "Error *const *errp" parameter.
>>>> +//
>>>> +// Skip functions with "assert(_errp && *_errp)" statement, because
>>>> +// that signals unusual semantics, and the parameter name may well
>>>> +// serve a purpose. (like nbd_iter_channel_error()).
>>>> +//
>>>> +// Skip util/error.c to not touch, for example, error_propagate() and
>>>> +// error_propagate_prepend().
>>>> +@ depends on !(file in "util/error.c") disable optional_qualifier@
>>>> +identifier fn;
>>>> +identifier _errp !=3D errp;
>>>> +@@
>>>> +
>>>> + fn(...,
>>>> +-   Error **_errp
>>>> ++   Error **errp
>>>> +    ,...)
>>>> + {
>>>> +(
>>>> +     ... when !=3D assert(_errp && *_errp)
>>>> +&
>>>> +     <...
>>>> +-    _errp
>>>> ++    errp
>>>> +     ...>
>>>> +)
>>>> + }
>>>> +
>>>> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
>>>> +// necessary
>>>> +//
>>>> +// Note, that without "when any" the final "..." does not mach
>>>> +// something matched by previous pattern, i.e. the rule will not matc=
h
>>>> +// double error_prepend in control flow like in
>>>> +// vfio_set_irq_signaling().
>>>> +//
>>>> +// Note, "exists" says that we want apply rule even if it matches not
>>>> +// on all possible control flows (otherwise, it will not match
>>>> +// standard pattern when error_propagate() call is in if branch).
>>>> +@ disable optional_qualifier exists@
>>>> +identifier fn, local_err;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(..., Error **errp, ...)
>>>> + {
>>>> ++   ERRP_AUTO_PROPAGATE();
>>>> +    ...  when !=3D ERRP_AUTO_PROPAGATE();
>>>> +(
>>>> +(
>>>> +    error_append_hint(errp, ...);
>>>> +|
>>>> +    error_prepend(errp, ...);
>>>> +|
>>>> +    error_vprepend(errp, ...);
>>>> +)
>>>> +    ... when any
>>>> +|
>>>> +    Error *local_err =3D NULL;
>>>> +    ...
>>>> +(
>>>> +    error_propagate_prepend(errp, local_err, ...);
>>>> +|
>>>> +    error_propagate(errp, local_err);
>>>> +)
>>>> +    ...
>>>> +)
>>>> + }
>>>> +
>>>> +
>>>> +// Match functions with propagation of local error to errp.
>>>> +// We want to refer these functions in several following rules, but I
>>>> +// don't know a proper way to inherit a function, not just its name
>>>> +// (to not match another functions with same name in following rules)=
.
>>>> +// Not-proper way is as follows: rename errp parameter in functions
>>>> +// header and match it in following rules. Rename it back after all
>>>> +// transformations.
>>>> +//
>>>> +// The simplest case of propagation scheme is single definition of
>>>> +// local_err with at most one error_propagate_prepend or
>>>> +// error_propagate on each control-flow. Still, we want to match more
>>>> +// complex schemes too. We'll warn them with help of further rules.
>>>
>>> I think what we actually want is to examine instances of this pattern t=
o
>>> figure out whether and how we want to transform them.  Perhaps:
>>>
>>>       // The common case is a single definition of local_err with at mo=
st one
>>>       // error_propagate_prepend() or error_propagate() on each control=
-flow
>>>       // path. Instances of this case we convert with this script. Func=
tions
>>
>> For me, sounds a bit like "other things we don't convert".
>> Actually we convert other things too.
>=20
> What other patterns of error propagation do we convert?

Something like in xen_block_device_destroy, why not? Otherwise, it's better=
 to avoid
matching things like xen_block_device_destroy, not just warn them.
But I'd prefer to proceed now as is to fit into 5.0.. Too much time already
spent on this. So, I'm OK with your wording too.

>=20
>>>       // with multiple definitions or propagates we want to examine
>>>       // manually. Later rules emit warnings to guide us to them.
>>>
>>>> +@rule1 disable optional_qualifier exists@
>>>> +identifier fn, local_err;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(..., Error **
>>>> +-    errp
>>>> ++    ____
>>>> +    , ...)
>>>> + {
>>>> +     ...
>>>> +     Error *local_err =3D NULL;
>>>> +     ...
>>>> +(
>>>> +     error_propagate_prepend(errp, local_err, ...);
>>>> +|
>>>> +     error_propagate(errp, local_err);
>>>> +)
>>>> +     ...
>>>> + }
>>>> +
>>>> +
>>>> +// Warn several Error * definitions.
>>>> +@check1 disable optional_qualifier exists@
>>>> +identifier fn =3D rule1.fn, local_err, local_err2;
>>>
>>> Elsewhere, you use just rule.fn instead of fn =3D rule1.fn.  Any
>>> particular reason for the difference?
>>
>> I didn't find other way to ref check1.fn in next python rule. It just do=
n't
>> work if I write here just rule1.fn.
>>
>>>
>>> With the ___ chaining hack, I doubt we still need "=3D rule1.fn" or
>>> "rule1.fn".  If I replace "fn =3D rule1.fn" and "rule.fn" by just "fn"
>>> everywhere, then apply the script to the complete tree, I get the same
>>> result.
>>
>> I think, it's more efficient to reuse names from previous rules. I think=
 it should
>> work faster (more information, less extra matching).
>=20
> Nope.  With my hacked up script (patch appended) Coccinelle is actually
> *faster* for the .[ch] touched by this series: with your unmodified
> script, it takes a bit over 12s on my box, with mine around 7s.  Output
> is identical.
>=20
> Never guess performance, always measure it :)

Hmm, whole tree results would be better proof

>=20
> Two notes on my script:
>=20
> * Unlike yours, it recognizes double-propagation in my test case.
>    Discussed below.
>=20
> * Its "several definitions of" warning includes positions.  That turned
>    out to be useless, but I've been too lazy to take that out again.
>=20
>>>
>>>> +@@
>>>> +
>>>> + fn(..., Error ** ____, ...)
>>>> + {
>>>> +     ...
>>>> +     Error *local_err =3D NULL;
>>>> +     ... when any
>>>> +     Error *local_err2 =3D NULL;
>>>> +     ... when any
>>>> + }
>>>> +
>>>> +@ script:python @
>>>> +fn << check1.fn;
>>>> +@@
>>>> +
>>>> +print('Warning: function {} has several definitions of '
>>>> +      'Error * local variable'.format(fn))
>>>> +
>>>> +// Warn several propagations in control flow.
>>>> +@check2 disable optional_qualifier exists@
>>>> +identifier fn =3D rule1.fn;
>>>> +symbol errp;
>>>> +position p1, p2;
>>>> +@@
>>>> +
>>>> + fn(..., Error ** ____, ...)
>>>> + {
>>>> +     ...
>>>> +(
>>>> +     error_propagate_prepend(errp, ...);@p1
>>>> +|
>>>> +     error_propagate(errp, ...);@p1
>>>> +)
>>>> +     ...
>>>> +(
>>>> +     error_propagate_prepend(errp, ...);@p2
>>>> +|
>>>> +     error_propagate(errp, ...);@p2
>>>> +)
>>>> +     ... when any
>>>> + }
>>>> +
>>>
>>> Hmm, we don't catch the example I used in review of v8:
>>>
>>>       extern foo(int, Error **);
>>>       extern bar(int, Error **);
>>>
>>>       void frob(Error **errp)
>>>       {
>>>           Error *local_err =3D NULL;
>>>           int arg;
>>>
>>>           foo(arg, errp);
>>>           bar(arg, &local_err);
>>>           error_propagate(errp, local_err);
>>>           bar(arg + 1, &local_err);
>>>           error_propagate(errp, local_err);
>>>       }
>>>
>>> I believe this is because rule1 does not match here.
>>
>> Yes, rule1 wants at least one code flow with non-doubled propagation.
>>
>>>
>>> If I change the rule as follows, it catches the example:
>>>
>>>       @@ -157,24 +157,23 @@ print('Warning: function {} has several def=
initions of '
>>>
>>>        // Warn several propagations in control flow.
>>>        @check2 disable optional_qualifier exists@
>>>       -identifier fn =3D rule1.fn;
>>>       -symbol errp;
>>>       +identifier fn, _errp;
>>>        position p1, p2;
>>>        @@
>>>
>>>       - fn(..., Error ** ____, ...)
>>>       + fn(..., Error **_errp, ...)
>>>         {
>>>             ...
>>>        (
>>>       -     error_propagate_prepend(errp, ...);@p1
>>>       +     error_propagate_prepend(_errp, ...);@p1
>>>        |
>>>       -     error_propagate(errp, ...);@p1
>>>       +     error_propagate(_errp, ...);@p1
>>>        )
>>>             ...
>>>        (
>>>       -     error_propagate_prepend(errp, ...);@p2
>>>       +     error_propagate_prepend(_errp, ...);@p2
>>>        |
>>>       -     error_propagate(errp, ...);@p2
>>>       +     error_propagate(_errp, ...);@p2
>>>        )
>>>             ... when any
>>>         }
>>>
>>> To my mild surprise, it still doesn't find anything in our tree.
>>>
>>> Should we decouple the previous rule from rule1, too?  I tested the
>>> following on the whole tree:
>>
>> I don't think so. Why to check what we are not going to convert? If we w=
ant
>> to check side things, it's better to do it in other coccinelle script..
>=20
> Misunderstanding?  The rules are still chained together via the ___
> hack, just not via function name, because that's unreliable and
> redundant.


Strange.. Then, how can it match something not matched by rule1?


>=20
>>>
>>>       @@ -136,10 +136,10 @@ symbol errp;
>>>
>>>        // Warn several Error * definitions.
>>>        @check1 disable optional_qualifier exists@
>>>       -identifier fn =3D rule1.fn, local_err, local_err2;
>>>       +identifier fn, _errp, local_err, local_err2;
>>>        @@
>>>
>>>       - fn(..., Error ** ____, ...)
>>>       + fn(..., Error **_errp, ...)
>>>         {
>>>             ...
>>>             Error *local_err =3D NULL;
>>>
>>> Warnings remain unchanged.
>>>
>>>> +@ script:python @
>>>> +fn << check2.fn;
>>>> +p1 << check2.p1;
>>>> +p2 << check2.p2;
>>>> +@@
>>>> +
>>>> +print('Warning: function {} propagates to errp several times in '
>>>> +      'one control flow: at {}:{} and then at {}:{}'.format(
>>>> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>>> +
>>>> +// Convert special case with goto separately.
>>>> +// I tried merging this into the following rule the obvious way, but
>>>> +// it made Coccinelle hang on block.c
>>>> +//
>>>> +// Note interesting thing: if we don't do it here, and try to fixup
>>>> +// "out: }" things later after all transformations (the rule will be
>>>> +// the same, just without error_propagate() call), coccinelle fails t=
o
>>>> +// match this "out: }".
>>>> +@ disable optional_qualifier@
>>>> +identifier rule1.fn, rule1.local_err, out;
>>>
>>> As explained above, I doubt the need for rule1.fn.  We do need
>>> rule1.local_err to avoid unwanted transformations.  More of the same
>>> below.
>>
>> Logically, I want to inherit from rule1. So why not to stress it by inhe=
riting
>> fn variable? It's just a correct thing to do.
>> And I hope it helps coccinelle to work more efficiently.
>>
>>>
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(..., Error ** ____, ...)
>>>> + {
>>>> +     <...
>>>> +-    goto out;
>>>> ++    return;
>>>> +     ...>
>>>> +- out:
>>>> +-    error_propagate(errp, local_err);
>>>> + }
>>>> +
>>>> +// Convert most of local_err related stuff.
>>>> +//
>>>> +// Note, that we update everything related to matched by rule1
>>>> +// function name and local_err name. We may match something not
>>>> +// related to the pattern matched by rule1. For example, local_err ma=
y
>>>> +// be defined with the same name in different blocks inside one
>>>> +// function, and in one block follow the propagation pattern and in
>>>> +// other block doesn't. Or we may have several functions with the sam=
e
>>>> +// name (for different configurations).
>>>> +//
>>>> +// Note also that errp-cleaning functions
>>>> +//   error_free_errp
>>>> +//   error_report_errp
>>>> +//   error_reportf_errp
>>>> +//   warn_report_errp
>>>> +//   warn_reportf_errp
>>>> +// are not yet implemented. They must call corresponding Error* -
>>>> +// freeing function and then set *errp to NULL, to avoid further
>>>> +// propagation to original errp (consider ERRP_AUTO_PROPAGATE in use)=
.
>>>> +// For example, error_free_errp may look like this:
>>>> +//
>>>> +//    void error_free_errp(Error **errp)
>>>> +//    {
>>>> +//        error_free(*errp);
>>>> +//        *errp =3D NULL;
>>>> +//    }
>>>> +@ disable optional_qualifier exists@
>>>> +identifier rule1.fn, rule1.local_err;
>>>> +expression list args;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(..., Error ** ____, ...)
>>>> + {
>>>> +     <...
>>>> +(
>>>> +-    Error *local_err =3D NULL;
>>>> +|
>>>> +
>>>> +// Convert error clearing functions
>>>> +(
>>>> +-    error_free(local_err);
>>>> ++    error_free_errp(errp);
>>>> +|
>>>> +-    error_report_err(local_err);
>>>> ++    error_report_errp(errp);
>>>> +|
>>>> +-    error_reportf_err(local_err, args);
>>>> ++    error_reportf_errp(errp, args);
>>>> +|
>>>> +-    warn_report_err(local_err);
>>>> ++    warn_report_errp(errp);
>>>> +|
>>>> +-    warn_reportf_err(local_err, args);
>>>> ++    warn_reportf_errp(errp, args);
>>>> +)
>>>> +?-    local_err =3D NULL;
>>>> +
>>>> +|
>>>> +-    error_propagate_prepend(errp, local_err, args);
>>>> ++    error_prepend(errp, args);
>>>> +|
>>>> +-    error_propagate(errp, local_err);
>>>> +|
>>>> +-    &local_err
>>>> ++    errp
>>>> +)
>>>> +     ...>
>>>> + }
>>>> +
>>>> +// Convert remaining local_err usage. For example, different kinds of
>>>> +// error checking in if conditionals. We can't merge this into
>>>> +// previous hunk, as this conflicts with other substitutions in it (a=
t
>>>> +// least with "- local_err =3D NULL").
>>>> +@ disable optional_qualifier@
>>>> +identifier rule1.fn, rule1.local_err;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(..., Error ** ____, ...)
>>>> + {
>>>> +     <...
>>>> +-    local_err
>>>> ++    *errp
>>>> +     ...>
>>>> + }
>>>> +
>>>> +// Always use the same pattern for checking error
>>>> +@ disable optional_qualifier@
>>>> +identifier rule1.fn;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(..., Error ** ____, ...)
>>>> + {
>>>> +     <...
>>>> +-    *errp !=3D NULL
>>>> ++    *errp
>>>> +     ...>
>>>> + }
>>>> +
>>>> +// Revert temporary ___ identifier.
>>>> +@ disable optional_qualifier@
>>>> +identifier rule1.fn;
>>>> +@@
>>>> +
>>>> + fn(..., Error **
>>>> +-   ____
>>>> ++   errp
>>>> +    , ...)
>>>> + {
>>>> +     ...
>>>> + }
>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>> index 30140d9bfe..56c133520d 100644
>>>> --- a/include/qapi/error.h
>>>> +++ b/include/qapi/error.h
>>>> @@ -214,6 +214,9 @@
>>>>     *         }
>>>>     *         ...
>>>>     *     }
>>>> + *
>>>> + * For mass-conversion use script
>>>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>>>     */
>>>>      #ifndef ERROR_H
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 857f969aa1..047f1b9714 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1998,6 +1998,7 @@ F: include/qemu/error-report.h
>>>>    F: qapi/error.json
>>>>    F: util/error.c
>>>>    F: util/qemu-error.c
>>>> +F: scripts/coccinelle/*err*.cocci
>>>>      GDB stub
>>>>    M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>
>=20
>=20
>  From 42a08c529024337d1b859839c9ce7f797f784555 Mon Sep 17 00:00:00 2001
> From: Markus Armbruster <armbru@redhat.com>
> Date: Fri, 13 Mar 2020 14:27:57 +0100
> Subject: [PATCH] fixup! scripts: Coccinelle script to use
>   ERRP_AUTO_PROPAGATE()
>=20
> ---
>   scripts/coccinelle/auto-propagated-errp.cocci | 37 ++++++++++---------
>   1 file changed, 20 insertions(+), 17 deletions(-)
>=20
> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/cocc=
inelle/auto-propagated-errp.cocci
> index 7dac2dcfa4..43b0b0e63b 100644
> --- a/scripts/coccinelle/auto-propagated-errp.cocci
> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
> @@ -136,45 +136,48 @@ symbol errp;
>  =20
>   // Warn several Error * definitions.
>   @check1 disable optional_qualifier exists@
> -identifier fn =3D rule1.fn, local_err, local_err2;
> +identifier fn, _errp, local_err, local_err2;
> +position p1, p2;


Hmm, seems like I forget to define ____ as symbol in my patch

>   @@
>  =20
> - fn(..., Error ** ____, ...)
> + fn(..., Error **_errp, ...)

Ahmm.. it will break compilation?

Or, how will it work when _errp defined as meta variable is only in "+..." =
line? Should it be symbol instead, or just not defined?

>    {
>        ...
> -     Error *local_err =3D NULL;
> +     Error *local_err =3D NULL;@p1

Why to do -/+ here? Nothing changed..

>        ... when any
> -     Error *local_err2 =3D NULL;
> +     Error *local_err2 =3D NULL;@p2
>        ... when any
>    }
>  =20
>   @ script:python @
>   fn << check1.fn;
> +p1 << check1.p1;
> +p2 << check1.p2;
>   @@
>  =20
>   print('Warning: function {} has several definitions of '
> -      'Error * local variable'.format(fn))
> +      'Error * local variable: at {}:{} and then at {}:{}'.format(
> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>  =20
>   // Warn several propagations in control flow.
>   @check2 disable optional_qualifier exists@
> -identifier fn =3D rule1.fn;
> -symbol errp;
> +identifier fn, _errp;
>   position p1, p2;
>   @@
>  =20
> - fn(..., Error ** ____, ...)
> + fn(..., Error **_errp, ...)
>    {
>        ...
>   (
> -     error_propagate_prepend(errp, ...);@p1
> +     error_propagate_prepend(_errp, ...);@p1
>   |
> -     error_propagate(errp, ...);@p1
> +     error_propagate(_errp, ...);@p1
>   )
>        ...
>   (
> -     error_propagate_prepend(errp, ...);@p2
> +     error_propagate_prepend(_errp, ...);@p2
>   |
> -     error_propagate(errp, ...);@p2
> +     error_propagate(_errp, ...);@p2
>   )

You change some occurrences of errp to _errp, but not all. It breaks compil=
ation.

>        ... when any
>    }
> @@ -198,7 +201,7 @@ print('Warning: function {} propagates to errp severa=
l times in '
>   // the same, just without error_propagate() call), coccinelle fails to
>   // match this "out: }".
>   @ disable optional_qualifier@
> -identifier rule1.fn, rule1.local_err, out;
> +identifier fn, rule1.local_err, out;

Hmm. If it improves performance it is strange.. But I can live with this ch=
ange.

>   symbol errp;
>   @@
>  =20
> @@ -239,7 +242,7 @@ symbol errp;
>   //        *errp =3D NULL;
>   //    }
>   @ disable optional_qualifier exists@
> -identifier rule1.fn, rule1.local_err;
> +identifier fn, rule1.local_err;
>   expression list args;
>   symbol errp;
>   @@
> @@ -287,7 +290,7 @@ symbol errp;
>   // previous hunk, as this conflicts with other substitutions in it (at
>   // least with "- local_err =3D NULL").
>   @ disable optional_qualifier@
> -identifier rule1.fn, rule1.local_err;
> +identifier fn, rule1.local_err;
>   symbol errp;
>   @@
>  =20
> @@ -301,7 +304,7 @@ symbol errp;
>  =20
>   // Always use the same pattern for checking error
>   @ disable optional_qualifier@
> -identifier rule1.fn;
> +identifier fn;
>   symbol errp;
>   @@
>  =20
> @@ -315,7 +318,7 @@ symbol errp;
>  =20
>   // Revert temporary ___ identifier.
>   @ disable optional_qualifier@
> -identifier rule1.fn;
> +identifier fn;
>   @@
>  =20
>    fn(..., Error **
>=20


--=20
Best regards,
Vladimir

