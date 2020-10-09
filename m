Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CE9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06FB20709
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFzSjV+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06FB20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtX8-0007pd-Lc
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQtVL-0006LL-P4
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQtVH-0007df-MT
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602254174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xHizHi/RtEFe+/dn6td7sn9ASMLRm1S1SgWNGCdn/ys=;
 b=hFzSjV+wgk1Sz7VmvrNaGUKp+Vs2NSaIMMaG+J/w0tiJNWb0FMXBPaeKCB73G2EE4RRqZ4
 RoTqFo7qNt5YWlOUw805xUA+b1eXIVh9MyynuPzhiFixA0WS0UoHJLmks9VtMHZSh8SL/X
 v+tISfcGqPMJjXlHDbqbe8u7dZ5IPk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-n1qN2tPDMbuZgHiqo3R3wQ-1; Fri, 09 Oct 2020 10:36:10 -0400
X-MC-Unique: n1qN2tPDMbuZgHiqo3R3wQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51744802B66;
 Fri,  9 Oct 2020 14:36:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22F575D9E8;
 Fri,  9 Oct 2020 14:36:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 982FE11329AE; Fri,  9 Oct 2020 16:36:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] keyval: Parse help options
References: <20200929172649.158086-1-kwolf@redhat.com>
 <20200929172649.158086-2-kwolf@redhat.com>
 <b28cad72-d344-78fa-fc07-b4a6a63fbc50@redhat.com>
Date: Fri, 09 Oct 2020 16:36:06 +0200
In-Reply-To: <b28cad72-d344-78fa-fc07-b4a6a63fbc50@redhat.com> (Eric Blake's
 message of "Tue, 29 Sep 2020 12:46:55 -0500")
Message-ID: <871ri7ii09.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/29/20 12:26 PM, Kevin Wolf wrote:
>> This adds a new parameter 'help' to keyval_parse() that enables parsing
>> of help options. If NULL is passed, the function behaves the same as
>> before. But if a bool pointer is given, it contains the information
>> whether an option "help" without value was given (which would otherwise
>> either result in an error or be interpreted as the value for an implied
>> key).
>> 
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>
>> +++ b/util/keyval.c
>
> Might be nice to see this before the testsuite changes by tweaking the
> git orderfile.
>
>> @@ -166,7 +166,7 @@ static QObject *keyval_parse_put(QDict *cur,
>>   * On failure, return NULL.
>>   */
>>  static const char *keyval_parse_one(QDict *qdict, const char *params,
>> -                                    const char *implied_key,
>> +                                    const char *implied_key, bool *help,
>>                                      Error **errp)
>>  {
>>      const char *key, *key_end, *s, *end;
>> @@ -179,6 +179,16 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
>>  
>>      key = params;
>>      len = strcspn(params, "=,");
>> +
>> +    if (help && key[len] != '=' && !strncmp(key, "help", len)) {
>
> What if the user typed "help,," to get "help," as the value of the
> implied key?

The value of an implied key cannot contain ','.  This is intentional.

test-keyval.c:

    /* Implied key with empty value (qemu_opts_parse() accepts this) */
    qdict = keyval_parse(",", "implied", &err);
    error_free_or_abort(&err);
    g_assert(!qdict);

    /* Likewise (qemu_opts_parse(): implied key with comma value) */
    qdict = keyval_parse(",,,a=1", "implied", &err);
    error_free_or_abort(&err);
    g_assert(!qdict);

Grammar:

 *   val-no-key   = / [^=,]* /

Aside: should be + instead of *.  Doc bug.  I'll fix it.

[...]


