Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461E9C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE9C20730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEkjZUfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE9C20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izWMW-0006vm-9d
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izWLh-0006JA-7n
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izWLg-0006k8-2Z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:52:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51032
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izWLf-0006gI-T5
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580953975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APy/drKfq7VRnQwpEzWdtfKUfAz389JIEHVp4gShIfA=;
 b=bEkjZUfU4sVqYcCvJA8IUICxA2nua1E++8fhJ5MiQncida0n21atoW9zBKkD+ChgvIiazd
 +QX1OgrxVKFoDOFR3Bc5i3yeYZpWeustGU8tzet1Izyo+UjhD/1fku3pJAJ0QyqqocT4QM
 A+nAUIq5/mipdPeJycNIi04D2x2X/4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-gsv9VSAsMVi06F9lTtFtTQ-1; Wed, 05 Feb 2020 20:52:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E2F014E0;
 Thu,  6 Feb 2020 01:52:50 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2E011A7E3;
 Thu,  6 Feb 2020 01:52:49 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: David Edmondson <dme@dme.org>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
 <cunftfqsaat.fsf@gag-halfrunt.hh.sledj.net>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5465fed7-3bf3-9f92-495f-6537521d8e59@redhat.com>
Date: Wed, 5 Feb 2020 19:52:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cunftfqsaat.fsf@gag-halfrunt.hh.sledj.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gsv9VSAsMVi06F9lTtFtTQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 8:21 AM, David Edmondson wrote:
> On Tuesday, 2020-02-04 at 07:31:52 -06, Eric Blake wrote:
> 
>> On 2/4/20 3:52 AM, David Edmondson wrote:
>>> In many cases the target of a convert operation is a newly provisioned
>>> target that the user knows is blank (filled with zeroes). In this
>>
>> 'filled with zeroes' is accurate for a preallocated image, but reads
>> awkwardly for a sparse image; it might be better to state 'reads as zero'.
> 

>>> +++ b/docs/interop/qemu-img.rst
>>> @@ -214,6 +214,12 @@ Parameters to convert subcommand:
>>>      will still be printed.  Areas that cannot be read from the source will be
>>>      treated as containing only zeroes.
>>>    
>>> +.. option:: --target-is-zero
>>> +
>>> +  Assume that the destination is filled with zeros. This parameter is
>>
>> Spelled 'zeroes' just three lines earlier.
> 
> My understanding is that "zeros" is the correct plural of "zero" (and
> that "zeroes" relates to the use of "zero" as a verb), but perhaps
> that's another British English thing?
> 
> I don't care enough to fight about it.
> 

https://english.stackexchange.com/questions/3824/what-is-the-plural-form-of-zero 
says both zeros and zeroes are fine for the noun (with UK leaning more 
to zeros), but only zeroes for the verb; but also concedes that zeroes 
is gaining in popularity over time.  I likewise won't bother tweaking 
your patch (I see in v4 that you left it unchanged).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


