Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0C9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387DF2225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbQYjl9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387DF2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUR9M-0003AK-7g
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUR87-0001ex-9p
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUR85-0005ty-Jc
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603098416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRYrqw52OCkb/E+c3XzAmYPb4P0vfFjEv4RFEXiivCA=;
 b=fbQYjl9w+oMqqfB3U572LNH6n1Qj3oAfBud/kF0D+Ics65zJztUqM9DTAmbTrpuol9GIHo
 RX4+4wiK1vKwoCFzHs7SISm1SwQbfQJa2Kfa6Zps6w4X79duAVjFCmutyMdaLZHeCOp9Xp
 70r6KS/9NSU7JsLbefBK52BYEdzkT1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-ndXMnQjBOXCcYCC8U6BHpA-1; Mon, 19 Oct 2020 05:06:53 -0400
X-MC-Unique: ndXMnQjBOXCcYCC8U6BHpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC4A78030B2;
 Mon, 19 Oct 2020 09:06:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77BFA5C225;
 Mon, 19 Oct 2020 09:06:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF1781132A08; Mon, 19 Oct 2020 11:06:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 4/7] keyval: Parse help options
References: <20201011073505.1185335-1-armbru@redhat.com>
 <20201011073505.1185335-5-armbru@redhat.com>
 <2f9e1df0-9be8-e63c-8c2d-b1afbe952a0c@redhat.com>
Date: Mon, 19 Oct 2020 11:06:50 +0200
In-Reply-To: <2f9e1df0-9be8-e63c-8c2d-b1afbe952a0c@redhat.com> (Eric Blake's
 message of "Mon, 12 Oct 2020 06:51:19 -0500")
Message-ID: <87wnzmzis5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/11/20 2:35 AM, Markus Armbruster wrote:
>> From: Kevin Wolf <kwolf@redhat.com>
>> This adds a special meaning for 'help' and '?' as options to the
>> keyval
>> parser. Instead of being an error (because of a missing value) or a
>> value for an implied key, they now request help, which is a new boolean
>> output of the parser in addition to the QDict.
>> A new parameter 'p_help' is added to keyval_parse() that contains on
>> return whether help was requested. If NULL is passed, requesting help
>> results in an error and all other cases work like before.
>> 
>
>> +
>> +    /* "help" by itself, without implied key */
>> +    qdict = keyval_parse("help", NULL, &help, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 0);
>> +    g_assert(help);
>> +    qobject_unref(qdict);
>> +
>> +    /* "help" by itself, with implied key */
>> +    qdict = keyval_parse("help", "implied", &help, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 0);
>> +    g_assert(help);
>> +    qobject_unref(qdict);
>> +
>> +    /* "help" when no help is available, without implied key */
>> +    qdict = keyval_parse("help", NULL, NULL, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>> +
>> +    /* "help" when no help is available, with implied key */
>> +    qdict = keyval_parse("help", "implied", NULL, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>> +
>> +    /* Key "help" */
>> +    qdict = keyval_parse("help=on", NULL, &help, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "help"), ==, "on");
>> +    g_assert(!help);
>> +    qobject_unref(qdict);
>> +
>> +    /* "help" followed by crap, without implied key */
>> +    qdict = keyval_parse("help.abc", NULL, &help, &err);
>> +    error_free_or_abort(&err);
>> +    g_assert(!qdict);
>> +
>> +    /* "help" followed by crap, with implied key */
>> +    qdict = keyval_parse("help.abc", "implied", &help, &err);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "help.abc");
>> +    g_assert(!help);
>> +    qobject_unref(qdict);
>> +
>> +    /* "help" with other stuff, without implied key */
>> +    qdict = keyval_parse("number=42,help,foo=bar", NULL, &help, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 2);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "number"), ==, "42");
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), ==, "bar");
>> +    g_assert(help);
>> +    qobject_unref(qdict);
>> +
>> +    /* "help" with other stuff, with implied key */
>> +    qdict = keyval_parse("val,help,foo=bar", "implied", &help, &error_abort);
>> +    g_assert_cmpuint(qdict_size(qdict), ==, 2);
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "val");
>> +    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), ==, "bar");
>> +    g_assert(help);
>> +    qobject_unref(qdict);
>
> Is it worth checking that "helper" with implied key is a value, not help?

Case /* "help" followed by crap, with implied key */ covers this,
doesn't it?

>> +++ b/util/keyval.c
>> @@ -14,10 +14,11 @@
>>    * KEY=VALUE,... syntax:
>>    *
>>    *   key-vals     = [ key-val { ',' key-val } [ ',' ] ]
>> - *   key-val      = key '=' val
>> + *   key-val      = key '=' val | help
>>    *   key          = key-fragment { '.' key-fragment }
>>    *   key-fragment = / [^=,.]+ /
>>    *   val          = { / [^,]+ / | ',,' }
>> + *   help         = 'help | '?'
>
> Missing '

Kevin fixed it up.

> Otherwise
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


