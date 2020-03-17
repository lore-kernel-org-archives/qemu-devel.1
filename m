Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	YOU_INHERIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84555C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D69F206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="j73WRuYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D69F206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8aC-0003OG-DK
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jE8Xi-0001RJ-0W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jE8Xb-0000HI-NL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:29:45 -0400
Received: from mail-db8eur05on2126.outbound.protection.outlook.com
 ([40.107.20.126]:24384 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jE8XL-0007XO-Fx; Tue, 17 Mar 2020 05:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdVwnOo79nnkKndn8lHo8BDtiwgvDekiEWDdbxTvAkGm7DJbB0zWOcZNcWbQQ+XxFF3FyTb2ar/Bpgw0B49FyLn6TFi+1AIwjRCLBR7RCvyij+WH7mFlYGBgf68OIGqWIyVJTeLBjbqBvXX4I2bkp3xPShAitiBCOxoxJRHIrXM50GI1wYaivlWhE/VDo+GmipC6Vi9gz+ghAC84ZkHTQBlU+O3R9az+TQy4NsBU0knpcAkbah1nc7eJ1u9tpBakCuM3kjSrnysRJRnpiwK84FMlDHsgfrjZkdH1yU3O58CzoW/QwcF4cJHDhwfc9rxDBxE/vaqIaS2myIe2J7cPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg9rMj5ni0KuSs42TSPbSMASREEbcYLd7VCBxs5JASE=;
 b=bkBSotMJEFTp1N8s/U6/lpVnbAbxnCa8Px7vtJxBdeXsDgiuGHbN9Gw8A5Qz2DcqgcgXaIXuRImy5Z0CDQOj8A5E8PpanmrKqxwjO4OhDdJnFhNxv4qPCs4g5HWbtUuShRPvB5uww6zYBI7Lwo7ZGqoTR0X9EADqiWJnuQ/0mFp15B6MwD+TPLcWEpC0UfcsOiY/KH64GnPSv220fPAtG/LlRfBJEtpKttmnK+EfoLZvz19m7t4VXDGoS7cLON9f5XAQh+dommAvDhHwWqywhr+p0q13ZidsmT6stOhkX/LsJqa9IQr/XXGseKDCGS0gIWNkWntWDkWgai72L4nPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg9rMj5ni0KuSs42TSPbSMASREEbcYLd7VCBxs5JASE=;
 b=j73WRuYx1fd16lL8APJsonZ4hVfYD5qazBve971cEZbqS3+2zGYDnB3+m/C17By9CgoEPvH0TcCSF66XxofxR9qGP6957nQHcr3lGUgQ+yphiAxOFEgeZN8mN+7vJpj4nB5OL7ZlmRZAxjl8n2pqTYhHT7wnEXcN//BBoIn+sKw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2156.eurprd08.prod.outlook.com (10.172.125.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Tue, 17 Mar 2020 09:29:17 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 09:29:16 +0000
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
 <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
 <875zf8gt2m.fsf@dusky.pond.sub.org>
 <7c6f9a91-76cf-242d-8166-0693ec14b24d@virtuozzo.com>
 <87blozex9v.fsf@dusky.pond.sub.org>
 <f9c8de73-38d8-a14c-632a-8e57d18e00c8@virtuozzo.com>
 <87o8swk8wc.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200317122913058
Message-ID: <db2fa8a3-48cc-51aa-a3d5-eba88fb29f66@virtuozzo.com>
Date: Tue, 17 Mar 2020 12:29:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87o8swk8wc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.248) by
 FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 09:29:14 +0000
X-Tagtoolbar-Keys: D20200317122913058
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 238e09b0-3288-4501-b4cb-08d7ca55a968
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2156:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2156F06805A1195140B1AB6DC1F60@HE1PR0802MB2156.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(39850400004)(396003)(136003)(199004)(81166006)(186003)(36756003)(26005)(8676002)(16526019)(81156014)(86362001)(31686004)(5660300002)(956004)(66946007)(52116002)(8936002)(31696002)(7416002)(2616005)(66556008)(66476007)(16576012)(316002)(54906003)(478600001)(66574012)(4326008)(2906002)(6916009)(6486002)(53546011)(30864003)(2004002)(559001)(579004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2156;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KXdBEL0eT8ReYsdjZIXtHmoP7stVNAsM0yEIo+Kb4+aq/00lMzvi9SWzYxBc5Ihw6IeqgFBDlgzTKgI5TG76UKSsmrSKuK55HL7hSGIbPruQBZ2wiTj4mu6neqOo9ndW0pT67Tz9YxrPrOmu0HjUglTEMN0H8Domx+KB1vu4D9gdC/pIaaFgnvYbwp6t/SPvCWOTinA640uZ6elT2/bs6wnwxp4rHpFvl+zv9QXvsPYWP6vn4WKBWplwOSPujYR24STQAMz1TJv3zq4Rjo/Biuj1CBuVBOmf+T4wlz5Pe1yxIK1BQbcmHkI6bcXZIjcOOOYPXQHS2TWJ9AcJbKdH1y3bmyvaPMzb+I8gLb+DcB+4YSZL3jaUzK05zP1mkRs3hjYqrJp9BVi/o7J3WERqkm1itMIVv1N3j8OoVE+MAWulbgroa5YYvqKlVx6QLNZigNjOpb0KESVplznNiUHaYlK6mN8CeZSaEqbXVzwVxur2xni/HiCIZntbCAp6Ba3FJVX1F5uQx3wBrxnYCjXhcczzd107vA2OIJ9rtLupp5oiAM9u0c1DLE64WgCDpUu
X-MS-Exchange-AntiSpam-MessageData: +SoPiWaCoKgAas4y12I+0iuFl6eoCstkg/x8C4fsUuYCNHmDJlzqqddy/s6UgN7GUR1dgiiJOqStHNBt87xRpxRS14qVb8bQo4C+BVx0QQAjUNF8Hf1jjenExVnh9j+UjSC17f4fgzCPlq9wW/P/Vg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238e09b0-3288-4501-b4cb-08d7ca55a968
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 09:29:16.7623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HddFgQZzoHtB4dCj9kpIfyMzWVHAif/n+UzT2G6S9Qcz6xIWR5wceswTTqzBka7asBsE+mGMf1AjN442B1fjfdIVqezj6Rj02pzeYRbJeGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2156
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.126
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

16.03.2020 11:21, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> On 14.03.2020 00:54, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> 13.03.2020 18:42, Markus Armbruster wrote:
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>
>>>>>> 12.03.2020 19:36, Markus Armbruster wrote:
>>>>>>> I may have a second look tomorrow with fresher eyes, but let's get =
this
>>>>>>> out now as is.
>>>>>>>
>>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>>>
>>>>>>>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate=
 and
>>>>>>>> does corresponding changes in code (look for details in
>>>>>>>> include/qapi/error.h)
>>>>>>>>
>>>>>>>> Usage example:
>>>>>>>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>>>>>      --macro-file scripts/cocci-macro-file.h --in-place --no-show-=
diff \
>>>>>>>>      --max-width 80 FILES...
>>>>>>>>
>>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.=
com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Cc: Eric Blake <eblake@redhat.com>
>>>>>>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>>>>>>> Cc: Max Reitz <mreitz@redhat.com>
>>>>>>>> Cc: Greg Kurz <groug@kaod.org>
>>>>>>>> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>>>>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>>>>>>> Cc: Anthony Perard <anthony.perard@citrix.com>
>>>>>>>> Cc: Paul Durrant <paul@xen.org>
>>>>>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>>>>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>>>>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>>>>>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>>>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>>>>>> Cc: qemu-devel@nongnu.org
>>>>>>>> Cc: qemu-block@nongnu.org
>>>>>>>> Cc: xen-devel@lists.xenproject.org
>>>>>>>>
>>>>>>>>      scripts/coccinelle/auto-propagated-errp.cocci | 327 +++++++++=
+++++++++
>>>>>>>>      include/qapi/error.h                          |   3 +
>>>>>>>>      MAINTAINERS                                   |   1 +
>>>>>>>>      3 files changed, 331 insertions(+)
>>>>>>>>      create mode 100644 scripts/coccinelle/auto-propagated-errp.co=
cci
>>>>>>>>
>>>>>>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scrip=
ts/coccinelle/auto-propagated-errp.cocci
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000000..7dac2dcfa4
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>>>>>>> @@ -0,0 +1,327 @@
>>>>>>>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>>>>>>> +//
>>>>>>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>>>>>>> +//
>>>>>>>> +// This program is free software; you can redistribute it and/or
>>>>>>>> +// modify it under the terms of the GNU General Public License as
>>>>>>>> +// published by the Free Software Foundation; either version 2 of=
 the
>>>>>>>> +// License, or (at your option) any later version.
>>>>>>>> +//
>>>>>>>> +// This program is distributed in the hope that it will be useful=
,
>>>>>>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>>>> +// GNU General Public License for more details.
>>>>>>>> +//
>>>>>>>> +// You should have received a copy of the GNU General Public Lice=
nse
>>>>>>>> +// along with this program.  If not, see
>>>>>>>> +// <http://www.gnu.org/licenses/>.
>>>>>>>> +//
>>>>>>>> +// Usage example:
>>>>>>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci=
 \
>>>>>>>> +//  --macro-file scripts/cocci-macro-file.h --in-place \
>>>>>>>> +//  --no-show-diff --max-width 80 FILES...
>>>>>>>> +//
>>>>>>>> +// Note: --max-width 80 is needed because coccinelle default is l=
ess
>>>>>>>> +// than 80, and without this parameter coccinelle may reindent so=
me
>>>>>>>> +// lines which fit into 80 characters but not to coccinelle defau=
lt,
>>>>>>>> +// which in turn produces extra patch hunks for no reason.
>>>>>>>
>>>>>>> This is about unwanted reformatting of parameter lists due to the _=
__
>>>>>>> chaining hack.  --max-width 80 makes that less likely, but not
>>>>>>> impossible.
>>>>>>>
>>>>>>> We can search for unwanted reformatting of parameter lists.  I thin=
k
>>>>>>> grepping diffs for '^\+.*Error \*\*' should do the trick.  For the =
whole
>>>>>>> tree, I get one false positive (not a parameter list), and one hit:
>>>>>>>
>>>>>>>         @@ -388,8 +388,10 @@ static void object_post_init_with_type=
(O
>>>>>>>              }
>>>>>>>          }
>>>>>>>
>>>>>>>         -void object_apply_global_props(Object *obj, const GPtrArra=
y *props, Error **errp)
>>>>>>>         +void object_apply_global_props(Object *obj, const GPtrArra=
y *props,
>>>>>>>         +                               Error **errp)
>>>>>>>          {
>>>>>>>         +    ERRP_AUTO_PROPAGATE();
>>>>>>>              int i;
>>>>>>>
>>>>>>>              if (!props) {
>>>>>>>
>>>>>>> Reformatting, but not unwanted.
>>>>>>
>>>>>> Yes, I saw it. This line is 81 character length, so it's OK to fix i=
t in one hunk with
>>>>>> ERRP_AUTO_PROPAGATE addition even for non-automatic patch.
>>>>>
>>>>> Agree.
>>>>>
>>>>>>>
>>>>>>> The --max-width 80 hack is good enough for me.
>>>>>>>
>>>>>>> It does result in slightly long transformed lines, e.g. this one in
>>>>>>> replication.c:
>>>>>>>
>>>>>>>         @@ -113,7 +113,7 @@ static int replication_open(BlockDriver=
S
>>>>>>>                  s->mode =3D REPLICATION_MODE_PRIMARY;
>>>>>>>                  top_id =3D qemu_opt_get(opts, REPLICATION_TOP_ID);
>>>>>>>                  if (top_id) {
>>>>>>>         -            error_setg(&local_err, "The primary side does =
not support option top-id");
>>>>>>>         +            error_setg(errp, "The primary side does not su=
pport option top-id");
>>>>>>>                      goto fail;
>>>>>>>                  }
>>>>>>>              } else if (!strcmp(mode, "secondary")) {
>>>>>>>
>>>>>>> v8 did break this line (that's how I found it).  However, v9 still
>>>>>>> shortens the line, just not below the target.  All your + lines loo=
k
>>>>>>> quite unlikely to lengthen lines.  Let's not worry about this.
>>>>>>>
>>>>>>>> +// Switch unusual Error ** parameter names to errp
>>>>>>>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>>>>>>>> +//
>>>>>>>> +// Disable optional_qualifier to skip functions with
>>>>>>>> +// "Error *const *errp" parameter.
>>>>>>>> +//
>>>>>>>> +// Skip functions with "assert(_errp && *_errp)" statement, becau=
se
>>>>>>>> +// that signals unusual semantics, and the parameter name may wel=
l
>>>>>>>> +// serve a purpose. (like nbd_iter_channel_error()).
>>>>>>>> +//
>>>>>>>> +// Skip util/error.c to not touch, for example, error_propagate()=
 and
>>>>>>>> +// error_propagate_prepend().
>>>>>>>> +@ depends on !(file in "util/error.c") disable optional_qualifier=
@
>>>>>>>> +identifier fn;
>>>>>>>> +identifier _errp !=3D errp;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> + fn(...,
>>>>>>>> +-   Error **_errp
>>>>>>>> ++   Error **errp
>>>>>>>> +    ,...)
>>>>>>>> + {
>>>>>>>> +(
>>>>>>>> +     ... when !=3D assert(_errp && *_errp)
>>>>>>>> +&
>>>>>>>> +     <...
>>>>>>>> +-    _errp
>>>>>>>> ++    errp
>>>>>>>> +     ...>
>>>>>>>> +)
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
>>>>>>>> +// necessary
>>>>>>>> +//
>>>>>>>> +// Note, that without "when any" the final "..." does not mach
>>>>>>>> +// something matched by previous pattern, i.e. the rule will not =
match
>>>>>>>> +// double error_prepend in control flow like in
>>>>>>>> +// vfio_set_irq_signaling().
>>>>>>>> +//
>>>>>>>> +// Note, "exists" says that we want apply rule even if it matches=
 not
>>>>>>>> +// on all possible control flows (otherwise, it will not match
>>>>>>>> +// standard pattern when error_propagate() call is in if branch).
>>>>>>>> +@ disable optional_qualifier exists@
>>>>>>>> +identifier fn, local_err;
>>>>>>>> +symbol errp;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> + fn(..., Error **errp, ...)
>>>>>>>> + {
>>>>>>>> ++   ERRP_AUTO_PROPAGATE();
>>>>>>>> +    ...  when !=3D ERRP_AUTO_PROPAGATE();
>>>>>>>> +(
>>>>>>>> +(
>>>>>>>> +    error_append_hint(errp, ...);
>>>>>>>> +|
>>>>>>>> +    error_prepend(errp, ...);
>>>>>>>> +|
>>>>>>>> +    error_vprepend(errp, ...);
>>>>>>>> +)
>>>>>>>> +    ... when any
>>>>>>>> +|
>>>>>>>> +    Error *local_err =3D NULL;
>>>>>>>> +    ...
>>>>>>>> +(
>>>>>>>> +    error_propagate_prepend(errp, local_err, ...);
>>>>>>>> +|
>>>>>>>> +    error_propagate(errp, local_err);
>>>>>>>> +)
>>>>>>>> +    ...
>>>>>>>> +)
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> +
>>>>>>>> +// Match functions with propagation of local error to errp.
>>>>>>>> +// We want to refer these functions in several following rules, b=
ut I
>>>>>>>> +// don't know a proper way to inherit a function, not just its na=
me
>>>>>>>> +// (to not match another functions with same name in following ru=
les).
>>>>>>>> +// Not-proper way is as follows: rename errp parameter in functio=
ns
>>>>>>>> +// header and match it in following rules. Rename it back after a=
ll
>>>>>>>> +// transformations.
>>>>>>>> +//
>>>>>>>> +// The simplest case of propagation scheme is single definition o=
f
>>>>>>>> +// local_err with at most one error_propagate_prepend or
>>>>>>>> +// error_propagate on each control-flow. Still, we want to match =
more
>>>>>>>> +// complex schemes too. We'll warn them with help of further rule=
s.
>>>>>>>
>>>>>>> I think what we actually want is to examine instances of this patte=
rn to
>>>>>>> figure out whether and how we want to transform them.  Perhaps:
>>>>>>>
>>>>>>>         // The common case is a single definition of local_err with=
 at most one
>>>>>>>         // error_propagate_prepend() or error_propagate() on each c=
ontrol-flow
>>>>>>>         // path. Instances of this case we convert with this script=
. Functions
>>>>>>
>>>>>> For me, sounds a bit like "other things we don't convert".
>>>>>> Actually we convert other things too.
>>>>>
>>>>> What other patterns of error propagation do we convert?
>>>>
>>>> Something like in xen_block_device_destroy, why not? Otherwise, it's b=
etter to avoid
>>>> matching things like xen_block_device_destroy, not just warn them.
>>>> But I'd prefer to proceed now as is to fit into 5.0.. Too much time al=
ready
>>>> spent on this. So, I'm OK with your wording too.
>>>
>>> Let's scratch "Instances of this case we convert with this script."
>>
>> OK
>>
>>>
>>>>>>>         // with multiple definitions or propagates we want to exami=
ne
>>>>>>>         // manually. Later rules emit warnings to guide us to them.
>>>>>>>
>>>>>>>> +@rule1 disable optional_qualifier exists@
>>>>>>>> +identifier fn, local_err;
>>>>>>>> +symbol errp;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> + fn(..., Error **
>>>>>>>> +-    errp
>>>>>>>> ++    ____
>>>>>>>> +    , ...)
>>>>>>>> + {
>>>>>>>> +     ...
>>>>>>>> +     Error *local_err =3D NULL;
>>>>>>>> +     ...
>>>>>>>> +(
>>>>>>>> +     error_propagate_prepend(errp, local_err, ...);
>>>>>>>> +|
>>>>>>>> +     error_propagate(errp, local_err);
>>>>>>>> +)
>>>>>>>> +     ...
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> +
>>>>>>>> +// Warn several Error * definitions.
>>>>>>>> +@check1 disable optional_qualifier exists@
>>>>>>>> +identifier fn =3D rule1.fn, local_err, local_err2;
>>>>>>>
>>>>>>> Elsewhere, you use just rule.fn instead of fn =3D rule1.fn.  Any
>>>>>>> particular reason for the difference?
>>>>>>
>>>>>> I didn't find other way to ref check1.fn in next python rule. It jus=
t don't
>>>>>> work if I write here just rule1.fn.
>>>>>>
>>>>>>>
>>>>>>> With the ___ chaining hack, I doubt we still need "=3D rule1.fn" or
>>>>>>> "rule1.fn".  If I replace "fn =3D rule1.fn" and "rule.fn" by just "=
fn"
>>>>>>> everywhere, then apply the script to the complete tree, I get the s=
ame
>>>>>>> result.
>>>>>>
>>>>>> I think, it's more efficient to reuse names from previous rules. I t=
hink it should
>>>>>> work faster (more information, less extra matching).
>>>>>
>>>>> Nope.  With my hacked up script (patch appended) Coccinelle is actual=
ly
>>>>> *faster* for the .[ch] touched by this series: with your unmodified
>>>>> script, it takes a bit over 12s on my box, with mine around 7s.  Outp=
ut
>>>>> is identical.
>>>>>
>>>>> Never guess performance, always measure it :)
>>>>
>>>> Hmm, whole tree results would be better proof
>>>>
>>>>>
>>>>> Two notes on my script:
>>>>>
>>>>> * Unlike yours, it recognizes double-propagation in my test case.
>>>>>      Discussed below.
>>>>>
>>>>> * Its "several definitions of" warning includes positions.  That turn=
ed
>>>>>      out to be useless, but I've been too lazy to take that out again=
.
>>>>>
>>>>>>>
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> + fn(..., Error ** ____, ...)
>>>>>>>> + {
>>>>>>>> +     ...
>>>>>>>> +     Error *local_err =3D NULL;
>>>>>>>> +     ... when any
>>>>>>>> +     Error *local_err2 =3D NULL;
>>>>>>>> +     ... when any
>>>>>>>> + }
>>>
>>> This flags functions that have more than one declaration along any
>>> control flow path.  It doesn't flag this one:
>>>
>>>       void gnat(bool b, Error **errp)
>>>       {
>>>           if (b) {
>>>               Error *local_err =3D NULL;
>>>               foo(arg, &local_err);
>>>               error_propagate(errp, local_err);
>>>           } else {
>>>               Error *local_err =3D NULL;
>>>               bar(arg, &local_err);
>>>               error_propagate(errp, local_err);
>>>           }
>>>       }
>>>
>>> The Coccinelle script does the right thing for this one regardless.
>>>
>>> I'd prefer to have such functions flagged, too.  But spending time on
>>> convincing Coccinelle to do it for me is not worthwhile; I can simply
>>> search the diff produced by Coccinelle for deletions of declarations
>>> that are not indented exactly four spaces.
>>>
>>> But if we keep this rule, we should adjust its comment
>>>
>>>       // Warn several Error * definitions.
>>>
>>> because it sure suggests it also catches functions like the one I gave
>>> above.
>>
>> Hmm, yes.. We can write "Warn several Error * definitions in _one_
>> control flow (it's not so trivial to match _any_ case with several
>> definitions with coccinelle)" or something like this.
>=20
> Ha, "trivial" reminds me of a story.  The math professor, after having
> spent a good chunk of his lecture developing a proof on the blackboad
> turns to the audience to explain why this little part doesn't require
> proof with the words familiar to any math student "and this is trivial."
> Pause, puzzled look...  "Is it trivial?"  Pause, storms out of the
> lecture hall.  A minute or three pass.  Professor comes back beaming,
> "it is trivial!", and proceeds with the proof.
>=20
> My point is: it might be trivial with Coccinelle once you know how to do
> it.  We don't.
>=20
> Suggest "(can't figure out how to match several definitions regardless
> of control flow)".

Wrong too, because I can:) for example, chaining two rules, catching the
positions of definition and check that they are different.. Or, some
cheating with python script.. That's why I wrote "not trivial",

So, most correct would be "(can't figure out how to simply match several de=
finitions regardless
 > of control flow)".

But again, coccinelle is for matching control flows, so its probably imposs=
ible to match such thing..

>=20
>>
>>>
>>>>>>>> +
>>>>>>>> +@ script:python @
>>>>>>>> +fn << check1.fn;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> +print('Warning: function {} has several definitions of '
>>>>>>>> +      'Error * local variable'.format(fn))
>>>>>>>> +
>>>>>>>> +// Warn several propagations in control flow.
>>>>>>>> +@check2 disable optional_qualifier exists@
>>>>>>>> +identifier fn =3D rule1.fn;
>>>>>>>> +symbol errp;
>>>>>>>> +position p1, p2;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> + fn(..., Error ** ____, ...)
>>>>>>>> + {
>>>>>>>> +     ...
>>>>>>>> +(
>>>>>>>> +     error_propagate_prepend(errp, ...);@p1
>>>>>>>> +|
>>>>>>>> +     error_propagate(errp, ...);@p1
>>>>>>>> +)
>>>>>>>> +     ...
>>>>>>>> +(
>>>>>>>> +     error_propagate_prepend(errp, ...);@p2
>>>>>>>> +|
>>>>>>>> +     error_propagate(errp, ...);@p2
>>>>>>>> +)
>>>>>>>> +     ... when any
>>>>>>>> + }
>>>>>>>> +
>>>>>>>
>>>>>>> Hmm, we don't catch the example I used in review of v8:
>>>>>>>
>>>>>>>         extern foo(int, Error **);
>>>>>>>         extern bar(int, Error **);
>>>>>>>
>>>>>>>         void frob(Error **errp)
>>>>>>>         {
>>>>>>>             Error *local_err =3D NULL;
>>>>>>>             int arg;
>>>>>>>
>>>>>>>             foo(arg, errp);
>>>>>>>             bar(arg, &local_err);
>>>>>>>             error_propagate(errp, local_err);
>>>>>>>             bar(arg + 1, &local_err);
>>>>>>>             error_propagate(errp, local_err);
>>>>>>>         }
>>>>>>>
>>>>>>> I believe this is because rule1 does not match here.
>>>>>>
>>>>>> Yes, rule1 wants at least one code flow with non-doubled propagation=
.
>>>>>>
>>>>>>>
>>>>>>> If I change the rule as follows, it catches the example:
>>>>>>>
>>>>>>>         @@ -157,24 +157,23 @@ print('Warning: function {} has sever=
al definitions of '
>>>>>>>
>>>>>>>          // Warn several propagations in control flow.
>>>>>>>          @check2 disable optional_qualifier exists@
>>>>>>>         -identifier fn =3D rule1.fn;
>>>>>>>         -symbol errp;
>>>>>>>         +identifier fn, _errp;
>>>>>>>          position p1, p2;
>>>>>>>          @@
>>>>>>>
>>>>>>>         - fn(..., Error ** ____, ...)
>>>>>>>         + fn(..., Error **_errp, ...)
>>>>>>>           {
>>>>>>>               ...
>>>>>>>          (
>>>>>>>         -     error_propagate_prepend(errp, ...);@p1
>>>>>>>         +     error_propagate_prepend(_errp, ...);@p1
>>>>>>>          |
>>>>>>>         -     error_propagate(errp, ...);@p1
>>>>>>>         +     error_propagate(_errp, ...);@p1
>>>>>>>          )
>>>>>>>               ...
>>>>>>>          (
>>>>>>>         -     error_propagate_prepend(errp, ...);@p2
>>>>>>>         +     error_propagate_prepend(_errp, ...);@p2
>>>>>>>          |
>>>>>>>         -     error_propagate(errp, ...);@p2
>>>>>>>         +     error_propagate(_errp, ...);@p2
>>>>>>>          )
>>>>>>>               ... when any
>>>>>>>           }
>>>>>>>
>>>>>>> To my mild surprise, it still doesn't find anything in our tree.
>>>>>>>
>>>>>>> Should we decouple the previous rule from rule1, too?  I tested the
>>>>>>> following on the whole tree:
>>>>>>
>>>>>> I don't think so. Why to check what we are not going to convert? If =
we want
>>>>>> to check side things, it's better to do it in other coccinelle scrip=
t..
>>>>>
>>>>> Misunderstanding?  The rules are still chained together via the ___
>>>>> hack, just not via function name, because that's unreliable and
>>>>> redundant.
>>>>
>>>> Strange.. Then, how can it match something not matched by rule1?
>>>
>>> I think I got confused when I wrote the "Misunderstanding?" paragraph.
>>>
>>> Let me try again.
>>>
>>> First rule check2.
>>>
>>> The common case is a at most one propagation to @errp along any control
>>> flow path.  We trust your Coccinelle script to convert that alright.
>>>
>>> Any other propagation to @errp I want to review.  Whether the script
>>> attempts a conversion or not is unimportant, as long as it points me to
>>> the function to review.
>>>
>>> Rule rule1 matches functions that propagate to @errp once along at leas=
t
>>> one control flow path.
>>>
>>> Unchained from rule rule1, rule check2 flags any function that
>>> propagates to @errp multiple times along any control flow path.
>>>
>>> Chained to rule1, it flags only functions that also have a path with
>>> single propagation.
>>>
>>> In other words, the unchained rule flags *all* multi-propagations to
>>> @errp, while the chained rule flags only the ones the script attempts t=
o
>>> convert.  The former is much more useful to me.
>>>
>>> Now rule check1.  It flags functions with multiple declarations along
>>> any control flow path.  Again, chaining it to rule1 restricts it to the
>>> functions we attempt to convert.  Makes it less useful to me.  However,
>>> because my desire to review multiple declarations in function we don't
>>> attempt to convert is lower than my desire to review multiple
>>> propagations to @errp in such functions, chaining check1 is tolerable
>>> for me.  But why chain check1 if we don't chain check2?
>>>
>>
>> OK, let's unchain them.
>>
>>>>
>>>>>
>>>>>>>
>>>>>>>         @@ -136,10 +136,10 @@ symbol errp;
>>>>>>>
>>>>>>>          // Warn several Error * definitions.
>>>>>>>          @check1 disable optional_qualifier exists@
>>>>>>>         -identifier fn =3D rule1.fn, local_err, local_err2;
>>>>>>>         +identifier fn, _errp, local_err, local_err2;
>>>>>>>          @@
>>>>>>>
>>>>>>>         - fn(..., Error ** ____, ...)
>>>>>>>         + fn(..., Error **_errp, ...)
>>>>>>>           {
>>>>>>>               ...
>>>>>>>               Error *local_err =3D NULL;
>>>>>>>
>>>>>>> Warnings remain unchanged.
>>>>>>>
>>>>>>>> +@ script:python @
>>>>>>>> +fn << check2.fn;
>>>>>>>> +p1 << check2.p1;
>>>>>>>> +p2 << check2.p2;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> +print('Warning: function {} propagates to errp several times in '
>>>>>>>> +      'one control flow: at {}:{} and then at {}:{}'.format(
>>>>>>>> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>>>>>>> +
>>>>>>>> +// Convert special case with goto separately.
>>>>>>>> +// I tried merging this into the following rule the obvious way, =
but
>>>>>>>> +// it made Coccinelle hang on block.c
>>>>>>>> +//
>>>>>>>> +// Note interesting thing: if we don't do it here, and try to fix=
up
>>>>>>>> +// "out: }" things later after all transformations (the rule will=
 be
>>>>>>>> +// the same, just without error_propagate() call), coccinelle fai=
ls to
>>>>>>>> +// match this "out: }".
>>>>>>>> +@ disable optional_qualifier@
>>>>>>>> +identifier rule1.fn, rule1.local_err, out;
>>>>>>>
>>>>>>> As explained above, I doubt the need for rule1.fn.  We do need
>>>>>>> rule1.local_err to avoid unwanted transformations.  More of the sam=
e
>>>>>>> below.
>>>>>>
>>>>>> Logically, I want to inherit from rule1. So why not to stress it by =
inheriting
>>>>>> fn variable? It's just a correct thing to do.
>>>>>> And I hope it helps coccinelle to work more efficiently.
>>>>>>
>>>>>>>
>>>>>>>> +symbol errp;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> + fn(..., Error ** ____, ...)
>>>>>>>> + {
>>>>>>>> +     <...
>>>>>>>> +-    goto out;
>>>>>>>> ++    return;
>>>>>>>> +     ...>
>>>>>>>> +- out:
>>>>>>>> +-    error_propagate(errp, local_err);
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> +// Convert most of local_err related stuff.
>>>>>>>> +//
>>>>>>>> +// Note, that we update everything related to matched by rule1
>>>>>>>> +// function name and local_err name. We may match something not
>>>>>>>> +// related to the pattern matched by rule1. For example, local_er=
r may
>>>>>>>> +// be defined with the same name in different blocks inside one
>>>>>>>> +// function, and in one block follow the propagation pattern and =
in
>>>>>>>> +// other block doesn't. Or we may have several functions with the=
 same
>>>>>>>> +// name (for different configurations).
>>>>>>>> +//
>>>>>>>> +// Note also that errp-cleaning functions
>>>>>>>> +//   error_free_errp
>>>>>>>> +//   error_report_errp
>>>>>>>> +//   error_reportf_errp
>>>>>>>> +//   warn_report_errp
>>>>>>>> +//   warn_reportf_errp
>>>>>>>> +// are not yet implemented. They must call corresponding Error* -
>>>>>>>> +// freeing function and then set *errp to NULL, to avoid further
>>>>>>>> +// propagation to original errp (consider ERRP_AUTO_PROPAGATE in =
use).
>>>>>>>> +// For example, error_free_errp may look like this:
>>>>>>>> +//
>>>>>>>> +//    void error_free_errp(Error **errp)
>>>>>>>> +//    {
>>>>>>>> +//        error_free(*errp);
>>>>>>>> +//        *errp =3D NULL;
>>>>>>>> +//    }
>>>>>>>> +@ disable optional_qualifier exists@
>>>>>>>> +identifier rule1.fn, rule1.local_err;
>>>>>>>> +expression list args;
>>>>>>>> +symbol errp;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> + fn(..., Error ** ____, ...)
>>>>>>>> + {
>>>>>>>> +     <...
>>>>>>>> +(
>>>>>>>> +-    Error *local_err =3D NULL;
>>>>>>>> +|
>>>>>>>> +
>>>>>>>> +// Convert error clearing functions
>>>>>>>> +(
>>>>>>>> +-    error_free(local_err);
>>>>>>>> ++    error_free_errp(errp);
>>>>>>>> +|
>>>>>>>> +-    error_report_err(local_err);
>>>>>>>> ++    error_report_errp(errp);
>>>>>>>> +|
>>>>>>>> +-    error_reportf_err(local_err, args);
>>>>>>>> ++    error_reportf_errp(errp, args);
>>>>>>>> +|
>>>>>>>> +-    warn_report_err(local_err);
>>>>>>>> ++    warn_report_errp(errp);
>>>>>>>> +|
>>>>>>>> +-    warn_reportf_err(local_err, args);
>>>>>>>> ++    warn_reportf_errp(errp, args);
>>>>>>>> +)
>>>>>>>> +?-    local_err =3D NULL;
>>>>>>>> +
>>>>>>>> +|
>>>>>>>> +-    error_propagate_prepend(errp, local_err, args);
>>>>>>>> ++    error_prepend(errp, args);
>>>>>>>> +|
>>>>>>>> +-    error_propagate(errp, local_err);
>>>>>>>> +|
>>>>>>>> +-    &local_err
>>>>>>>> ++    errp
>>>>>>>> +)
>>>>>>>> +     ...>
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> +// Convert remaining local_err usage. For example, different kind=
s of
>>>>>>>> +// error checking in if conditionals. We can't merge this into
>>>>>>>> +// previous hunk, as this conflicts with other substitutions in i=
t (at
>>>>>>>> +// least with "- local_err =3D NULL").
>>>>>>>> +@ disable optional_qualifier@
>>>>>>>> +identifier rule1.fn, rule1.local_err;
>>>>>>>> +symbol errp;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> + fn(..., Error ** ____, ...)
>>>>>>>> + {
>>>>>>>> +     <...
>>>>>>>> +-    local_err
>>>>>>>> ++    *errp
>>>>>>>> +     ...>
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> +// Always use the same pattern for checking error
>>>>>>>> +@ disable optional_qualifier@
>>>>>>>> +identifier rule1.fn;
>>>>>>>> +symbol errp;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> + fn(..., Error ** ____, ...)
>>>>>>>> + {
>>>>>>>> +     <...
>>>>>>>> +-    *errp !=3D NULL
>>>>>>>> ++    *errp
>>>>>>>> +     ...>
>>>>>>>> + }
>>>>>>>> +
>>>>>>>> +// Revert temporary ___ identifier.
>>>>>>>> +@ disable optional_qualifier@
>>>>>>>> +identifier rule1.fn;
>>>>>>>> +@@
>>>>>>>> +
>>>>>>>> + fn(..., Error **
>>>>>>>> +-   ____
>>>>>>>> ++   errp
>>>>>>>> +    , ...)
>>>>>>>> + {
>>>>>>>> +     ...
>>>>>>>> + }
>>>>>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>>>>>> index 30140d9bfe..56c133520d 100644
>>>>>>>> --- a/include/qapi/error.h
>>>>>>>> +++ b/include/qapi/error.h
>>>>>>>> @@ -214,6 +214,9 @@
>>>>>>>>       *         }
>>>>>>>>       *         ...
>>>>>>>>       *     }
>>>>>>>> + *
>>>>>>>> + * For mass-conversion use script
>>>>>>>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>>>>>>>       */
>>>>>>>>        #ifndef ERROR_H
>>>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>>>> index 857f969aa1..047f1b9714 100644
>>>>>>>> --- a/MAINTAINERS
>>>>>>>> +++ b/MAINTAINERS
>>>>>>>> @@ -1998,6 +1998,7 @@ F: include/qemu/error-report.h
>>>>>>>>      F: qapi/error.json
>>>>>>>>      F: util/error.c
>>>>>>>>      F: util/qemu-error.c
>>>>>>>> +F: scripts/coccinelle/*err*.cocci
>>>>>>>>        GDB stub
>>>>>>>>      M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>>>
>>>>>
>>>>>
>>>>>    From 42a08c529024337d1b859839c9ce7f797f784555 Mon Sep 17 00:00:00 =
2001
>>>>> From: Markus Armbruster <armbru@redhat.com>
>>>>> Date: Fri, 13 Mar 2020 14:27:57 +0100
>>>>> Subject: [PATCH] fixup! scripts: Coccinelle script to use
>>>>>     ERRP_AUTO_PROPAGATE()
>>>>>
>>>>> ---
>>>>>     scripts/coccinelle/auto-propagated-errp.cocci | 37 ++++++++++----=
-----
>>>>>     1 file changed, 20 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/=
coccinelle/auto-propagated-errp.cocci
>>>>> index 7dac2dcfa4..43b0b0e63b 100644
>>>>> --- a/scripts/coccinelle/auto-propagated-errp.cocci
>>>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>>>> @@ -136,45 +136,48 @@ symbol errp;
>>>>>       // Warn several Error * definitions.
>>>>>     @check1 disable optional_qualifier exists@
>>>>> -identifier fn =3D rule1.fn, local_err, local_err2;
>>>>> +identifier fn, _errp, local_err, local_err2;
>>>>> +position p1, p2;
>>>>
>>>>
>>>> Hmm, seems like I forget to define ____ as symbol in my patch
>>>
>>> Coccinelle defaults to symbol.
>>
>> But for errp we saw warnings simetimes.
>=20
> I believe it warns when you use rely on the symbol default while also
> using it as something else in other rules.
>=20
> Feel free to explicitly define it as symbol.
>=20
>>>>>     @@
>>>>>     - fn(..., Error ** ____, ...)
>>>>> + fn(..., Error **_errp, ...)
>>>>
>>>> Ahmm.. it will break compilation?
>>>>
>>>> Or, how will it work when _errp defined as meta variable is only in "+=
..." line? Should it be symbol instead, or just not defined?
>>>
>>> Misunderstanding?  It's a diff between your .cocci and mine.
>>
>> Oops, yes, sorry. Patches to coccinelle scripts are tricky thing.
>>
>>> My version
>>> is
>>>
>>>       // Warn several Error * definitions.
>>>       @check1 disable optional_qualifier exists@
>>>       identifier fn, _errp, local_err, local_err2;
>>>       position p1, p2;
>>>       @@
>>>
>>>        fn(..., Error **_errp, ...)
>>>        {
>>>            ...
>>>            Error *local_err =3D NULL;@p1
>>>            ... when any
>>>            Error *local_err2 =3D NULL;@p2
>>>            ... when any
>>>        }
>>>
>>>       @ script:python @
>>>       fn << check1.fn;
>>>       p1 << check1.p1;
>>>       p2 << check1.p2;
>>>       @@
>>>
>>>>>      {
>>>>>          ...
>>>>> -     Error *local_err =3D NULL;
>>>>> +     Error *local_err =3D NULL;@p1
>>>>
>>>> Why to do -/+ here? Nothing changed..
>>>>
>>>>>          ... when any
>>>>> -     Error *local_err2 =3D NULL;
>>>>> +     Error *local_err2 =3D NULL;@p2
>>>>>          ... when any
>>>>>      }
>>>>>       @ script:python @
>>>>>     fn << check1.fn;
>>>>> +p1 << check1.p1;
>>>>> +p2 << check1.p2;
>>>>>     @@
>>>>>       print('Warning: function {} has several definitions of '
>>>>> -      'Error * local variable'.format(fn))
>>>>> +      'Error * local variable: at {}:{} and then at {}:{}'.format(
>>>>> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>>>>       // Warn several propagations in control flow.
>>>>>     @check2 disable optional_qualifier exists@
>>>>> -identifier fn =3D rule1.fn;
>>>>> -symbol errp;
>>>>> +identifier fn, _errp;
>>>>>     position p1, p2;
>>>>>     @@
>>>>>     - fn(..., Error ** ____, ...)
>>>>> + fn(..., Error **_errp, ...)
>>>>>      {
>>>>>          ...
>>>>>     (
>>>>> -     error_propagate_prepend(errp, ...);@p1
>>>>> +     error_propagate_prepend(_errp, ...);@p1
>>>>>     |
>>>>> -     error_propagate(errp, ...);@p1
>>>>> +     error_propagate(_errp, ...);@p1
>>>>>     )
>>>>>          ...
>>>>>     (
>>>>> -     error_propagate_prepend(errp, ...);@p2
>>>>> +     error_propagate_prepend(_errp, ...);@p2
>>>>>     |
>>>>> -     error_propagate(errp, ...);@p2
>>>>> +     error_propagate(_errp, ...);@p2
>>>>>     )
>>>>
>>>> You change some occurrences of errp to _errp, but not all. It breaks c=
ompilation.
>>>>
>>>>>          ... when any
>>>>>      }
>>>>> @@ -198,7 +201,7 @@ print('Warning: function {} propagates to errp se=
veral times in '
>>>>>     // the same, just without error_propagate() call), coccinelle fai=
ls to
>>>>>     // match this "out: }".
>>>>>     @ disable optional_qualifier@
>>>>> -identifier rule1.fn, rule1.local_err, out;
>>>>> +identifier fn, rule1.local_err, out;
>>>>
>>>> Hmm. If it improves performance it is strange.. But I can live with th=
is change.
>>>>
>>>>>     symbol errp;
>>>>>     @@
>>>>>     @@ -239,7 +242,7 @@ symbol errp;
>>>>>     //        *errp =3D NULL;
>>>>>     //    }
>>>>>     @ disable optional_qualifier exists@
>>>>> -identifier rule1.fn, rule1.local_err;
>>>>> +identifier fn, rule1.local_err;
>>>>>     expression list args;
>>>>>     symbol errp;
>>>>>     @@
>>>>> @@ -287,7 +290,7 @@ symbol errp;
>>>>>     // previous hunk, as this conflicts with other substitutions in i=
t (at
>>>>>     // least with "- local_err =3D NULL").
>>>>>     @ disable optional_qualifier@
>>>>> -identifier rule1.fn, rule1.local_err;
>>>>> +identifier fn, rule1.local_err;
>>>>>     symbol errp;
>>>>>     @@
>>>>>     @@ -301,7 +304,7 @@ symbol errp;
>>>>>       // Always use the same pattern for checking error
>>>>>     @ disable optional_qualifier@
>>>>> -identifier rule1.fn;
>>>>> +identifier fn;
>>>>>     symbol errp;
>>>>>     @@
>>>>>     @@ -315,7 +318,7 @@ symbol errp;
>>>>>       // Revert temporary ___ identifier.
>>>>>     @ disable optional_qualifier@
>>>>> -identifier rule1.fn;
>>>>> +identifier fn;
>>>>>     @@
>>>>>        fn(..., Error **
>>>>>
>>>
>>> I append my hacked up version of auto-propagated-errp.cocci.  It
>>> produces the same patch as yours for the complete tree.
>>>
>>>
>>>
>>> // Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>> //
>>> // Copyright (c) 2020 Virtuozzo International GmbH.
>>> //
>>> // This program is free software; you can redistribute it and/or
>>> // modify it under the terms of the GNU General Public License as
>>> // published by the Free Software Foundation; either version 2 of the
>>> // License, or (at your option) any later version.
>>> //
>>> // This program is distributed in the hope that it will be useful,
>>> // but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> // MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> // GNU General Public License for more details.
>>> //
>>> // You should have received a copy of the GNU General Public License
>>> // along with this program.  If not, see
>>> // <http://www.gnu.org/licenses/>.
>>> //
>>> // Usage example:
>>> // spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>> //  --macro-file scripts/cocci-macro-file.h --in-place \
>>> //  --no-show-diff --max-width 80 FILES...
>>> //
>>> // Note: --max-width 80 is needed because coccinelle default is less
>>> // than 80, and without this parameter coccinelle may reindent some
>>> // lines which fit into 80 characters but not to coccinelle default,
>>> // which in turn produces extra patch hunks for no reason.
>>>
>>> // Switch unusual Error ** parameter names to errp
>>> // (this is necessary to use ERRP_AUTO_PROPAGATE).
>>> //
>>> // Disable optional_qualifier to skip functions with
>>> // "Error *const *errp" parameter.
>>> //
>>> // Skip functions with "assert(_errp && *_errp)" statement, because
>>> // that signals unusual semantics, and the parameter name may well
>>> // serve a purpose. (like nbd_iter_channel_error()).
>>> //
>>> // Skip util/error.c to not touch, for example, error_propagate() and
>>> // error_propagate_prepend().
>>> @ depends on !(file in "util/error.c") disable optional_qualifier@
>>> identifier fn;
>>> identifier _errp !=3D errp;
>>> @@
>>>
>>>    fn(...,
>>> -   Error **_errp
>>> +   Error **errp
>>>       ,...)
>>>    {
>>> (
>>>        ... when !=3D assert(_errp && *_errp)
>>> &
>>>        <...
>>> -    _errp
>>> +    errp
>>>        ...>
>>> )
>>>    }
>>>
>>> // Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
>>> // necessary
>>> //
>>> // Note, that without "when any" the final "..." does not mach
>>> // something matched by previous pattern, i.e. the rule will not match
>>> // double error_prepend in control flow like in
>>> // vfio_set_irq_signaling().
>>> //
>>> // Note, "exists" says that we want apply rule even if it matches not
>>> // on all possible control flows (otherwise, it will not match
>>> // standard pattern when error_propagate() call is in if branch).
>>> @ disable optional_qualifier exists@
>>> identifier fn, local_err;
>>> symbol errp;
>>> @@
>>>
>>>    fn(..., Error **errp, ...)
>>>    {
>>> +   ERRP_AUTO_PROPAGATE();
>>>       ...  when !=3D ERRP_AUTO_PROPAGATE();
>>> (
>>> (
>>>       error_append_hint(errp, ...);
>>> |
>>>       error_prepend(errp, ...);
>>> |
>>>       error_vprepend(errp, ...);
>>> )
>>>       ... when any
>>> |
>>>       Error *local_err =3D NULL;
>>>       ...
>>> (
>>>       error_propagate_prepend(errp, local_err, ...);
>>> |
>>>       error_propagate(errp, local_err);
>>> )
>>>       ...
>>> )
>>>    }
>>>
>>>
>>> // Match functions with propagation of local error to errp.
>>> // We want to refer these functions in several following rules, but I
>>> // don't know a proper way to inherit a function, not just its name
>>> // (to not match another functions with same name in following rules).
>>> // Not-proper way is as follows: rename errp parameter in functions
>>> // header and match it in following rules. Rename it back after all
>>> // transformations.
>>> //
>>> // The simplest case of propagation scheme is single definition of
>>> // local_err with at most one error_propagate_prepend or
>>> // error_propagate on each control-flow. Still, we want to match more
>>> // complex schemes too. We'll warn them with help of further rules.
>>> @rule1 disable optional_qualifier exists@
>>> identifier fn, local_err;
>>> symbol errp;
>>> @@
>>>
>>>    fn(..., Error **
>>> -    errp
>>> +    ____
>>>       , ...)
>>>    {
>>>        ...
>>>        Error *local_err =3D NULL;
>>>        ...
>>> (
>>>        error_propagate_prepend(errp, local_err, ...);
>>> |
>>>        error_propagate(errp, local_err);
>>> )
>>>        ...
>>>    }
>>>
>>>
>>> // Warn several Error * definitions.
>>> @check1 disable optional_qualifier exists@
>>> identifier fn, _errp, local_err, local_err2;
>>> position p1, p2;
>>> @@
>>>
>>>    fn(..., Error **_errp, ...)
>>>    {
>>>        ...
>>>        Error *local_err =3D NULL;@p1
>>>        ... when any
>>>        Error *local_err2 =3D NULL;@p2
>>>        ... when any
>>>    }
>>>
>>> @ script:python @
>>> fn << check1.fn;
>>> p1 << check1.p1;
>>> p2 << check1.p2;
>>> @@
>>>
>>> print('Warning: function {} has several definitions of '
>>>         'Error * local variable: at {}:{} and then at {}:{}'.format(
>>>             fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>>
>>> // Warn several propagations in control flow.
>>> @check2 disable optional_qualifier exists@
>>> identifier fn, _errp;
>>> position p1, p2;
>>> @@
>>>
>>>    fn(..., Error **_errp, ...)
>>>    {
>>>        ...
>>> (
>>>        error_propagate_prepend(_errp, ...);@p1
>>> |
>>>        error_propagate(_errp, ...);@p1
>>> )
>>>        ...
>>> (
>>>        error_propagate_prepend(_errp, ...);@p2
>>> |
>>>        error_propagate(_errp, ...);@p2
>>> )
>>>        ... when any
>>>    }
>>>
>>> @ script:python @
>>> fn << check2.fn;
>>> p1 << check2.p1;
>>> p2 << check2.p2;
>>> @@
>>>
>>> print('Warning: function {} propagates to errp several times in '
>>>         'one control flow: at {}:{} and then at {}:{}'.format(
>>>             fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>>
>>> // Convert special case with goto separately.
>>> // I tried merging this into the following rule the obvious way, but
>>> // it made Coccinelle hang on block.c
>>> //
>>> // Note interesting thing: if we don't do it here, and try to fixup
>>> // "out: }" things later after all transformations (the rule will be
>>> // the same, just without error_propagate() call), coccinelle fails to
>>> // match this "out: }".
>>> @ disable optional_qualifier@
>>> identifier fn, rule1.local_err, out;
>>> symbol errp;
>>> @@
>>>
>>>    fn(..., Error ** ____, ...)
>>>    {
>>>        <...
>>> -    goto out;
>>> +    return;
>>>        ...>
>>> - out:
>>> -    error_propagate(errp, local_err);
>>>    }
>>>
>>> // Convert most of local_err related stuff.
>>> //
>>> // Note, that we update everything related to matched by rule1
>>> // function name and local_err name. We may match something not
>>> // related to the pattern matched by rule1. For example, local_err may
>>> // be defined with the same name in different blocks inside one
>>> // function, and in one block follow the propagation pattern and in
>>> // other block doesn't. Or we may have several functions with the same
>>> // name (for different configurations).
>>> //
>>> // Note also that errp-cleaning functions
>>> //   error_free_errp
>>> //   error_report_errp
>>> //   error_reportf_errp
>>> //   warn_report_errp
>>> //   warn_reportf_errp
>>> // are not yet implemented. They must call corresponding Error* -
>>> // freeing function and then set *errp to NULL, to avoid further
>>> // propagation to original errp (consider ERRP_AUTO_PROPAGATE in use).
>>> // For example, error_free_errp may look like this:
>>> //
>>> //    void error_free_errp(Error **errp)
>>> //    {
>>> //        error_free(*errp);
>>> //        *errp =3D NULL;
>>> //    }
>>> @ disable optional_qualifier exists@
>>> identifier fn, rule1.local_err;
>>> expression list args;
>>> symbol errp;
>>> @@
>>>
>>>    fn(..., Error ** ____, ...)
>>>    {
>>>        <...
>>> (
>>> -    Error *local_err =3D NULL;
>>> |
>>>
>>> // Convert error clearing functions
>>> (
>>> -    error_free(local_err);
>>> +    error_free_errp(errp);
>>> |
>>> -    error_report_err(local_err);
>>> +    error_report_errp(errp);
>>> |
>>> -    error_reportf_err(local_err, args);
>>> +    error_reportf_errp(errp, args);
>>> |
>>> -    warn_report_err(local_err);
>>> +    warn_report_errp(errp);
>>> |
>>> -    warn_reportf_err(local_err, args);// Use ERRP_AUTO_PROPAGATE (see =
include/qapi/error.h)
>> //
>> // Copyright (c) 2020 Virtuozzo International GmbH.
>> //
>> // This program is free software; you can redistribute it and/or
>> // modify it under the terms of the GNU General Public License as
>> // published by the Free Software Foundation; either version 2 of the
>> // License, or (at your option) any later version.
>> //
>> // This program is distributed in the hope that it will be useful,
>> // but WITHOUT ANY WARRANTY; without even the implied warranty of
>> // MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> // GNU General Public License for more details.
>> //
>> // You should have received a copy of the GNU General Public License
>> // along with this program.  If not, see
>> // <http://www.gnu.org/licenses/>.
>> //
>> // Usage example:
>> // spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>> //  --macro-file scripts/cocci-macro-file.h --in-place \
>> //  --no-show-diff --max-width 80 FILES...
>> //
>> // Note: --max-width 80 is needed because coccinelle default is less
>> // than 80, and without this parameter coccinelle may reindent some
>> // lines which fit into 80 characters but not to coccinelle default,
>> // which in turn produces extra patch hunks for no reason.
>>
>> // Switch unusual Error ** parameter names to errp
>> // (this is necessary to use ERRP_AUTO_PROPAGATE).
>> //
>> // Disable optional_qualifier to skip functions with
>> // "Error *const *errp" parameter.
>> //
>> // Skip functions with "assert(_errp && *_errp)" statement, because
>> // that signals unusual semantics, and the parameter name may well
>> // serve a purpose. (like nbd_iter_channel_error()).
>> //
>> // Skip util/error.c to not touch, for example, error_propagate() and
>> // error_propagate_prepend().
>> @ depends on !(file in "util/error.c") disable optional_qualifier@
>> identifier fn;
>> identifier _errp !=3D errp;
>> @@
>>
>>   fn(...,
>> -   Error **_errp
>> +   Error **errp
>>      ,...)
>>   {
>> (
>>       ... when !=3D assert(_errp && *_errp)
>> &
>>       <...
>> -    _errp
>> +    errp
>>       ...>
>> )
>>   }
>>
>> // Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
>> // necessary
>> //
>> // Note, that without "when any" the final "..." does not mach
>> // something matched by previous pattern, i.e. the rule will not match
>> // double error_prepend in control flow like in
>> // vfio_set_irq_signaling().
>> //
>> // Note, "exists" says that we want apply rule even if it matches not
>> // on all possible control flows (otherwise, it will not match
>> // standard pattern when error_propagate() call is in if branch).
>> @ disable optional_qualifier exists@
>> identifier fn, local_err;
>> symbol errp;
>> @@
>>
>>   fn(..., Error **errp, ...)
>>   {
>> +   ERRP_AUTO_PROPAGATE();
>>      ...  when !=3D ERRP_AUTO_PROPAGATE();
>> (
>> (
>>      error_append_hint(errp, ...);
>> |
>>      error_prepend(errp, ...);
>> |
>>      error_vprepend(errp, ...);
>> )
>>      ... when any
>> |
>>      Error *local_err =3D NULL;
>>      ...
>> (
>>      error_propagate_prepend(errp, local_err, ...);
>> |
>>      error_propagate(errp, local_err);
>> )
>>      ...
>> )
>>   }
>>
>>
>> // Match functions with propagation of local error to errp.
>> // We want to refer these functions in several following rules, but I
>> // don't know a proper way to inherit a function, not just its name
>> // (to not match another functions with same name in following rules).
>> // Not-proper way is as follows: rename errp parameter in functions
>> // header and match it in following rules. Rename it back after all
>> // transformations.
>> //
>> // The simplest case of propagation scheme is single definition of
>> // local_err with at most one error_propagate_prepend or
>> // error_propagate on each control-flow. Still, we want to match more
>> // complex schemes too. We'll warn them with help of further rules.
>> @rule1 disable optional_qualifier exists@
>> identifier fn, local_err;
>> symbol errp;
>> @@
>>
>>   fn(..., Error **
>> -    errp
>> +    ____
>>      , ...)
>>   {
>>       ...
>>       Error *local_err =3D NULL;
>>       ...
>> (
>>       error_propagate_prepend(errp, local_err, ...);
>> |
>>       error_propagate(errp, local_err);
>> )
>>       ...
>>   }
>>
>>
>> // Warn several Error * definitions.
>> @check1 disable optional_qualifier exists@
>> identifier fn, _errp, local_err, local_err2;
>> position p1, p2;
>> @@
>>
>>   fn(..., Error **_errp, ...)
>>   {
>>       ...
>>       Error *local_err =3D NULL;@p1
>>       ... when any
>>       Error *local_err2 =3D NULL;@p2
>>       ... when any
>>   }
>>
>> @ script:python @
>> fn << check1.fn;
>> p1 << check1.p1;
>> p2 << check1.p2;
>> @@
>>
>> print('Warning: function {} has several definitions of '
>>        'Error * local variable: at {}:{} and then at {}:{}'.format(
>>            fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>
>> // Warn several propagations in control flow.
>> @check2 disable optional_qualifier exists@
>> identifier fn, _errp;
>> position p1, p2;
>> @@
>>
>>   fn(..., Error **_errp, ...)
>>   {
>>       ...
>> (
>>       error_propagate_prepend(_errp, ...);@p1
>> |
>>       error_propagate(_errp, ...);@p1
>> )
>>       ...
>> (
>>       error_propagate_prepend(_errp, ...);@p2
>> |
>>       error_propagate(_errp, ...);@p2
>> )
>>       ... when any
>>   }
>>
>> @ script:python @
>> fn << check2.fn;
>> p1 << check2.p1;
>> p2 << check2.p2;
>> @@
>>
>> print('Warning: function {} propagates to errp several times in '
>>        'one control flow: at {}:{} and then at {}:{}'.format(
>>            fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>
>> // Convert special case with goto separately.
>> // I tried merging this into the following rule the obvious way, but
>> // it made Coccinelle hang on block.c
>> //
>> // Note interesting thing: if we don't do it here, and try to fixup
>> // "out: }" things later after all transformations (the rule will be
>> // the same, just without error_propagate() call), coccinelle fails to
>> // match this "out: }".
>> @ disable optional_qualifier@
>> identifier fn, rule1.local_err, out;
>> symbol errp;
>> @@
>>
>>   fn(..., Error ** ____, ...)
>>   {
>>       <...
>> -    goto out;
>> +    return;
>>       ...>
>> - out:
>> -    error_propagate(errp, local_err);
>>   }
>>
>> // Convert most of local_err related stuff.
>> //
>> // Note, that we update everything related to matched by rule1
>> // function name and local_err name. We may match something not
>> // related to the pattern matched by rule1. For example, local_err may
>> // be defined with the same name in different blocks inside one
>> // function, and in one block follow the propagation pattern and in
>> // other block doesn't. Or we may have several functions with the same
>> // name (for different configurations).
>> //
>> // Note also that errp-cleaning functions
>> //   error_free_errp
>> //   error_report_errp
>> //   error_reportf_errp
>> //   warn_report_errp
>> //   warn_reportf_errp
>> // are not yet implemented. They must call corresponding Error* -
>> // freeing function and then set *errp to NULL, to avoid further
>> // propagation to original errp (consider ERRP_AUTO_PROPAGATE in use).
>> // For example, error_free_errp may look like this:
>> //
>> //    void error_free_errp(Error **errp)
>> //    {
>> //        error_free(*errp);
>> //        *errp =3D NULL;
>> //    }
>> @ disable optional_qualifier exists@
>> identifier fn, rule1.local_err;
>> expression list args;
>> symbol errp;
>> @@
>>
>>   fn(..., Error ** ____, ...)
>>   {
>>       <...
>> (
>> -    Error *local_err =3D NULL;
>> |
>>
>> // Convert error clearing functions
>> (
>> -    error_free(local_err);
>> +    error_free_errp(errp);
>> |
>> -    error_report_err(local_err);
>> +    error_report_errp(errp);
>> |
>> -    error_reportf_err(local_err, args);
>> +    error_reportf_errp(errp, args);
>> |
>> -    warn_report_err(local_err);
>> +    warn_report_errp(errp);
>> |
>> -    warn_reportf_err(local_err, args);
>> +    warn_reportf_errp(errp, args);
>> )
>> ?-    local_err =3D NULL;
>>
>> |
>> -    error_propagate_prepend(errp, local_err, args);
>> +    error_prepend(errp, args);
>> |
>> -    error_propagate(errp, local_err);
>> |
>> -    &local_err
>> +    errp
>> )
>>       ...>
>>   }
>>
>> // Convert remaining local_err usage. For example, different kinds of
>> // error checking in if conditionals. We can't merge this into
>> // previous hunk, as this conflicts with other substitutions in it (at
>> // least with "- local_err =3D NULL").
>> @ disable optional_qualifier@
>> identifier fn, rule1.local_err;
>> symbol errp;
>> @@
>>
>>   fn(..., Error ** ____, ...)
>>   {
>>       <...
>> -    local_err
>> +    *errp
>>       ...>
>>   }
>>
>> // Always use the same pattern for checking error
>> @ disable optional_qualifier@
>> identifier fn;
>> symbol errp;
>> @@
>>
>>   fn(..., Error ** ____, ...)
>>   {
>>       <...
>> -    *errp !=3D NULL
>> +    *errp
>>       ...>
>>   }
>>
>> // Revert temporary ___ identifier.
>> @ disable optional_qualifier@
>> identifier fn;
>> @@
>>
>>   fn(..., Error **
>> -   ____
>> +   errp
>>      , ...)
>>   {
>>       ...
>>   }
>>
>>> +    warn_reportf_errp(errp, args);
>>> )
>>> ?-    local_err =3D NULL;
>>>
>>> |
>>> -    error_propagate_prepend(errp, local_err, args);
>>> +    error_prepend(errp, args);
>>> |
>>> -    error_propagate(errp, local_err);
>>> |
>>> -    &local_err
>>> +    errp
>>> )
>>>        ...>
>>>    }
>>>
>>> // Convert remaining local_err usage. For example, different kinds of
>>> // error checking in if conditionals. We can't merge this into
>>> // previous hunk, as this conflicts with other substitutions in it (at
>>> // least with "- local_err =3D NULL").
>>> @ disable optional_qualifier@
>>> identifier fn, rule1.local_err;
>>> symbol errp;
>>> @@
>>>
>>>    fn(..., Error ** ____, ...)
>>>    {
>>>        <...
>>> -    local_err
>>> +    *errp
>>>        ...>
>>>    }
>>>
>>> // Always use the same pattern for checking error
>>> @ disable optional_qualifier@
>>> identifier fn;
>>> symbol errp;
>>> @@
>>>
>>>    fn(..., Error ** ____, ...)
>>>    {
>>>        <...
>>> -    *errp !=3D NULL
>>> +    *errp
>>>        ...>
>>>    }
>>>
>>> // Revert temporary ___ identifier.
>>> @ disable optional_qualifier@
>>> identifier fn;
>>> @@
>>>
>>>    fn(..., Error **
>>> -   ____
>>> +   errp
>>>       , ...)
>>>    {
>>>        ...
>>>    }
>>>
>>
>> OK, I almost OK with it, the only thing I doubt a bit is the following:
>>
>> We want to keep rule1.local_err inheritance to keep connection with
>> local_err definition.
>=20
> Yes.
>=20
>> Interesting, when we have both rule1.fn and rule1.local_err inherited,
>> do we inherit them in separate (i.e. all possible combinations of fn
>> and local_err symbols from rule1) or do we inherit a pair, i.e. only
>> fn/local_err pairs, found by rule1? If the latter is correct, that
>> with your script we loss this pair inheritance, and go to all possible
>> combinations of fn and local_err from rule1, possibly adding some wrong
>> conversion (OK, you've checked that no such cases in current code tree).
>=20
> The chaining "identifier rule1.FOO" is by name.  It's reliable only as
> long as there is exactly one instance of the name.
>=20
> We already discussed the case of the function name: if there are two
> instances of foo(), and rule1 matches only one of them, then we
> nevertheless apply the rules chained to rule1 to both.  Because that can
> be wrong, you came up with the ___ trick, which chains reliably.
>=20
> The same issue exists with the variable name: if there are two instances
> of @local_err, and rule1 matches only one of them, then we nevertheless
> apply the rules chained to rule1 to both.  Can also be wrong.
>=20
> What are the conditions for "wrong"?
>=20
> Because the ___ chaining is reliable, we know rule1 matched the
> function, i.e. it has a parameter Error **errp, and it has a automatic
> variable Error *local_err =3D NULL.
>=20
> We're good as long as *all* identifiers @local_err in this function are
> declared that way.  This seems quite likely.  It's not certain, though.
>=20
> Since nested declarations of Error ** variables are rare, we can rely on
> review to ensure we transform these functions correctly.
>=20
>> So, dropping inheritance in check-rules makes sence, as it may match
>> (and warn) more interesting cases.
>>
>> But for other rules, I'd prefere to be safer, and explictly inherit all
>> actually inherited identifiers..
>=20
> I still can't see what chaining by function name in addition to the ___
> chaining buys us.

I'll check this thing soon. And resend today.

>=20
>>                                   Still, I feel, we'll never be
>> absolutely safe with coccinelle :)
>=20
> Right, although this particular problem is not really Coccinelle's
> fault.  Blindly treating all instances of a certain identifier in a
> certain area the same regardless of how they are bound to declarations
> is fundamentally unreliable, regardless of your actual tooling.
>=20

Yes, still interesting, can coccinelle do more smart inheritance to match
exactly same object... I think, I need to CC coccinelle mailing list
to the next version

--=20
Best regards,
Vladimir

