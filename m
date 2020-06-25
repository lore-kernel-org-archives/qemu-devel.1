Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E017C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC72620781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1bVThBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC72620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joS17-0003Kp-Lj
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joS0K-0002CB-Ct
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:33:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20664
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joS0H-0006Ra-PS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593092000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMaWU1Px2aB/Oh7iKuIJIoAnjinhd2rmpLtHXP+b5co=;
 b=a1bVThBupA4UYc2N12/KxLDdXfs1NyXQxUMjraoRKIxupHNwjbu2hLNJVaNq40Go7nPqr4
 cL0N9CseSJ/MFgoOs0l8idLXw7+hyc2zFxgc92esJrGkTdsBVOjzYxaifo8sHkjs2ZBpy0
 ZwKHbkhNvo9YfHw7pRTyI+v6zQFwbRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-VkGy_UjpNK-x3ZwfNUX4DQ-1; Thu, 25 Jun 2020 09:33:19 -0400
X-MC-Unique: VkGy_UjpNK-x3ZwfNUX4DQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D747D1005512;
 Thu, 25 Jun 2020 13:33:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 785655D9C5;
 Thu, 25 Jun 2020 13:33:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F2EFF11384D4; Thu, 25 Jun 2020 15:33:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 17/46] qemu-option: Smooth error checking with Coccinelle
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-18-armbru@redhat.com>
 <7368e632-8cdb-f6cd-65b5-5d1e14c61459@redhat.com>
Date: Thu, 25 Jun 2020 15:33:15 +0200
In-Reply-To: <7368e632-8cdb-f6cd-65b5-5d1e14c61459@redhat.com> (Eric Blake's
 message of "Wed, 24 Jun 2020 15:08:11 -0500")
Message-ID: <87ftajz2w4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
>>      foo(..., &err);
>>      if (err) {
>>          ...
>>      }
>>
>> to
>>
>>      if (!foo(..., &err)) {
>>          ...
>>      }
>>
>> for QemuOpts functions that now return true / false on success /
>> error.  Coccinelle script:
>>
>
>>
>> Eliminate error_propagate() that are now unnecessary.  Delete @err
>> that are now unused.  Tidy up line breaks and whitespace.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>>   32 files changed, 70 insertions(+), 192 deletions(-)
>
> Another decent chunk of cleanups.
>
>>
>> diff --git a/block.c b/block.c
>> index 30a72bc4c2..77e85f13db 100644
>> --- a/block.c
>> +++ b/block.c
>
>> @@ -6091,8 +6086,8 @@ void bdrv_img_create(const char *filename, const char *fmt,
>>       }
>>         if (base_filename) {
>> -        qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename, &local_err);
>> -        if (local_err) {
>> +        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename,
>> +                          &local_err)) {
>>               error_setg(errp, "Backing file not supported for file format '%s'",
>>                          fmt);
>
> Pre-existing - it is odd that we collect a message into local_err,
> then write something else into errp; the out: label does
> error_propagate(errp, local_err) which ensures there is no leak but
> discards the original err.  You could pass NULL instead.  But as it is
> pre-existing, passing NULL should be a separate patch.

PATCH 20.

>>               goto out;
>> @@ -6100,8 +6095,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
>>       }
>>         if (base_fmt) {
>> -        qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, &local_err);
>> -        if (local_err) {
>> +        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, &local_err)) {
>>               error_setg(errp, "Backing file format not supported for file "
>>                                "format '%s'", fmt);
>
> Ditto.

Likewise.

>> +++ b/qemu-img.c
>> @@ -467,8 +467,8 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
>>       Error *err = NULL;
>>         if (base_filename) {
>> -        qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename, &err);
>> -        if (err) {
>> +        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename,
>> +                          &err)) {
>>               error_report("Backing file not supported for file format '%s'",
>>                            fmt);
>>               error_free(err);
>> @@ -476,8 +476,7 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
>>           }
>>       }
>>       if (base_fmt) {
>> -        qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, &err);
>> -        if (err) {
>> +        if (!qemu_opt_set(opts, BLOCK_OPT_BACKING_FMT, base_fmt, &err)) {
>>               error_report("Backing file format not supported for file "
>>                            "format '%s'", fmt);
>>               error_free(err);
>
> Ditto.

PATCH 44.

> But the conversion here is sane.
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


