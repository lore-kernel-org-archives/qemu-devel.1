Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79DCC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6B9208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxjKdIVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6B9208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoYY-0007Ls-IS
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLoWc-0006d4-OX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLoWb-0004S0-1q
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:16:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601043396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rVgmWpYDftW3ZvE5cm+hXtpAkpJEniXpzLa9Xtzo4XU=;
 b=LxjKdIVq4QKU2u92EZVK9NGIqH5S+ovPzsfpYvYVNp3bqDCqOjRoKIlnwiUADvXQl6P1do
 /R4qakRdoSYRt4ZQSSxIPKbbXugNKH+aHblUQb4MFFDqQgjmUmFHGyYooVlb9x8HFP+nsY
 Bgse97v6kTc68/LbhqxJqB/l1k0/LoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-Dw9v2hYMNe2Rx-0FEb7YIw-1; Fri, 25 Sep 2020 10:16:34 -0400
X-MC-Unique: Dw9v2hYMNe2Rx-0FEb7YIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE8FB100857A;
 Fri, 25 Sep 2020 14:16:32 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFEA85C22E;
 Fri, 25 Sep 2020 14:16:31 +0000 (UTC)
Subject: Re: [PATCH 16/16] qapi/expr.py: Use an expression checker dispatch
 table
To: Helio Loureiro <helio@loureiro.eng.br>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-17-jsnow@redhat.com>
 <20200925011849.GI368253@localhost.localdomain>
 <5a392d78-cf26-7c75-e00e-bf913607c0ac@redhat.com>
 <CAPxLgJLSntAY5zaLJvJuPhA9bccGYpAe04j0nhcMdk94SSvtAA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <52dfd3f1-c82a-e1e1-9f23-60bc15da76f1@redhat.com>
Date: Fri, 25 Sep 2020 10:16:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAPxLgJLSntAY5zaLJvJuPhA9bccGYpAe04j0nhcMdk94SSvtAA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 9/25/20 2:03 AM, Helio Loureiro wrote:
> Hi,
> 
> I would replace the word variable "kind" by "category".
> 

Hi, welcome to the list!

For patch reviews, we try to reply in-line, below the original post.

I'm not attached to 'kind', but 'category' is perhaps too broad. 
Category in this particular domain might refer to the difference between 
a "Directive" (include, pragma) and a Definition (enum, struct, union, 
alternate, command, event)

(For more information on the QAPI Schema Language that we are parsing 
and validating here, see docs/devel/qapi-code-gen.txt if you are 
curious. Ultimately it is a JSON-like format that permits multiple 
objects per document and allows comments. We use these structures to 
generate types and command interfaces for our API protocol, QMP.)

Ultimately I am using 'kind' for the 'type of expression', but type is 
an extremely overloaded word when parsing a language in another language!

We also use 'meta' nearby for semantically the same thing, but with 
different typing.

Thanks for looking!
--js

> ./helio
> 
> On Fri, Sep 25, 2020, 03:32 John Snow <jsnow@redhat.com 
> <mailto:jsnow@redhat.com>> wrote:
> 
>     On 9/24/20 9:18 PM, Cleber Rosa wrote:
>      > I have to say the style of this line bothers me, but it's just that,
>      > style. So,
> 
>     What don't you like?
> 
> 


