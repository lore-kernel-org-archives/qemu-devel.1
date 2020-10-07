Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E27EC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3463D2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIT1PS/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3463D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQE64-0000XI-55
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 14:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQE4n-0008PK-Ny
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQE4m-0007QS-0U
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602094926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G1LCkG1doYBqnmb1jXV9kmfmwizHSb984sYxcR3stz8=;
 b=SIT1PS/cLJuGA+fYrPCO5bag7NHsZsPSxAwXS53g1YrM6a5IWzXz1JVBaEHj0I+BjYV+FS
 wzt9s22JgVodcbdqkCJNvbrqVWoaYvIshh5PnwqFjZCuiTEwqIQxZ/BtKVhHpoOPFQfCoC
 OsvExs75ncVffKebWpfqS8CkntUF/h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-7P2K-ciHP3m2PK4H7gdHuA-1; Wed, 07 Oct 2020 14:22:03 -0400
X-MC-Unique: 7P2K-ciHP3m2PK4H7gdHuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10188106275C;
 Wed,  7 Oct 2020 18:22:02 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1040E1002EE9;
 Wed,  7 Oct 2020 18:21:50 +0000 (UTC)
Subject: Re: [PATCH 07/20] python/machine.py: Add _qmp access shim
To: Kevin Wolf <kwolf@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-8-jsnow@redhat.com>
 <20201007095322.GC7212@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Message-ID: <614fa5a6-817c-7f14-a9f1-6c56e854302d@redhat.com>
Date: Wed, 7 Oct 2020 14:21:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007095322.GC7212@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 5:53 AM, Kevin Wolf wrote:
> Am 07.10.2020 um 01:58 hat John Snow geschrieben:
>> Like many other Optional[] types, it's not always a given that this
>> object will be set. Wrap it in a type-shim that raises a meaningful
>> error and will always return a concrete type.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
>> @@ -515,11 +515,13 @@ def set_qmp_monitor(self, enabled=True):
>>                           line. Default is True.
>>           @note: call this function before launch().
>>           """
>> -        if enabled:
>> -            self._qmp_set = True
>> -        else:
>> -            self._qmp_set = False
>> -            self._qmp = None
>> +        self._qmp_set = enabled
> 
> This change seems unrelated to wrapping the connection in a property.
> Intuitively, it makes sense that the connection of a running instance
> doesn't go away just because I disable QMP in the command line for the
> next launch.
> 
> If this is the reasoning behind the change, maybe mention it in the
> commit message.
> 
> With this:
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 

Oh, yes. That's what happened here -- and it got folded in here 
specifically to make that access check consistent.

I'll update the commit message.


