Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EDBCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4690F2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwH2RCJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4690F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYrts-000752-LT
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 09:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYrtJ-0006TH-IH
 for qemu-devel@nongnu.org; Wed, 13 May 2020 09:57:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28646
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYrtI-0001JS-8J
 for qemu-devel@nongnu.org; Wed, 13 May 2020 09:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589378263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IsicyNVYbYc8Wxhua+Cexf128j3n2UnFOKw+GZNHfOY=;
 b=QwH2RCJLdv+sDqrRsUfclzl83Qg2trpelYpgFqKlzFvQQkx8U5Rdcsc86hvxdNHbZz1dWG
 bU5L8v03T1gEW+kBejqLPbLHes54AIeDuQHu7N/W5OPo91xbfLMKgTqOzoxT9on8UwNt8O
 zEaOmt05Hd2tpqT1mbB3OCM/x3cFQcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-TBCMOTXDMyiBGvjaBchytg-1; Wed, 13 May 2020 09:57:38 -0400
X-MC-Unique: TBCMOTXDMyiBGvjaBchytg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC5BF8018A7;
 Wed, 13 May 2020 13:57:37 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 346D439E;
 Wed, 13 May 2020 13:57:34 +0000 (UTC)
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com> <20200511154645.GI2811@work-vm>
 <20200512113206.62836e44@luklap> <20200512094337.GK1191162@redhat.com>
 <20200513103245.GD6202@linux.fritz.box> <20200513105359.GF3225@work-vm>
 <20200513111320.GE6202@linux.fritz.box> <20200513125624.GJ3225@work-vm>
 <20200513130849.GD1253949@redhat.com> <20200513134856.GK3225@work-vm>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0185c988-33d9-382c-11cc-2e24cc990c18@redhat.com>
Date: Wed, 13 May 2020 08:57:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513134856.GK3225@work-vm>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 8:48 AM, Dr. David Alan Gilbert wrote:

>>> Yeh I worry about whether on nbd if you can have multiple nbd
>>> connections to one block device.
>>
>> The kernel NBD driver now supports multiple parallel connections.
>> QEMU hasn't implemented this in its NBD code yet, but I certainly
>> see that being in scope for future.
> 
> It's not parallel for performance that worries me, it's more about
> separateq connections for separate uses - e.g. if we're serving the same
> read-only disk to multiple separate things.

qemu allows multiple simultaneous NBD clients, but does not promise 
cache consistency between them.  As long as all the clients are 
read-only, you can't tell the difference (and thus, for read-only 
connections, qemu even advertises NBD_FLAG_CAN_MULTI_CONN per the NBD 
spec).  See also 'qemu-nbd -e' for controlling how many clients qemu-nbd 
will permit at once (when qemu proper is serving NBD, we don't currently 
expose a knob over QMP to control client count, but instead just blindly 
allow multiple connections).  But as soon as one of the clients wants to 
write, that is where we would need to improve code before making it 
safe, so there, we do not advertise MULTI_CONN support.

As for cases with multiple simultaneous clients: we already have those. 
In the case of incremental backups with an NBD export, my demo code for 
copying out the incremental backup involved two parallel NBD clients - 
one using 'qemu-img map' to probe which portions of the image were 
dirty, and a second client actually performing the reads.  But 
incremental backups are read-only situations (the clients are not 
modifying qemu state).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


