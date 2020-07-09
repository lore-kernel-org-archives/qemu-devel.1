Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C8AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE90206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4ASFfoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE90206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUvX-0004Pu-JC
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtUun-0003zP-3l
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:40:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtUuj-0003UE-UQ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594294828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xgxbitz7A7YPljzlGK4RtVia+8xmv4jQcUjNq6dUyQI=;
 b=N4ASFfoii+8flEOALeDmQ3Xl/rFu0AQvc4hEdUFihcfuOXNlTwkXmMiqhoPSFc48LLmkQU
 oK7Fz78T857ZGX0IXpaO/j5vyCTPbT/pSUb6SGT1tJSOdxx94Kh62lld2wpJCMVnokAxL5
 wjjRd4hjLK4jQVmy7M9P0Y9F+LPp8ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-95JHIaNLPJ2oePNbmMArGQ-1; Thu, 09 Jul 2020 07:40:26 -0400
X-MC-Unique: 95JHIaNLPJ2oePNbmMArGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ABCD107ACCD;
 Thu,  9 Jul 2020 11:40:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87F532B6DE;
 Thu,  9 Jul 2020 11:40:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F32F71132FD2; Thu,  9 Jul 2020 13:40:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 2/2] util/qemu-sockets: make keep-alive enabled by default
References: <20200708191540.28455-1-vsementsov@virtuozzo.com>
 <20200708191540.28455-3-vsementsov@virtuozzo.com>
 <20200709082954.GD3753300@redhat.com>
 <a59b626e-c54a-1619-9b67-d699971c5816@openvz.org>
Date: Thu, 09 Jul 2020 13:40:19 +0200
In-Reply-To: <a59b626e-c54a-1619-9b67-d699971c5816@openvz.org> (Denis
 V. Lunev's message of "Thu, 9 Jul 2020 11:54:00 +0300")
Message-ID: <871rlkudb0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, kraxel@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Denis V. Lunev" <den@openvz.org> writes:

> On 7/9/20 11:29 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Jul 08, 2020 at 10:15:39PM +0300, Vladimir Sementsov-Ogievskiy w=
rote:
>>> Keep-alive won't hurt, let's try to enable it even if not requested by
>>> user.
>> Keep-alive intentionally breaks TCP connections earlier than normal
>> in face of transient networking problems.
>>
>> The question is more about which type of pain is more desirable. A
>> stall in the network connection (for a potentially very long time),
>> or an intentionally broken socket.
>>
>> I'm not at all convinced it is a good idea to intentionally break
>> /all/ QEMU sockets in the face of transient problems, even if the
>> problems last for 2 hours or more.=20
>>
>> I could see keep-alives being ok on some QEMU socket. For example
>> VNC/SPICE clients, as there is no downside to proactively culling
>> them as they can trivially reconnect. Migration too is quite
>> reasonable to use keep alives, as you generally want migration to
>> run to completion in a short amount of time, and aborting migration
>> needs to be safe no matter what.
>>
>> Breaking chardevs or block devices or network devices that use
>> QEMU sockets though will be disruptive. The only solution once
>> those backends have a dead socket is going to be to kill QEMU
>> and cold-boot the VM again.
>
> nope, and this is exactly what we are trying to achive.
>
> Let us assume that QEMU NBD is connected to the
> outside world, f.e. to some HA service running in
> other virtual machine. Once that far away VM is
> becoming dead, it is re-started on some other host
> with the same IP.
>
> QEMU NBD has an ability to reconnect to this same
> endpoint and this process is transient for the guest.
>
> This is the workflow we are trying to improve.
>
> Anyway, sitting over dead socket is somewhat
> which is not productive. This is like NFS hard and
> soft mounts. In hypervisor world using hard mounts
> (defaults before the patch) leads to various non
> detectable deadlocks, that is why we are proposing
> soft with such defaults.
>
> It should also be noted that this is more consistent
> as we could face the problem if we perform write
> to the dead socket OR we could hang forever, thus
> the problem with the current state is still possible.
> With new settings we would consistently observe
> the problem.

Daniel's point remains valid: keep-alive makes sense only for sockets
where we can recover from connection breakage.  When graceful recovery
is impossible, we shouldn't aggressively break unresponsive connections,
throwing away the chance (however slim) of them becoming responsive
again.


