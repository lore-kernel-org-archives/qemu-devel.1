Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBEAC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 23:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5EE20674
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 23:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lSYD5hJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5EE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPDMp-0002Sr-0x
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 19:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kPDLW-0001sb-71
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 19:23:16 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:24235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kPDLS-0000gz-SF
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 19:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1601853787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLUBtJzgGaK0nQvttAB5kmm8Wn0fS2YO6b82JGAS39s=;
 b=lSYD5hJsLVHZXtBYPPVNXrJAPm/vhODWZA4eyMk9Gzxw1RC3k8RIy1Rz3Vr/fPH2TTMQfQ
 WHhKOHtmhr/+Jjms1g6sScmVQ2JX0fmSFnESaU15FzaDWXaSo5LmApNHUgCoOmrVdHiDut
 ckhT+AsgvcoHsgxDFzTMeE36ScNIr7Y=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-ysDFZ_zeOU2f0hV8_Kvp-Q-1; Mon, 05 Oct 2020 01:23:05 +0200
X-MC-Unique: ysDFZ_zeOU2f0hV8_Kvp-Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8WMG8Cr+edz6vSgBFsHoSMbpVP0+cmUgxFgYXB6zgSPFgaaqtZWgxj8Flk+BL90W0bwg537QyaXZG7nksLQK8rbZe0uezzDliSuc8e20GLxIGn4kfLnlCpmuWgbeap2v2UC2j+9GuBYqVsIIhf8i+x0BAdpTVm/Ong+qa8lwWg/tnSM4zOL/gEPXwkl8HyNSPe7Ql+oIFwiFNoPoDI9IK4sPcDgBmqyAoVTCN3n4fLS3vpHEY3V4+zHnvUj7/5P7wJjKvDoVm3kaEVTbCBwLpO8VybCv/4tIqiXMhVJ7XTv19c+zacPbt8MXLzEj81UksfzsA9aTGzrKWdxHY7h5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3h1RxJ0V71ezYSqmh2fv6wZfdehrC6BstAWSR3N8SM=;
 b=Zc8KCQbwSqTir/t1ucdycMuRzusurmTqnPoh5FrovCnIfhxqFZiyLHQquVO7jlMHmn2CLfh5TO37ur0+cwUrC8XNqePS/oVvBbRPGWVAJBBU/WXK0cTFmhmUi34Xo6x7a0iVlGymb5vWb0NVoElqSS6cdZauuUOywNp4u1M05KdufGYulNuVdFetrM37Lu5/9COToG74ybXcAqKXnSaaiqmkKDYRKRD8QgHNkxGRxtkOMjoEGS0rO7xgKx3dhft+dierPWrrslTGFDIK726WX1eq8t1JMyURSouHrnUHcZ4s0s1V7oaALzqgU4KQ5LUxAluVKWgjmDwKjRMcYigdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM0PR04MB6964.eurprd04.prod.outlook.com
 (2603:10a6:208:18a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Sun, 4 Oct
 2020 23:23:02 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9891:ed4f:b5a2:6441]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9891:ed4f:b5a2:6441%6]) with mapi id 15.20.3433.043; Sun, 4 Oct 2020
 23:23:02 +0000
Message-ID: <94ad7c1f05640afc9c1d3713aaa314a0571cef48.camel@suse.com>
Subject: Re: [RFC PATCH 16/21] contrib/gitdm: Add SUSE to the domain map
From: Bruce Rogers <brogers@suse.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, 
 qemu-devel@nongnu.org
Date: Sun, 04 Oct 2020 17:22:36 -0600
In-Reply-To: <20201004180443.2035359-17-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-17-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [63.248.145.198]
X-ClientProxiedBy: CY4PR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:903:117::29) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.4] (63.248.145.198) by
 CY4PR02CA0043.namprd02.prod.outlook.com (2603:10b6:903:117::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Sun, 4 Oct 2020 23:22:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 447a9de3-9c04-4547-f2d4-08d868bc7070
X-MS-TrafficTypeDiagnostic: AM0PR04MB6964:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB69645F36C7BF428D55964CECD90F0@AM0PR04MB6964.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McOxavA/kM0Hek35HEkfJcI6SgZXjA9mMVpqiWK7kL3WegOzy/SCBKIkffe4KJQy9m0j5bhdSYxp8WVEBIkXt0Cv7psAMJp8NPEK8i88wbp3Bk5zaIgMcFh4dusbjGlIesKGwSv5XMEc7KaPUAf+0fsKlhTKxruh6KWzxA2lh3LSDPednM8CfeSJstFIzVpTXwqYHy8KPNgP59Vx3l82vKK9CVmehyh86bFYSfeLgimRZoGYOeoQOTCW2MsA3YS7ZHh6wwbkk8YtiUFT2+qykUkenj7MrfG4TMaR+pZYsn17OQ2boSUfSG9KOXKNMa9izz0mz9Ra632owLI65WIIxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(396003)(39860400002)(366004)(346002)(8936002)(186003)(2616005)(52116002)(4326008)(54906003)(956004)(16526019)(6666004)(66946007)(478600001)(316002)(5660300002)(16576012)(66556008)(66476007)(2906002)(26005)(8676002)(86362001)(107886003)(36756003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5hccgUPXNqmoFMgnPW08R5rRaWaxTVPxUr6VuHGn3ngxifwNMalY5laDa0b/M7w/rtJR5Laf5Ai2nLkqwSWd4goCw55+5TdjJmyovcWioF2hZ8g4S9Kco+H2bY4IuiixDdovROaRX2dqgcyUgGqbvXsclxWxD8I2px8ozaTZvYnPIqBciU4+rKji94gAvcyTuA+ObyAR1SDil5a159I/rUcaENkNX3UmF9OM/O3dO5FZsZYvRhGT6SnL1cghDzEnpCpKxXE9Exv5totwpc3g8M2scz1fDZ/MN7OEmZPOdWtPf9+y5bJdL0jJhxgXuUMuRhs0VzKJXVdrXNFgUpOGPYshsjF+EkU7HpDCIHQPi/jGVkzBl3TDT2Kdro/aOILBsAjXqsQaHqTP+pxm9jNk0oFLfB1U9DH9PVJdljaFRsARospzRPsH9DvJFV8QzO42e1r5MNxB4HTTNMw/ZnG5KgHdSdwUJDgQMku6fB9PsFyXP/ErYTYl7qmzqKGg9u2Pb+UyrLgjvFI3i0t1M6LUQYtNopUc0nkTZonwaPg+b8WHmQ56zIggbDI28mAf/4ROAXUwf4VF+H01UuvImmmjZX2V3dghKZtf8zATsalbErM4qDOvyHliMwClBr3U5Syi9RTOJiAevb/9MU2meBz2YA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447a9de3-9c04-4547-f2d4-08d868bc7070
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 23:23:02.5414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lq4vZVFkHVghhZ4pneaVpPQNM2oBF5X5ckHtjfiPQnicylN9+W5bD19QOE7OTkzi79BtDdgYXWETWbaggkoOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6964
Received-SPF: pass client-ip=62.140.7.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 19:23:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Charles Arnold <carnold@suse.com>, Juergen Gross <jgross@suse.com>,
 Liang Yan <lyan@suse.com>, Zhu Lingshan <lszhu@suse.com>,
 Kirk Allan <kallan@suse.com>, Petr Tesarik <ptesarik@suse.com>,
 Dinar Valeev <dvaleev@suse.com>, Chunyan Liu <cyliu@suse.com>,
 Fei Li <fli@suse.com>, Jan Krupa <jkrupa@suse.com>,
 Jan Beulich <jbeulich@suse.com>, Lin Ma <lma@suse.com>,
 Bo Yang <boyang@suse.com>, Larry Dewey <ldewey@suse.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 2020-10-04 at 20:04 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> There is a number of contributors from this domain,
> add its own entry to the gitdm domain map.
>=20
> Cc: Andreas F=C3=A4rber <afaerber@suse.de>
> Cc: Bo Yang <boyang@suse.com>
> Cc: Bruce Rogers <brogers@suse.com>
> Cc: Charles Arnold <carnold@suse.com>
> Cc: Chunyan Liu <cyliu@suse.com>
> Cc: Dinar Valeev <dvaleev@suse.com>
> Cc: Fei Li <fli@suse.com>
> Cc: Jan Beulich <jbeulich@suse.com>
> Cc: Jan Krupa <jkrupa@suse.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Kirk Allan <kallan@suse.com>
> Cc: Larry Dewey <ldewey@suse.com>
> Cc: Liang Yan <lyan@suse.com>
> Cc: Lin Ma <lma@suse.com>
> Cc: Petr Tesarik <ptesarik@suse.com>
> Cc: Zhu Lingshan <lszhu@suse.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> One Reviewed-by/Ack-by from someone from this domain
> should be sufficient to get this patch merged.
> ---
>  contrib/gitdm/domain-map | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 77f2a140cd..65a6dcb74e 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -34,6 +34,7 @@ rt-rk.com       RT-RK
>  samsung.com     Samsung
>  siemens.com     Siemens
>  sifive.com      SiFive
> +suse.com        SUSE
>  suse.de         SUSE
>  virtuozzo.com   Virtuozzo
>  wdc.com         Western Digital


Acked-by: Bruce Rogers <brogers@suse.com>


