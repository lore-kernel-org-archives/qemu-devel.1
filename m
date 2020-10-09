Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6ABC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E877222244
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpoIilwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E877222244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmiB-0000Se-TU
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQmhC-0008P3-9A
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQmh8-00059c-RU
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602228001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+svfVBOG91qnO3OQ7BKlovbh3P9TDuuqfJlrVJSzVk=;
 b=DpoIilwUY4UXCpfz7y0VvVsvhkPyrnW2G1eWb+rzOfb/4lEZ/IZUlqsCvmAcT0OISL0tz2
 t35H9LPzt7PYrKL3LrQQK6+WogsSLh2s72luPI5JEPpVc8T++3//yziJZPO3SFCp+kLx85
 St6SjQE324xh2lA+fh/rKJzRqFH0eig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-LN76nhIpOMa_vSBOl2DdZQ-1; Fri, 09 Oct 2020 03:19:59 -0400
X-MC-Unique: LN76nhIpOMa_vSBOl2DdZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8510280401A
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 07:19:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5262D5C1DA;
 Fri,  9 Oct 2020 07:19:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D77B8112CE10; Fri,  9 Oct 2020 09:19:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 03/36] qapi-gen: Separate arg-parsing from generation
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-4-jsnow@redhat.com>
 <87r1qaihen.fsf@dusky.pond.sub.org>
 <50e590af-deff-3864-9abd-710a30eaa804@redhat.com>
 <878sch429q.fsf@dusky.pond.sub.org>
 <98cec6c2-fd10-42f5-873d-ae6748d2feff@redhat.com>
Date: Fri, 09 Oct 2020 09:19:56 +0200
In-Reply-To: <98cec6c2-fd10-42f5-873d-ae6748d2feff@redhat.com> (John Snow's
 message of "Thu, 8 Oct 2020 13:14:47 -0400")
Message-ID: <87eem7rhlv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/8/20 3:15 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> On 10/7/20 4:12 AM, Markus Armbruster wrote:
>>>> I keep stumbling over things in later patches that turn out to go back
>>>> to this one.
>>>> John Snow <jsnow@redhat.com> writes:
>>>>
>>>>> This is a minor re-work of the entrypoint script. It isolates a
>>>>> generate() method from the actual command-line mechanism.
>>>>>
>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>>>> Tested-by: Cleber Rosa <crosa@redhat.com>
>>>>> ---
>>>>>    scripts/qapi-gen.py | 85 +++++++++++++++++++++++++++++++++------------
>>>>>    1 file changed, 62 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>>>>> index 541e8c1f55d..117b396a595 100644
>>>>> --- a/scripts/qapi-gen.py
>>>>> +++ b/scripts/qapi-gen.py
>>>>> @@ -1,30 +1,77 @@
>>>>>    #!/usr/bin/env python3
>>>>> -# QAPI generator
>>>>> -#
>>>>> +
>>>>>    # This work is licensed under the terms of the GNU GPL, version 2 or later.
>>>>>    # See the COPYING file in the top-level directory.
>>>>>    +"""
>>>>> +QAPI Generator
>>>>> +
>>>>> +This script is the main entry point for generating C code from the QAPI schema.
>>>> PEP 8: For flowing long blocks of text with fewer structural
>>>> restrictions (docstrings or comments), the line length should be limited
>>>> to 72 characters.
>>>>
>>>
>>> Eugh. OK, but I don't have a good way to check or enforce this,
>>> admittedly. I have to change my emacs settings to understand this when
>>> I hit the reflow key. I don't know if the python mode has a
>>> context-aware reflow length.
>>>
>>> ("I don't disagree, but I'm not immediately sure right now how I will
>>> make sure I, or anyone else, complies with this. Low priority as a
>>> result?")
>> 
>> Emacs Python mode is close enough by default: fill-paragraph (bound to
>> M-q) uses variable fill-column, which defaults to 70.  If you want the
>> extra two columns PEP 8 grants you, I can show you how to bump it to 72
>> just for Python mode.
>> 
>> You can use fill-paragraph for code, too.  I don't myself, because I
>> disagree with its line breaking decisions too often (and so does PEP 8).
>> A better Python mode would break code lines more neatly, and with the
>> width defaulting to 79.
>
> Yeah, how do I set the reflow to 72 for specific modes?
>
> I tend to do a lot of refactoring and "prototyping" in Pycharm, but
> when it comes to bread and butter edits I still prefer emacs. I kinda
> bounce between 'em a lot. Having emacs DTRT is still useful to me.

In your .emacs:

    (add-hook 'python-mode-hook
              (lambda () (setq fill-column 72)))


Happy to explain this in detail if you're curious.

[...]


