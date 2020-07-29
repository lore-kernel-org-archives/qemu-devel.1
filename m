Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B606DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 08:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE252076E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 08:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RC9hP3ae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE252076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0hYi-0002ZA-NG
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 04:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0hXv-00027r-38
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 04:34:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0hXs-0002F4-5U
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 04:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596011678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ZMb709yA4p6c9Hn833N9EKyhsWbnguEHtpWpOQpFAE=;
 b=RC9hP3aePI8Eq7qXI91u9dGKHYgS27mKBzUUH7173YsewkWarq4qLC2qrjgBbASeX7rPjt
 PNxdusClvVYpZr3HYfpU4xARKbHSnJ/aI+7pHp7CIj1QHE9A8Ed6tqGW/1hbHf3t5GAZwr
 bgjkNhUTHcgYBFZizgVSi+wqa0EcAYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-zjEKd030Mq2s9_wga1yjoQ-1; Wed, 29 Jul 2020 04:34:36 -0400
X-MC-Unique: zjEKd030Mq2s9_wga1yjoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D586D18C63C1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 08:34:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD3D86842F;
 Wed, 29 Jul 2020 08:34:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 78A2F1132FD2; Wed, 29 Jul 2020 10:34:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: Missing qapi_free_Type in error case for qapi generated code?
References: <ly4kprhd8e.fsf@redhat.com>
 <fe8f0bd6-ed47-08b8-d7c9-fc40c32b0bb2@redhat.com>
Date: Wed, 29 Jul 2020 10:34:31 +0200
In-Reply-To: <fe8f0bd6-ed47-08b8-d7c9-fc40c32b0bb2@redhat.com> (Eric Blake's
 message of "Tue, 28 Jul 2020 10:44:21 -0500")
Message-ID: <87eeouafe0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.74; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 03:32:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 7/28/20 10:26 AM, Christophe de Dinechin wrote:
>> The qapi generated code for qmp_marshal_query_spice seems to be missing a
>> resource deallocation for "retval". For example, for SpiceInfo:
>>
>
>>      retval = qmp_query_spice(&err);
>>      error_propagate(errp, err);
>>      if (err) {
>> /* retval not freed here */
>
> Because it should be NULL here.  Returning an error AND an object is
> frowned on.

It's forbidden, actually.  The QMP handler must either succeed and
return a value, or fail cleanly.

Since it has to return a value even when it fails, it returns an error
value then.  "Cleanly" means the error value does not require cleanup.

The generated marshalling function relies on this: it *ignores* the
error value.

>> /* Missing: qapi_free_SpiceInfo(retval); */
>>          goto out;
>>      }
>>
>>      qmp_marshal_output_SpiceInfo(retval, ret, errp);
>
> And here, retval was non-NULL, but is cleaned as a side-effect of
> qmp_marshal_output_SpiceInfo.
>
>>
>> out:
>
> So no matter how you get to the label, retval is no longer valid
> memory that can be leaked.
>
>>      visit_free(v);
>>      v = qapi_dealloc_visitor_new();
>>      visit_start_struct(v, NULL, NULL, 0, NULL);
>>      visit_end_struct(v, NULL);
>>      visit_free(v);
>> }
>> #endif /* defined(CONFIG_SPICE) */
>>
>> Questions:
>>
>> - Is the query code supposed to always return NULL in case of error?
>
> Yes.  If not, that is a bug in qmp_query_spice.

Correct.

>> In the
>>    case of hmp_info_spice, there is no check for info==NULL, so on the

I'm blind.  Where?

>>    contrary, it seems to indicate that a non-null result is always expected,
>>    and that function does call qapi_free_SpiceInfo
>
> Calling qapi_free_SpiceInfo(NULL) is a safe no-op.  Or if you expect
> the function to always succeed, you could pass &error_abort as the
> errp parameter.
>
>>
>> - If not, is there an existing shortcut to generate the correct deallocation
>>    code for return types that need it? You can't just use
>>    qapi_free_%(c_type)s because that would generate an extra * character,
>>    i.e. I get "SpiceInfo *" and not "SpiceInfo".
>
> Ah, you're debating about editing scripts/qapi/commands.py.  If
> anything, an edit to add 'assert(!retval)' if qmp_COMMAND failed might
> be smarter than trying to add code to free retval.

This is more complicated than it may seem.

The "natural" error value for a pointer-valued function is NULL.  I'm
confident the handlers use it.  assert(!retval) should work.

For functions returning something else, people may have different ideas
on what to return on error.  To make assert(!retval) work, they need to
return something "falsish".  I'm not ready to bet my own money on all of
them doing that.

Aside: only functions in pragma returns-whitelist can return
non-pointer.

>> - If not, is there any good way to know if the type is a pointer type?
>>    (A quick look in cripts/qapi/types.py does not show anything obvious)

No clean way exists, simply because there has been no need.  So far,
we've always found a reasonable way to generate code that works whether
types are pointers in C or not.

> Look at scripts/qapi/schema.py; each QAPI metatype has implementations
> of .c_name and .c_type that determine how to represent that QAPI
> object in C.  You probably want c_name instead of c_type when
> constructing the name of a qapi_free_FOO function, but that goes back
> to my question of whether such a call is even needed.

Method c_name() returns a string you can interpolate into C identifiers.

Method c_type() returns a string you can use as C type in generated
code.

The QAPI scripts could use more comments.


