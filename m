Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D039CC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0072E2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RU0TZlj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0072E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBny-00015U-HT
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQBhl-0004ou-6d
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQBhh-0007Fq-9N
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602085805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ch2pCg7Wb1abxAdRhWqk9kGmJu4QL1sRaTYPNfCpEE=;
 b=RU0TZlj3ypE9e6p/zf8JF2lXp5RGT4MI8Nbf77BPwZzheKoOygYYCt4jfZtrjZGwvpkhUk
 nnL2d6sXpLhE63j8sWcZDm3ETCMV2MePHSs3oAHOjrl9lZwCqQvdTYcDALQi81UuNlZlcz
 M8pH2e33uVvUUblikqoToTnUWT8DV8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-lbrgQvoiNL2TKb4F99ngxw-1; Wed, 07 Oct 2020 11:50:02 -0400
X-MC-Unique: lbrgQvoiNL2TKb4F99ngxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B1511029D44
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 15:50:01 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46DBD6E72F;
 Wed,  7 Oct 2020 15:49:58 +0000 (UTC)
Subject: Re: [PATCH v5 23/36] qapi/commands.py: enable checking with mypy
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-24-jsnow@redhat.com>
 <87r1qae07b.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <145205fe-346b-b382-1cc6-a888dbcf2f65@redhat.com>
Date: Wed, 7 Oct 2020 11:49:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1qae07b.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 7:37 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   scripts/qapi/mypy.ini | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
>> index 5df11e53fd1..8ab9ac52cc4 100644
>> --- a/scripts/qapi/mypy.ini
>> +++ b/scripts/qapi/mypy.ini
>> @@ -4,11 +4,6 @@ strict_optional = False
>>   disallow_untyped_calls = False
>>   python_version = 3.6
>>   
>> -[mypy-qapi.commands]
>> -disallow_untyped_defs = False
>> -disallow_incomplete_defs = False
>> -check_untyped_defs = False
>> -
>>   [mypy-qapi.error]
>>   disallow_untyped_defs = False
>>   disallow_incomplete_defs = False
> 
> The equivalent change for  events.py you squashed into the commit adding
> type hints.  Any particular reason for not doing the same here?
> 

Just making my life easier for re-arranging commits and rebasing. By 
separating them out whenever I had > 1 fix patch prior, I was able to 
freely re-arrange and re-order the prior fix patches.

They can be squashed on commit if desired, but for my own sake and 
inability to predict review comments, they are separate.

--js


