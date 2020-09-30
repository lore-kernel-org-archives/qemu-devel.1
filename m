Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315F4C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4EC206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKwOTzyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4EC206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNUNv-0006pC-K7
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 01:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNU0x-0002YX-H4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNU0v-0001de-12
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:46:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601441207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sr1zC+J7cij/dKim/2fmWDXKjcio9lMZhUssu2t2EaA=;
 b=MKwOTzynXEGZmBK4fbR6iHXKrqGOfrONpQOaDaHzeYVcc1y9pTswf/oZ9tzpQ9ZEq01zTs
 3pomJaA9MV8uZEo8azvg9COGEJAYXVK+BIOviFyekJQiCDW6vhOtjHx/ubp2UIx3tBxYJ0
 of1JMbH69iqdGclSDe6gcQ6mCyr8e24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-l0igbeS1NUign4X55bhlBw-1; Wed, 30 Sep 2020 00:46:44 -0400
X-MC-Unique: l0igbeS1NUign4X55bhlBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 324491921FB7;
 Wed, 30 Sep 2020 04:46:43 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6227010023A7;
 Wed, 30 Sep 2020 04:46:42 +0000 (UTC)
Subject: Re: [PATCH 16/16] qapi/expr.py: Use an expression checker dispatch
 table
To: Helio Loureiro <helio@loureiro.eng.br>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-17-jsnow@redhat.com>
 <20200925011849.GI368253@localhost.localdomain>
 <5a392d78-cf26-7c75-e00e-bf913607c0ac@redhat.com>
 <CAPxLgJLSntAY5zaLJvJuPhA9bccGYpAe04j0nhcMdk94SSvtAA@mail.gmail.com>
 <52dfd3f1-c82a-e1e1-9f23-60bc15da76f1@redhat.com>
 <CAPxLgJ+Kp48zr-rcFrtGJGBdkZKs3xkfXoCHeC2VdTe369aucA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1b1799e3-7dea-e904-56bc-913fae6d82c1@redhat.com>
Date: Wed, 30 Sep 2020 00:46:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAPxLgJ+Kp48zr-rcFrtGJGBdkZKs3xkfXoCHeC2VdTe369aucA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/20 7:31 AM, Helio Loureiro wrote:
> 
> 
> On Fri, Sep 25, 2020, 16:16 John Snow <jsnow@redhat.com 
> <mailto:jsnow@redhat.com>> wrote:
> 
>     On 9/25/20 2:03 AM, Helio Loureiro wrote:
>      > Hi,
>      >
>      > I would replace the word variable "kind" by "category".
>      >
> 
>     Hi, welcome to the list!
> 
> 
> Tkz!
> 
> 
>     For patch reviews, we try to reply in-line, below the original post.
> 
> 
> I realized that later.  It has been more than 20 years I don't use this 
> formating.  But if I intend to join the pack, I need to follow the pack.
> 
> 
> 
>     (For more information on the QAPI Schema Language that we are parsing
>     and validating here, see docs/devel/qapi-code-gen.txt if you are
>     curious. Ultimately it is a JSON-like format that permits multiple
>     objects per document and allows comments. We use these structures to
>     generate types and command interfaces for our API protocol, QMP.)
> 
> 
> Based on that I would suggest 'type_ref' instead to match the 
> definitions over there and since word 'type' itself is reserved.
> 

One of the unsolvable problems in computer science is naming things: 
"TYPE-REF" also has a specific meaning in QAPI, as it is the name of one 
of the BNF grammar tokens we use.

So I might suggest (if "kind" is too ambiguous), that I might use 
"statement_type" or "expression_type" if that helps clarify things.

--js


