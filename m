Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89701C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD6522268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUgyOX/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD6522268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kURBf-0004uP-EF
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUR9l-0003dK-J2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUR9j-000633-FC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603098518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/EroG+YMzt/peYN+rgs2bNi9+VHUIsE1/4RZLuQZ7zg=;
 b=MUgyOX/xGvo48q4FHTH1/acy6EcCFiQuwQwHNe9wQ+sb6sGy2dp5oaJDNw/T9iqYXl/kSx
 EAhlK26sTUy/BAHfzL+Ox6RA9bInecej0AwfmfZV2axiveLygqGeR7VofnKa+lOCYVxG4x
 bfWG5JWzNtbtKELGSDvAXbNSxjKUVL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-pIE123nNOxarGruKJ3QSyg-1; Mon, 19 Oct 2020 05:08:36 -0400
X-MC-Unique: pIE123nNOxarGruKJ3QSyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 168268030A3;
 Mon, 19 Oct 2020 09:08:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAEA65577A;
 Mon, 19 Oct 2020 09:08:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7137D1132A08; Mon, 19 Oct 2020 11:08:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 0/7] qemu-storage-daemon: Remove QemuOpts from --object
References: <20201011073505.1185335-1-armbru@redhat.com>
 <20201012143908.GF7777@merkur.fritz.box>
Date: Mon, 19 Oct 2020 11:08:33 +0200
In-Reply-To: <20201012143908.GF7777@merkur.fritz.box> (Kevin Wolf's message of
 "Mon, 12 Oct 2020 16:39:08 +0200")
Message-ID: <87sgaazipa.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 11.10.2020 um 09:34 hat Markus Armbruster geschrieben:
>> This replaces the QemuOpts-based help code for --object in the storage
>> daemon with code based on the keyval parser.
>> 
>> Review of v3 led me to preexisting issues.  Instead of posting my
>> fixes separately, then working with Kevin to rebase his work on top of
>> mine, I did the rebase myself and am posting it together with my fixes
>> as v4.  Hope that's okay.
>> 
>> Note: to test qemu-storage-daemon --object help, you need Philippe's
>> "[PATCH v3] hw/nvram: Always register FW_CFG_DATA_GENERATOR_INTERFACE"
>> and its prerequisites (first 10 patches of Paolo's "[PULL 00/39] SCSI,
>> qdev, qtest, meson patches for 2020-10-10"), so it doesn't crash with
>> "missing interface 'fw_cfg-data-generator' for object 'tls-creds'".
>
> Thanks, fixed up the typos in patch 4 and applied patches 1-4. I'm
> taking patches 5-7 from my original series because you didn't add your
> S-o-b (they are unchanged anyway, so no practical difference).

Makes sense.  I didn't feel like slapping my S-o-b on patches I reposted
unchanged.

Thanks!


