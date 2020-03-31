Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC4BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7616020786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNewfFjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7616020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIgB-0007lb-K2
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJIeO-0006UQ-Up
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJIeK-0005Xd-MM
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:18:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36357
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJIeK-0005XE-HQ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585667875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3wpkcqdprPCnSEkq/jpVDyO4r7oYUD+dIjVpmhPAj8=;
 b=aNewfFjCzqu9/90zh4BEPHGp738weK+kR6/2PDM++A6dmCbjFtsYfjTdkeZt22FQHUCycj
 35IsAjEUIPZ9pwnzitUGLngtsrShWSW4W2uLCLyA1xOMaRRrW3OZRxInHFTmY0YA61zGsE
 tEsw9qa0lBe+V1ZcMJqyyKJSkaA067U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-gJFC3VzaNN-b7eJpwCuSxg-1; Tue, 31 Mar 2020 11:17:51 -0400
X-MC-Unique: gJFC3VzaNN-b7eJpwCuSxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19FD8801A01;
 Tue, 31 Mar 2020 15:17:50 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B516860BE0;
 Tue, 31 Mar 2020 15:17:49 +0000 (UTC)
Subject: Re: [PATCH 1/3] crypto: Add qcrypto_tls_shutdown()
To: Markus Armbruster <armbru@redhat.com>
References: <20200327161936.2225989-1-eblake@redhat.com>
 <20200327161936.2225989-2-eblake@redhat.com>
 <87ftdp3ozl.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9491a050-e873-dcf0-8fa0-6f4316bcf06a@redhat.com>
Date: Tue, 31 Mar 2020 10:17:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87ftdp3ozl.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 3:30 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> Gnutls documents that applications that want to distinguish between a
>> clean end-of-communication and a malicious client abruptly tearing the
>> underlying transport out of under our feet need to use gnutls_bye().
>> Our channel code is already set up to allow shutdown requests, but we
>> weren't forwarding those to gnutls.  To make that work, we first need
>> a new entry point that can isolate the rest of our code from the
>> gnutls interface.
>>

>> +int qcrypto_tls_session_shutdown(QCryptoTLSSession *session,
>> +                                 QCryptoShutdownMode how)

> 
> This is a thin wrapper around gnutls_bye().  I understand this is an
> abstraction layer backed by GnuTLS.  Not sure abstracting from just one
> concrete thing is a good idea, but that's way out of scope here.

If we ever add an alternative TLS implementation to gnutls, then the 
abstraction is useful.  But I'm not sure how likely that is, so maybe 
Dan has more insight why he chose this design originally.

> 
> In scope: why do you need QCryptoShutdownMode be a QAPI type?

I don't, other than the fact that other TLS parameters were also QAPI 
types (such as QCryptoTLSCredsEndpoint).

But that may be moot, as Dan argued that this series adds more 
complexity than it is worth (I originally wrote it while trying to debug 
an nbdkit bug; but in the meantime, I have fixed the nbdkit bug without 
any change to qemu behavior).  So at this point, I will probably not be 
posting a v2 of this series.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


