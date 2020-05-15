Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6C6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4017320727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qns2uHK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4017320727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZe4z-0000VG-GI
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZe4N-0008Iy-V2
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:24:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34373
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZe4M-0008Ub-HO
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589563461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Pl4HzJVB7uTMJhbVdf+AY/dRX81/aJsae0WIaMydEk=;
 b=Qns2uHK/bgobY/kuL+/hfQoaPXTOi9DqBeRn0wj2KmaTP710J0r7DQDX+F00ZufSFU7ipx
 aP2zfUyE05Yr5LMB+wx5pL2ji68bnSS5yvkrWlv4tLYe8/AZYVXjxCZ4BTEha6eBSlPqEw
 XtpNqUxkPHy+1rJXr9/RKNepmzZoL6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-NwlDlk_GM4CWLzL692xePg-1; Fri, 15 May 2020 13:24:16 -0400
X-MC-Unique: NwlDlk_GM4CWLzL692xePg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E90A8015D1;
 Fri, 15 May 2020 17:24:15 +0000 (UTC)
Received: from [10.3.114.84] (ovpn-114-84.phx2.redhat.com [10.3.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D63306E9E9;
 Fri, 15 May 2020 17:24:14 +0000 (UTC)
Subject: Re: [PATCH v6 04/14] block/amend: separate amend and create options
 for qemu-img
To: Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-5-mlevitsk@redhat.com>
 <5b389390-eadb-e1d6-48f8-be99c2dfad99@redhat.com>
 <52231bba-4ef1-2e96-1e82-9e350a68b106@redhat.com>
 <c93d9e92-94dc-9965-e291-2aef8724385a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3a2238b4-e040-e327-a7dd-831e3f24c808@redhat.com>
Date: Fri, 15 May 2020 12:24:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c93d9e92-94dc-9965-e291-2aef8724385a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
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

On 5/15/20 1:22 AM, Max Reitz wrote:

>>>
>>>> +        QCOW_COMMON_OPTIONS,
>>>> +        { /* end of list */ }
>>
>> ...the intended usage is to use the macro name followed by a comma, so
>> including a trailing comma in the macro itself would lead to a syntax
>> error.
> 
> But why is that the indended usage?  Is there something in our coding
> style that forbids macros that don’t allow a separator to be placed
> after them?

If we have more than one such macro, it is easier to write and indent 
(especially when using your editor's ability to decipher enough syntax 
to suggest how to indent):

myarray = {
   COMMON_ELEMENTS,
   MORE_ELEMENTS,
   { /* end of list */ }
};

than it is:

myarray = {
   COMMON_ELEMENTS
   MORE_ELEMENTS
   { /* end of list */ }
};

which in turn implies that it is better to NOT stick a trailing comma in 
the macro itself.  Similarly, for macros intended to replace statements, 
we tend to avoid the trailing ; in the macro itself, because it is 
easier to read:

{
   code;
   MACRO();
   more code;
}

than it is:

{
   code;
   MACRO()
   more code;
}

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


