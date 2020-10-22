Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDAFC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3683222E9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vNKnnJzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3683222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWkn-00067T-Rf
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 05:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVWjs-0005Ho-UV
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:18:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVWjr-0008Jo-8D
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:18:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M9Exol036808;
 Thu, 22 Oct 2020 09:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=gkNqXvUxYJAoanXcrRJRBujWXW1VnW2EnDZ02klZrTU=;
 b=vNKnnJzueRN8CGXeIbFUWqP0bg4j6ofv5pwbvigTUUSrmTCYgoSjS4KpYthqZ1snARER
 57EC8NI3TkUvqbo1AZ8bbXN6bC3n2rAGdZvDKNMjPzM+UJD3JKivXFaxYdJ3WOP+OJ2T
 PUPLfWOPkWYoAwy8FOHPNePLEjXZZux3OR+9M/twcmeeqQA2aaFa1WvgIadheYgSMxul
 yzd056Cecw9o5o9gHpVc0z6j0gJLhjtgoqr3IZEY+Bnk6QoJiyNwEVne7Xl0FQvmnWBy
 j+VYAmMhTYyskRi7ypOhr1xPODR5EbbskbzPIsWwAMoA2gropJQdzF5v+4tzgU8e9pup dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 347p4b50g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Oct 2020 09:18:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M9G82m060373;
 Thu, 22 Oct 2020 09:18:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 348a6qcqru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 09:18:23 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09M9ILtA025897;
 Thu, 22 Oct 2020 09:18:21 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 22 Oct 2020 02:18:21 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 095651D6DBCA; Thu, 22 Oct 2020 10:18:18 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 15/16] fuzz: register predefined generic-fuzz configs
In-Reply-To: <20201021210922.572955-16-alxndr@bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
 <20201021210922.572955-16-alxndr@bu.edu>
Date: Thu, 22 Oct 2020 10:18:18 +0100
Message-ID: <m2r1pq7h5x.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=1 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220062
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=darren.kenny@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:25:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-10-21 at 17:09:21 -04, Alexander Bulekov wrote:
> We call get_generic_fuzz_configs, which fills an array with
> predefined {name, args, objects} triples. For each of these, we add a
> new FuzzTarget, that uses a small wrapper to set
> QEMU_FUZZ_{ARGS,OBJECTS} to the corresponding predefined values.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  tests/qtest/fuzz/generic_fuzz.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
> index f739937827..bff98fe3c8 100644
> --- a/tests/qtest/fuzz/generic_fuzz.c
> +++ b/tests/qtest/fuzz/generic_fuzz.c
> @@ -26,6 +26,7 @@
>  #include "hw/qdev-core.h"
>  #include "hw/pci/pci.h"
>  #include "hw/boards.h"
> +#include "generic_fuzz_configs.h"
>  
>  /*
>   * SEPARATOR is used to separate "operations" in the fuzz input
> @@ -901,6 +902,17 @@ static GString *generic_fuzz_cmdline(FuzzTarget *t)
>      return cmd_line;
>  }
>  
> +static GString *generic_fuzz_predefined_config_cmdline(FuzzTarget *t)
> +{
> +    const generic_fuzz_config *config;
> +    g_assert(t->opaque);
> +
> +    config = t->opaque;
> +    setenv("QEMU_FUZZ_ARGS", config->args, 1);
> +    setenv("QEMU_FUZZ_OBJECTS", config->objects, 1);
> +    return generic_fuzz_cmdline(t);
> +}
> +
>  static void register_generic_fuzz_targets(void)
>  {
>      fuzz_add_target(&(FuzzTarget){
> @@ -911,6 +923,26 @@ static void register_generic_fuzz_targets(void)
>              .fuzz = generic_fuzz,
>              .crossover = generic_fuzz_crossover
>      });
> +
> +    GString *name;
> +    const generic_fuzz_config *config;
> +
> +    for (int i = 0;
> +         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
> +         i++) {
> +        config = predefined_configs + i;
> +        name = g_string_new("generic-fuzz");
> +        g_string_append_printf(name, "-%s", config->name);
> +        fuzz_add_target(&(FuzzTarget){
> +                .name = name->str,
> +                .description = "Predefined generic-fuzz config.",
> +                .get_init_cmdline = generic_fuzz_predefined_config_cmdline,
> +                .pre_fuzz = generic_pre_fuzz,
> +                .fuzz = generic_fuzz,
> +                .crossover = generic_fuzz_crossover,
> +                .opaque = (void *)config
> +        });
> +    }
>  }
>  
>  fuzz_target_init(register_generic_fuzz_targets);
> -- 
> 2.28.0

