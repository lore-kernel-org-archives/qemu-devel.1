Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54C6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5945E2225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqI0Zafb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5945E2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQPG-0007lp-DI
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUQEz-00070R-4W
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUQEx-0005P0-82
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603094998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWl2hdQyAW25HOiZSbXV7+k+2/q0m+rEii6CmAqWX/w=;
 b=dqI0Zafb2Z0arg2o6N1SW3vtbk7y6SGiE1aYHjhgYIn+6ByfgsERUxsNgPQ62oAtJ0YIAL
 uTHaLa9Fqk/gr0LMKVGtDSfT0L5ZHxXugub7W8rW1UNwDvbiXbBWj3gNhgqy2Q/M105Jrb
 2F/ngioCJ7Qkeoo/JYrGsBJx/wKCCJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-BA_UC-FjPSe7f7ualGa8kQ-1; Mon, 19 Oct 2020 04:09:56 -0400
X-MC-Unique: BA_UC-FjPSe7f7ualGa8kQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B83D10866A4;
 Mon, 19 Oct 2020 08:09:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7651E6EF7B;
 Mon, 19 Oct 2020 08:09:54 +0000 (UTC)
Subject: Re: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
From: Thomas Huth <thuth@redhat.com>
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-3-j@getutm.app>
 <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
Message-ID: <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
Date: Mon, 19 Oct 2020 10:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 19/10/2020 10.07, Thomas Huth wrote:
> On 19/10/2020 03.39, Joelle van Dyne wrote:
>> From: osy <osy86@users.noreply.github.com>
>>
>> The iOS toolchain does not use the host prefix naming convention. We add a
>> new option `--enable-cross-compile` that forces cross-compile even without
>> a cross_prefix.
>>
>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>> ---
>>  configure | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 3c63879750..46d5db63e8 100755
>> --- a/configure
>> +++ b/configure
>> @@ -234,6 +234,7 @@ cpu=""
>>  iasl="iasl"
>>  interp_prefix="/usr/gnemul/qemu-%M"
>>  static="no"
>> +cross_compile="no"
>>  cross_prefix=""
>>  audio_drv_list=""
>>  block_drv_rw_whitelist=""
>> @@ -456,6 +457,11 @@ for opt do
>>    optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
>>    case "$opt" in
>>    --cross-prefix=*) cross_prefix="$optarg"
>> +                    cross_compile="yes"
>> +  ;;
>> +  --enable-cross-compile) cross_compile="yes"
>> +  ;;
>> +  --disable-cross-compile) cross_compile="no"
> 
> Can't you simply use --cros-prefix="" instead?

I mean, still introduce the "cross_compile=yes" variable, just omit the new
options.

 Thomas


