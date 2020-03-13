Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE437C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0732073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 06:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n4fpiVoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0732073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCdyu-0004OW-Rl
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 02:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCdy4-0003xO-P2
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 02:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCdy1-0000Lp-HC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 02:38:48 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com
 ([40.107.3.109]:36677 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCdxj-0008G5-Gv; Fri, 13 Mar 2020 02:38:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwM2O6TyqugKsOOaarI1oACQZX0GNsoL6L3lDAz0QL6GovRIZoEqaB4YRbSdpk16AhaiSXvav55w59PGTBN3mrpjQ07cvO/HTcSktATi6AIg8FVWDhf3TEN/hM7OCrIh0CUKHyHf3qtbKJFhfjceVJWPgw1EeH4OEfu1DTCzvfdYsnWxGWwFEi1izHF78sVrss4ZT2yF0h8ll8RSJwI/+Yx20n6sQLouTaNIEjH6Ed5ZUQKKIFMixmU7e0q9QkHlRilLEjB/Sk3ruexGcCDMJfChrf4XTMgsRqjV+/Y8teccqSRfDVbfQaRPlb8Vj0X8TitDxYgTIsvqZEcuGQnipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPa9+d2GPRLxlTEcxyqupPSJTXgzAuQt/AfTeXNVTOk=;
 b=hP1344yhKrwtLkv3l5X3POkL8LYAu7ItzGnLVm76UFK6mGbZW93ino+NIXJMTVYcMe1PFfpxWCffEaEaquq7Mb+9UJKE/fSUkql8ORk+wEaxRYNoUF+WHoOT3NxsUN69mwEalg6tk+s8YiqLmLivGEVR6NGTB7wK4YSi15obj1p3+epPCePRt+d3VIQfwhxXpDC06kAyYadO27DNHgqizzxy30GBo3WKWEs5cep6Rj0qiEyxgkADVl8gi0DB94ZZdXwr9qy5WiRBSPtM/JeDhJLq8dRM09VYB/lN3VV19jMQJWl9KP99M58gESaAlx/O/hsVuq3qBrrjD3FNOBfLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPa9+d2GPRLxlTEcxyqupPSJTXgzAuQt/AfTeXNVTOk=;
 b=n4fpiVoyOWRCnoP9yB7e7GBKJTrd351r/HWU9XeK/B0Rc6f0nfEn4kvgR/ONIPoD8MHWYEQ5lLp15vVzPGpoNgY3PzVjKzBxrBAVqNUeqkh866yOHza7A9Zv+EEn/9ZF0xpVfSIl77SdaGoI7y2i5BU3KkG5xszJBuDxGTFEjV4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3797.eurprd08.prod.outlook.com (20.178.89.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 13 Mar 2020 06:38:24 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.016; Fri, 13 Mar 2020
 06:38:24 +0000
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200313093821535
Message-ID: <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
Date: Fri, 13 Mar 2020 09:38:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <874kuto7hq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR09CA0045.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR09CA0045.eurprd09.prod.outlook.com (2603:10a6:7:3c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Fri, 13 Mar 2020 06:38:23 +0000
X-Tagtoolbar-Keys: D20200313093821535
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 815a982c-7d0a-428f-7a53-08d7c719216a
X-MS-TrafficTypeDiagnostic: AM6PR08MB3797:
X-Microsoft-Antispam-PRVS: <AM6PR08MB379713A88C90401BFAE7D26DC1FA0@AM6PR08MB3797.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(376002)(39850400004)(396003)(199004)(52116002)(4326008)(16576012)(66476007)(66556008)(66946007)(36756003)(2906002)(54906003)(86362001)(31696002)(316002)(7416002)(26005)(6486002)(5660300002)(8936002)(16526019)(31686004)(186003)(81166006)(6916009)(8676002)(81156014)(2616005)(478600001)(956004)(30864003)(66574012)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3797;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOioxxRg2ZBJXGyxdywTEC27Hqc3bdSsBWzY8C6VirZHKA2EmC2WyPBb1o3SCTUp3ZVXMT9yZpDcR11cmgkw76OvRDFqDBRSZmP7TTPea7NgcnY+G4W0cnSdspqQH5lkKqBiUajhaERtg+t2o79B6gIhREJ5LiQDVrAPzGSe7/kVs2s6HfkKpyhmHpzpCw3xHOUZ7OiGh8FRmogpGHpbaU2X4p3ErxmZodWwwkBRtnsCLSN6aJmPgOITIMpm+JTZCQweov684aYN96JlZpZ9KH9GNdUKXozho/8uKYfi8qisFNUbMxfwisBcBjuSm6r7BGBhejSD0IiakNUBN00a5UL91FyyRgdND2A8tIEBl/fSSqz2SMRLRIrNJqR3QMzQbHLUnP7pFGEzLhDP+paHp3tIaWeCChKBJQF+X6/DwMDJ8mygq/cikM4+kIuif6v4TtqntqpMeP/75TICD5oU/LfXfGceKnD8JwSI7qgiEWKV6Ns4DSHPFpczSY8V7otZaBmPXEkpKdSDVYLXon0AO4uqq57O+D2x6yqYal/am8kB0rMKXQ+G+SpG6J16Mtrj
X-MS-Exchange-AntiSpam-MessageData: gMuhBbaX3rBhzUftN6XbCsqW95+W7Iqgz5s94IFfdNZsXhAZkNkfAAwMh7zQSfriFz3F3zr2DCvXnEGG02XaYfFoBObheqjOdjMOQZpE3dL0Sqvaqq5aWFZq6F0uVEL5u6QOlQqrH5OXCbeMgDqllg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815a982c-7d0a-428f-7a53-08d7c719216a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 06:38:24.7838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TV4B08T0PnWDpoPQFmpbtl7xtK32Mu1a2JkrrM6csUyvHY4Yh2T30XhqRL6NJju3Ocmg5Qlm/TcqUZM3yB39tVJzsSvsZN+xB7s2dv4bUQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3797
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.109
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
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.03.2020 19:36, Markus Armbruster wrote:
> I may have a second look tomorrow with fresher eyes, but let's get this
> out now as is.
>=20
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
>> does corresponding changes in code (look for details in
>> include/qapi/error.h)
>>
>> Usage example:
>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>   --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>>   --max-width 80 FILES...
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: Greg Kurz <groug@kaod.org>
>> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: Paul Durrant <paul@xen.org>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-block@nongnu.org
>> Cc: xen-devel@lists.xenproject.org
>>
>>   scripts/coccinelle/auto-propagated-errp.cocci | 327 ++++++++++++++++++
>>   include/qapi/error.h                          |   3 +
>>   MAINTAINERS                                   |   1 +
>>   3 files changed, 331 insertions(+)
>>   create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>
>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/coc=
cinelle/auto-propagated-errp.cocci
>> new file mode 100644
>> index 0000000000..7dac2dcfa4
>> --- /dev/null
>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>> @@ -0,0 +1,327 @@
>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>> +//
>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>> +//
>> +// This program is free software; you can redistribute it and/or
>> +// modify it under the terms of the GNU General Public License as
>> +// published by the Free Software Foundation; either version 2 of the
>> +// License, or (at your option) any later version.
>> +//
>> +// This program is distributed in the hope that it will be useful,
>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +// GNU General Public License for more details.
>> +//
>> +// You should have received a copy of the GNU General Public License
>> +// along with this program.  If not, see
>> +// <http://www.gnu.org/licenses/>.
>> +//
>> +// Usage example:
>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>> +//  --macro-file scripts/cocci-macro-file.h --in-place \
>> +//  --no-show-diff --max-width 80 FILES...
>> +//
>> +// Note: --max-width 80 is needed because coccinelle default is less
>> +// than 80, and without this parameter coccinelle may reindent some
>> +// lines which fit into 80 characters but not to coccinelle default,
>> +// which in turn produces extra patch hunks for no reason.
>=20
> This is about unwanted reformatting of parameter lists due to the ___
> chaining hack.  --max-width 80 makes that less likely, but not
> impossible.
>=20
> We can search for unwanted reformatting of parameter lists.  I think
> grepping diffs for '^\+.*Error \*\*' should do the trick.  For the whole
> tree, I get one false positive (not a parameter list), and one hit:
>=20
>      @@ -388,8 +388,10 @@ static void object_post_init_with_type(O
>           }
>       }
>=20
>      -void object_apply_global_props(Object *obj, const GPtrArray *props,=
 Error **errp)
>      +void object_apply_global_props(Object *obj, const GPtrArray *props,
>      +                               Error **errp)
>       {
>      +    ERRP_AUTO_PROPAGATE();
>           int i;
>=20
>           if (!props) {
>=20
> Reformatting, but not unwanted.

Yes, I saw it. This line is 81 character length, so it's OK to fix it in on=
e hunk with
ERRP_AUTO_PROPAGATE addition even for non-automatic patch.

>=20
> The --max-width 80 hack is good enough for me.
>=20
> It does result in slightly long transformed lines, e.g. this one in
> replication.c:
>=20
>      @@ -113,7 +113,7 @@ static int replication_open(BlockDriverS
>               s->mode =3D REPLICATION_MODE_PRIMARY;
>               top_id =3D qemu_opt_get(opts, REPLICATION_TOP_ID);
>               if (top_id) {
>      -            error_setg(&local_err, "The primary side does not suppo=
rt option top-id");
>      +            error_setg(errp, "The primary side does not support opt=
ion top-id");
>                   goto fail;
>               }
>           } else if (!strcmp(mode, "secondary")) {
>=20
> v8 did break this line (that's how I found it).  However, v9 still
> shortens the line, just not below the target.  All your + lines look
> quite unlikely to lengthen lines.  Let's not worry about this.
>=20
>> +// Switch unusual Error ** parameter names to errp
>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>> +//
>> +// Disable optional_qualifier to skip functions with
>> +// "Error *const *errp" parameter.
>> +//
>> +// Skip functions with "assert(_errp && *_errp)" statement, because
>> +// that signals unusual semantics, and the parameter name may well
>> +// serve a purpose. (like nbd_iter_channel_error()).
>> +//
>> +// Skip util/error.c to not touch, for example, error_propagate() and
>> +// error_propagate_prepend().
>> +@ depends on !(file in "util/error.c") disable optional_qualifier@
>> +identifier fn;
>> +identifier _errp !=3D errp;
>> +@@
>> +
>> + fn(...,
>> +-   Error **_errp
>> ++   Error **errp
>> +    ,...)
>> + {
>> +(
>> +     ... when !=3D assert(_errp && *_errp)
>> +&
>> +     <...
>> +-    _errp
>> ++    errp
>> +     ...>
>> +)
>> + }
>> +
>> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
>> +// necessary
>> +//
>> +// Note, that without "when any" the final "..." does not mach
>> +// something matched by previous pattern, i.e. the rule will not match
>> +// double error_prepend in control flow like in
>> +// vfio_set_irq_signaling().
>> +//
>> +// Note, "exists" says that we want apply rule even if it matches not
>> +// on all possible control flows (otherwise, it will not match
>> +// standard pattern when error_propagate() call is in if branch).
>> +@ disable optional_qualifier exists@
>> +identifier fn, local_err;
>> +symbol errp;
>> +@@
>> +
>> + fn(..., Error **errp, ...)
>> + {
>> ++   ERRP_AUTO_PROPAGATE();
>> +    ...  when !=3D ERRP_AUTO_PROPAGATE();
>> +(
>> +(
>> +    error_append_hint(errp, ...);
>> +|
>> +    error_prepend(errp, ...);
>> +|
>> +    error_vprepend(errp, ...);
>> +)
>> +    ... when any
>> +|
>> +    Error *local_err =3D NULL;
>> +    ...
>> +(
>> +    error_propagate_prepend(errp, local_err, ...);
>> +|
>> +    error_propagate(errp, local_err);
>> +)
>> +    ...
>> +)
>> + }
>> +
>> +
>> +// Match functions with propagation of local error to errp.
>> +// We want to refer these functions in several following rules, but I
>> +// don't know a proper way to inherit a function, not just its name
>> +// (to not match another functions with same name in following rules).
>> +// Not-proper way is as follows: rename errp parameter in functions
>> +// header and match it in following rules. Rename it back after all
>> +// transformations.
>> +//
>> +// The simplest case of propagation scheme is single definition of
>> +// local_err with at most one error_propagate_prepend or
>> +// error_propagate on each control-flow. Still, we want to match more
>> +// complex schemes too. We'll warn them with help of further rules.
>=20
> I think what we actually want is to examine instances of this pattern to
> figure out whether and how we want to transform them.  Perhaps:
>=20
>      // The common case is a single definition of local_err with at most =
one
>      // error_propagate_prepend() or error_propagate() on each control-fl=
ow
>      // path. Instances of this case we convert with this script. Functio=
ns

For me, sounds a bit like "other things we don't convert".
Actually we convert other things too.

>      // with multiple definitions or propagates we want to examine
>      // manually. Later rules emit warnings to guide us to them.
>=20
>> +@rule1 disable optional_qualifier exists@
>> +identifier fn, local_err;
>> +symbol errp;
>> +@@
>> +
>> + fn(..., Error **
>> +-    errp
>> ++    ____
>> +    , ...)
>> + {
>> +     ...
>> +     Error *local_err =3D NULL;
>> +     ...
>> +(
>> +     error_propagate_prepend(errp, local_err, ...);
>> +|
>> +     error_propagate(errp, local_err);
>> +)
>> +     ...
>> + }
>> +
>> +
>> +// Warn several Error * definitions.
>> +@check1 disable optional_qualifier exists@
>> +identifier fn =3D rule1.fn, local_err, local_err2;
>=20
> Elsewhere, you use just rule.fn instead of fn =3D rule1.fn.  Any
> particular reason for the difference?

I didn't find other way to ref check1.fn in next python rule. It just don't
work if I write here just rule1.fn.

>=20
> With the ___ chaining hack, I doubt we still need "=3D rule1.fn" or
> "rule1.fn".  If I replace "fn =3D rule1.fn" and "rule.fn" by just "fn"
> everywhere, then apply the script to the complete tree, I get the same
> result.

I think, it's more efficient to reuse names from previous rules. I think it=
 should
work faster (more information, less extra matching).

>=20
>> +@@
>> +
>> + fn(..., Error ** ____, ...)
>> + {
>> +     ...
>> +     Error *local_err =3D NULL;
>> +     ... when any
>> +     Error *local_err2 =3D NULL;
>> +     ... when any
>> + }
>> +
>> +@ script:python @
>> +fn << check1.fn;
>> +@@
>> +
>> +print('Warning: function {} has several definitions of '
>> +      'Error * local variable'.format(fn))
>> +
>> +// Warn several propagations in control flow.
>> +@check2 disable optional_qualifier exists@
>> +identifier fn =3D rule1.fn;
>> +symbol errp;
>> +position p1, p2;
>> +@@
>> +
>> + fn(..., Error ** ____, ...)
>> + {
>> +     ...
>> +(
>> +     error_propagate_prepend(errp, ...);@p1
>> +|
>> +     error_propagate(errp, ...);@p1
>> +)
>> +     ...
>> +(
>> +     error_propagate_prepend(errp, ...);@p2
>> +|
>> +     error_propagate(errp, ...);@p2
>> +)
>> +     ... when any
>> + }
>> +
>=20
> Hmm, we don't catch the example I used in review of v8:
>=20
>      extern foo(int, Error **);
>      extern bar(int, Error **);
>=20
>      void frob(Error **errp)
>      {
>          Error *local_err =3D NULL;
>          int arg;
>=20
>          foo(arg, errp);
>          bar(arg, &local_err);
>          error_propagate(errp, local_err);
>          bar(arg + 1, &local_err);
>          error_propagate(errp, local_err);
>      }
>=20
> I believe this is because rule1 does not match here.

Yes, rule1 wants at least one code flow with non-doubled propagation.

>=20
> If I change the rule as follows, it catches the example:
>=20
>      @@ -157,24 +157,23 @@ print('Warning: function {} has several defini=
tions of '
>=20
>       // Warn several propagations in control flow.
>       @check2 disable optional_qualifier exists@
>      -identifier fn =3D rule1.fn;
>      -symbol errp;
>      +identifier fn, _errp;
>       position p1, p2;
>       @@
>=20
>      - fn(..., Error ** ____, ...)
>      + fn(..., Error **_errp, ...)
>        {
>            ...
>       (
>      -     error_propagate_prepend(errp, ...);@p1
>      +     error_propagate_prepend(_errp, ...);@p1
>       |
>      -     error_propagate(errp, ...);@p1
>      +     error_propagate(_errp, ...);@p1
>       )
>            ...
>       (
>      -     error_propagate_prepend(errp, ...);@p2
>      +     error_propagate_prepend(_errp, ...);@p2
>       |
>      -     error_propagate(errp, ...);@p2
>      +     error_propagate(_errp, ...);@p2
>       )
>            ... when any
>        }
>=20
> To my mild surprise, it still doesn't find anything in our tree.
>=20
> Should we decouple the previous rule from rule1, too?  I tested the
> following on the whole tree:

I don't think so. Why to check what we are not going to convert? If we want
to check side things, it's better to do it in other coccinelle script..

>=20
>      @@ -136,10 +136,10 @@ symbol errp;
>=20
>       // Warn several Error * definitions.
>       @check1 disable optional_qualifier exists@
>      -identifier fn =3D rule1.fn, local_err, local_err2;
>      +identifier fn, _errp, local_err, local_err2;
>       @@
>=20
>      - fn(..., Error ** ____, ...)
>      + fn(..., Error **_errp, ...)
>        {
>            ...
>            Error *local_err =3D NULL;
>=20
> Warnings remain unchanged.
>=20
>> +@ script:python @
>> +fn << check2.fn;
>> +p1 << check2.p1;
>> +p2 << check2.p2;
>> +@@
>> +
>> +print('Warning: function {} propagates to errp several times in '
>> +      'one control flow: at {}:{} and then at {}:{}'.format(
>> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>> +
>> +// Convert special case with goto separately.
>> +// I tried merging this into the following rule the obvious way, but
>> +// it made Coccinelle hang on block.c
>> +//
>> +// Note interesting thing: if we don't do it here, and try to fixup
>> +// "out: }" things later after all transformations (the rule will be
>> +// the same, just without error_propagate() call), coccinelle fails to
>> +// match this "out: }".
>> +@ disable optional_qualifier@
>> +identifier rule1.fn, rule1.local_err, out;
>=20
> As explained above, I doubt the need for rule1.fn.  We do need
> rule1.local_err to avoid unwanted transformations.  More of the same
> below.

Logically, I want to inherit from rule1. So why not to stress it by inherit=
ing
fn variable? It's just a correct thing to do.
And I hope it helps coccinelle to work more efficiently.

>=20
>> +symbol errp;
>> +@@
>> +
>> + fn(..., Error ** ____, ...)
>> + {
>> +     <...
>> +-    goto out;
>> ++    return;
>> +     ...>
>> +- out:
>> +-    error_propagate(errp, local_err);
>> + }
>> +
>> +// Convert most of local_err related stuff.
>> +//
>> +// Note, that we update everything related to matched by rule1
>> +// function name and local_err name. We may match something not
>> +// related to the pattern matched by rule1. For example, local_err may
>> +// be defined with the same name in different blocks inside one
>> +// function, and in one block follow the propagation pattern and in
>> +// other block doesn't. Or we may have several functions with the same
>> +// name (for different configurations).
>> +//
>> +// Note also that errp-cleaning functions
>> +//   error_free_errp
>> +//   error_report_errp
>> +//   error_reportf_errp
>> +//   warn_report_errp
>> +//   warn_reportf_errp
>> +// are not yet implemented. They must call corresponding Error* -
>> +// freeing function and then set *errp to NULL, to avoid further
>> +// propagation to original errp (consider ERRP_AUTO_PROPAGATE in use).
>> +// For example, error_free_errp may look like this:
>> +//
>> +//    void error_free_errp(Error **errp)
>> +//    {
>> +//        error_free(*errp);
>> +//        *errp =3D NULL;
>> +//    }
>> +@ disable optional_qualifier exists@
>> +identifier rule1.fn, rule1.local_err;
>> +expression list args;
>> +symbol errp;
>> +@@
>> +
>> + fn(..., Error ** ____, ...)
>> + {
>> +     <...
>> +(
>> +-    Error *local_err =3D NULL;
>> +|
>> +
>> +// Convert error clearing functions
>> +(
>> +-    error_free(local_err);
>> ++    error_free_errp(errp);
>> +|
>> +-    error_report_err(local_err);
>> ++    error_report_errp(errp);
>> +|
>> +-    error_reportf_err(local_err, args);
>> ++    error_reportf_errp(errp, args);
>> +|
>> +-    warn_report_err(local_err);
>> ++    warn_report_errp(errp);
>> +|
>> +-    warn_reportf_err(local_err, args);
>> ++    warn_reportf_errp(errp, args);
>> +)
>> +?-    local_err =3D NULL;
>> +
>> +|
>> +-    error_propagate_prepend(errp, local_err, args);
>> ++    error_prepend(errp, args);
>> +|
>> +-    error_propagate(errp, local_err);
>> +|
>> +-    &local_err
>> ++    errp
>> +)
>> +     ...>
>> + }
>> +
>> +// Convert remaining local_err usage. For example, different kinds of
>> +// error checking in if conditionals. We can't merge this into
>> +// previous hunk, as this conflicts with other substitutions in it (at
>> +// least with "- local_err =3D NULL").
>> +@ disable optional_qualifier@
>> +identifier rule1.fn, rule1.local_err;
>> +symbol errp;
>> +@@
>> +
>> + fn(..., Error ** ____, ...)
>> + {
>> +     <...
>> +-    local_err
>> ++    *errp
>> +     ...>
>> + }
>> +
>> +// Always use the same pattern for checking error
>> +@ disable optional_qualifier@
>> +identifier rule1.fn;
>> +symbol errp;
>> +@@
>> +
>> + fn(..., Error ** ____, ...)
>> + {
>> +     <...
>> +-    *errp !=3D NULL
>> ++    *errp
>> +     ...>
>> + }
>> +
>> +// Revert temporary ___ identifier.
>> +@ disable optional_qualifier@
>> +identifier rule1.fn;
>> +@@
>> +
>> + fn(..., Error **
>> +-   ____
>> ++   errp
>> +    , ...)
>> + {
>> +     ...
>> + }
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index 30140d9bfe..56c133520d 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>> @@ -214,6 +214,9 @@
>>    *         }
>>    *         ...
>>    *     }
>> + *
>> + * For mass-conversion use script
>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>    */
>>  =20
>>   #ifndef ERROR_H
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 857f969aa1..047f1b9714 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1998,6 +1998,7 @@ F: include/qemu/error-report.h
>>   F: qapi/error.json
>>   F: util/error.c
>>   F: util/qemu-error.c
>> +F: scripts/coccinelle/*err*.cocci
>>  =20
>>   GDB stub
>>   M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20


--=20
Best regards,
Vladimir

