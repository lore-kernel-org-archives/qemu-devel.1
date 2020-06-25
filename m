Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BF4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0015206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hegffpWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0015206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTRE-00046e-TS
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joTPc-0002Ov-54
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:03:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56502
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joTPX-0000Hm-SL
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593097410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6Cl5O7SAJTov4z2dnwRbZo80DQWeDqxcCLhimW8M4c=;
 b=hegffpWgz7tqT9CklS2b+toQGDXGOQ9kzG/didl3dAaX4vjo5Ja5UHr6r/TsLnkjsq1yTo
 McBG2wQrvMNt6Yu89rlO9sVIim/7BwVNlgt1PV5GLGWEKcic6W7gpiJJlvhzD55svyyhCB
 5QlUp79rZmEhrgsjlPYMDG3Qs6ldJp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-wXrm2N2mOVaKRgOf3Ia_Xg-1; Thu, 25 Jun 2020 11:03:27 -0400
X-MC-Unique: wXrm2N2mOVaKRgOf3Ia_Xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7B0810059A5;
 Thu, 25 Jun 2020 15:03:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BB661002393;
 Thu, 25 Jun 2020 15:03:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CAFED11384D4; Thu, 25 Jun 2020 17:03:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 23/46] qapi: Smooth error checking with Coccinelle
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-24-armbru@redhat.com>
 <c1fed52d-ff57-c366-c35d-271a0a1d724c@redhat.com>
Date: Thu, 25 Jun 2020 17:03:22 +0200
In-Reply-To: <c1fed52d-ff57-c366-c35d-271a0a1d724c@redhat.com> (Eric Blake's
 message of "Wed, 24 Jun 2020 15:50:38 -0500")
Message-ID: <87lfkbxk5h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 6/24/20 11:43 AM, Markus Armbruster wrote:
>> The previous commit enables conversion of
>>
>>      visit_foo(..., &err);
>>      if (err) {
>> =09...
>>      }
>>
>> to
>>
>>      if (!visit_foo(..., errp)) {
>> =09...
>>      }
>>
>> for visitor functions that now return true / false on success / error.
>> Coccinelle script:
>>
>>      @@
>>      identifier fun =3D~ "check_list|input_type_enum|lv_start_struct|lv_=
type_bool|lv_type_int64|lv_type_str|lv_type_uint64|output_type_enum|parse_t=
ype_bool|parse_type_int64|parse_type_null|parse_type_number|parse_type_size=
|parse_type_str|parse_type_uint64|print_type_bool|print_type_int64|print_ty=
pe_null|print_type_number|print_type_size|print_type_str|print_type_uint64|=
qapi_clone_start_alternate|qapi_clone_start_list|qapi_clone_start_struct|qa=
pi_clone_type_bool|qapi_clone_type_int64|qapi_clone_type_null|qapi_clone_ty=
pe_number|qapi_clone_type_str|qapi_clone_type_uint64|qapi_dealloc_start_lis=
t|qapi_dealloc_start_struct|qapi_dealloc_type_anything|qapi_dealloc_type_bo=
ol|qapi_dealloc_type_int64|qapi_dealloc_type_null|qapi_dealloc_type_number|=
qapi_dealloc_type_str|qapi_dealloc_type_uint64|qobject_input_check_list|qob=
ject_input_check_struct|qobject_input_start_alternate|qobject_input_start_l=
ist|qobject_input_start_struct|qobject_input_type_any|qobject_input_type_bo=
ol|qobject_input_type_bool_keyval|qobject_input_type_int64|qobject_input_ty=
pe_int64_keyval|qobject_input_type_null|qobject_input_type_number|qobject_i=
nput_type_number_keyval|qobject_input_type_size_keyval|qobject_input_type_s=
tr|qobject_input_type_str_keyval|qobject_input_type_uint64|qobject_input_ty=
pe_uint64_keyval|qobject_output_start_list|qobject_output_start_struct|qobj=
ect_output_type_any|qobject_output_type_bool|qobject_output_type_int64|qobj=
ect_output_type_null|qobject_output_type_number|qobject_output_type_str|qob=
ject_output_type_uint64|start_list|visit_check_list|visit_check_struct|visi=
t_start_alternate|visit_start_list|visit_start_struct|visit_type_.*";
>
> Long line. Does coccinelle understand \-newline wrapping?

Documentation is mum on it.  A quick test appears to work.  I'll check
whether I still get the same result here.

>>      expression list args, args2;
>>      typedef Error;
>>      Error *err;
>>      identifier errp;
>>      @@
>>      -      fun(args, &err, args2);
>>      -      if (err) {
>>      +      if (!fun(args, errp, args2)) {
>> =09       ... when !=3D err
>>      -=09   error_propagate(errp, err);
>> =09       ...
>> =09   }
>>
>>      @@
>>      identifier fun =3D~ "check_list|input_type_enum|lv_start_struct|lv_=
type_bool|lv_type_int64|lv_type_str|lv_type_uint64|output_type_enum|parse_t=
ype_bool|parse_type_int64|parse_type_null|parse_type_number|parse_type_size=
|parse_type_str|parse_type_uint64|print_type_bool|print_type_int64|print_ty=
pe_null|print_type_number|print_type_size|print_type_str|print_type_uint64|=
qapi_clone_start_alternate|qapi_clone_start_list|qapi_clone_start_struct|qa=
pi_clone_type_bool|qapi_clone_type_int64|qapi_clone_type_null|qapi_clone_ty=
pe_number|qapi_clone_type_str|qapi_clone_type_uint64|qapi_dealloc_start_lis=
t|qapi_dealloc_start_struct|qapi_dealloc_type_anything|qapi_dealloc_type_bo=
ol|qapi_dealloc_type_int64|qapi_dealloc_type_null|qapi_dealloc_type_number|=
qapi_dealloc_type_str|qapi_dealloc_type_uint64|qobject_input_check_list|qob=
ject_input_check_struct|qobject_input_start_alternate|qobject_input_start_l=
ist|qobject_input_start_struct|qobject_input_type_any|qobject_input_type_bo=
ol|qobject_input_type_bool_keyval|qobject_input_type_int64|qobject_input_ty=
pe_int64_keyval|qobject_input_type_null|qobject_input_type_number|qobject_i=
nput_type_number_keyval|qobject_input_type_size_keyval|qobject_input_type_s=
tr|qobject_input_type_str_keyval|qobject_input_type_uint64|qobject_input_ty=
pe_uint64_keyval|qobject_output_start_list|qobject_output_start_struct|qobj=
ect_output_type_any|qobject_output_type_bool|qobject_output_type_int64|qobj=
ect_output_type_null|qobject_output_type_number|qobject_output_type_str|qob=
ject_output_type_uint64|start_list|visit_check_list|visit_check_struct|visi=
t_start_alternate|visit_start_list|visit_start_struct|visit_type_.*";
>
> The same list twice.  Is there a way to write it only once, then refer
> to it by reference in the two halves of the script?

I wish I knew!  Tell me, and I owe you a beverage of your choice at the
next in-person KVM Forum.

>>   46 files changed, 95 insertions(+), 331 deletions(-)
>
> Nice to see the size reduction.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


