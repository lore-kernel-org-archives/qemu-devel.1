Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DB4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 10:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01D620679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 10:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YU+yR+nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01D620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgQsK-0004a4-0h
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 06:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jgQrj-0004Am-9S
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 06:43:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jgQrh-0006OF-8P
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 06:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591180999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0TaQ3rQyHLhBjcQqM4MI5YgRhjrnGw1rybXjZkDKTZE=;
 b=YU+yR+nmtQNybRNVnZBm6DI2Pv8xod2Sua72O5w/3tbKC1rx5lqKYHUhW6YGVmmv8hJh/R
 S7W/XRKyjNkImnyC0W8AlVv4RVq/LnV417yD3VqdINt1FBaEGIxTF1nWE6AVqDGe54Vm2A
 5479RdbSzC+13wnqFPoBQEWJbVa+G3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-LgDe0rA-Pai-Zc3HApjhxQ-1; Wed, 03 Jun 2020 06:43:17 -0400
X-MC-Unique: LgDe0rA-Pai-Zc3HApjhxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 981AE8015CE;
 Wed,  3 Jun 2020 10:43:16 +0000 (UTC)
Received: from work-vm (ovpn-115-9.ams2.redhat.com [10.36.115.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE08860C81;
 Wed,  3 Jun 2020 10:43:09 +0000 (UTC)
Date: Wed, 3 Jun 2020 11:43:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PULL 04/12] hmp: Simplify qom-set
Message-ID: <20200603104306.GC2974@work-vm>
References: <20200601184004.272784-1-dgilbert@redhat.com>
 <20200601184004.272784-5-dgilbert@redhat.com>
 <87pnai7ymz.fsf@dusky.pond.sub.org> <20200602092601.GD2758@work-vm>
 <847cb8b5-1507-46cf-495a-952d41a3c2b2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <847cb8b5-1507-46cf-495a-952d41a3c2b2@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 23:55:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, lukasstraub2@web.de, quintela@redhat.com,
 qemu-devel@nongnu.org, pannengyuan@huawei.com, f4bug@amsat.org,
 Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 02.06.20 11:26, Dr. David Alan Gilbert wrote:
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> >>
> >>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>>
> >>> Simplify qom_set by making it use qmp_qom_set and the JSON parser.
> >>>
> >>> (qemu) qom-get /machine smm
> >>> "auto"
> >>> (qemu) qom-set /machine smm "auto"
> >>>
> >>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>> Message-Id: <20200520151108.160598-3-dgilbert@redhat.com>
> >>> Reviewed-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> >>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>>   With 's'->'S' type change suggested by Paolo and Markus
> >>
> >> This is actually more than just simplification, it's disarming a bear
> >> trap: the string visitor is restricted to a subset of the QAPI types,
> >> and when you qom-set a property with a type it can't handle, QEMU
> >> aborts.  I mentioned this in the discussion of possible ways out of the
> >> qom-get impasse, but missed reraising it in patch review.
> >>
> >> A suitably amended commit would be nice, but respinning the PR just for
> >> that may not be worthwhile.
> > 
> > A bit late; still as long as we're removing bear traps not adding them.
> 
> This breaks qom-set for my (virtio-mem) use case:
> 
> echo "qom-set vm0 requested-size 300M" | sudo nc -U /var/tmp/mon_src
> QEMU 5.0.50 monitor - type 'help' for more information
> (qemu) qom-set vm0 requested-size 300M
> Error: Expecting at most one JSON value

Does qom-set vm0 requested-size 300e6 do the same thing?

Dave

> 
> -- 
> Thanks,
> 
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


