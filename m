Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EF120873
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frWeIoLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EF120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduXw-0004Jl-48
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jduXL-0003or-2W
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:47:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41562
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jduXJ-0005vW-Gf
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590580071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vHaFoexjr9OAVa1ZOFucS+I4E6wQdIFIfMEumIDCFRw=;
 b=frWeIoLzy7gvZNDk7KnvrGocEUCZKw1B2IjFypQVRqcZNpj+qJNYtddVFktEuQa5xAbK2w
 8sGHVR1Ot4cYOjDA8DZCEIT5DkjHgBuMAT/uE5APTomYki5LaEzqBg+9EP1bsC+K4CnW4W
 csjj6L7BoQ9gVnUxWXKQjzzbBCt5kco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-FDpg5iZGNQmz9qQuUFwW0g-1; Wed, 27 May 2020 07:47:50 -0400
X-MC-Unique: FDpg5iZGNQmz9qQuUFwW0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF855BFCE;
 Wed, 27 May 2020 11:47:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4789691D98;
 Wed, 27 May 2020 11:47:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2AF5113864A; Wed, 27 May 2020 13:47:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] arm/aspeed: Rework NIC attachment
References: <20200526070802.160897-1-clg@kaod.org>
Date: Wed, 27 May 2020 13:47:46 +0200
In-Reply-To: <20200526070802.160897-1-clg@kaod.org> (=?utf-8?Q?=22C=C3=A9d?=
 =?utf-8?Q?ric?= Le Goater"'s
 message of "Tue, 26 May 2020 09:08:02 +0200")
Message-ID: <871rn5r44d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> The number of MACs supported by an Aspeed SoC is defined by "macs_num"
> under the SoC model, that is two for the AST2400 and AST2500 and four
> the AST2600. The model initializes the maximum number of supported
> MACs but the number of realized devices is caped by the number of

s/caped/capped/

> network device back-ends defined on the command line. This can leave
> unrealized devices hanging around in the QOM composition tree.
>
> Modify the machine initialization to define which MACs are attached to
> a network device back-end using a bit-field property "macs-mask" and
> let the SoC realize all network devices.
>
> The default setting of "macs-mask" is "use MAC0" only, which works for
> all our AST2400 and AST2500 machines. The AST2600 machines have
> different configurations. The AST2600 EVB machine activates MAC1, MAC2
> and MAC3 and the Tacoma BMC machine activates MAC2.
>
> Inactive MACs will have no peer and QEMU will warn the user with :
>
>     qemu-system-arm: warning: nic ftgmac100.0 has no peer
>     qemu-system-arm: warning: nic ftgmac100.1 has no peer
>     qemu-system-arm: warning: nic ftgmac100.3 has no peer

This confused me, until I realized that QEMU sometimes supresses the
warning.

In vl.c:

    if (!default_net && (!qtest_enabled() || has_defaults)) {
        net_check_clients();
    }

Suppressed when none of -netdev, -nic, -net, -nodefaults is specified,
and also for -accel=3Dqtest -nodefaults.

Say "QEMU may warn" instead?

I looked for other boards with onboard NICs.  As far as I can tell, they
all behave the same.

>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Patch looks good, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>


