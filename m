Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB76C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 05:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8077520708
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 05:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+9Dbf3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8077520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jav5S-0003JB-Jp
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 01:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jav4f-0002U8-A5
 for qemu-devel@nongnu.org; Tue, 19 May 2020 01:45:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jav4e-0003C0-JY
 for qemu-devel@nongnu.org; Tue, 19 May 2020 01:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589867156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzO2EM9qxFbSXo9ndV3QOhZLTKiQsvjgzbRwusLWFvM=;
 b=E+9Dbf3XHj+YhNo+Fda6I9sjUVVsCZ/7Qz94OR+7IYb4kIxfuIf7cXvI4ISR64iwQd7jSg
 HR0zwubDOeQYwQyVVWQ4MSXx67TtM3UcCNKtCRvK73gLzayt7P4H9ORy/08uu4/1UptaBZ
 LZZZhqXQeYwHuPtXfPo9EC63dU7dz5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-iePTPCzhO_mBPwjnsnJ5Tg-1; Tue, 19 May 2020 01:45:47 -0400
X-MC-Unique: iePTPCzhO_mBPwjnsnJ5Tg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 108E5107ACCA;
 Tue, 19 May 2020 05:45:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2411649D6;
 Tue, 19 May 2020 05:45:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5376211358BC; Tue, 19 May 2020 07:45:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Andrew Jeffery" <andrew@aj.id.au>
Subject: Re: [PATCH 04/24] aspeed: Don't create unwanted "ftgmac100",
 "aspeed-mmi" devices
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-5-armbru@redhat.com>
 <9fc4a6e2-fa90-ba62-91cf-e22eb3ef4cdc@kaod.org>
 <eb1b203d-44ba-4b89-b96b-4e7bf993ac67@www.fastmail.com>
Date: Tue, 19 May 2020 07:45:44 +0200
In-Reply-To: <eb1b203d-44ba-4b89-b96b-4e7bf993ac67@www.fastmail.com> (Andrew
 Jeffery's message of "Tue, 19 May 2020 09:50:34 +0930")
Message-ID: <87v9ks5vg7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani
 via <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Andrew Jeffery" <andrew@aj.id.au> writes:

> On Mon, 18 May 2020, at 21:49, C=C3=A9dric Le Goater wrote:
>> On 5/18/20 7:03 AM, Markus Armbruster wrote:
>> > These devices are optional, and controlled by @nb_nics.
>> > aspeed_soc_ast2600_init() and aspeed_soc_init() create the maximum
>> > supported number.  aspeed_soc_ast2600_realize() and
>> > aspeed_soc_realize() realize only the wanted number.  Works, although
>> > it can leave unrealized devices hanging around in the QOM composition
>> > tree.  Affects machines ast2500-evb, ast2600-evb, palmetto-bmc,
>> > romulus-bmc, swift-bmc, tacoma-bmc, and witherspoon-bmc.
>> >=20
>> > Make the init functions create only the wanted ones.  Visible in "info
>> > qom-tree"; here's the change for ast2600-evb:
>> >=20
>> >      /machine (ast2600-evb-machine)
>> >        [...]
>> >        /soc (ast2600-a1)
>> >          [...]
>> >          /ftgmac100[0] (ftgmac100)
>> >            /ftgmac100[0] (qemu:memory-region)
>> >     -    /ftgmac100[1] (ftgmac100)
>> >     -    /ftgmac100[2] (ftgmac100)
>> >     -    /ftgmac100[3] (ftgmac100)
>> >          /gpio (aspeed.gpio-ast2600)
>> >          [...]
>> >          /mii[0] (aspeed-mmi)
>> >            /aspeed-mmi[0] (qemu:memory-region)
>> >     -    /mii[1] (aspeed-mmi)
>> >     -    /mii[2] (aspeed-mmi)
>> >     -    /mii[3] (aspeed-mmi)
>> >          /rtc (aspeed.rtc)
>> >=20
>> > I'm not sure creating @nb_nics devices makes sense.  How many does the
>> > physical chip provide?
>>=20
>> The AST2400, AST2500 SoC have 2 macs and the AST2600 has 4. Each machine
>> define the one it uses, generally MAC0 but the tacoma board uses MAC3.
>>=20
>> Shouldn't the model reflect the real address space independently from
>> the NIC backends defined on the command line ? =20
>
> That's my feeling too, though I'm not sure what to make of the unrealised=
 devices
> in the QOM tree. Does it matter? It hasn't bothered me.

Depending on what the initialization code does, unrealized devices can
be anything from a little wasted memory to open bear trap.  I don't
really expect the latter extreme in the code, as I expect bear traps to
quickly catch the developer that set them.

I guess the unrealized devices cleaned up in this patch did no actual
harm.

Still, it's an unhealthy state, and that's why I clean it up.  "[PATCH
24/24] qdev: Assert onboard devices all get realized properly" should
ensure we stay clean.


