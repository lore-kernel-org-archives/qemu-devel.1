Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5B3C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A50D2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pKt+Egob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A50D2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI6xe-0007VK-6N
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 05:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI6wx-0006xH-5R; Tue, 15 Sep 2020 05:08:31 -0400
Received: from mail-am6eur05on2117.outbound.protection.outlook.com
 ([40.107.22.117]:38113 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI6wt-0000iz-VL; Tue, 15 Sep 2020 05:08:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmH/oIHVS2yhmLXwD4Nv3Oaduhh8cQFVUH6oZyWDlj+2nrY6mGpepDtuDMCbVM/DaLdwuVS01qY481WMQrJ4E4oupc6WGkhsQELii6YiXSu+DaB0ekA7vy5gDPHFnWEKNmLz7WN8JLtoBebTDpUtSAvBJ1Sw3yi23eY0RWzfQQDcWvt2HdsfAeBhisihlpzGNoWZLbMgFxqL74ce+R4dyRPPfDtzxBpz1dcZKi+RznKapO+FYjkaPvvXdBtm5Niw/iHpxfTsvxTdErARDaOkqeaX3RMVP0kCgO/jMBc8Cm8pHSykp8zi7mcMDdnugUwKOQaVklSBRp411z90n9Lcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmgmx6v9ibp7nwhPIDApTDCUF1pNeOzbEsIaVQRH7mA=;
 b=HX02RGAM8gcs6suNC6HK3y6axK/INdir1KbjcrWIKeJ2xZd6CpGqkNtgap6J22wLc2M2rFmE1ZMGzeAQDRSKQDIqiH1Xs8bScyAm8r1A1XbXHmQDJXmhL46i8HGul0lQHGun6mo2r7U4osfbK1ukuQtk84d9evc1DndPhwT70BZvRtIqZ6gdmuLemQ9YQYwkk9WcPouk/8nbEht/bjihDNCSSzyiCedKKmudax4hpN2S2INNOC/ofvW5KplVnD+AtXU76py1GRtvFY8wQbEe7iWGoIIb0dc2ss+1JM8YS/7mX6RnLikTLF2wmdVUnwJblpqUkh7ORsiZvB9/7RYEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmgmx6v9ibp7nwhPIDApTDCUF1pNeOzbEsIaVQRH7mA=;
 b=pKt+EgobJXMAYgxlXeqtVZ8/45t6YEyVNjPEXvRdCQ4o3pqcQw57z2BT6dKis+Ub8GbiS+Q/b7kFU8F8W3jK+mMLRc0+mU/iQfemfRIpebOMFAkkKtBC9lkQ5GfVD4ZmOUORqKjUtCAk42DKvy4CFd4p8ZnOKboVSrF+stUw/Hs=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4072.eurprd08.prod.outlook.com (2603:10a6:20b:a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 09:08:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 09:08:24 +0000
Subject: Re: [PATCH 01/15] spapr: Fix error leak in spapr_realize_vcpu()
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-2-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9f4681d7-fa69-214b-e820-bf2847e9320c@virtuozzo.com>
Date: Tue, 15 Sep 2020 12:08:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-2-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0501CA0053.eurprd05.prod.outlook.com
 (2603:10a6:200:68::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM4PR0501CA0053.eurprd05.prod.outlook.com (2603:10a6:200:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Tue, 15 Sep 2020 09:08:24 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b5c6146-0fff-40df-bb5d-08d85956e6a6
X-MS-TrafficTypeDiagnostic: AM6PR08MB4072:
X-Microsoft-Antispam-PRVS: <AM6PR08MB407258A868679B4E37E695E1C1200@AM6PR08MB4072.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0nClhut5Tk3vpzqJOOcXthC2bbfpCsvohcII2UruV3LER5BjZep0PIUpgbGcC/1EEaeuWyn33+2a0KnCDh+uaLQ0QWVTS8ewkvQmmOIQO95BnVHLfewEMAiztiEjWPa202tjmykzC6UgSZMshhpccPgf/uZg2w8L1ICi4YPe4zG+nt3uCL9Lei7rtHEMzf7RBjRQuh6jGZftDWN6ifv0SCGr7mEfUxdD80n9R219N60O6MQ8z8o5Bz+DPu2iO2Dx++Cci98FDn1fYr7BnuWOgS6IAQwNXcjo4ABkZnADAl5GzI0ZWpem0Y2mw2uuuRX/p2WHYOmwKHPBXzC14kEyN3BI6Ihnyd12lLUe1uvGDp9cU/UdeDvwE/wxrKlZpTk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(136003)(396003)(16576012)(2616005)(956004)(86362001)(31696002)(5660300002)(36756003)(66946007)(66556008)(66476007)(4326008)(8676002)(52116002)(54906003)(6486002)(478600001)(316002)(8936002)(16526019)(26005)(2906002)(83380400001)(186003)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OglIDK3EZ277N2KUVpXna8JzOcI08OGwV3xzRlLqGcjnhBx2ll/31H1l2ADVzteNn2fGHKlar90u13XRZ2mp7+sLSMhYb6rkjh7YP9H97tqzVpMVMct8FKM2Bps7tgapq3u0m2+CNJqbUNR8BlCjVJegMKcmQYVQeCERGfblN4FOMVvZmy7Ibwykf6bw+VkU5bHMRRpXru4dEHsMTpwIrhXTuVnQJD+pQWe/uwxnwPbjL8IwupkaIbsdgE233V0cnVfJZoGvnsXji2LmEI/QNsAzg5tRHH9OoNIU5YmRS8twJXR4uG1RTECQ4oIgG6f3wmdoaMe8ziNJrAXZupfnhyiQ55zhIFaIW3LgX7lxSxB7dS+M2YP3b8qEyGhAPjVJaTwTXTA+uPvq4UZqCqcFiJ7JcECkq5JWpCKTNFu3U1cFLefakeGYwI6haciSunwMVFOCzcycu+y7to5K8KtJZjIxBNDXnwFnMRLTWxB9tROo2pzysvlZsf8vlEHSj/GM6HX5PUi0tZlwtEZRnn0AOLzhH0+YSNPcUW7M9GILuo9YWAidPJw7Jg28aEZLGYvKEwwuabQwyQF4HEqYTNO7I3eAT1e2L9qwghDl5bTzAJ0dyuoqVwEpyTS5F3Pfn0A4t5XgxGe8yx5HV9VnoR4Zdw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5c6146-0fff-40df-bb5d-08d85956e6a6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 09:08:24.6543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCk+e5mGF48YeL/XrXkYiaFSr9+PVPNYROr8zXkZ0aftPiHkuiRiya3ZyuyckKuTn8gKPnOemYxQ54ZTDGOQeZfm2FZgVuLCIyxU/AyE1eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4072
Received-SPF: pass client-ip=40.107.22.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 05:08:25
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.09.2020 15:34, Greg Kurz wrote:
> If spapr_irq_cpu_intc_create() fails, local_err isn't propagated and
> thus leaked.
> 
> Fixes: 992861fb1e4c ("error: Eliminate error_propagate() manually")
> Cc: armbru@redhat.com
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   hw/ppc/spapr_cpu_core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 2125fdac348f..3e4f402b2e9f 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -232,7 +232,6 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
>   {
>       CPUPPCState *env = &cpu->env;
>       CPUState *cs = CPU(cpu);
> -    Error *local_err = NULL;
>   
>       if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
>           return;
> @@ -244,7 +243,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
>       kvmppc_set_papr(cpu);
>   
> -    if (spapr_irq_cpu_intc_create(spapr, cpu, &local_err) < 0) {
> +    if (spapr_irq_cpu_intc_create(spapr, cpu, errp) < 0) {
>           cpu_remove_sync(CPU(cpu));
>           return;
>       }
> 


-- 
Best regards,
Vladimir

