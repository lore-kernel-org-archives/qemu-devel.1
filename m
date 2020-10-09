Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCBCC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7324D2222F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSa/wX1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7324D2222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmbw-0005OY-EI
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQmaG-0004BF-HR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQmaD-0004LW-9a
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602227571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bYDzLVPZryRpoFbK9HOlLMHnlPBmOLrNRl4LA8ozPI=;
 b=TSa/wX1K76QC2lIEC2scB3+Nbbgi72iWdlPLmKu+kt1pVR3yIQq7twMyjY0+vm8iG3MKrK
 CrgpOJRx1JF6a7dxuIbJNifQo6H+uidxlc5hs+LnCCSsKEoAPMwykcIFRvxus6AGtSlOq6
 a1B38UvDQvv691pwUl9Wu8Y1wrX2GBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-e1jKZCQqMJ-JFMqGQuodIA-1; Fri, 09 Oct 2020 03:12:49 -0400
X-MC-Unique: e1jKZCQqMJ-JFMqGQuodIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B72B0802B51
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 07:12:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87A8060E1C;
 Fri,  9 Oct 2020 07:12:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05845112CE10; Fri,  9 Oct 2020 09:12:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 03/36] qapi-gen: Separate arg-parsing from generation
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-4-jsnow@redhat.com>
 <877ds2jw6t.fsf@dusky.pond.sub.org>
 <007985f2-2872-1ab7-16aa-19414ba8cc78@redhat.com>
 <87d01t43de.fsf@dusky.pond.sub.org>
 <b062539d-622b-ea0c-f6b0-8f71774d1875@redhat.com>
Date: Fri, 09 Oct 2020 09:12:46 +0200
In-Reply-To: <b062539d-622b-ea0c-f6b0-8f71774d1875@redhat.com> (John Snow's
 message of "Thu, 8 Oct 2020 12:50:13 -0400")
Message-ID: <87imbjrhxt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/8/20 2:51 AM, Markus Armbruster wrote:
>> It can be executed by any process.  See execve(2):
>>
>>         pathname must be either a binary executable, or a script starting  with
>>         a line of the form:
>>             #!interpreter [optional-arg]
>>         For details of the latter case, see "Interpreter scripts"
>> below.
>>
>> "Entry point" makes sense in Python context, "script entry point" also
>> makes sense (since every Python program is a script, script is
>> redundant, but not wrong).  "Shell script entry point" is misleading.
>
> You know, I don't think I was actually explicitly aware that the #!
> shebang was not something the shell actually processed itself. Always 
> learning new things.
>
> (No, I don't think I have ever execve'd something that wasn't a binary.)

I'm sure you've done it countless times, just not knowingly :)

> "entry point" is a little vague, an entry point for what? by whom? I
> was trying to call attention to the idea specifically that main() was 
> intended as python's "console script entry point", but used the word
> "shell" instead.
>
> "console script entrypoint" is also a lot of jargon. What I really

It is.

If I didn't find "console script" so thoroughly misguided, I'd advie you
to stick to it just because it's what we found in Python's docs.  It's
misguided, because this entry point is the one and only entry point for
*any* kind of Python executable program, be it console, GUI, or
whatever.

> want to communicate is: "When you run `qapi-gen` on your command-line,
> this is the function that runs!"
>
> So I guess something like:
>
> "qapi-gen executable entry point." will suffice. Please further adjust
> to your liking when staging.

Works for me.


