Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E01C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03472076A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nt3jyuzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03472076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXfTn-00036a-BX
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 03:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXfSx-0002Y2-Og
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 03:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXfSv-0007wm-D5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 03:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603868507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tSjo56HQI/YDsuYxXlxaMHjPKsq6AwfWrwmZayP/LTI=;
 b=Nt3jyuzvvn6Wu2ooy1f3iOc54yUhIHIXAlc+/vRUDg8l9Nn5e4HyGz2cW+gzOVhXAteZjl
 GR2kH7J5o9REQPO+ADfNlvyYpMwKKOm8nJKeKYzR0Ja5YQb0B3OhJgKvbnXqIi+Om0HxAY
 93ECjqzSb2vmI4qwoRo8kipTDqYELv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-i7QGiqfnP--VmLO8_WF_9A-1; Wed, 28 Oct 2020 03:01:45 -0400
X-MC-Unique: i7QGiqfnP--VmLO8_WF_9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B02D480B73B;
 Wed, 28 Oct 2020 07:01:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 244D46266E;
 Wed, 28 Oct 2020 07:01:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7ACD0113865F; Wed, 28 Oct 2020 08:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/4] qemu-storage-daemon: QAPIfy --chardev the stupid way
References: <20201026101005.2940615-1-armbru@redhat.com>
 <d00ef574-b2c4-887c-6a37-79f6cf6eeae0@redhat.com>
Date: Wed, 28 Oct 2020 08:01:39 +0100
In-Reply-To: <d00ef574-b2c4-887c-6a37-79f6cf6eeae0@redhat.com> (Paolo
 Bonzini's message of "Tue, 27 Oct 2020 19:36:22 +0100")
Message-ID: <87a6w63kbw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 26/10/20 11:10, Markus Armbruster wrote:
>> Kevin's "[PATCH v2 0/6] qemu-storage-daemon: QAPIfy --chardev"
>> involves surgery to the QAPI generator.  Some (most?) of it should go
>> away if we deprecate the "data" wrappers due to simple unions in QMP.
>> 
>> Do we really need to mess with the code generator to solve the problem
>> at hand?
>> 
>> 
>> Let's recapitulate the problem:
>> 
>> * We want to QAPIfy --chardev, i.e. define its argument as a QAPI
>>   type.
>
> Considering that this is not 5.2 stuff at this point, I would like to
> suggest again moving chardevs to -object, and ask you to evaluate that
> option with the agreement that I do the work instead of you. :)

Replacing -chardev with -object without regressing features would be
lovely.  One feature in particular: introspection.

If we manage to fully QAPIfy -object, we should be good.  I understand
Eduardo is cutting a path through the jungle.

I can offer assistance with bridging QAPI schema to QOM.


