Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C599C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C610A20644
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfCUGy4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C610A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKJd-0003o5-UX
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOKIL-0002Oi-V2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOKII-0006cn-EL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601642173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aauS9YLt+EUdAZJPId3R7yAPWdCLOUG4meeNzb1X5dE=;
 b=UfCUGy4ShB18qTXTAGRjrSW0pLwvhc7x9uv31IN5ypayzejuZdubG8+ZhgxmzLkC6n64jI
 0++KNvh3ZFrB9yBMItgOnkqkTqSXH23lsUnI+44c3kxgdvoDRbY3k9QsIyRkwPqMQB5Dan
 u01o76ysRXK0jJ/M7Iz/LVvd3mwA6QM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-MxsCiZxAMlurhRIBAepkqw-1; Fri, 02 Oct 2020 08:36:11 -0400
X-MC-Unique: MxsCiZxAMlurhRIBAepkqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7A7B425DB;
 Fri,  2 Oct 2020 12:36:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9A4F5D9D3;
 Fri,  2 Oct 2020 12:36:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E94B1132784; Fri,  2 Oct 2020 14:36:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 3/4] qom: Add user_creatable_print_help_from_qdict()
References: <20200930124557.51835-1-kwolf@redhat.com>
 <20200930124557.51835-4-kwolf@redhat.com>
 <878scoke5z.fsf@dusky.pond.sub.org>
Date: Fri, 02 Oct 2020 14:36:09 +0200
In-Reply-To: <878scoke5z.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 02 Oct 2020 14:25:44 +0200")
Message-ID: <87a6x4iz46.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Kevin Wolf <kwolf@redhat.com> writes:
>
>> This adds a function that, given a QDict of non-help options, prints
>> help for user creatable objects.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  include/qom/object_interfaces.h | 9 +++++++++
>>  qom/object_interfaces.c         | 9 +++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
>> index f118fb516b..53b114b11a 100644
>> --- a/include/qom/object_interfaces.h
>> +++ b/include/qom/object_interfaces.h
>> @@ -161,6 +161,15 @@ int user_creatable_add_opts_foreach(void *opaque,
>>   */
>>  bool user_creatable_print_help(const char *type, QemuOpts *opts);
>>  
>> +/**
>> + * user_creatable_print_help_from_qdict:
>> + * @args: options to create
>> + *
>> + * Prints help considering the other options given in @args (if "qom-type" is
>> + * given and valid, print properties for the type, otherwise print valid types)
>> + */
>> +void user_creatable_print_help_from_qdict(QDict *args);
>> +
>>  /**
>>   * user_creatable_del:
>>   * @id: the unique ID for the object
>> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
>> index 3fd1da157e..ed896fe764 100644
>> --- a/qom/object_interfaces.c
>> +++ b/qom/object_interfaces.c
>> @@ -279,6 +279,15 @@ bool user_creatable_print_help(const char *type, QemuOpts *opts)
>>      return false;
>>  }
>>  
>> +void user_creatable_print_help_from_qdict(QDict *args)
>> +{
>> +    const char *type = qdict_get_try_str(args, "qom-type");
>> +
>> +    if (!type || !user_creatable_print_type_properites(type)) {
>> +        user_creatable_print_types();
>> +    }
>
> Existing user_creatable_print_help():
>
> 1. "qom-type=help,..." and its sugared forms, in particular "help"
>
>    List QOM types and succeed.
>
> 2. "qom-type=T,help,..." 
>
> 2a. If T names a QOM type
>
>     List T's properties and succeed.
>
> 2b. If T does not name a QOM type
>
>     Fail.  Callers typically interpret this as "no help requested",
>     proceed, then choke on invalid qom-type=T.

And of course

  3. Else

     No help requested; fail.

> New user_creatable_print_help() treats case 2b like case 1.
>
> Intentional?

The next patch relies on this, so I figure the answer is yes.

The difference to user_creatable_print_help() is subtle.  Perhaps the
contract should point it out explicitly.  Up to you.

By the way, the contract of user_creatable_print_help() is inaccurate:

 * Prints help if requested in @opts.
 *
 * Returns: true if @opts contained a help option and help was printed, false
 * if no help option was found.

One, it prints help when either @type or @opts request it.

Two, "if no help option was found" is misleading: case 2b.

Not this patch's problem.
>
>> +}
>> +
>>  bool user_creatable_del(const char *id, Error **errp)
>>  {
>>      Object *container;

Reviewed-by: Markus Armbruster <armbru@redhat.com>


