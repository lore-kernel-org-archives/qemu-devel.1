Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B76DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C5F2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guNyncBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C5F2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZGRw-0001nj-UN
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 12:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZGR4-0000mr-9z
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:10:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60985
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZGR3-0003ao-1N
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589472610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1TmkoMKvA+iFj6D38uXaDMSCDoLrUosH2djQ5PHBXI=;
 b=guNyncBGWXzi5PPbERAdYyzMBuV1Kfu7QsbGKbs/malk4jg3Kvg7gUvFZnVgF7mgjBRSQW
 vrmYG3a59CYJeIhwdv0czBX9fROzfQ5I89sE3kYUaboRqVjgfjazaROM4NucDrc9vltDyl
 6IxVRoepms4z7yAx/ocoV5+oeR+MtHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-h9Mkg50ZNayg451O6A9OSw-1; Thu, 14 May 2020 12:10:04 -0400
X-MC-Unique: h9Mkg50ZNayg451O6A9OSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3D2A461;
 Thu, 14 May 2020 16:10:03 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1311960BF1;
 Thu, 14 May 2020 16:10:02 +0000 (UTC)
Subject: Re: [PATCH v6 04/14] block/amend: separate amend and create options
 for qemu-img
To: Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-5-mlevitsk@redhat.com>
 <5b389390-eadb-e1d6-48f8-be99c2dfad99@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <52231bba-4ef1-2e96-1e82-9e350a68b106@redhat.com>
Date: Thu, 14 May 2020 11:10:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5b389390-eadb-e1d6-48f8-be99c2dfad99@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:35:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 7:28 AM, Max Reitz wrote:
> On 10.05.20 15:40, Maxim Levitsky wrote:
>> Some options are only useful for creation
>> (or hard to be amended, like cluster size for qcow2), while some other
>> options are only useful for amend, like upcoming keyslot management
>> options for luks
>>

>>   
>> +#define QCOW_COMMON_OPTIONS                                         \
>> +    {                                                               \

>> +        .help = "Width of a reference count entry in bits",         \
>> +        .def_value_str = "16"                                       \
>> +    }                                                               \
> 
> I think the last line should have a comma in it (otherwise the final
> backslash doesn’t make much sense, because whenever we’d add a new
> option, we would need to modify the line anyway to insert a comma).

Except that...

> 
> Speaking of adding option, this requires a rebase due to the
> compression_type option added (not trivial in the strict sense, but
> still straightforward to handle).
> 
>> +
>>   static QemuOptsList qcow2_create_opts = {
>>       .name = "qcow2-create-opts",
>>       .head = QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
>>       .desc = {
>>
> 
> [...]
> 
>> +        QCOW_COMMON_OPTIONS,
>> +        { /* end of list */ }

...the intended usage is to use the macro name followed by a comma, so 
including a trailing comma in the macro itself would lead to a syntax 
error.  I think the better fix is to eliminate the trailing \ on the 
final line, and have '}' without a trailing comma in the macro.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


