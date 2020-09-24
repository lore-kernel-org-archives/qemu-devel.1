Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E2C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C222388A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WCgO0tKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C222388A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLNt-0001Kj-Nr
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLLNB-0000QU-BB; Thu, 24 Sep 2020 03:08:57 -0400
Received: from mail-eopbgr150122.outbound.protection.outlook.com
 ([40.107.15.122]:8718 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLLN8-00064g-UA; Thu, 24 Sep 2020 03:08:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm+zCYHmIBz7hMRp4Juny/NMmRaie1Egmw57lFoHOO+GkfnnI+08Tr9MUtNRwqmQRlpeBwUWfQdX0suT0sGaS5gtI63XtR+wxVExr7skbHp4dw5vt31yIAaq8r6rxbBcnHvxBNv47ciWa/RJNk4dsZOpVUzBc7OOPwYPqFHzRP/0TjPa0xfiZgk73EtpSkjZUva8OaUfVV2diqCIRwgSdT6HwIWXStpNt00N61+j0oimuUE4k8Q+g0Ukzys6ZM0IRUE+JNeH5fy5SXMqdnCscrJQkkoGmawKItrBHbzBOvRzBFKHoTq7NW5AMyhQMxslR/wK81z6waCXarJUOxAcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNJqDcV4ImDSITJYVWxzagPwi3PqxawGq7ZWcZyfdVQ=;
 b=d5OXRwlrHkexTDB9TOgWZpgPR8ThjGDolnW+UY342mRqiJNoTj0rydmwOjU1QIdT221IAGBsAM+/wTpCIb9CJQFLDS8JKGBMgt252D7yFaDe/7wrx4Q614+GzzZo6OB29rI2cgPBzVF1rspXn0FhFRZkMEkp1pbvhpt1LpLAZOF1TmqksDa/FbuaCQLAQfsEOg1TQtJD8721zsTZh7DcCezM0nd3FBpkzvNKxK9OXVVWG/b54ipzKiupIEKv+hDduH1E1BkKlzKf7RBlbq256yLQhgMpM+Ctxo2sk4siJaA1WnjOS1DovwM/VgQI9VZ5/JXMNV8Rlj4FxSs5NBN4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNJqDcV4ImDSITJYVWxzagPwi3PqxawGq7ZWcZyfdVQ=;
 b=WCgO0tKTTSEgPnfW3LEZZcIRxFCdbW4BNggj3UKfJ10IluibhT5H1tadkwvHWI40ZEGqMBFhMOQRbTqk2Hhcj+bSn4rHiCrlAX26QNNIbPETt5HSmYtu5VVR3gxlRUxDjR0o+XD1t/zywfr9S5ns+VTsBwWQjRVaiBG16mALFPk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 07:08:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 07:08:52 +0000
Subject: Re: [PATCH v8 4/7] scripts: add block-coroutine-wrapper.py
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-5-vsementsov@virtuozzo.com>
 <be6408ba-a430-0294-96e8-a38af7f94c1b@virtuozzo.com>
 <73781605-a817-c627-fea9-183caf84c4b6@redhat.com>
 <197997e7-1aea-70c1-0c85-b7a903638d9c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <938aa96f-19db-c103-36b9-a11d00c2cb5a@virtuozzo.com>
Date: Thu, 24 Sep 2020 10:08:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <197997e7-1aea-70c1-0c85-b7a903638d9c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 07:08:51 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef67b3eb-d2c8-4950-61bd-08d86058b112
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29813329B24A091A63A4C19CC1390@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAM127QHk1dft2tUur8iTpYgdXgO8XljrrUqBJKmXQhm8UkR5+Mf/GKaCYhIGzdYdiHAWnnFuUw0WQ4ZeQv9efVzUJcGoFTf3mAB4wqc+YFRowt+Vh/Oj3qigMSscd1/dJs+TIkG7lS2NYdfiHWniIoQNh5wQ8XDcdmhFF1BkCgddTt9IhHQnVCBYxJBXDoJaVBPk2f6hld8HqwfIggwhfBqnuN8vs25qXq/E6e6Gqylzu/2T/bO53Z8ksUW5YHkjeJWBwKl/NfQYdpTdonMUvSo//p8nCEU0I75JQPg4Ek8BF1vN0fayZXOXlc8MmvxZw1HH0RfRJTUpnzD9sXIUmBXgKdwcpvDOSwvat1xcgeiA9FOt+80asGPDpG4yFPoMWe3X++GCyn5x9vAwMLUSpaBfZOeg5EuDVjOgMuyjHn4pObCcfrq4UdH4MxLD4upTsTmwmx7yVAZc6CYYIWfsmP5NN89iaWeP5GsgW6LojuZPU4eFUjNOmx+VRuDB+L4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(316002)(5660300002)(6486002)(16526019)(2906002)(66556008)(8936002)(7416002)(2616005)(83380400001)(66476007)(31696002)(956004)(8676002)(66946007)(26005)(86362001)(966005)(16576012)(478600001)(53546011)(186003)(52116002)(36756003)(31686004)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T7l0EPKf97+x552vZNpU9rPXSlDFXmZ+u7NCJwDOMGosK8W8rcWJO9AMdvVq96xqs6gLaNGp+DV0mT886YT5MUe+k482RVtUjnC4jMDhTxr91BWpJv9Hsqkf5omc54wwM/zTKQVs5ySmNwNX+A+38LY6o1MaRcD8JmRtQJbJq6ZLOvlxKGNGhBt7wrTraTNlG3FhpttJAtYsPVR3MVdHTTho9uFrq1RkkLrlYPFg8h1uoYiEmj6LzDX2uOXTC3LduYxMEwq4FDuoVVaoXM9HS3h+c7UX/8/MP3OZuNIlDpM21DsJ38erVOwru0AOeSHtFjiV9L4alaGAbzNJCixNbmHHXz9bL1szbZTuE6gLFr+FWwxDmJaR0sBctmpheLTg1S8U/tFjkw9uuiVj41tiBERLr5/7RQmwF5/kTD9LQ5K+KMJ8OrAidnaX4n6n91a+sPLNzFRTiPHiMXTlYllV3pnYC7RT7WHUQ7BN+IYWFrcCBZ7B69wo8RZZ0Ukax6E6nhUz/WqoGbVuFrpy1FD3GlN4OoaxO5ITMZz9SeNBm4/iVQMaR3gM5mF8qEaS9gFdLCiR13jyZmRSjdyhIETo2ii4QtMdkinzC+GGqQT29no4UkmQSNke3ZUfpZFp+jrt4Kk1bM33ZFY9Eaf/c32bEA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef67b3eb-d2c8-4950-61bd-08d86058b112
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 07:08:51.8718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/ZXxUa9nk/BHcP2orFrUmKSNWo26/Cpln1W9jbt3k0oHCx5Zq++zuNATnzeZvtaaFj+l5bByqV6mPQ6nUxm7JGMlBRTiPl5U5k1P5JwbcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=40.107.15.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 03:08:52
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

24.09.2020 04:20, Eric Blake wrote:
> On 9/23/20 7:00 PM, Eric Blake wrote:
> 
>>
>> Tested-by: Eric Blake <eblake@redhat.com>
>>
>> There's enough grammar fixes, and the fact that John is working on python cleanups, to make me wonder if we need a v9, or if I should just stage it where it is with any other cleanups as followups.  But I'm liking the reduced maintenance burden once it is in, and don't want to drag it out to the point that it needs more rebasing as other things land first.
>>
> 
> Here's what I've squashed in and temporarily pushed to my tree if you want to double-check my rebase work:
> https://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/master
> 
> diff --git a/docs/devel/block-coroutine-wrapper.rst b/docs/devel/block-coroutine-wrapper.rst
> index f7050bbc8fa6..d09fff2cc539 100644
> --- a/docs/devel/block-coroutine-wrapper.rst
> +++ b/docs/devel/block-coroutine-wrapper.rst
> @@ -2,43 +2,43 @@
>   block-coroutine-wrapper
>   =======================
> 
> -A lot of functions in QEMJ block layer (see ``block/*``) can by called
> -only in coroutine context. Such functions are normally marked by
> +A lot of functions in QEMU block layer (see ``block/*``) can only be
> +called in coroutine context. Such functions are normally marked by the
>   coroutine_fn specifier. Still, sometimes we need to call them from
> -non-coroutine context, for this we need to start a coroutine, run the
> +non-coroutine context; for this we need to start a coroutine, run the
>   needed function from it and wait for coroutine finish in
>   BDRV_POLL_WHILE() loop. To run a coroutine we need a function with one
> -void* argument. So for each coroutine_fn function, which needs
> +void* argument. So for each coroutine_fn function which needs a
>   non-coroutine interface, we should define a structure to pack the
>   parameters, define a separate function to unpack the parameters and
>   call the original function and finally define a new interface function
>   with same list of arguments as original one, which will pack the
>   parameters into a struct, create a coroutine, run it and wait in
> -BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand, so
> -we have a script to generate them.
> +BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand,
> +so we have a script to generate them.
> 
>   Usage
>   =====
> 
> -Assume we have defined ``coroutine_fn`` function
> +Assume we have defined the ``coroutine_fn`` function
>   ``bdrv_co_foo(<some args>)`` and need a non-coroutine interface for it,
>   called ``bdrv_foo(<same args>)``. In this case the script can help. To
>   trigger the generation:
> 
> -1. You need ``bdrv_foo`` declaration somewhere (for example in
> -   ``block/coroutines.h`` with ``generated_co_wrapper`` mark,
> +1. You need ``bdrv_foo`` declaration somewhere (for example, in
> +   ``block/coroutines.h``) with the ``generated_co_wrapper`` mark,
>      like this:
> 
>   .. code-block:: c
> 
> -    int generated_co_wrapper bdrv_foor(<some args>);
> +    int generated_co_wrapper bdrv_foo(<some args>);
> 
>   2. You need to feed this declaration to block-coroutine-wrapper script.
> -   For this, add .h (or .c) file with the declaration to
> +   For this, add the .h (or .c) file with the declaration to the
>      ``input: files(...)`` list of ``block_gen_c`` target declaration in
>      ``block/meson.build``
> 
> -You are done. On build, coroutine wrappers will be generated in
> +You are done. During the build, coroutine wrappers will be generated in
>   ``<BUILD_DIR>/block/block-gen.c``.
> 
>   Links
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 04773ce076b3..cb0abe1e6988 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -31,3 +31,4 @@ Contents:
>      reset
>      s390-dasd-ipl
>      clocks
> +   block-coroutine-wrapper
> diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
> index d859c07a5f55..8c0a08d9b020 100755
> --- a/scripts/block-coroutine-wrapper.py
> +++ b/scripts/block-coroutine-wrapper.py
> @@ -2,7 +2,7 @@
>   """Generate coroutine wrappers for block subsystem.
> 
>   The program parses one or several concatenated c files from stdin,
> -searches for functions with 'generated_co_wrapper' specifier
> +searches for functions with the 'generated_co_wrapper' specifier
>   and generates corresponding wrappers on stdout.
> 
>   Usage: block-coroutine-wrapper.py generated-file.c FILE.[ch]...
> @@ -39,7 +39,7 @@ def prettify(code: str) -> str:
>               'BraceWrapping': {'AfterFunction': True},
>               'BreakBeforeBraces': 'Custom',
>               'SortIncludes': False,
> -            'MaxEmptyLinesToKeep': 2
> +            'MaxEmptyLinesToKeep': 2,
>           })
>           p = subprocess.run(['clang-format', f'-style={style}'], check=True,
>                              encoding='utf-8', input=code,
> @@ -168,7 +168,7 @@ int {func.name}({ func.gen_list('{decl}') })
> 
> 
>   def gen_wrappers_file(input_code: str) -> str:
> -    res = gen_header()
> +    res = ''
>       for func in func_decl_iter(input_code):
>           res += '\n\n\n'
>           res += gen_wrapper(func)
> @@ -181,6 +181,7 @@ if __name__ == '__main__':
>           exit(f'Usage: {sys.argv[0]} OUT_FILE.c IN_FILE.[ch]...')
> 
>       with open(sys.argv[1], 'w') as f_out:
> +        f_out.write(gen_header())
>           for fname in sys.argv[2:]:
>               with open(fname) as f_in:
>                   f_out.write(gen_wrappers_file(f_in.read()))
> diff --git a/include/block/block.h b/include/block/block.h
> index d861883b8d9e..0f0ddc51b49e 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -13,7 +13,7 @@
>   /*
>    * generated_co_wrapper
>    *
> - * Function specifier, which does nothing but marking functions to be
> + * Function specifier, which does nothing but mark functions to be
>    * generated by scripts/block-coroutine-wrapper.py
>    *
>    * Read more in docs/devel/block-coroutine-wrapper.rst
> 
> 
> 


Seems OK, thanks!

-- 
Best regards,
Vladimir

