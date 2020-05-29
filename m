Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 06:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AC12074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 06:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA96mKWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AC12074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeYyD-0007Di-LI
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 02:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeYxE-0005r4-2l
 for qemu-devel@nongnu.org; Fri, 29 May 2020 02:57:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeYxB-0003Do-CW
 for qemu-devel@nongnu.org; Fri, 29 May 2020 02:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590735436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Xldoz2VXICzp9M9jMEBN3dnzdtVGVvd1JVzTpFBIf4k=;
 b=GA96mKWpvJ2/mJtlgYkVnUYD/qYnSUkAwYOvJRCH24Z4md58CiiDEzNAVotId88SJAmhAb
 SBJ7FJ5wngU0VM7eCgJskux/eEtz3ocNuS/+2MiYqHyODN+NuMo7YuVMP07Rik09YlYqZU
 2hYuSJKuSsM0aRxm6JtlExw+Jj/FYtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-CxpfI7s-NwyUNUbGN-d9BA-1; Fri, 29 May 2020 02:57:14 -0400
X-MC-Unique: CxpfI7s-NwyUNUbGN-d9BA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87A0B80B700;
 Fri, 29 May 2020 06:57:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E19019930;
 Fri, 29 May 2020 06:57:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF620113864A; Fri, 29 May 2020 08:57:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: QMP qom-get feels useless for child properties
Date: Fri, 29 May 2020 08:57:11 +0200
Message-ID: <87lflbns8o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>,
 =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QMP qom-get for a link property returns the canonical path of the link's
target:

    $ socat "READLINE,history=$HOME/.qmp_history,prompt=QMP> " UNIX-CONNECT:$HOME/work/images/test-qmp
    [...]
    QMP> {"execute": "qom-get", "arguments": {"path": "/machine", "property": "acpi-device"}}
    {"return": "/machine/unattached/device[23]"}

This makes sense.

Fine print: it returns "" for dangling links, I think.  See
object_get_link_property().

qom-get behaves the same for child properties:

    QMP> {"execute": "qom-get", "arguments": {"path": "/machine", "property": "peripheral"}}
    {"return": "/machine/peripheral"}

This surprised me.  I'm writing to the list in the hope of saving
somebody else the surprise and the time to figure out what's going on
here.

Returning the canonical path feels useless here.  The only explanation
that comes to my mind is we have to return something, the canonical path
is something, therefore we have to return it ;)

Fine print: child properties cannot dangle.  See
object_get_child_property().

To get the actual contents, you need to use another command:

    QMP> {"execute": "qom-list", "arguments": {"path": "/machine/peripheral"}}
    {"return": [{"name": "type", "type": "string"}, {"name": "vga", "type": "child<VGA>"}, {"name": "nic.0", "type": "child<virtio-net-pci>"}, {"name": "ide2", "type": "child<ide-cd>"}, {"name": "vd0", "type": "child<virtio-blk-pci>"}]}

You either just know that /machine/peripheral is a child property, or
you recognize the pattern "type": "child<T>" in output of qom-list one
level up:

    QMP>{"execute":"qom-list","arguments":{"path":"/machine"}}
    {"return": [... {"name": "peripheral", "type": "child<container>"}, ...]}

I believe ad hoc matching of type strings is necessary in other cases to
make sense of qom-get output.

I wish QOM introspection described types like QAPI introspection does.
Sadly, -ENOTIME.


