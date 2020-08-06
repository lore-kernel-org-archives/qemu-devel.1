Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439AEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B945022D02
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="e+Jvyd4w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sZlBmHZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B945022D02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bl0-0006By-Jf
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1k3bk7-0005S9-Hj
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:59:19 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:45631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1k3bk3-0003Ex-SW
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:59:19 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 7557D1209;
 Thu,  6 Aug 2020 04:59:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Thu, 06 Aug 2020 04:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
 from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-type; s=fm3; bh=3B07XIgM4In9ExDKqLo4LYy9nl
 4PxSTOmVQaZgccA9w=; b=e+Jvyd4wbAZIq7Oxz/YBqhjlks4AT2lONr3vFWFuEc
 wTMYwmCBTwzUgCo+WJ6xTR55U/+qpZdVLlIEyw9K8hbKt2kglcbZNPRbzXZqIp1k
 xqH0r9oZ4k1e/zrXz7dcRY3z+joxTDQzaYkE08lFzL/YD6W4XjP969YUE6Clk2hB
 VVpvk7Cj1hy756NU2ZtMC+SzVFvoRX+ua2Gyit9G6hJOQ+u2MQGZYaoFKHsPbZF2
 D+Ijizo4GlBcyWxCFbniRKIFyqyThbeuQB+35iA8mlM5UAOdcZFtMF+8yjkb3b6f
 UoWlw95c62woRQKnzRo4dUo9/chmghZziuVoE8Ik/shg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3B07XI
 gM4In9ExDKqLo4LYy9nl4PxSTOmVQaZgccA9w=; b=sZlBmHZ3BKseAmcDnGSsTo
 FVAfYCyjfVYbtWJaGzck2xC692XMH9+UOtnKFea8HPYimDoGjTv3LmoNDIccq0hy
 fVE0rYVw1McLRx4Qthc6v7yQuw0hgvYwwmXhbf/HTOV0kLAH+2qpRuJwilDjHfW2
 6H3ifqVPkiQh83FCNOcNNWsvOV42jA7sOaoCZOS4m0e8PUEDl/uxlzHIN20+r/7a
 W9VuzNlnGV6YpKkKoZyb47tOT7pUMlJBTDGdNBcqVkX66l6eDkOu8fUL0Cbm8oND
 0vNop1Rokxl5QndwrqZwG4HyN9Ooc+zhmHW5Wds0XTHakmy6kdzYXEqlZ4rjreQQ
 ==
X-ME-Sender: <xms:X8YrX1QhX4OzSFEyKaeIGBDnLVKOVhhqeHgRBvsHQAsJNmWZWaGo7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgdduudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufgjfhffkfggtgesthdtredttd
 dttdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheq
 necuggftrfgrthhtvghrnhephfetudeftdejveegudejhfeuiefgjeehuddvtddvhfejte
 dufeelhfelhfeghfetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeg
 rddukeegrddvvdelrddvgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:X8YrX-zE2EC3FsbAOOGWtRD2k06tzFBEIMDwzq72DR3wuYh4cLe6Qg>
 <xmx:X8YrX604KIYqZ52evslM69ACIVx782PrVZpHFt56wEVJRHmmydb3nA>
 <xmx:X8YrX9D7aswtIFGo0zKKP46HkLbmDZ7uD0Kme4LaKRO7B5VQI7CcMA>
 <xmx:YMYrX5viao62s7mGafV-J3cl3_uxMYRyGGKkmGzefOJLDNFZmbjV8A>
Received: from x220.qyliss.net (p54b8e5f4.dip0.t-ipconnect.de [84.184.229.244])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8B4703280065;
 Thu,  6 Aug 2020 04:59:11 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id BF33FE3; Thu,  6 Aug 2020 08:59:09 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost-user protocol feature negotiation
In-Reply-To: <20200805181352-mutt-send-email-mst@kernel.org>
References: <87sgd1ktx9.fsf@alyssa.is>
 <20200805181352-mutt-send-email-mst@kernel.org>
Date: Thu, 06 Aug 2020 08:59:09 +0000
Message-ID: <87lfis2lr6.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=64.147.123.19; envelope-from=hi@alyssa.is;
 helo=wout3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 04:59:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Aug 05, 2020 at 03:13:06PM +0000, Alyssa Ross wrote:
>> Quoting from the definition of VHOST_USER_SET_PROTOCOL_FEATURES in
>> vhost-user.rst:
>> 
>> >   Only legal if feature bit ``VHOST_USER_F_PROTOCOL_FEATURES`` is present in
>> >   ``VHOST_USER_GET_FEATURES``.
>> > 
>> > .. Note::
>> >    Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
>> >    this message even before ``VHOST_USER_SET_FEATURES`` was called.
>> 
>> To me, this could mean either of two things:
>> 
>> (1) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
>>     VHOST_USER_SET_PROTOCOL_FEATURES, a backend should enable the
>>     protocol features immediately.
>> 
>> (2) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
>>     VHOST_USER_SET_PROTOCOL_FEATURES, a backend should store those
>>     feature bits, but not actually consider them to be enabled until
>>     after VHOST_USER_SET_FEATURES has been received (presumably
>>     containing VHOST_USER_F_PROTOCOL_FEATURES).
>> 
>> The reason I bring this up is that QEMU appears to interpret it as (1),
>> while the vhost-user-net backend in Intel's cloud-hypervisor[1]
>> interprets it as (2).  So I'm looking for a clarification.
>> 
>> [1]: https://github.com/cloud-hypervisor/cloud-hypervisor
>> 
>> Thanks in advance.
>
>
> IMHO the intent was this: VHOST_USER_F_PROTOCOL_FEATURES bit in
> VHOST_USER_GET_FEATURES means that qemu can send
> VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.
>
> With most feature bits in VHOST_USER_GET_FEATURES, the
> specific functionality needs to only be enabled after
> VHOST_USER_SET_FEATURES.
>
> However, this is for functionality dealing with guest activity.
> VHOST_USER_SET_PROTOCOL_FEATURES has nothing to do with guest directly,
> it's about negotiation between qemu and backend: it is only in
> VHOST_USER_GET_FEATURES for the reason that this is the only message
> (very) old backends reported.  Thus, the backend should not check
> whether VHOST_USER_SET_FEATURES sets VHOST_USER_F_PROTOCOL_FEATURES,
> instead it should simply always be ready to receive
> VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.
>
> Backend that isn't always ready to handle
> VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES
> should not set VHOST_USER_F_PROTOCOL_FEATURES in
> VHOST_USER_GET_FEATURES.

Thanks for the explanation.  That matches what I had in mind with (1).

> This appears to be closer to (1), but if qemu can't distinguish
> then we don't care, right? For example, VHOST_USER_PROTOCOL_F_REPLY_ACK
> enables acks on arbitrary messages. Does the backend in question
> ignore the affected bit until SET_FEATURES? If yes won't this
> make qemu hang?

Yes.  That was my motivation for asking what the correct behaviour was,
so that I could fix the incorrect one. :)  I suspect that up to this point,
the cloud-hypervisor vhost-user-net backend has only been used with
cloud-hypervisor, and so this incompatibilty with QEMU was not noticed.

> How would you suggest clarifying the wording?

Do you think this communicates everything required?

---
diff --git i/docs/interop/vhost-user.rst w/docs/interop/vhost-user.rst
index 10e3e3475e..72724d292a 100644
--- i/docs/interop/vhost-user.rst
+++ w/docs/interop/vhost-user.rst
@@ -854,9 +854,8 @@ Master message types
   ``VHOST_USER_GET_FEATURES``.
 
 .. Note::
-   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must
-   support this message even before ``VHOST_USER_SET_FEATURES`` was
-   called.
+   ``VHOST_USER_F_PROTOCOL_FEATURES`` does not need to be acknowledged
+   with ``VHOST_USER_SET_FEATURES``.
 
 ``VHOST_USER_SET_PROTOCOL_FEATURES``
   :id: 16
@@ -869,8 +868,8 @@ Master message types
   ``VHOST_USER_GET_FEATURES``.
 
 .. Note::
-   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
-   this message even before ``VHOST_USER_SET_FEATURES`` was called.
+   ``VHOST_USER_F_PROTOCOL_FEATURES`` does not need to be acknowledged
+   with ``VHOST_USER_SET_FEATURES``.
 
 ``VHOST_USER_SET_OWNER``
   :id: 3

