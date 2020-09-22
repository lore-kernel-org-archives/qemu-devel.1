Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE6FC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 19:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293A12311C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 19:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuIA+8RZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293A12311C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKneu-0003gZ-Va
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 15:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKndc-0003Dn-Py
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 15:07:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKndZ-0006wW-Fz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 15:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600801656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BzXe18IsV1LrzEHTsIwXccyQAWc84p8PfOyFQSjMJA=;
 b=LuIA+8RZ8rqifrl7ma++uti4UgxCBymfxfJJODw0LplNkqvr9bMS1sekaMOb65l+aGWV3T
 0j/ETMjKsnuYZXx+BVRZydzKuJAZ10BXIxVJj/X+Oe4ahW6/MSNJgScULSsTtQtot/NmDk
 btF0Xnum2Adg7TlS2s6dUrVwMPcslTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-1eDlTZxLOVSIGaNakTkYzQ-1; Tue, 22 Sep 2020 15:07:34 -0400
X-MC-Unique: 1eDlTZxLOVSIGaNakTkYzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C84C71084D6E;
 Tue, 22 Sep 2020 19:07:32 +0000 (UTC)
Received: from work-vm (ovpn-115-25.ams2.redhat.com [10.36.115.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A58A75120;
 Tue, 22 Sep 2020 19:07:25 +0000 (UTC)
Date: Tue, 22 Sep 2020 20:07:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Anton Kuchin <antonkuchin@yandex-team.ru>, marcandre.lureau@redhat.com
Subject: Re: vhost-user: questions regarding migration
Message-ID: <20200922190722.GD2837@work-vm>
References: <6ef03e9e-aaff-ce20-7f61-0771fcf007eb@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <6ef03e9e-aaff-ce20-7f61-0771fcf007eb@yandex-team.ru>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 13:33:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Anton Kuchin (antonkuchin@yandex-team.ru) wrote:
> Hi,
> 
> I'm implementing migration support in vhost-user backend and have a
> couple of questions:

Hi Anton,
  I'ts a while since I've looked at this code, but from memory:

> 1. How master can be sure that logging was started?
> 
> We expect that right after set_fatures command with VHOST_F_LOG_ALL flag
> all memory modifications will be tracked in log, but slave can need a
> little time to process this command so there is a chance that some
> requests can be untracked. Is there a way to ensure all requests are
> logged or determine the moment since when tracking starts and master can
> start migrating memory?

I think it happens after the set_mem_table command; I think if the
command had the 'NEED_REPLY' flag set then the client responds to the
qemu to say the command is done.

> 2. Why do we need separate log_addr for vring and how can it be not
> covered by mem table?

Hmm I don't think I understand that question; isn't the vring covered by
the memtable?

> As far as I understand slave receives used address in set_vring_addr
> command and to map it correctly we do need valid entry in memory table.
> So this field looks redundant to me. Am I missing something?
> 
> BTW the word "log_guest_addr" is mentioned only once in the document and
> in "vring address description" payload it is just called "log",
> shouldn't we should change this names to match?

Let's cc in Marc-Andre.

Dave



-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


