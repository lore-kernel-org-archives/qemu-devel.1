Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D6C04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F7A21D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFqAd+Ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F7A21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZ8X-0002v2-D5
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQZ7Z-0002FU-BM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQZ7T-00036c-FF
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602175818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtdkPTyC9mwyIN1xqW7XZPtqvWnWLXBS/soDqjx9LKw=;
 b=IFqAd+YeN47nmlNmXDiYsCSLFZkE/AkyX2nK89S0uPbohujrNERThcTaGSOHu3RzOL8Svy
 sKp38E/JOANngPoq9QZOX3RXKuYYuG2Hb/Q6e1irvTsRkMyNuHz/aHESMZZqJJfNUIHPwm
 8MAxEjnB2+Hl5wZS+C+lZKzv/mX3o7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-Drepa_KGO82XiIrPUqPbaA-1; Thu, 08 Oct 2020 12:50:15 -0400
X-MC-Unique: Drepa_KGO82XiIrPUqPbaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4760F1062720
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 16:50:14 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90E4B19D7D;
 Thu,  8 Oct 2020 16:50:13 +0000 (UTC)
Subject: Re: [PATCH v5 03/36] qapi-gen: Separate arg-parsing from generation
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-4-jsnow@redhat.com>
 <877ds2jw6t.fsf@dusky.pond.sub.org>
 <007985f2-2872-1ab7-16aa-19414ba8cc78@redhat.com>
 <87d01t43de.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <b062539d-622b-ea0c-f6b0-8f71774d1875@redhat.com>
Date: Thu, 8 Oct 2020 12:50:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87d01t43de.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 2:51 AM, Markus Armbruster wrote:
> It can be executed by any process.  See execve(2):
> 
>         pathname must be either a binary executable, or a script starting  with
>         a line of the form:
> 
>             #!interpreter [optional-arg]
> 
>         For details of the latter case, see "Interpreter scripts" below.
> 
> "Entry point" makes sense in Python context, "script entry point" also
> makes sense (since every Python program is a script, script is
> redundant, but not wrong).  "Shell script entry point" is misleading.

You know, I don't think I was actually explicitly aware that the #! 
shebang was not something the shell actually processed itself. Always 
learning new things.

(No, I don't think I have ever execve'd something that wasn't a binary.)

"entry point" is a little vague, an entry point for what? by whom? I was 
trying to call attention to the idea specifically that main() was 
intended as python's "console script entry point", but used the word 
"shell" instead.

"console script entrypoint" is also a lot of jargon. What I really want 
to communicate is: "When you run `qapi-gen` on your command-line, this 
is the function that runs!"

So I guess something like:

"qapi-gen executable entry point." will suffice. Please further adjust 
to your liking when staging.

--js


