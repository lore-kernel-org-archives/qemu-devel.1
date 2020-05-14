Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F919C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA462065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tpw/4gwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA462065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZBdT-0002pQ-Ub
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZBce-00021S-O8
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:01:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28499
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZBcd-00014R-JT
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589454110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dIuL+xHdygaGlyrct5zf6YrJ88NZnaRUoItUVyipGBg=;
 b=Tpw/4gwuo5pmQbZud2WiS+YGLg9ak2Vv5/Vo88y1DsapwRSGcA/FYaJ0PbnJ2GOeJWEtAi
 0uCu/ce/9m9HVHbuWkAycqMsFDqR3s3r8yWJGuYZeaGG2hARxlDfdKZNnknEkhmIiAf2x0
 hrsf+/eZV5Xh+B6u/EoV8QIIi/t2fYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-vrigNjghNqSc8dCrHP1IBg-1; Thu, 14 May 2020 07:01:48 -0400
X-MC-Unique: vrigNjghNqSc8dCrHP1IBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E0AD107ACCA;
 Thu, 14 May 2020 11:01:47 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 310FD82A0A;
 Thu, 14 May 2020 11:01:40 +0000 (UTC)
Date: Thu, 14 May 2020 12:01:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200514110137.GH2787@work-vm>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200513211235.4d0711d1@luklap>
MIME-Version: 1.0
In-Reply-To: <20200513211235.4d0711d1@luklap>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
> Terminology:
> instance = one (nbd) blockdev/one chardev/the single migrationstate
> connection = one TCP connection
> 
> Hello Everyone,
> Having read all the comments, here is proposal v2:
> Every instance registers itself with a unique name in the form "blockdev:<node-name>", "chardev:<chardev-name>" and "migration" using yank_register_instance which will do some sanity checks like checking if the same name exists already. Then (multiple) yank functions can be registered as needed with that single name. When the instance exits/is removed, it unregisters all yank functions and unregisters it's name with yank_unregister_instance which will check if all yank functions where unregistered.
> Every instance that supports the yank feature will register itself and the yank functions unconditionally (No extra 'yank' option per instance).
> The 'query-yank' oob qmp command lists the names of all registered instances.
> The 'yank' oob qmp command takes a list of names and for every name calls all yank functions registered with that name. Before doing anything, it will check that all names exist.
> 
> If the instance has multiple connections (say, migration with multifd), i don't think it makes much sense to just shutdown one connection. Calling 'yank' on a instance will always shutdown all connections of that instance.

Agreed.

> Yank functions are generic and in no way limited to connections. Say, if migration is started to an 'exec:' address, migration could register a yank function to kill that external command on yank (Won't be implemented yet though).

One thing we need to be care of is that the yank functions stay suitable
for OOB calling.

Dave

> Regards,
> Lukas Straub


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


