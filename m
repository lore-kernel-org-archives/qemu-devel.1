Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E0C4727F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0694620657
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDJ+1dmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0694620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMrca-0003Xa-SO
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 07:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMrau-0002kj-0E
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMram-0007Cn-0H
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:45:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601293511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4AwA/KpCXa0tcOBrSASYgJyFe3NXGarXr1NKun6Pw4=;
 b=RDJ+1dmZsQ6o/caA0wxadJFDrnc/TxiTpzpqm6Tj8+SBSru2FH2QKSL+WfLOE51RMe7CXk
 eBs1YhDskXKdUYdHMeJS846N+pZQEw8UjrOZX75RboJYAOdoG8U1qPASBO6AkKnTYhc0LH
 PCAASzTNOp/jo5K45zo/liSCpuPyYig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-XJaLIVcJMhGJ_3TC0Gq-jQ-1; Mon, 28 Sep 2020 07:45:09 -0400
X-MC-Unique: XJaLIVcJMhGJ_3TC0Gq-jQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCBA2186DD20;
 Mon, 28 Sep 2020 11:45:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5F4778828;
 Mon, 28 Sep 2020 11:45:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A109113865F; Mon, 28 Sep 2020 13:45:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 02/38] qapi-gen: Separate arg-parsing from generation
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-3-jsnow@redhat.com>
 <20200923000031.GB191229@localhost.localdomain>
 <87zh5et7hx.fsf@dusky.pond.sub.org>
 <c38cbc07-4878-ae05-8871-8cb1c46acde2@redhat.com>
Date: Mon, 28 Sep 2020 13:45:06 +0200
In-Reply-To: <c38cbc07-4878-ae05-8871-8cb1c46acde2@redhat.com> (John Snow's
 message of "Fri, 25 Sep 2020 11:37:10 -0400")
Message-ID: <87blhqi0ql.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/25/20 7:34 AM, Markus Armbruster wrote:
>> Cleber Rosa <crosa@redhat.com> writes:
>> 
>>> On Tue, Sep 22, 2020 at 05:00:25PM -0400, John Snow wrote:
>>>> This is a minor re-work of the entrypoint script. It isolates a
>>>> generate() method from the actual command-line mechanism.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
[...]
>>>> +def generate(schema_file: str,
>>>> +             output_dir: str,
>>>> +             prefix: str,
>>>> +             unmask: bool = False,
>>>> +             builtins: bool = False) -> None:
>>>> +    """
>>>> +    generate uses a given schema to produce C code in the target directory.
>>>> +
>>>> +    :param schema_file: The primary QAPI schema file.
>>>> +    :param output_dir: The output directory to store generated code.
>>>> +    :param prefix: Optional C-code prefix for symbol names.
>>>> +    :param unmask: Expose non-ABI names through introspection?
>>>> +    :param builtins: Generate code for built-in types?
>>>> +
>>>> +    :raise QAPIError: On failures.
>>>> +    """
>>>> +    match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
>>>> +    if match and match.end() != len(prefix):
>>>
>>> Nice catch with the extra check here.  Maybe worth mentioning and/or
>>> splitting the change?
>>
>> Please do not sneak additional checking into patches advertized as pure
>> refactoring.  It makes me look for more sneakery with a microscope.
>> 
>> This re.match() cannot possibly fail.  Three cases:
>> 
>> * First character is funny
>> 
>>   The regexp matches the empty string.  There's a reason the regexp ends
>>   with '?'.
>> 
>> * Non-first character is funny
>> 
>>   The regexp matches the non-funny prefix.
>> 
>> * No character is funny
>> 
>>   The regexp matches the complete string.
>> 
>> Checking impossible conditions as if they were possible is confusing.
>> Please drop the additional check.
>> 
>> We can talk about checking this impossible condition with
>> 
>>         assert(match)
>> 
>> if you believe it makes the code easier to understand (it does not
>> improve its behavior).
>
> My use of strict_optional=False is what prevents this from exhibiting
> as an error in mypy. An assert will help convince mypy that 'match'
> cannot possibly be 'None'.

Adding assertions to help mypy along is okay.

> eh, well. I will fix this when I remove strict_optional, so I will
> just remove this additional check for now to avoid adding another
> patch to this series.

Makes sense to me.


