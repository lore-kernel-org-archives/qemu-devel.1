Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D532020874
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDghQ/64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D532020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUR7E-0000XR-Qs
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUR5k-0007ow-S6
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUR5h-0005XG-3D
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603098267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NU4y4UnIrWY8KrEJ3L9TsWxHeYUYeui1JXTTuFsoUTc=;
 b=KDghQ/640KvLB2QLLiuXd9F5dEkftiH1WaA80YB3oKBhINpnaBNaOkG9Ez3/O8ExMNPJ3H
 s4EVJQKKnJsQ05rVv9dIqaRG8glNCEQVrk77ySFhpNX5t6w+RI3dQ2aRsdswzoq25s5n/H
 cqNd8cEAp4kgVcYFmiyRPSW5yJa+QGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-oMN9TVEyMwCXKZlSCCKz9Q-1; Mon, 19 Oct 2020 05:04:25 -0400
X-MC-Unique: oMN9TVEyMwCXKZlSCCKz9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62EC8190A3E0;
 Mon, 19 Oct 2020 09:04:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C7566EF45;
 Mon, 19 Oct 2020 09:04:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BE4B1132A08; Mon, 19 Oct 2020 11:04:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 4/7] keyval: Parse help options
References: <20201011073505.1185335-1-armbru@redhat.com>
 <20201011073505.1185335-5-armbru@redhat.com>
 <20201012143501.GE7777@merkur.fritz.box>
Date: Mon, 19 Oct 2020 11:04:22 +0200
In-Reply-To: <20201012143501.GE7777@merkur.fritz.box> (Kevin Wolf's message of
 "Mon, 12 Oct 2020 16:35:01 +0200")
Message-ID: <871rhu1t9l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 11.10.2020 um 09:35 hat Markus Armbruster geschrieben:
>> From: Kevin Wolf <kwolf@redhat.com>
>> 
>> This adds a special meaning for 'help' and '?' as options to the keyval
>> parser. Instead of being an error (because of a missing value) or a
>> value for an implied key, they now request help, which is a new boolean
>> output of the parser in addition to the QDict.
>> 
>> A new parameter 'p_help' is added to keyval_parse() that contains on
>> return whether help was requested. If NULL is passed, requesting help
>> results in an error and all other cases work like before.
>> 
>> Turning previous error cases into help is a compatible extension. The
>> behaviour potentially changes for implied keys: They could previously
>> get 'help' as their value, which is now interpreted as requesting help.
>> 
>> This is not a problem in practice because 'help' and '?' are not a valid
>> values for the implied key of any option parsed with keyval_parse():
>> 
>> * audiodev: union Audiodev, implied key "driver" is enum AudiodevDriver,
>>   "help" and "?" are not among its values
>> 
>> * display: union DisplayOptions, implied key "type" is enum
>>   DisplayType, "help" and "?" are not among its values
>> 
>> * blockdev: union BlockdevOptions, implied key "driver is enum
>>   BlockdevDriver, "help" and "?" are not among its values
>> 
>> * export: union BlockExport, implied key "type" is enum BlockExportType,
>>   "help" and "?" are not among its values
>> 
>> * monitor: struct MonitorOptions, implied key "mode" is enum MonitorMode,
>>   "help" and "?" are not among its values
>> 
>> * nbd-server: struct NbdServerOptions, no implied key.
>> 
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>> diff --git a/tests/test-keyval.c b/tests/test-keyval.c
>> index 04c62cf045..7b459900af 100644
>> --- a/tests/test-keyval.c
>> +++ b/tests/test-keyval.c
>> @@ -1,3 +1,4 @@
>> +
>>  /*
>>   * Unit tests for parsing of KEY=VALUE,... strings
>>   *
>
> This hunk looks unintentional.

It is.  Thanks for fixing it up!


