Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FC8C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 12:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E50B21707
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 12:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NA0NfqF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E50B21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jp9rO-00006c-Bm
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 08:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp9qj-0007y5-Gt
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 08:22:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30374
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp9qh-0005rq-SU
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 08:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593260543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaVprD8Ftz5/0v7U7e9X5wy0OfkoFg6jOgctenkuGRw=;
 b=NA0NfqF3aAqT+I+RammG+S/Yu/ENVh6VuWjmU2wHsIhVbkVLnhablbikydcSbPHWjN2oMs
 JrAYi1YtriUHtU99cEB7Yi2wskttBb3f+g4rJq+xFq6ZBvacyCCqrfiRlon3sNl/tPalSr
 +JOB+PwYqR7k37pEevA+MnNc/9n6anI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-rhvIaRmFMPevaWQHDxbRGQ-1; Sat, 27 Jun 2020 08:22:18 -0400
X-MC-Unique: rhvIaRmFMPevaWQHDxbRGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E18E418B9FC4;
 Sat, 27 Jun 2020 12:22:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB9375D9D7;
 Sat, 27 Jun 2020 12:22:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 38F7011384A6; Sat, 27 Jun 2020 14:22:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 00/16] Crazy shit around -global (pardon my french)
References: <20200622094227.1271650-1-armbru@redhat.com>
 <c0d6ea24-eb20-3d99-ae02-1d762fd6c9dd@redhat.com>
 <87zh8r7nzd.fsf@dusky.pond.sub.org>
 <3ca757d9-39ff-677e-8062-729c3cb9db42@redhat.com>
Date: Sat, 27 Jun 2020 14:22:16 +0200
In-Reply-To: <3ca757d9-39ff-677e-8062-729c3cb9db42@redhat.com> (John Snow's
 message of "Fri, 26 Jun 2020 11:11:04 -0400")
Message-ID: <874kqwr953.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 07:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com, mreitz@redhat.com,
 David Alan Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: David for insurance against me spewing nonsense about migration.

John Snow <jsnow@redhat.com> writes:

> On 6/25/20 12:45 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> On 6/22/20 5:42 AM, Markus Armbruster wrote:
>>>> There are three ways to configure backends:
>>>>
>>>> * -nic, -serial, -drive, ... (onboard devices)
>>>>
>>>> * Set the property with -device, or, if you feel masochistic, with
>>>>   -set device (pluggable devices)
>>>>
>>>> * Set the property with -global (both)
>>>>
>>>> The trouble is -global is terrible.
>>>>
>>>> It gets applied in object_new(), which can't fail.  We treat failure
>>>> to apply -global as fatal error, except when hot-plugging, where we
>>>> treat it as warning *boggle*.  I'm not addressing that today.
>>>>
>>>> Some code falls apart when you use both -global and the other way.
>>>>
>>>> To make life more interesting, we gave -drive two roles: with
>>>> interface type other than none, it's for configuring onboard devices,
>>>> and with interface type none, it's for defining backends for use with
>>>> -device and such.  Since we neglect to require interface type none for
>>>> the latter, you can use one -drive in both roles.  This confuses the
>>>> code about as much as you, dear reader, probably are by now.
>>>>
>>>> Because this still isn't interesting enough, there's yet another way
>>>> to configure backends, just for floppies: set the floppy controller's
>>>> property.  Goes back to the time when floppy wasn't a separate device,
>>>> and involves some Bad Magic.  Now -global can interact with itself!
>>>>
>>>> Digging through all this took me an embarrassing amount of time.
>>>> Hair, too.
>>>>
>>>> My patches reject some the silliest uses outright, and deprecate some
>>>> not so silly ones that have replacements.
>>>>
>>>> Apply on top of my "[PATCH v2 00/58] qdev: Rework how we plug into the
>>>> parent bus".
>>>>
>>>
>>> Oof. Thank you for your work in fixing our darkest corners. I sincerely
>>> appreciate it.
>>>
>>> The qdev tree ordering problems don't cause any issues for migration, do
>>> they?
>> 
>> This series should only change device configuration, not device state or
>> its encoding in the migration stream.
>> 
>> I'm not sure what you mean by "qdev tree ordering problems".  Ist it
>> commit e8c9e65816 'qom: Make "info qom-tree" show children sorted'?
>> 
>>> (I see you already sent a PR, so whatever!)
>> 
>> A question that might avoid a later migration debugging session is
>> *never* "whatever"!
>> 
>
> I thought I had read that one of these patches changes the order in
> which devices get instantiated, which I thought might change their QOM
> paths. Which I thought *might* have some ramifications for migration,
> but wasn't sure.

Device instantiation order changes should not break migration.

The order in which devices appear in the migration stream should not
matter.

> If it's just showing the same path outputs *sorted*, then there's no
> problem.
>
> Likely misread.
>
> --js


