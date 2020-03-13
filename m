Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145B2C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4087206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 17:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4087206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCoHi-0002Sm-39
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 13:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1jCoGa-0001ym-FY
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1jCoGZ-0003hQ-Hy
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 13:38:36 -0400
Received: from relay64.bu.edu ([128.197.228.104]:54114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>)
 id 1jCoGW-0003FG-UL; Fri, 13 Mar 2020 13:38:32 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 02DHbjW0005484
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 13 Mar 2020 13:37:51 -0400
Date: Fri, 13 Mar 2020 13:37:45 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/3] Use &error_abort instead of separate assert()
Message-ID: <20200313173745.2cwlwbkt4fc7nmpc@mozz.bu.edu>
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200313170517.22480-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313170517.22480-2-armbru@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x
X-Received-From: 128.197.228.104
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
Cc: ashijeetacharya@gmail.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, paul.durrant@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200313 1805, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


> index 1a99277d60..aa9eee6ebf 100644
> --- a/tests/qtest/fuzz/qos_fuzz.c
> +++ b/tests/qtest/fuzz/qos_fuzz.c
> @@ -57,8 +57,7 @@ static void qos_set_machines_devices_available(void)
>      QList *lst;
>      Error *err = NULL;
Can this err declaration be removed? Don't think it's used anywhere
else.

>  
> -    qmp_marshal_query_machines(NULL, &response, &err);
> -    assert(!err);
> +    qmp_marshal_query_machines(NULL, &response, &error_abort);
>      lst = qobject_to(QList, response);
>      apply_to_qlist(lst, true);
>  
> @@ -70,8 +69,7 @@ static void qos_set_machines_devices_available(void)
>      qdict_put_bool(args, "abstract", true);
>      qdict_put_obj(req, "arguments", (QObject *) args);
>  
> -    qmp_marshal_qom_list_types(args, &response, &err);
> -    assert(!err);
> +    qmp_marshal_qom_list_types(args, &response, &error_abort);
>      lst = qobject_to(QList, response);
>      apply_to_qlist(lst, false);
>      qobject_unref(response);
> -- 
> 2.21.1
> 
Thanks!

Acked-by: Alexander Bulekov <alxndr@bu.edu>

